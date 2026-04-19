;;; rejafdofs channel --- Web browsers.
;;;
;;; Nyxt: Common Lisp 製の拡張可能ウェブブラウザ。
;;;
;;; 本家 Guix では 2026-01-13 のコミット 16838140fe で nyxt が削除された
;;; (guix/guix#518) ため、本チャンネルで独自にパッケージ化する。
;;;
;;; 3.12.0 からは nixpkgs のパッケージ定義を参考にし、**上流公式リリースの
;;; "source-with-submodules" tarball** を使用する構成に切り替えた。
;;; この tarball には Nyxt が依存する Common Lisp ライブラリ群が _build/
;;; サブディレクトリ以下に submodule として同梱されているため、個別に
;;; sbcl-* パッケージを入力として指定する必要がない (旧 3.11.7 定義では
;;; 50 個以上の sbcl-* 依存を Guix 側で用意する必要があった)。
;;;
;;; ビルド時は CL_SOURCE_REGISTRY で _build/ 以下を SBCL に教えることで、
;;; 同梱された依存のみでセルフコンパイルさせる。
;;;
;;; 上流: https://github.com/atlas-engineer/nyxt (BSD-3)
;;; 参考: https://github.com/NixOS/nixpkgs ... pkgs/applications/networking/browsers/nyxt/default.nix

(define-module (rejafdofs packages web-browsers)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages c)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages pkg-config)
  #:use-module (rejafdofs packages lisp-overrides)
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
     (list
      #:make-flags
      #~(list "all" "NYXT_SUBMODULES=false"
              ;; 論理パスネーム機構は SBCL 2.5.8 の globaldb / save-lisp-and-die
              ;; と相性が悪く -1 is not of type (UNSIGNED-BYTE 44) で落ちる
              ;; ことがあるため無効化。
              "NASDF_USE_LOGICAL_PATHS=false"
              (string-append "DESTDIR=" #$output)
              "PREFIX=")
      #:strip-binaries? #f           ;stripping breaks SBCL binaries
      ;; SBCL 2.5.8 の tune-image-for-dump は並列コンパイルとの
      ;; 組み合わせで内部状態が壊れて "-1 is not of type
      ;; (UNSIGNED-BYTE 44)" を出す既知の issue があるので直列化。
      #:parallel-build? #f
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure)
          ;; tarball はトップレベルに `source/`, `_build/`, `libraries/`, `makefile`
          ;; などを並列に持つ (単一ラッパーディレクトリが無い) ため、Guix の
          ;; unpack フェーズが誤って `source/` 内に cd する。1 階層上に戻す。
          (add-after 'unpack 'chdir-to-tarball-root
            (lambda _
              (when (file-exists? "../libraries")
                (chdir ".."))))
          ;; 新しい SBCL (2.5.8+) は未使用レキシカル変数を style-warning で
          ;; 報告するようになり、nasdf:fail-on-warnings がそれをエラー化して
          ;; ビルドを落とす。libraries/nasdf/tests.lisp のフィルタに
          ;; (typep c 'style-warning) を追加する。
          (add-after 'chdir-to-tarball-root 'relax-fail-on-warnings
            (lambda _
              (substitute* "libraries/nasdf/tests.lisp"
                (("\\(unless \\(or \\(redefinition-p c\\)")
                 "(unless (or (redefinition-p c) (typep c 'style-warning)"))))
          (add-before 'build 'set-lisp-environment
            (lambda* (#:key inputs #:allow-other-keys)
              ;; 同梱 submodules を SBCL から見えるようにする。
              (setenv "CL_SOURCE_REGISTRY"
                      (string-append (getcwd) "/_build//"))
              (setenv "ASDF_OUTPUT_TRANSLATIONS"
                      (string-append (getcwd) ":" (getcwd)))
              ;; SBCL キャッシュディレクトリ用。
              (setenv "HOME" "/tmp")
              ;; nyxt/nasdf は CFFI 経由で libgobject / libgtk 等を dlopen
              ;; するので、ビルド時にも LD_LIBRARY_PATH を通しておく。
              (setenv "LD_LIBRARY_PATH"
                      (string-join
                       (map (lambda (i)
                              (string-append (assoc-ref inputs i) "/lib"))
                            '("glib" "gobject-introspection"
                              "gdk-pixbuf" "cairo" "pango" "gtk+"
                              "webkitgtk-for-gtk3" "openssl" "sqlite"
                              "libfixposix"))
                       ":"))))
          (add-before 'check 'configure-tests
            (lambda _ (setenv "NYXT_TESTS_NO_NETWORK" "1")))
          (add-after 'install 'wrap-program
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((bin (string-append #$output "/bin/nyxt"))
                     (glib-networking (assoc-ref inputs "glib-networking"))
                     (gsettings (assoc-ref inputs "gsettings-desktop-schemas"))
                     (xdg (assoc-ref inputs "xdg-utils"))
                     (xclip (assoc-ref inputs "xclip"))
                     (wl-clip (assoc-ref inputs "wl-clipboard"))
                     (gi-path (getenv "GI_TYPELIB_PATH"))
                     (ld-libs
                      (string-join
                       (map (lambda (i)
                              (string-append (assoc-ref inputs i) "/lib"))
                            '("glib" "gobject-introspection"
                              "gdk-pixbuf" "cairo" "pango" "gtk+"
                              "webkitgtk-for-gtk3" "openssl" "sqlite"
                              "libfixposix"))
                       ":")))
                (wrap-program bin
                  `("GIO_EXTRA_MODULES" prefix
                    (,(string-append glib-networking "/lib/gio/modules")))
                  `("GI_TYPELIB_PATH" prefix (,gi-path))
                  `("LD_LIBRARY_PATH" ":" prefix (,ld-libs))
                  `("XDG_DATA_DIRS" ":" prefix
                    (,(string-append gsettings "/share")))
                  `("PATH" ":" prefix
                    (,(string-join
                       (map (lambda (p) (string-append p "/bin"))
                            (list xdg xclip wl-clip))
                       ":"))))))))))
    (native-inputs
     ;; 本家の sbcl (2.5.8) は Nyxt 3.12.0 の save-lisp-and-die で
     ;; GC regression を踏むため、本チャンネルで定義する 2.6.1 を使う。
     (list sbcl-2.6 pkg-config))
    (inputs
     (list bash-minimal
           libfixposix
           ;; GLib / GObject
           glib
           gobject-introspection
           glib-networking
           gsettings-desktop-schemas
           ;; GTK and friends
           gdk-pixbuf
           cairo
           pango
           gtk+                     ;GTK 3 (main loop)
           webkitgtk-for-gtk3
           ;; Misc
           openssl
           sqlite
           ;; GStreamer (video playback)
           gstreamer
           gst-libav
           gst-plugins-base
           gst-plugins-good
           gst-plugins-bad
           gst-plugins-ugly
           ;; Runtime helpers for clipboard / open-in-browser
           xdg-utils
           xclip
           wl-clipboard))
    (synopsis "Extensible web-browser in Common Lisp")
    (home-page "https://nyxt-browser.com/")
    (description "Nyxt is a keyboard-oriented, extensible web-browser designed
for power users.  The application has familiar Emacs and VI key-bindings and
is fully configurable and extensible in Common Lisp.")
    (license license:bsd-3)))
