;;; rejafdofs channel --- Web browsers.
;;;
;;; Nyxt: Common Lisp 製の拡張可能ウェブブラウザ (BSD-3)。
;;;
;;; 本家 Guix は 2026-01-13 のコミット 16838140fe で nyxt を削除したため、
;;; 本チャンネルで独自にパッケージ化する。
;;;
;;; 3.12.0 から upstream は公式リリース tarball
;;;   nyxt-X.Y.Z-source-with-submodules.tar.xz
;;; を配布しており、Common Lisp 依存は _build/ サブディレクトリに
;;; submodule として同梱される。個別に sbcl-* を用意する必要はない。
;;;
;;; 本定義は **upstream 同梱の guix.scm** (atlas-engineer/nyxt の
;;; リポジトリ直下) をベースにリリース tarball 用に改変したもの。
;;; upstream の guix.scm は _build/ 以下の各 .lisp にハードコードされた
;;; 共有ライブラリ名 (例 "libgobject-2.0.so") を substitute* で
;;; Guix store 上の絶対パスに書き換える処理が完備しているので、
;;; そのまま踏襲する。
;;;
;;; 上流: https://github.com/atlas-engineer/nyxt

(define-module (rejafdofs packages web-browsers)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages c)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg))

(define-public nyxt
  (package
    (name "nyxt")
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
       ;; NYXT_SUBMODULES=false: release tarball には _build/ 以下に
       ;; submodule が同梱されているため、makefile が git submodule
       ;; update を呼ぼうとして失敗する (ビルドコンテナに git が無い) のを防ぐ。
       (list "nyxt" "NYXT_SUBMODULES=false"
             (string-append "DESTDIR=" (assoc-ref %outputs "out"))
             "PREFIX=")
       #:strip-binaries? #f             ;stripping breaks SBCL binaries
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ;; tarball はトップレベルに source/ / _build/ / libraries/ / makefile
         ;; などを並列に持つ (単一ラッパーディレクトリが無い) ため、Guix の
         ;; unpack フェーズが誤って source/ 内に cd する。1 階層上に戻す。
         (add-after 'unpack 'chdir-to-tarball-root
           (lambda _
             (when (file-exists? "../libraries")
               (chdir ".."))))
         ;; 新しい SBCL は未使用レキシカル変数を style-warning で報告し、
         ;; nasdf:fail-on-warnings がそれをエラー化するので緩和。
         (add-after 'chdir-to-tarball-root 'relax-fail-on-warnings
           (lambda _
             (substitute* "libraries/nasdf/tests.lisp"
               (("\\(unless \\(or \\(redefinition-p c\\)")
                "(unless (or (redefinition-p c) (typep c 'style-warning)"))))
         ;; upstream の guix.scm をそのまま踏襲: 同梱 _build/ 内の各
         ;; .lisp にハードコードされた共有ライブラリ名を Guix store 上の
         ;; 絶対パスに書き換える。これにより実行時の LD_LIBRARY_PATH
         ;; 設定が最小限で済む。chdir-to-tarball-root 後に実行する必要あり。
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
    (native-inputs (list sbcl))
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
    (synopsis "Extensible web-browser in Common Lisp")
    (home-page "https://nyxt-browser.com/")
    (description "Nyxt is a keyboard-oriented, extensible web-browser designed
for power users.  The application has familiar Emacs and VI key-bindings and
is fully configurable and extensible in Common Lisp.")
    (license license:bsd-3)))
