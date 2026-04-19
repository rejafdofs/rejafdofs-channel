;;; rejafdofs channel --- VRChat tooling.
;;;
;;; vrc-get: Fast OSS command-line client for VRChat Package Manager.
;;; Upstream: https://github.com/vrc-get/vrc-get  (MIT)
;;;
;;; 本パッケージは Rust の Cargo workspace 内の `vrc-get` クレート (CLI 本体) のみを
;;; ビルドします。GUI 版 (`vrc-get-gui` / ALCOM) は Tauri 依存が重いため対象外。
;;;
;;; === 重要: Rust クレート依存の生成 ===
;;; このファイル単体ではビルドできません。`rejafdofs/packages/rust-crates.scm` に
;;; Cargo.lock 由来の依存パッケージ定義を生成してから使用してください。
;;;
;;;   git clone --branch v1.9.1 --depth 1 \
;;;     https://github.com/vrc-get/vrc-get /tmp/vrc-get
;;;   guix import -i rejafdofs/packages/rust-crates.scm crate \
;;;     -f /tmp/vrc-get/Cargo.lock vrc-get
;;;
;;; 生成後、下の `cargo-inputs-from-lockfile` が参照する場所を正しく差し替えて
;;; ください。詳細は README.md を参照。

(define-module (rejafdofs packages vrchat)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages tls))

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
      ;; 本家 Guix (2025 以降の新 Rust 方式) を使う場合は、下記を有効化して
      ;; Cargo workspace 内の CLI クレートだけをビルド対象にしてください:
      ;;
      ;;   #:cargo-package-crates #~'("vrc-get")
      ;;
      ;; Guix 1.4 系ではこのキーワードが未サポートです。その場合は
      ;; cargo-build-system のデフォルト挙動 (workspace の default-members を
      ;; すべてビルド) を使うか、snippet で vrc-get 以外を削除してください。
      #:install-source? #f
      #:tests? #f))
    (native-inputs
     (list pkg-config))
    (inputs
     ;; 静的リンクされるが、ビルド時に OpenSSL ヘッダを必要とすることがある。
     (list openssl))
    (home-page "https://github.com/vrc-get/vrc-get")
    (synopsis "VRChat Package Manager (VCC) の OSS コマンドライン代替")
    (description
     "vrc-get は VRChat Creator Companion (VCC) の代替として動作する
軽量で高速な OSS のコマンドラインツール (Rust 製)。VPM リポジトリを追加・
削除したり、Unity プロジェクトにパッケージを導入するなどの操作を
スクリプトしやすい形で提供する。")
    (license license:expat)))
