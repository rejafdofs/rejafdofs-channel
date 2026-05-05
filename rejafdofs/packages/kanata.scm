;;; rejafdofs channel --- キーボードカスタマイズツール。
;;;
;;; 提供パッケージ:
;;;   - kanata : 多層キーマップ (tap-hold / マクロ / Unicode 出力等) を
;;;              ソフトウェアで実現するクロスプラットフォーム
;;;              キーリマッパ (Rust 製)。
;;;
;;; 上流: https://github.com/jtroo/kanata  (LGPL-3.0-only)
;;;
;;; === 実装メモ ===
;;;
;;; 1. Cargo workspace で、binary クレート `kanata` がリポジトリ root、
;;;    `parser` `keyberon` `tcp_protocol` 等の補助クレートが workspace
;;;    members としてサブディレクトリに配置されている。CLI (`kanata`)
;;;    のみを成果物としてインストールする。
;;;
;;; 2. デフォルト feature には `win_sendinput_send_scancodes` が含まれる
;;;    が、これは kanata-parser の同名 cfg を有効化するだけで、実際の
;;;    Windows 専用依存 (winapi 等) は `[target.'cfg(target_os = "windows")']`
;;;    でゲートされている。Linux ビルドでは cargo が自動的に除外する
;;;    ため、追加の `--no-default-features` 指定は不要。
;;;
;;; 3. `Cargo.toml` の `edition = "2024"` は Rust 1.85+ で安定化。Guix
;;;    本家の rust が 1.85 未満の場合はビルドできないため、必要に応じて
;;;    `package-with-rust` 的に新しい rust-team を指定するか、上流の
;;;    `rust-version` 緩和を待つ。
;;;
;;; 4. 実行時には Linux で `/dev/uinput` への書き込み権限と、入力デバイス
;;;    `/dev/input/event*` への読み取り権限が必要。systemd-run / sudo /
;;;    `setcap cap_sys_admin+ep` 等の運用は本パッケージのスコープ外。
;;;
;;; === Rust crate 依存 ===
;;;
;;; 237 個の crate 依存は `rejafdofs/packages/rust-crates.scm` の
;;; `define-cargo-inputs` テーブルに `(kanata => (list ...))` として
;;; 既に登録済みです (うち 71 個は vrc-get と共通のため再利用、新規は
;;; 166 個)。上流の `Cargo.lock` が変わった時の再生成手順は同ファイル
;;; の冒頭コメントを参照してください。

(define-module (rejafdofs packages kanata)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages pkg-config)
  #:use-module (rejafdofs packages rust-crates))

(define-public kanata
  (package
    (name "kanata")
    (version "1.11.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/jtroo/kanata")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "11bwg6xk2y1x8kbyvw15yfmvc9nr7w5kbxrc0xpppzn8fz99bcgf"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:install-source? #f
      ;; テストは evdev / uinput 等の実デバイスに依存し、ビルド環境では
      ;; 実行不可能なため無効化。
      #:tests? #f
      ;; Cargo workspace のうち binary クレート `kanata` のみを
      ;; インストール対象とする。
      #:cargo-package-crates ''("kanata")
      #:cargo-install-paths ''(".")))
    (native-inputs
     (list pkg-config))
    (inputs
     (cargo-inputs 'kanata
                   #:module '(rejafdofs packages rust-crates)))
    (home-page "https://github.com/jtroo/kanata")
    (synopsis "多層キーマップ対応のクロスプラットフォーム キーリマッパ")
    (description
     "kanata は Linux / macOS / Windows で動作するソフトウェア
キーリマッパ。複数の「レイヤ」を切り替えて同じ物理キーに別の機能を
割り当てたり、tap-hold (短押し / 長押しで挙動を変える)、コンボ、
マクロ、Unicode 文字の直接入力、TCP 経由の外部制御などを提供する。

設定は専用の S 式風 DSL で記述し、ホットリロードに対応する。
QMK のような自作キーボードファームウェアの機能をソフトウェアで
再現することを目指したプロジェクトで、特殊なハードウェアを必要と
しない。

Linux で動作させるには @code{/dev/uinput} と @code{/dev/input/event*}
への適切なアクセス権が必要 (詳細は上流 wiki の
@samp{Avoid using sudo on Linux} を参照)。")
    (license license:lgpl3)))
