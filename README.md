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
| `font-hina-mincho` | 1.004   | 古風で可愛い日本語明朝体 (satsuyako 氏)                     | ✅ 成功 (Guix 1.4)      | OFL-1.1    |
| `font-hina-mincho-mono` | 1.004 | Hina Mincho ターミナル用等幅派生 (ソースからビルド)        | ✅ 成功 (Guix 1.4)      | OFL-1.1    |
| `kanata`         | 1.11.0    | 多層キーマップ対応のクロスプラットフォーム キーリマッパ     | crate-inputs 整備済 (下記) | LGPL-3     |

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
guix build -L . font-hina-mincho
guix build -L . font-hina-mincho-mono
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

### font-hina-mincho (`rejafdofs/packages/fonts.scm`)

[satsuyako/Hina-Mincho](https://github.com/satsuyako/Hina-Mincho) を
そのまま提供します。雛人形にインスパイアされた古風で可愛い日本語
明朝体で、Google Fonts / Adobe Fonts にも収録されています。

**実装メモ:**

1. 上流リポジトリは git tag / GitHub Release を切っていないため、
   特定 commit (`1bdbf0b0...`, 2026-03-20) に固定し、Guix 慣例の
   `(git-version "1.004" "0" commit)` で version 文字列を生成して
   います。上流が新しいコミットを出した時はこの 2 ヶ所
   (`commit` / `revision`) と `sha256` を更新してください。
2. 上流配布の `fonts/ttf/Hina-Mincho-Regular.ttf` をそのまま
   `share/fonts/truetype/` に配置するだけの `copy-build-system`
   パッケージです。Glyphs ソース (`.glyphspackage`) からのリビルドは
   Glyphs 自体が非自由のため行いません。
3. インストール後 `fc-list | grep -i hina` で
   `Hina Mincho:style=Regular` が認識されることを確認できます。

### font-hina-mincho-mono (`rejafdofs/packages/fonts.scm`)

`font-hina-mincho` と同じ上流コミットから、Glyphs 3 ソース
`sources/Hina-Mincho.glyphspackage` を **ソースからリビルド** して
ターミナル表示向けの等幅派生を生成するパッケージです。

**ビルドフロー** (`hina-mincho-monospace.py` が一括して実行):

1. `.glyphspackage` (= ディレクトリ形式の Glyphs 3 ソース) を
   `python-openstep-plist` で読み、`fontinfo.plist` + `glyphs/*.glyph` +
   `order.plist` を結合して単一の `.glyphs` plist を生成。
2. `python-glyphslib` で `.glyphs` → designspace + UFO に変換。
3. `python-ufo2ft` の `compileTTF` で UFO → fontTools.TTFont を生成
   (= fontmake が内部でやっているのと同じ呼び出し。fontmake パッケージ
   自体は Guix 1.4 系に無いため不要にしている)。
4. 各グリフの cmap 逆引きから Unicode East Asian Width を引いて
   advance を半角 (UPM/2=500) / 全角 (UPM=1000) のいずれかに
   丸める。Ambiguous (罫線・記号類) は CJK ロケールのターミナル
   慣例どおり全角扱い。cmap 外グリフ (合字/異体字) は元 advance を
   閾値で丸める fallback。
5. `post.isFixedPitch=1`, `OS/2.panose.bProportion=9`,
   `OS/2.xAvgCharWidth=500` を立てて fontconfig に monospace
   ファミリとして拾わせる。`name` テーブルを
   `Hina Mincho Mono` / `HinaMinchoMono-Regular` に書き換える。

**実装メモ:**

1. **Glyphs 本体 (非自由) は不要**。`.glyphspackage` から
   `python-fontmake` 相当のパイプライン (`glyphsLib` + `ufo2ft`) を
   Python から直接駆動している。
2. **Guix 1.4 系の制約への対応** (詳細はコミットログ参照):
   - `python-ufo2ft 2.28.0` が要求する `fontTools.designspaceLib.split`
     は `python-fonttools 4.28.5` (デフォルト) に無いため、
     `propagated-inputs` を `modify-inputs` で `python-fonttools-next`
     (4.37.1) に直接差し替えた派生 (`python-ufo2ft/fonttools-next` 等)
     を使う。`package-input-rewriting` だと依存グラフ全体を再帰書換
     して guix プロセスが 16 GB を食って OOM される。
   - `python-glyphslib 6.0.7` は `.glyphspackage` を直接読めない
     (6.1+ で対応)。よって 1. の前処理が必要。
   - `glyphsLib 6.0.7` は `customParameters` の重複 (Glyphs エディタは
     許容、Hina Mincho では `hheaLineGap` が 350 と 0 で 2 回登録)
     に対し `RuntimeError` を投げるため、前処理段階で再帰的に
     name でユニーク化する (Glyphs 同様後勝ち)。
3. ファミリ名を変えてあるため `font-hina-mincho` と同時インストール
   しても名前空間で衝突しません。`fc-match 'Hina Mincho Mono:spacing=mono'`
   で確実に拾えます。

**ターミナル表示の確認結果** (主要グリフの advance):

```
ASCII (' ' 'A' 'a' '0' '~') / Latin extended ('©') / 半角カナ (ｱ) → 500
全角 Latin (Ａ) / ひらがな (あ) / 漢字 (中, 愛) / カタカナ (ア)   → 1000
Ambiguous (罫線 ─, em-dash —, ギリシャ α, キリル Ё)              → 1000
```

### kanata (`rejafdofs/packages/kanata.scm`)

[jtroo/kanata](https://github.com/jtroo/kanata) は QMK ライクな多層
キーマップをソフトウェアで実現するキーリマッパ。`kanata.scm` は
v1.11.0 の binary クレート (`kanata`) のみをビルドする
`cargo-build-system` パッケージ定義です。

**実装メモ:**

1. 上流 `Cargo.toml` の `edition = "2024"` は Rust 1.85+ で安定化
   されたエディション。Guix 本家の rust が 1.85 未満の段階では
   `error[E0658]: edition 2024 is unstable` でビルドできないため、
   新しい Guix (rust ≥ 1.85 を含む 2025 春以降) を必須とする。
2. デフォルト feature の `win_sendinput_send_scancodes` は
   `kanata-parser` 側の cfg を立てるだけで、Windows 専用の native
   依存 (`winapi` / `native-windows-gui` 等) は Cargo 側で
   `cfg(target_os = "windows")` ゲートされている。Linux 上では
   そのままデフォルト feature でビルドできる。
3. `--features gui` (Windows GUI tray アプリ) と
   `--features interception_driver` (Windows カーネルドライバ) は
   非 Linux 限定なので有効化しない。
4. 実行時には `/dev/uinput` への書き込みと `/dev/input/event*` の
   読み取り権限が必要。`udev` ルールや `setcap` 等の運用設定は
   パッケージ側では行わない (`man udev` 参照)。

**Rust crate 依存:**

`rejafdofs/packages/rust-crates.scm` の `define-cargo-inputs` に
`(kanata => (list ...))` 節として 237 個の crate を登録済み (うち 71
個は vrc-get と共通)。新規追加した 166 個の `crate-source` 定義も
同ファイルにマージしている。

ハッシュ生成は `Cargo.lock` の `[[package]]` から `checksum` を取り
出して nix-base32 エンコードしている。Guix 2025+ の `guix import
crate -f Cargo.lock kanata` を流す方法でも完全に等価な結果になる。

```sh
# 上流が新バージョンを出した場合の更新手順 (Guix 2025+ 環境):
git clone --branch vX.Y.Z --depth 1 \
  https://github.com/jtroo/kanata /tmp/kanata
guix import -i rejafdofs/packages/rust-crates.scm crate \
  -f /tmp/kanata/Cargo.lock kanata
# 生成された (kanata => (list ...)) ブロックで既存節を置換し、
# 新バージョンの crate-source 定義を本体にマージする。
```

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

Guix 1.4 (substitutes 経由) でも以下を確認:

```
/gnu/store/764h1sdkf3jf10gna1gnj64vz1shpx09-font-hina-mincho-1.004-0.1bdbf0b
/gnu/store/rmg4cp0dcrmc9pamysx03xs0g4yn46wy-font-hina-mincho-mono-1.004-0.1bdbf0b
```

動作確認済み:
- `nyxt --version` → `Nyxt version 3.11.7`
- `vrc-get --version` → `vrc-get 1.9.1`
- `font-hina-mincho` の `share/fonts/truetype/Hina-Mincho-Regular.ttf` が
  正常に配置されること (TrueType Font data, digitally signed, 16 tables)
- `font-hina-mincho-mono` の `HinaMinchoMono-Regular.ttf` (5.16 MB,
  TrueType 15 tables) が出力され、`post.isFixedPitch=1`,
  `OS/2.panose.bProportion=9`, ユニーク advance = `{0, 500, 1000}`,
  EAW Na/H/N グリフが 500 / EAW F/W/A が 1000 になっていること

## ライセンス

本リポジトリ (チャンネルのパッケージ定義ファイル) は GPL-3.0-or-later です。
各パッケージ自体のライセンスは上表を参照してください。
