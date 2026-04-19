# rejafdofs-channel

rejafdofs 個人向け Guix チャンネル。以下 3 パッケージを提供します。

| パッケージ       | バージョン | 説明                                                 | ビルド検証             | ライセンス |
|------------------|-----------|------------------------------------------------------|------------------------|------------|
| `nyxt`           | 3.11.7    | Common Lisp 製の拡張可能ウェブブラウザ               | ✅ 成功 (Guix 2026)    | BSD-3      |
| `vrc-get`        | 1.9.1     | VRChat Package Manager (VCC) の OSS CLI              | ⚠️  骨格のみ (別途要補完) | MIT        |
| `ruby-ninix-fmo` | 1.0.2     | ninix-kagari 用 FileMappingObject Ruby gem           | ✅ 成功                 | MIT        |
| `ninix-kagari`   | 3.1.1     | Ukagaka 互換デスクトップマスコット                   | ✅ 成功 (build のみ)    | GPL-2      |

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
guix install nyxt ninix-kagari
# vrc-get は下記「vrc-get」節を参照
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

本チャンネルでは、削除直前のリビジョン `030bd035ae` に存在した
**nyxt 3.11.7 の完全な定義をそのまま取り込んで**います。
依存する 73 個の sbcl-* / cl-* / webkitgtk / gst-* 等は現行の本家 Guix に
残っているため、追加定義は不要で `guix build -L . nyxt` が通ります。

なお、新しい SBCL (2.5.8+) は未使用レキシカル変数を style-warning で
報告するようになっており、nyxt の `nasdf:fail-on-warnings` がそれを
コンパイルエラーに昇格するため、**`libraries/nasdf/tests.lisp` の
フィルタに `(typep c 'style-warning)` を追加する patch を自動で適用**
しています。

### vrc-get (`rejafdofs/packages/vrchat.scm`)

骨格のみの定義で、**Rust クレート依存のリストは未完成**です。
実ビルド可能にするには次の手順で Cargo.lock から依存を生成してください。

```sh
# 事前に vrc-get のソースを用意 (v1.9.1 タグを checkout)
git clone --branch v1.9.1 --depth 1 https://github.com/vrc-get/vrc-get /tmp/vrc-get

# Cargo.lock から Guix パッケージ定義を自動生成
guix import -i rejafdofs/packages/rust-crates.scm crate \
  -f /tmp/vrc-get/Cargo.lock vrc-get
```

生成された `rust-crates.scm` をリポジトリに追加コミットすれば
`guix build -L . vrc-get` が通るはずです。

> 本家 Guix の新しい Rust パッケージングモデル
> (`cargo-inputs-from-lockfile` / `#:cargo-package-crates`) を前提としています。
> Guix 1.4 系では旧 API のみサポートで、かつ cargo が workspace inheritance
> 未対応のためビルドできません。必ず `guix pull` 後の新 Guix で使用してください。

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
/gnu/store/q04ksx2hmjr762lyq8sh9svd73qm057j-ruby-ninix-fmo-1.0.2
/gnu/store/rnw5642kygidrfxys2m31ljkr51c726q-ninix-kagari-3.1.1
```

`nyxt --version` が `Nyxt version 3.11.7` を返すこと、`--help` が
オプション一覧を表示することを確認済み。

## ライセンス

本リポジトリ (チャンネルのパッケージ定義ファイル) は GPL-3.0-or-later です。
各パッケージ自体のライセンスは上表を参照してください。
