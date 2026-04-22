;;; rejafdofs channel --- Ghostty terminal emulator.
;;;
;;; Ghostty: GPU 加速の高速・機能豊富なクロスプラットフォーム端末エミュレータ。
;;; Zig 製。Apache-2.0 / MIT デュアル (本パッケージ目的では MIT 表記)。
;;;
;;; 上流: https://github.com/ghostty-org/ghostty
;;; PACKAGING.md: https://github.com/ghostty-org/ghostty/blob/main/PACKAGING.md
;;;
;;; === ビルド戦略 ===
;;;
;;; Ghostty の build.zig.zon は外部 URL から 36 個の Zig 依存を fetch する。
;;; Guix sandbox では fetch できないため、各依存を `(origin)` として
;;; ghostty-zig-deps.scm に列挙し、build phase 開始前に
;;;   ../zig-cache/p/<key>/
;;; に展開して `--system <cache>/p` で参照させる。これは upstream の
;;; PACKAGING.md「offline-cache」方式と同等。
;;;
;;; Zig 依存リストは scripts なしでは長いため、別ファイル
;;; ghostty-zig-deps.scm に分離 (build.zig.zon.json から自動生成)。
;;;
;;; === ビルド環境要件 ===
;;;
;;; Zig 0.15.2 のコンパイラは `copy_file_range(2)` syscall を直接呼び、
;;; ENOSYS のフォールバックを持たない (内部で `@panic("TODO")` で死ぬ)。
;;; gVisor (`runsc`) などの sandbox では `copy_file_range` が未実装
;;; なので、本パッケージはそれら sandbox 内では build できない。
;;; 通常の Linux kernel では `copy_file_range` は 4.5 以降サポート
;;; されており、何の問題もなく build できる想定。
;;;
;;; populate-zig-cache phase までは sandbox 環境でも正常完了することを
;;; 確認済み (cache に 36 entry 展開成功)。`zig build` 段階で前述
;;; gVisor 制限に当たる場合は `--disable-chroot` でない通常の Guix
;;; 環境を使用するか、別途 Zig 側に upstream patch (ENOSYS fallback)
;;; を当てる必要がある。

(define-module (rejafdofs packages ghostty)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix build-system zig)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages zig)
  #:use-module (rejafdofs packages ghostty-zig-deps)
  #:use-module (rejafdofs packages zig-overrides))

