;;; rejafdofs channel --- VRChat tooling.
;;;
;;; vrc-get: Fast OSS command-line client for VRChat Package Manager.
;;; Upstream: https://github.com/vrc-get/vrc-get  (MIT)
;;;
;;; Cargo workspace 内の `vrc-get` クレート (CLI 本体) のみをビルドします。
;;; GUI 版 (`vrc-get-gui` / ALCOM) は Tauri 依存が重いため対象外。
;;;
;;; Rust クレート依存は `rejafdofs/packages/rust-crates.scm` に定義されており、
;;; `guix import crate -f Cargo.lock vrc-get` で自動生成したものです。

(define-module (rejafdofs packages vrchat)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages tls)
  #:use-module (rejafdofs packages rust-crates))

(define-public vrc-get
  (package
    (name "vrc-get")
    (version "1.9.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/vrc-get/vrc-get")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0gwkwb1dikdqghigbh98hpkq7wnvxljszw1208if311w2bv70pm5"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:install-source? #f
      #:tests? #f
      ;; Cargo workspace の内、CLI クレート `vrc-get` のみをビルド。
      #:cargo-package-crates ''("vrc-get")
      ;; `cargo install` は workspace root だと virtual manifest を
      ;; 受け付けないため、CLI 本体のサブディレクトリを明示。
      #:cargo-install-paths ''("vrc-get")))
    (native-inputs
     (list pkg-config))
    (inputs
     (cons openssl
           (cargo-inputs 'vrc-get
                         #:module '(rejafdofs packages rust-crates))))
    (home-page "https://github.com/vrc-get/vrc-get")
    (synopsis "VRChat Package Manager (VCC) の OSS コマンドライン代替")
    (description
     "vrc-get は VRChat Creator Companion (VCC) の代替として動作する
軽量で高速な OSS のコマンドラインツール (Rust 製)。VPM リポジトリを追加・
削除したり、Unity プロジェクトにパッケージを導入するなどの操作を
スクリプトしやすい形で提供する。")
    (license license:expat)))
