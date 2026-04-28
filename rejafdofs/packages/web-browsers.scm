;;; rejafdofs channel --- Web browsers.
;;;
;;; Nyxt: Common Lisp 製の拡張可能ウェブブラウザ (BSD-3)。
;;;
;;; 本家 Guix では 2026-01-13 のコミット 16838140fe で nyxt が削除された
;;; (guix/guix#518 参照)。本チャンネルで独自にパッケージ化する。
;;;
;;; 提供するバリアント:
;;;
;;;   nyxt       — 3.11.7 (default, git-fetch + sbcl-* 個別依存)。安定動作。
;;;   nyxt-3.12  — 3.12.0 (release tarball + 同梱 _build/ 依存)。
;;;                nixpkgs の default.nix と upstream 同梱 guix.scm を
;;;                参考にした recipe。recipe としては完成しているが、
;;;                2026-04 時点で sbcl (2.4.11 / 2.5.8 / 2.6.1 すべて)
;;;                の save-lisp-and-die 中 scavenge_immobile_newspace で
;;;                クラッシュする (下記参照)。bleeding edge が欲しい人用。
;;;
;;; === nyxt-3.12 の既知問題 ===
;;;
;;; Nyxt 3.12.0 は asdf:make 実行 (save-lisp-and-die で image を生成
;;; する段階) で以下のいずれかの形で SBCL がクラッシュする:
;;;
;;;   - SBCL 2.2.9  : SB-KERNEL:CODE-N-ENTRIES で TYPE-ERROR
;;;                   (Debian/Ubuntu apt と同版)
;;;   - SBCL 2.4.11 : scavenge_immobile_newspace で generic crash
;;;   - SBCL 2.5.x  : "-1 is not of type (UNSIGNED-BYTE 44)"
;;;                   (SB-IMPL::INFO-NAME-LIST 周辺の globaldb regression)
;;;   - SBCL 2.6.1  : "Bug in readtable iterators or concurrent access?"
;;;                   (fset の readtable 操作)
;;;
;;; 4 系列の SBCL 全てで失敗することから SBCL version 固有ではなく、
;;; Nyxt 3.12.0 自身が image dump 時の SBCL に何らかの矛盾を起こす
;;; パターンになっているとみなせる。upstream の issue tracker での
;;; 解決もしくはより新しい SBCL での再試行待ち。
;;;
;;; 上流: https://github.com/atlas-engineer/nyxt

(define-module (rejafdofs packages web-browsers)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages c)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages lisp-check)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (rejafdofs packages lisp-overrides))

;;;
;;; nyxt 3.11.7 — 安定版 (default)
;;;
;;; 本家 Guix の削除直前リビジョン 030bd035ae に存在した 3.11.7 定義を
;;; そのまま踏襲。依存の sbcl-* / cl-* はすべて本家に残っている。
;;;

;;;
;;; nyxt (4.0.0) — upstream の Linux AppImage を再パッケージ化したもの。
;;;
;;; 4.0.0 から Nyxt は WebKitGTK ベースから Electron ベースに大きく移行
;;; しており、Common Lisp 依存も submodule 110 個で git URL の一部
;;; (例 pcostanza/closer-mop) が dead で source build 不可。
;;; upstream が公式に配布する self-contained AppImage を抽出して
;;; Guix store にインストールする方式を採る。
;;;
;;; AppImage 内の構造:
;;;   AppRun
;;;   nyxt.desktop / nyxt.png
;;;   usr/bin/nyxt              (Lisp side, ~110MB)
;;;   usr/bin/cl-electron-server (Electron renderer, ~102MB)
;;;   usr/lib/lib*.so           (bundled openssl/sqlite/enchant 等)
;;;
;;; 依存は libc/libm/libdl/libpthread/libz のみ (glibc + zlib) なので
;;; patchelf で interpreter を Guix の glibc に向けて RPATH を
;;; 設定すれば動く。