(define-public ghostty
  (package
    (name "ghostty")
    (version "1.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://release.files.ghostty.org/" version
             "/ghostty-" version ".tar.gz"))
       (sha256
        (base32 "1nycpyg5m90nzzq7957yrxlijy8qgm7k263s360s5ggz01bd4j9k"))))
    (build-system zig-build-system)
    (arguments
     (list
      ;; zig-build-system のデフォルト zig (0.13) では build.zig.zon が
      ;; 解析できない (1.3.1 は Zig 0.15 enum 構文使用)。明示。
      #:zig zig-0.15-fixed
      #:install-source? #f
      #:tests? #f
      #:zig-build-flags
      ;; --prefix は zig-build-system が空で渡すので、ここでは指定しない
      ;; (二重渡しすると zig が panic する)。代わりに DESTDIR を環境変数で
      ;; 渡す方式 (zig-build-system は --prefix "" → "" + DESTDIR を combine)。
      ;; --system <cache>/p で offline cache を使う。
      #~(list "--system" "../zig-cache/p"
              "-Doptimize=ReleaseFast"
              "-Dcpu=baseline")
      #:phases
      #~(modify-phases %standard-phases
          ;; Ghostty の SharedDeps.zig は `bzip2` という名前で
          ;; system library をリンクしようとする (libbzip2.so を探す) が、
          ;; Guix (および大半の Linux ディストロ) は libbz2.so を提供する
          ;; ので名前が合わず "unable to find dynamic system library
          ;; 'bzip2'" で失敗する。linkSystemLibrary2 の引数を "bz2" に
          ;; 置き換えて正しい名前を使わせる。
          (add-after 'unpack 'fix-bzip2-library-name
            (lambda _
              (substitute* "src/build/SharedDeps.zig"
                (("linkSystemLibrary2\\(\"bzip2\"")
                 "linkSystemLibrary2(\"bz2\""))))
          ;; Zig 依存を ../zig-cache/p/<cache-key>/ に展開する。
          ;; build.zig.zon の各 dep は中身がそのまま展開された状態を期待。
          (add-after 'unpack 'populate-zig-cache
            (lambda* (#:key inputs #:allow-other-keys)
              (use-modules (ice-9 ftw))
              (let ((cache "../zig-cache/p"))
                (mkdir-p cache)
                (for-each
                 (lambda (entry)
                   (let* ((key (car entry))
                          (artifact (cadr entry))
                          (dest (string-append cache "/" key)))
                     (mkdir-p dest)
                     (cond
                      ;; .tar.zst
                      ((string-suffix? ".tar.zst" artifact)
                       (invoke "tar" "--zstd" "-xf" artifact
                               "-C" dest "--strip-components=1"))
                      ;; .tar.xz
                      ((or (string-suffix? ".tar.xz" artifact)
                           (string-suffix? ".txz" artifact))
                       (invoke "tar" "-xJf" artifact
                               "-C" dest "--strip-components=1"))
                      ;; gzipped
                      ((or (string-suffix? ".tar.gz" artifact)
                           (string-suffix? ".tgz" artifact))
                       (invoke "tar" "-xzf" artifact
                               "-C" dest "--strip-components=1"))
                      ;; git-fetch directory (no compression).
                      ;; tar で source -> stdout -> tar 展開すると
                      ;; --no-same-permissions が効いて store の
                      ;; read-only mode を継承しない。
                      ((file-is-directory? artifact)
                       (invoke
                        "sh" "-c"
                        (string-append
                         "tar -C '" artifact
                         "' -cf - . | tar -C '" dest
                         "' --no-same-permissions --no-same-owner"
                         " --overwrite -xf -")))
                      (else
                       (error "Unknown artifact format" artifact)))))
                 ;; entry: (cache-key . origin-store-path)
                 ;; we recover the artifact path from inputs by index.
                 ;; しかしここでは inputs に加える側で順序を保つので、
                 ;; ペアを再構築する。
                 #$(let loop ((deps %ghostty-zig-deps)
                              (acc '()))
                     (if (null? deps)
                         #~(list #$@(reverse acc))
                         (let ((key (caar deps))
                               (origin (cadar deps)))
                           (loop (cdr deps)
                                 (cons #~(list #$key #$origin)
                                       acc))))))
                (setenv "ZIG_GLOBAL_CACHE_DIR" "../zig-cache"))))
          ;; Zig は link 時に /usr/lib/x86_64-linux-gnu を RUNPATH の
          ;; 先頭に埋め込む。Guix には存在しないパスなので純粋 Guix
          ;; System では害はないが、Ubuntu 等のディストロ上に Guix を
          ;; 入れている環境では先に Ubuntu の libc を拾って
          ;; "undefined symbol: __nptl_change_stack_perm" で実行時に
          ;; 落ちるため、patchelf で削除する。
          (add-after 'install 'strip-bogus-runpath
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((bin (string-append (assoc-ref outputs "out")
                                        "/bin/ghostty")))
                (when (file-exists? bin)
                  ;; sh で printf|patchelf して一時 file に書き、
                  ;; sed で bogus path を除去してから set-rpath する。
                  (invoke
                   "sh" "-c"
                   (string-append
                    "rp=$(patchelf --print-rpath " bin
                    "); kept=$(printf '%s' \"$rp\" | "
                    "sed 's|/usr/lib/x86_64-linux-gnu:||g; "
                    "s|:/usr/lib/x86_64-linux-gnu||g; "
                    "s|^/usr/lib/x86_64-linux-gnu$||'); "
                    "patchelf --set-rpath \"$kept\" " bin)))))))))
    (native-inputs
     ;; Ghostty 1.3.1 は Zig 0.15.2+ を要求 (デフォルト `zig` は 0.13 系)。
     ;; gettext-minimal: build.zig が msgfmt(1) を呼んで .po → .mo を
     ;; 生成するため必要 (なければ "FileNotFound" でビルド失敗)。
     (list zig-0.15-fixed
           pkg-config
           pandoc
           ncurses
           libxml2
           blueprint-compiler
           gettext-minimal
           patchelf))
    (inputs
     (list bash-minimal
           ;; Core
           oniguruma
           ;; GTK / GNOME
           gtk
           libadwaita
           gtk4-layer-shell
           ;; OpenGL / shaders
           glslang
           mesa
           ;; Fonts
           fontconfig
           freetype
           harfbuzz
           ;; Misc
           bzip2
           glib
           ;; GStreamer (video / audio)
           gstreamer
           gst-plugins-base
           gst-plugins-good))
    (synopsis "Fast, GPU-accelerated terminal emulator (Zig)")
    (home-page "https://ghostty.org")
    (description
     "Ghostty is a fast, feature-rich, and cross-platform terminal emulator
that uses platform-native UI and GPU acceleration.  Written in Zig, it aims
to provide a no-frills user experience with first-class support for shell
integration, ligatures, and GPU-accelerated rendering.")
    (license license:expat)))
