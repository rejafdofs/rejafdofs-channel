# rejafdofs-channel

rejafdofs 個人向け Guix チャンネル。以下の 3 パッケージを提供します。

| パッケージ       | 説明                                                 | ライセンス |
|------------------|------------------------------------------------------|------------|
| `nyxt`           | Common Lisp 製の拡張可能ウェブブラウザ (本家の再エクスポート) | BSD-3      |
| `vrc-get`        | VRChat Package Manager (VCC) の OSS CLI              | MIT        |
| `ninix-kagari`   | Ukagaka 互換デスクトップマスコット                   | GPL-2      |

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
guix build -L . vrc-get
guix build -L . ninix-kagari
```

## 実装状況 / 既知の事項

### Nyxt (`rejafdofs/packages/web-browsers.scm`)

本家 `(gnu packages web-browsers)` の `nyxt` を再エクスポートしているだけです。
`guix pull` 後の本家 Guix に含まれるバージョンがそのまま公開されます。

もし本家より新しいバージョンを使いたい場合は、`rejafdofs/packages/web-browsers.scm`
の `define-public nyxt` を上書きし、`(inherit upstream-nyxt)` + 新しい `version`
と `source` を指定してください。

### vrc-get (`rejafdofs/packages/vrchat.scm`)

**骨格のみの定義**であり、Rust クレート依存のリストは未完成です。
実ビルド可能にするには次の手順でロックファイルから依存を生成してください。

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
> 旧 API (`#:cargo-inputs`) は 2026-12-31 に廃止予定。

### ninix-kagari (`rejafdofs/packages/ukagaka.scm`)

同ファイル内で以下を定義します。

- `ruby-ninix-fmo` — ninix-kagari が依存する FileMappingObject 用 Ruby gem
  ([Tatakinov/ninix-fmo](https://github.com/Tatakinov/ninix-fmo) / MIT)
- `ninix-kagari` 本体

**既知の制約:**

1. **`ruby-gtk4` 等の Ruby-GNOME バインディングが Guix 本家にまだ無い可能性**があります。
   その場合、本チャンネルで ruby-gnome スイートを追加定義する必要があります (未実装)。
2. SHIORI バックエンド (Aosora / Kawari / Satori / YAYA) と Sorakado (Ao / Ai) は
   本パッケージには**含めていません**。必要になったゴーストのディレクトリ内で
   個別に用意してください。ninix-kagari 本体の起動のみをサポートします。
3. ソースの sha256 ハッシュはプレースホルダです。初回ビルド時に `guix download` または
   `guix hash -rx` で取得した正しい値に差し替えてください。

### SSP

ユーザ合意の上、スコープ外とします。Wine 経由のみ動作する
プロプライエタリ Windows バイナリのため、本チャンネルでは提供しません。

## ライセンス

本リポジトリ (チャンネルのパッケージ定義ファイル) は GPL-3.0-or-later です。
各パッケージ自体のライセンスは上表を参照してください。