(define-public nyxt
  (package
    (name "nyxt")
    (version "4.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/atlas-engineer/nyxt/releases/download/"
             version "/Linux-Nyxt-x86_64.tar.gz"))
       (sha256
        (base32
         "1i296nb9c7h7m3phm1rhz23gfir4wqw7bi48z35hsb1gkcmpmv5z"))))
    (build-system trivial-build-system)
    (arguments
     (list
      #:modules '((guix build utils)
                  (ice-9 popen)
                  (ice-9 rdelim))
      #:builder
      #~(begin
          (use-modules (guix build utils)
                       (ice-9 popen)
                       (ice-9 rdelim))
          (let* ((out      #$output)
                 (gzip     (string-append #$(this-package-native-input "gzip")
                                          "/bin/gzip"))
                 (tar      (string-append #$(this-package-native-input "tar")
                                          "/bin/tar"))
                 (squash   (string-append #$(this-package-native-input
                                             "squashfs-tools")
                                          "/bin/unsquashfs"))
                 (patchelf (string-append #$(this-package-native-input
                                             "patchelf")
                                          "/bin/patchelf"))
                 (glibc    #$(this-package-input "glibc"))
                 (zlib     #$(this-package-input "zlib"))
                 (loader   (string-append glibc "/lib/ld-linux-x86-64.so.2"))
                 (work     (string-append (getcwd) "/work")))
            (mkdir-p work)
            ;; 1. tar.gz の中身は AppImage 1 file。upstream の tarball は
            ;;    "extra field encrypted" 拡張で tar -xzf が直接通らない
            ;;    ため、source を work にコピーして gunzip でインプレース
            ;;    展開してから tar -xf で解く。
            (let ((local (string-append work "/Linux-Nyxt-x86_64.tar.gz")))
              (copy-file #$source local)
              (chmod local #o644)
              (invoke gzip "-d" local)
              (invoke tar "-xf" (string-append work "/Linux-Nyxt-x86_64.tar")
                      "-C" work)
              (delete-file (string-append work "/Linux-Nyxt-x86_64.tar")))
            ;; 2. AppImage 内の squashfs を抽出。offset は AppImage runtime
            ;;    が --appimage-offset で出してくれるのでそれを取得。
            (let* ((appimage (string-append work "/Nyxt-x86_64.AppImage")))
              (chmod appimage #o755)
              (let* ((port (open-input-pipe
                            (string-append appimage " --appimage-offset")))
                     (offset (read-line port)))
                (close-pipe port)
                (invoke squash "-d" (string-append work "/sq")
                        "-no-progress" "-quiet" "-offset" offset
                        appimage)))
            ;; (注: 実際の offset は AppImage runtime の version で異なる
            ;; ので、自動検出版は build-finalize で対応)
            (let* ((src (string-append work "/sq")))
              ;; 3. インストールレイアウトを構築
              (mkdir-p (string-append out "/bin"))
              (mkdir-p (string-append out "/lib"))
              (mkdir-p (string-append out "/share/applications"))
              (mkdir-p (string-append out "/share/icons/hicolor/512x512/apps"))
              (copy-file (string-append src "/usr/bin/nyxt")
                         (string-append out "/bin/nyxt"))
              (copy-file (string-append src "/usr/bin/cl-electron-server")
                         (string-append out "/bin/cl-electron-server"))
              (chmod (string-append out "/bin/nyxt") #o755)
              (chmod (string-append out "/bin/cl-electron-server") #o755)
              ;; bundled libs
              (for-each
               (lambda (lib)
                 (copy-file lib
                            (string-append out "/lib/"
                                           (basename lib))))
               (find-files (string-append src "/usr/lib")
                           "\\.so(\\.[0-9]+)*$"))
              ;; desktop / icon
              (when (file-exists? (string-append src "/nyxt.desktop"))
                (copy-file (string-append src "/nyxt.desktop")
                           (string-append out "/share/applications/nyxt.desktop")))
              (when (file-exists? (string-append src "/nyxt.png"))
                (copy-file (string-append src "/nyxt.png")
                           (string-append out
                                          "/share/icons/hicolor/512x512/apps/nyxt.png")))
              ;; 4. patchelf — interpreter を Guix の ld.so に、RPATH に
              ;;    glibc/lib + zlib/lib + 同梱 lib を入れる
              (let ((rpath (string-join
                            (list (string-append glibc "/lib")
                                  (string-append zlib "/lib")
                                  (string-append out "/lib"))
                            ":")))
                (for-each
                 (lambda (bin)
                   (invoke patchelf "--set-interpreter" loader bin)
                   (invoke patchelf "--set-rpath" rpath bin))
                 (list (string-append out "/bin/nyxt")
                       (string-append out "/bin/cl-electron-server"))))
              #t)))))
    (native-inputs
     (list (specification->package "tar")
           (specification->package "gzip")
           (specification->package "squashfs-tools")
           (specification->package "patchelf")))
    (inputs
     (list (specification->package "glibc")
           (specification->package "zlib")))
    (synopsis "Nyxt 4.0.0 (Electron 版、upstream AppImage 再パッケージ)")
    (home-page "https://nyxt-browser.com/")
    (description "Nyxt is a keyboard-oriented, extensible web-browser designed
for power users.  This package wraps upstream's official Linux AppImage
(Electron-based renderer) for use under Guix; it is a binary repackage,
not a source build.  See @code{nyxt-3} for the older 3.11.7 source build.")
    (license license:bsd-3)))


(define-public nyxt-3
  (package
    ;; `nyxt` という名前は新しい 4.0.0 (Electron 版バイナリ) を指すように
    ;; 譲り、こちらは `nyxt-3` として明示。`guix install nyxt-3` で利用可。
    (name "nyxt-3")
    (version "3.11.7")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/atlas-engineer/nyxt")
             (commit version)))
       (sha256
        (base32
         "0qrlks2b4a02b1lf8ah5cv3y32kh8yxnxkvfgrnia92g72xpj4j2"))
       (file-name (git-file-name name version))))
    (build-system gnu-build-system)
    (arguments
     `(#:make-flags (list "nyxt" "NYXT_SUBMODULES=false"
                          (string-append "DESTDIR=" (assoc-ref %outputs "out"))
                          "PREFIX=")
       #:strip-binaries? #f             ;stripping breaks SBCL binaries
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ;; 新しい SBCL は未使用レキシカル変数を style-warning で報告し、
         ;; nasdf:fail-on-warnings がそれをエラー化するので緩和する。
         (add-after 'unpack 'relax-fail-on-warnings
           (lambda _
             (substitute* "libraries/nasdf/tests.lisp"
               (("\\(unless \\(or \\(redefinition-p c\\)")
                "(unless (or (redefinition-p c) (typep c 'style-warning)"))))
         (add-before 'build 'fix-common-lisp-cache-folder
           (lambda _ (setenv "HOME" "/tmp")))
         (add-before 'check 'configure-tests
           (lambda _ (setenv "NYXT_TESTS_NO_NETWORK" "1")))
         (add-after 'install 'wrap-program
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin/nyxt"))
                    (glib-networking (assoc-ref inputs "glib-networking"))
                    (webkit (assoc-ref inputs "webkitgtk-for-gtk3"))
                    (libs '("gsettings-desktop-schemas"))
                    (path (string-join
                           (map (lambda (lib)
                                  (string-append (assoc-ref inputs lib) "/lib"))
                                libs)
                           ":"))
                    (gi-path (getenv "GI_TYPELIB_PATH"))
                    (gst-libs
                     (map (lambda (lib)
                            (string-append (assoc-ref inputs lib)
                                           "/lib/gstreamer-1.0"))
                          '("gstreamer" "gst-libav" "gst-plugins-base"
                            "gst-plugins-good" "gst-plugins-bad"
                            "gst-plugins-ugly")))
                    (gst-path (string-join gst-libs ":"))
                    (xdg-path (string-join
                               (map (lambda (lib)
                                      (string-append (assoc-ref inputs lib) "/share"))
                                    libs)
                               ":")))
               (wrap-program bin
                 ;; HTTPS / TLS support (glib-networking が無いと
                 ;; "TLS is not supported" でページがロードできない)。
                 `("GIO_EXTRA_MODULES" prefix
                   (,(string-append glib-networking "/lib/gio/modules")))
                 `("GI_TYPELIB_PATH" prefix (,gi-path))
                 `("LD_LIBRARY_PATH" ":" prefix (,path))
                 `("XDG_DATA_DIRS" ":" prefix (,xdg-path))
                 ;; WebKit の補助プロセス (WebKitWebProcess /
                 ;; WebKitNetworkProcess) の場所。これが無いと renderer
                 ;; サブプロセスが起動できずページが空白になる。
                 `("WEBKIT_EXEC_PATH" =
                   (,(string-append webkit "/libexec/webkit2gtk-4.1")))
                 ;; 動画/音声 codec
                 `("GST_PLUGIN_SYSTEM_PATH" ":" prefix (,gst-path))
                 ;; "Error in FFI method: 1073741824 is not of type
                 ;; GDK:GDK-EVENT" 対策。WebKitGTK の compositing 経路
                 ;; (HW accel) を無効化することで cl-cffi-gtk が知らない
                 ;; 新 GDK enum を含む event を回避する。これがないと
                 ;; ページが空白になる症状が出る (Guix bug#79119,
                 ;; FreeBSD forum で workaround として確認)。
                 `("WEBKIT_DISABLE_COMPOSITING_MODE" = ("1"))
                 ;; "Web process terminated" 対策。WebKit の bubblewrap
                 ;; sandbox は Guix store の non-standard path 構成
                 ;; (各 lib が個別 store path) と相性が悪く、renderer
                 ;; 起動直後にクラッシュすることがある。Sandbox を切って
                 ;; 安定優先で動かす (security trade-off あり)。
                 `("WEBKIT_DISABLE_SANDBOX_THIS_IS_DANGEROUS" = ("1")))))))))
    (native-inputs (list cl-lisp-unit2 sbcl))
    (inputs (list bash-minimal
                  sbcl-alexandria
                  sbcl-bordeaux-threads
                  sbcl-calispel
                  sbcl-cl-base64
                  sbcl-cl-colors2
                  sbcl-cl-containers
                  sbcl-cl-gopher
                  sbcl-cl-html-diff
                  sbcl-cl-json
                  sbcl-cl-ppcre
                  sbcl-cl-prevalence
                  sbcl-cl-qrencode
                  sbcl-cl-sqlite
                  sbcl-cl-str
                  sbcl-cl-tld
                  sbcl-closer-mop
                  sbcl-clss
                  sbcl-cluffer
                  sbcl-custom-hash-table
                  sbcl-dexador
                  sbcl-dissect
                  sbcl-enchant
                  sbcl-flexi-streams
                  sbcl-history-tree
                  sbcl-iolib
                  sbcl-lass
                  sbcl-local-time
                  sbcl-log4cl
                  sbcl-lparallel
                  sbcl-montezuma
                  sbcl-moptilities
                  sbcl-named-readtables
                  sbcl-nclasses
                  sbcl-ndebug
                  sbcl-nfiles
                  sbcl-nhooks
                  sbcl-njson
                  sbcl-nkeymaps
                  sbcl-nsymbols
                  sbcl-parenscript
                  sbcl-phos
                  sbcl-plump
                  sbcl-prompter
                  sbcl-py-configparser
                  sbcl-quri
                  sbcl-serapeum
                  sbcl-slime-swank
                  sbcl-slynk
                  sbcl-spinneret
                  sbcl-trivia
                  sbcl-trivial-clipboard
                  sbcl-trivial-custom-debugger
                  sbcl-trivial-features
                  sbcl-trivial-garbage
                  sbcl-trivial-package-local-nicknames
                  sbcl-trivial-types
                  sbcl-unix-opts
                  ;; WebKitGTK deps
                  sbcl-cl-cffi-gtk
                  ;; 本家 sbcl-cl-webkit ではなく、本チャンネルの patch 版
                  ;; (WORLD parameter NIL 許容) を使う。これがないと
                  ;; "The value NIL is not of type STRING when binding
                  ;; CL-WEBKIT2::WORLD" 警告でページレンダリングが妨げられる。
                  sbcl-cl-webkit-patched
                  glib-networking
                  gsettings-desktop-schemas
                  cl-gobject-introspection
                  gtk+                  ; For the main loop
                  webkitgtk-for-gtk3    ; Required when we use its typelib
                  gobject-introspection
                  pkg-config
                  ;; Useful for video playback
                  gst-libav
                  gst-plugins-bad
                  gst-plugins-base
                  gst-plugins-good
                  gst-plugins-ugly))
    (synopsis "Extensible web-browser in Common Lisp")
    (home-page "https://nyxt-browser.com/")
    (description "Nyxt is a keyboard-oriented, extensible web-browser designed
for power users.  The application has familiar Emacs and VI key-bindings and
is fully configurable and extensible in Common Lisp.")
    (license license:bsd-3)))

;;;
;;; nyxt-3.12 — 実験版 (Nix 準拠、現状ビルド失敗)
;;;
;;; upstream の公式リリース tarball
;;;   nyxt-3.12.0-source-with-submodules.tar.xz
;;; を使用し、依存 Common Lisp は _build/ 同梱版に統一。
;;;
;;; 本 recipe は nixpkgs の pkgs/applications/networking/browsers/nyxt/default.nix
;;; と upstream リポジトリ同梱の guix.scm を参考にしている。
;;; fix-so-paths phase で _build/ 内各 .lisp の hardcoded 共有ライブラリ名を
;;; Guix store 絶対パスに書き換える処理完備。
;;;
;;; ただし 2026-04 時点で SBCL 2.4/2.5/2.6 系すべてで
;;; save-lisp-and-die 時の scavenge_immobile_newspace クラッシュが発生する。
;;; (モジュール冒頭の「nyxt-3.12 の既知問題」参照)
;;;

(define-public nyxt-next
  (package
    ;; `nyxt` と同名にすると guix が高い version (3.12) を優先してしまい、
    ;; 既知問題で build に失敗するデフォルト動作になるので別名にする。
    ;; `guix install nyxt-next` で明示的に選択する運用。
    (name "nyxt-next")
    (version "3.12.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/atlas-engineer/nyxt/releases/download/"
             version "/nyxt-" version "-source-with-submodules.tar.xz"))
       (sha256
        (base32 "0m55r5dl8l72v8bdbg519ac6xq3z8pcb25p0p0q52l16rkqgcmck"))))
    (build-system gnu-build-system)
    (arguments
     `(#:make-flags
       (list "nyxt" "NYXT_SUBMODULES=false"
             (string-append "DESTDIR=" (assoc-ref %outputs "out"))
             "PREFIX=")
       #:strip-binaries? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ;; release tarball にはトップレベル単一ラッパーディレクトリが
         ;; 無く複数のトップレベル項目 (source/ / _build/ / libraries/
         ;; / makefile) を持つため、Guix の unpack が誤って source/
         ;; 内に cd する。1 階層戻す。
         (add-after 'unpack 'chdir-to-tarball-root
           (lambda _
             (when (file-exists? "../libraries")
               (chdir ".."))))
         (add-after 'chdir-to-tarball-root 'relax-fail-on-warnings
           (lambda _
             (substitute* "libraries/nasdf/tests.lisp"
               (("\\(unless \\(or \\(redefinition-p c\\)")
                "(unless (or (redefinition-p c) (typep c 'style-warning)"))))
         ;; upstream 同梱 guix.scm の処理:
         ;; _build/ 内 .lisp にハードコードされた共有ライブラリ名を
         ;; Guix store 絶対パスに書き換え。
         ;; chdir-to-tarball-root 後に走る必要があるのでそれを anchor。
         (add-after 'relax-fail-on-warnings 'fix-so-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "_build/cl-plus-ssl/src/reload.lisp"
               (("libssl.so" all)
                (string-append (assoc-ref inputs "openssl") "/lib/" all))
               (("libcrypto.so" all)
                (string-append (assoc-ref inputs "openssl") "/lib/" all)))
             (substitute* "_build/iolib/src/syscalls/ffi-functions-unix.lisp"
               (("\\(:default \"libfixposix\"\\)")
                (string-append "(:default \""
                               (assoc-ref inputs "libfixposix")
                               "/lib/libfixposix\")")))
             (substitute* "_build/cl-sqlite/sqlite-ffi.lisp"
               (("libsqlite3" all)
                (string-append (assoc-ref inputs "sqlite") "/lib/" all)))
             (substitute* "_build/cl-gobject-introspection/src/init.lisp"
               (("libgobject-2\\.0\\.so")
                (search-input-file inputs "/lib/libgobject-2.0.so"))
               (("libgirepository-1\\.0\\.so")
                (search-input-file inputs "/lib/libgirepository-1.0.so")))
             (substitute* "_build/cl-webkit/webkit2/webkit2.init.lisp"
               (("libwebkit2gtk" all)
                (string-append (assoc-ref inputs "webkitgtk-for-gtk3")
                               "/lib/" all)))
             (substitute* "_build/cl-cffi-gtk/glib/glib.init.lisp"
               (("libglib-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all)))
               (("libgthread-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/gobject/gobject.init.lisp"
               (("libgobject-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/gio/gio.init.lisp"
               (("libgio-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/cairo/cairo.init.lisp"
               (("libcairo\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/pango/pango.init.lisp"
               (("libpango-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all)))
               (("libpangocairo-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/gdk-pixbuf/gdk-pixbuf.init.lisp"
               (("libgdk_pixbuf-[0-9.]*\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/gdk/gdk.init.lisp"
               (("libgdk-[0-9]\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))
             (substitute* "_build/cl-cffi-gtk/gdk/gdk.package.lisp"
               (("libgtk-[0-9]\\.so" all)
                (search-input-file inputs (string-append "/lib/" all))))))
         (add-after 'fix-so-paths 'fix-clipboard-paths
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* "_build/trivial-clipboard/src/text.lisp"
               (("\"xsel\"")
                (string-append "\"" (assoc-ref inputs "xsel") "/bin/xsel\""))
               (("\"wl-copy\"")
                (string-append "\"" (assoc-ref inputs "wl-clipboard")
                               "/bin/wl-copy\""))
               (("\"wl-paste\"")
                (string-append "\"" (assoc-ref inputs "wl-clipboard")
                               "/bin/wl-paste\"")))))
         (add-before 'build 'fix-common-lisp-cache-folder
           (lambda _ (setenv "HOME" "/tmp")))
         ;; NYXT_SUBMODULES=false だと makefile は nasdf の
         ;; register-submodules を呼ばないため、ASDF が _build/ 配下の
         ;; 同梱ライブラリを見つけられない。自前で CL_SOURCE_REGISTRY
         ;; を設定する。
         (add-before 'build 'set-source-registry
           (lambda _
             (setenv "CL_SOURCE_REGISTRY"
                     (string-append (getcwd) "/_build//:"
                                    (getcwd) "/libraries//:"
                                    (getcwd) "/"))))
         (add-before 'check 'configure-tests
           (lambda _ (setenv "NASDF_TESTS_NO_NETWORK" "1")))
         (add-after 'install 'wrap-program
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((gsettings (assoc-ref inputs "gsettings-desktop-schemas")))
               (wrap-program (string-append (assoc-ref outputs "out")
                                            "/bin/nyxt")
                 `("GIO_EXTRA_MODULES" prefix
                   (,(string-append (assoc-ref inputs "glib-networking")
                                    "/lib/gio/modules")))
                 `("GI_TYPELIB_PATH" prefix
                   (,(getenv "GI_TYPELIB_PATH")))
                 `("LD_LIBRARY_PATH" ":" prefix
                   (,(string-append gsettings "/lib")))
                 `("XDG_DATA_DIRS" ":" prefix
                   (,(string-append gsettings "/share"))))))))))
    (native-inputs
     ;; Debian/Ubuntu の apt と同じ SBCL 2.2.9 を使う。upstream 公式
     ;; の AppImage / .deb はこれでビルドされていると考えられる。
     ;; 2.4 / 2.5 / 2.6 系は scavenge_immobile_newspace でクラッシュする。
     (list sbcl-2.2.9))
    (inputs (list cairo
                  gdk-pixbuf
                  glib
                  glib-networking
                  gobject-introspection
                  gsettings-desktop-schemas
                  gst-libav
                  gst-plugins-bad
                  gst-plugins-base
                  gst-plugins-good
                  gst-plugins-ugly
                  gtk+
                  libfixposix
                  openssl
                  pango
                  pkg-config
                  sqlite
                  webkitgtk-for-gtk3
                  wl-clipboard
                  xsel))
    (synopsis "Extensible web-browser in Common Lisp (3.12.0, experimental)")
    (home-page "https://nyxt-browser.com/")
    (description "Nyxt 3.12.0 release tarball-based package.
@strong{実験版:} SBCL の save-lisp-and-die と Nyxt 3.12.0 の組み合わせで
save-lisp-and-die でクラッシュする既知問題があり、SBCL 2.2 / 2.4 / 2.5 / 2.6
のいずれでも同様に失敗する。安定動作を求める場合は @code{nyxt}
(3.11.7) を使うこと。")
    (license license:bsd-3)))
