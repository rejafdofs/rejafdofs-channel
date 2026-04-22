# rejafdofs-channel

rejafdofs 個人向け Guix チャンネル。以下のパッケージを提供します。

| パッケージ       | バージョン | 説明                                                        | ビルド検証             | ライセンス |
|------------------|-----------|-------------------------------------------------------------|------------------------|------------|
| `nyxt`           | 3.11.7    | Common Lisp 製の拡張可能ウェブブラウザ (安定版)             | ✅ 成功 (Guix 2026)    | BSD-3      |
| `nyxt-next`      | 3.12.0    | Nyxt 3.12.0 (Nix 準拠、**実験版・現状ビルド失敗**)           | ⚠️ 失敗 (下記)          | BSD-3      |
| `vrc-get`        | 1.9.1     | VRChat Package Manager (VCC) の OSS CLI                     | ✅ 成功 (Guix 2026)    | MIT        |
| `ruby-ninix-fmo` | 1.0.2     | ninix-kagari 用 FileMappingObject Ruby gem                  | ✅ 成功                 | MIT        |
| `ninix-kagari`   | 3.1.1     | Ukagaka 互換デスクトップマスコット                          | ✅ 成功 (build のみ)    | GPL-2      |
| `sbcl-2.6`       | 2.6.3     | SBCL 2.6 系 (本家 sbcl@2.5.8 の override)                   | 定義のみ                | MIT / PD   |
| `sbcl-2.4`       | 2.4.11    | SBCL 2.4 系 (nixpkgs と同系統)                              | ✅ bootstrap 成功       | MIT / PD   |
| `sbcl-2.4.10`    | 2.4.10    | SBCL 2.4.10 (nixpkgs のデフォルトと同版)                    | 定義のみ                | MIT / PD   |

## セットアップ

`~/.config/guix/channels.scm` に以下を追記します。

```scheme
(cons* (channel
         (name 'rejafdofs)
         (url "https://github.com/rejafdofs/rejafdofs-channel.git")
         (branch "main"))
       %default-channels)
```

その後、チャンネルを取り込んでインストール。

```sh
guix pull
guix install nyxt vrc-get ninix-kagari
```

## ローカル開発

リポジトリを clone してそのまま `-L` で参照することもできます。

```sh
git clone https://github.com/rejafdofs/rejafdofs-channel.git
cd rejafdofs-channel
guix build -L . nyxt
guix build -L . ninix-kagari
```

## 実装状況 / 既知の事項

### Nyxt (`rejafdofs/packages/web-browsers.scm`)

本家 Guix では 2026-01-13 のコミット `16838140fe` で `nyxt` パッケージが
削除されました (upstream issue `guix/guix#518`)。これが `guix install nyxt`
が失敗する原因です。

本チャンネルでは 2 つのバリアントを提供します。

#### `nyxt` (3.11.7, 安定版 / 推奨)

削除直前のリビジョン `030bd035ae` に存在した **nyxt 3.11.7 の完全な
定義をそのまま取り込んで**います。依存する 73 個の sbcl-* / cl-* /
webkitgtk / gst-* 等は現行の本家 Guix に残っているため、追加定義は
不要で `guix build -L . nyxt` が通ります。

新しい SBCL (2.5.8+) は未使用レキシカル変数を style-warning で
報告するようになり、nyxt の `nasdf:fail-on-warnings` がそれを
コンパイルエラーに昇格するため、**`libraries/nasdf/tests.lisp` の
フィルタに `(typep c 'style-warning)` を追加する patch を自動で適用**
しています。

#### `nyxt-next` (3.12.0, 実験版 / 現状ビルド失敗)

upstream の公式リリース tarball
`nyxt-3.12.0-source-with-submodules.tar.xz` を使い、依存 Common Lisp を
_build/ 同梱版に統一する **Nix 準拠**の recipe です
(`nixpkgs/.../browsers/nyxt/default.nix` と upstream リポジトリ直下の
`guix.scm` を参考にした)。

`fix-so-paths` phase で _build/ 内各 .lisp のハードコードされた共有
ライブラリ名を Guix store 絶対パスに書き換えるなど、ビルド recipe
としては完成しています。

**既知問題 (2026-04 時点):** Nyxt 3.12.0 は `asdf:make` の
save-lisp-and-die 段階で SBCL の `scavenge_immobile_newspace` が
クラッシュする。同現象が SBCL 2.4.11 / 2.5.8 / 2.6.1 いずれでも
再現するため、SBCL version 固有ではなく Nyxt 3.12.0 側の immobile
space 使用パターンが原因とみなしている。SBCL 2.6.3+ / 上流修正待ち。

