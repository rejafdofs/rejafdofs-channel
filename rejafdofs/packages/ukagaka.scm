;;; rejafdofs channel --- Ukagaka (デスクトップマスコット) 関連。
;;;
;;; 提供パッケージ:
;;;   - ruby-ninix-fmo : ninix-kagari が依存する FileMappingObject 用 Ruby gem
;;;   - ninix-kagari   : Ukagaka 互換デスクトップマスコット (Tatakinov 氏による
;;;                      ninix-aya のフォーク)
;;;
;;; 上流:
;;;   https://github.com/Tatakinov/ninix-fmo   (MIT)
;;;   https://github.com/Tatakinov/ninix-kagari (GPL-2)
;;;
;;; === 既知の制約 ===
;;;
;;; ninix-kagari は ruby-gtk4, ruby-narray, ruby-zip 等に依存しますが、
;;; 2026-04 時点で Guix 本家にはこれらの Ruby-GNOME バインディングがまだ
;;; 含まれていません。よって本パッケージの実ビルドには、以下のいずれかの
;;; 対応が別途必要です。
;;;
;;;   (a) ruby-gnome スイート (gtk4, gio2, glib2, gobject-introspection,
;;;       pango, gdk-pixbuf, cairo) をこのチャンネルに追加定義する
;;;   (b) 本家 Guix への ruby-gtk4 追加を待つ
;;;
;;; SHIORI バックエンド (Aosora / Kawari / Satori / YAYA) や
;;; Sorakado (Ao / Ai) は本パッケージでは**ビルドしません**。必要な
;;; ゴーストディレクトリに別途配置してください。

(define-module (rejafdofs packages ukagaka)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system ruby)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages ruby-xyz))

;;;
;;; ninix-fmo : File Mapping Object 用 Ruby gem (C 拡張)。
;;;

(define-public ruby-ninix-fmo
  ;; v1.0.1 tag は .gemspec 追加前なので、gemspec を含む v1.0.2 を使用。
  ;; gemspec 内部の spec.version は "1.0.1" のまま。
  (package
    (name "ruby-ninix-fmo")
    (version "1.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Tatakinov/ninix-fmo")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "044a2h1b39lajyvdy5dlakg33pc1773j8fbs8b10blcq3cb94x6h"))))
    (build-system ruby-build-system)
    (arguments
     ;; 新 Guix ではデフォルト `ruby` が 3.3 系になっており、gemspec の
     ;; required_ruby_version = ">= 3.1.0" を満たすためそのまま使う。
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          ;; glibc < 2.34 では shm_open / sem_* が librt に属するため、
          ;; extconf.rb に have_library('rt') を追加する。
          (add-after 'unpack 'link-librt
            (lambda _
              (substitute* "ext/ninix-fmo/extconf.rb"
                (("require 'mkmf'")
                 "require 'mkmf'\nhave_library('rt')\nhave_library('pthread')")))))))
    (synopsis "ninix-kagari 用 FileMappingObject Ruby gem")
    (description
     "ninix-fmo は Windows の FileMappingObject と互換な IPC 機構を
ninix-kagari に提供する Ruby の C 拡張 gem。")
    (home-page "https://github.com/Tatakinov/ninix-fmo")
    (license license:expat)))

;;;
;;; ninix-kagari : Ukagaka 互換デスクトップマスコット。
;;;
;;; Makefile の `install-lib` / `install-bin` / `install-doc` のみを使い、
;;; SHIORI バックエンドのビルドは行いません。
;;;

(define-public ninix-kagari
  (package
    (name "ninix-kagari")
    (version "3.1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Tatakinov/ninix-kagari")
             (commit (string-append "v" version))
             (recursive? #t)))           ;SHIORI サブモジュール参照のため
       (file-name (git-file-name name version))
       (sha256
        (base32 "0zq9953jq94mibcgw2zh31pzgr3mxzvig0rq9ilx76gzr90c0kap"))))
    (build-system copy-build-system)
    (arguments
     (list
      #:install-plan
      ;; ruby/ 配下の Ruby ソースは /lib/ninix-kagari 相当に配置し、
      ;; 実行用ラッパースクリプトは bin/ninix へ。
      #~'(("lib"              "lib/ninix-kagari/")
          ("bin/ninix.in"     "bin/ninix")
          ("README.md"        "share/doc/ninix-kagari/")
          ("README.ninix"     "share/doc/ninix-kagari/")
          ("README.ninix-aya" "share/doc/ninix-kagari/")
          ("COPYING"          "share/doc/ninix-kagari/"))
      #:phases
      #~(modify-phases %standard-phases
          ;; bin/ninix.in に含まれる @prefix@ / @libdir@ を実際のパスに
          ;; 置換する。上流 Makefile の sed ルールを模倣。
          (add-after 'install 'patch-launcher
            (lambda _
              (let* ((bin (string-append #$output "/bin/ninix"))
                     (lib (string-append #$output "/lib/ninix-kagari")))
                (substitute* bin
                  (("@prefix@") #$output)
                  (("@libdir@") lib)
                  (("@bindir@") (string-append #$output "/bin"))
                  (("@docdir@") (string-append #$output
                                               "/share/doc/ninix-kagari")))
                (chmod bin #o755)))))))
    (inputs
     ;; これらは現状 Guix 本家に無い or 本チャンネル側で追加定義が必要。
     ;; 暫定的に ruby 本体のみを propagated しておき、残りは README.md の
     ;; 「既知の制約」参照。
     (list ruby
           ruby-gettext
           ;; TODO: ruby-gtk4 ruby-narray ruby-zip ruby-ninix-fmo を追加
           ))
    (synopsis "Ukagaka 互換デスクトップマスコット (ninix-aya フォーク)")
    (description
     "ninix-kagari は Windows 向けの「伺か」互換デスクトップマスコットを
Linux 上でネイティブに動かすための Ruby 製ベースウェアである。
ninix-aya の長期メンテナンスが止まっていたのを受け、Tatakinov 氏が
フォークしたもので、現代的な GTK4 環境で動作するよう改修されている。")
    (home-page "https://github.com/Tatakinov/ninix-kagari")
    (license license:gpl2)))