`guix install nyxt-next` で明示選択できるが、現状**ビルドは失敗**します。
安定動作には `nyxt` (3.11.7) を利用してください。

#### SBCL variants (`rejafdofs/packages/lisp-overrides.scm`)

本家 Guix の `sbcl@2.5.8` を version だけ差し替えた派生を提供:

  - `sbcl-2.6` (2.6.3)  — 最新系列
  - `sbcl-2.4` (2.4.11) — 長期安定系 (nixpkgs のサポート対象)
  - `sbcl-2.4.10`       — nixpkgs のデフォルトと同版

`nyxt-next` で SBCL version を切り替えて検証するときなどに利用。

### vrc-get (`rejafdofs/packages/vrchat.scm` + `rust-crates.scm`)

Rust クレート依存は `rejafdofs/packages/rust-crates.scm` にまとまって
います。このファイルは上流の Cargo.lock から **`guix import crate` で
自動生成**したもので、約 500 crate の定義を含みます。

上流が新しいバージョンを出したら、下記で再生成してください。

```sh
# 新バージョンのソースを用意 (vX.Y.Z タグを checkout)
git clone --branch vX.Y.Z --depth 1 \
  https://github.com/vrc-get/vrc-get /tmp/vrc-get

# rust-crates.scm を再生成 (既存を上書き)
truncate -s 0 rejafdofs/packages/rust-crates.scm
guix import -i rejafdofs/packages/rust-crates.scm crate \
  -f /tmp/vrc-get/Cargo.lock vrc-get

# 生成直後はヘッダ (define-module + #:export) が無い状態なので、
# 既存コミットから以下をファイル先頭にコピー:
#   (define-module (rejafdofs packages rust-crates) ...
#    #:export (lookup-cargo-inputs))
# そして define-cargo-inputs ブロックをファイル末尾に移動。
```

> Guix 1.4 系では新 Rust パッケージングモデル未対応で、cargo 本体も
> Cargo workspace inheritance に未対応のためビルドできません。
> 必ず `guix pull` 済みの新 Guix (2025 以降) を使用してください。

### ninix-kagari (`rejafdofs/packages/ukagaka.scm`)

同ファイル内で以下を定義します。

- `ruby-ninix-fmo` — ninix-kagari が依存する FileMappingObject 用 Ruby gem
  ([Tatakinov/ninix-fmo](https://github.com/Tatakinov/ninix-fmo) / MIT)
- `ninix-kagari` 本体

**実装メモ:**

1. `ruby-ninix-fmo` の上流 v1.0.1 タグには `.gemspec` が無いため、
   v1.0.2 タグを使用しています (gemspec の内部バージョンは 1.0.1 のまま)。
2. Linux の `shm_open` / `sem_*` は glibc < 2.34 で `librt` 経由です。
   ビルド phase で `extconf.rb` に `have_library('rt')` と
   `have_library('pthread')` を挿入しています。
3. SHIORI バックエンド (Aosora / Kawari / Satori / YAYA) と Sorakado (Ao / Ai)
   は**含めていません**。必要になったゴーストのディレクトリ内で個別に
   用意してください。ninix-kagari 本体のソース配置と起動スクリプト
   `bin/ninix` のインストールのみをサポートします。
4. `ninix-kagari` の runtime 依存のうち `ruby-gtk4`, `ruby-narray`, `ruby-zip`
   等は Guix 本家にまだ無いため、**`guix build` は成功しますが実行時に
   `require` が失敗する可能性**があります。将来これらが Guix に入るか、
   本チャンネルで追加定義するかで対応予定。

### SSP

ユーザ合意の上、スコープ外とします。Wine 経由のみ動作する
プロプライエタリ Windows バイナリのため、本チャンネルでは提供しません。

## ビルド検証ログ (実ビルド済み store path)

Guix 2026 (commit `30442f49a581447285bd6f050acec6a9b677f3ad`) 上で確認:

```
/gnu/store/gjya4jqs5hcb9jb1673cnn1c77145dxk-nyxt-3.11.7
/gnu/store/gg8qxiyzs9k3dwhidz0im0xw02hy2khq-vrc-get-1.9.1
/gnu/store/q04ksx2hmjr762lyq8sh9svd73qm057j-ruby-ninix-fmo-1.0.2
/gnu/store/rnw5642kygidrfxys2m31ljkr51c726q-ninix-kagari-3.1.1
```

動作確認済み:
- `nyxt --version` → `Nyxt version 3.11.7`
- `vrc-get --version` → `vrc-get 1.9.1`

## ライセンス

本リポジトリ (チャンネルのパッケージ定義ファイル) は GPL-3.0-or-later です。
各パッケージ自体のライセンスは上表を参照してください。
