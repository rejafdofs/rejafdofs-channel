#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
"""Hina Mincho の TTF を等幅化する。

  python3 hina-mincho-monospace.py <input.ttf> <output.ttf>

上流が `fonts/ttf/Hina-Mincho-Regular.ttf` として配布している既ビルド TTF を
入力に取り、ターミナル表示用に以下を行って書き出す:
  - 各グリフの advance を Unicode East Asian Width で
    半角 (UPM/2) / 全角 (UPM) のいずれかに丸める
  - post.isFixedPitch=1 / OS/2.panose.bProportion=9 /
    OS/2.xAvgCharWidth=半角値 を立て fontconfig に monospace 認識させる
  - name テーブルを `Hina Mincho Mono` に書き換える

Glyphs ソース (`.glyphspackage`) からの再ビルド経路は使わない。glyphsLib
6.1+ が Hina Mincho の `_part.*` 系スマートコンポーネントの古い軸メタ
情報 (未参照の `partsSettings` / 日付バックアップレイヤ等) で
KeyError / Locations must be unique. を投げ、バージョンによって異なる
場所で破綻するため。上流配布 TTF の outline をそのまま使い、advance と
メタデータだけを書き換える方が頑健。
"""
import sys
import unicodedata

from fontTools.ttLib import TTFont


FAMILY = "Hina Mincho Mono"
FULL_NAME = "Hina Mincho Mono Regular"
POSTSCRIPT_NAME = "HinaMinchoMono-Regular"

# name テーブルのうちフォント名同定に使われる ID と、そこに入れる新しい値。
#   1, 16, 21      : Family / Preferred Family / WWS Family
#   4, 18          : Full Name / Mac compatible full
#   6, 20          : PostScript Name / CID findfont name
#   3              : Unique font identifier (重複すると OS が同一フォント
#                    扱いし得るので必ず差し替える)
NAME_RENAMES = {
    1: FAMILY,
    3: POSTSCRIPT_NAME,
    4: FULL_NAME,
    6: POSTSCRIPT_NAME,
    16: FAMILY,
    18: FULL_NAME,
    20: POSTSCRIPT_NAME,
    21: FAMILY,
}


def _build_target_widths(font, half: int, full: int) -> dict:
    """各グリフの target advance を Unicode East Asian Width で決める。

    ターミナル表示が目的なので「1 セル = 半角、2 セル = 全角」になるよう
    Unicode の EAW プロパティで判定する:
      - F (Fullwidth) / W (Wide) / A (Ambiguous) → 全角 (= 2 セル)
        Ambiguous (罫線・記号類) は CJK ロケールのターミナル慣例どおり
        全角扱いにする。Hina Mincho は日本語フォントなので妥当。
      - Na (Narrow) / H (Halfwidth) / N (Neutral) → 半角 (= 1 セル)
        Mincho の大文字 Latin は元 advance が 700+ で広いが、ターミナル
        では半角扱いを強制する (元設計を尊重した結果セル幅が崩れる方が
        ターミナル用途では致命的)。
    cmap に無いグリフ (合字, 異体字, .alt, .sub 系など) は元 advance を
    閾値で丸める fallback。
    """
    cmap = font.getBestCmap()
    glyph_to_cps: dict = {}
    for cp, gname in cmap.items():
        glyph_to_cps.setdefault(gname, []).append(cp)

    threshold = (half + full) // 2
    targets = {}
    for gname, (adv, _) in font["hmtx"].metrics.items():
        cps = glyph_to_cps.get(gname)
        if cps:
            is_full = any(
                unicodedata.east_asian_width(chr(cp)) in ("F", "W", "A")
                for cp in cps
            )
            targets[gname] = full if is_full else half
        elif adv == 0:
            targets[gname] = 0
        else:
            targets[gname] = full if adv >= threshold else half
    return targets


def monospacify(font) -> None:
    """hmtx の advance を半角/全角の 2 値に丸めて name/OS2/post を書き換える。"""
    upm = font["head"].unitsPerEm  # Hina Mincho は 1000
    half, full = upm // 2, upm
    targets = _build_target_widths(font, half, full)

    hmtx = font["hmtx"]
    new_metrics = {}
    for name, (adv, lsb) in hmtx.metrics.items():
        target = targets[name]
        # グリフを左右中央へ寄せる (LSB を半分だけずらす)
        if target and target != adv:
            lsb += (target - adv) // 2
        new_metrics[name] = (target, lsb)
    hmtx.metrics = new_metrics

    # hhea.advanceWidthMax / minLeftSideBearing / xMaxExtent 等は
    # hmtx を書き換えただけだと旧値のまま残る。fontTools の compile() は
    # `glyf` テーブルがロード済みのときにのみ recalc を走らせるため、
    # ここで明示的にデコンパイルさせて save() 時の recalc を有効化する。
    font["glyf"]

    # name 書き換え。上流 Hina Mincho の TTF には Windows 日本語
    # (3,1,0x411) や Mac 日本語 (1,1,11) ロケールの name レコードが
    # "ひな明朝" / "Hina Mincho" として入っている。setName で英語ロケール
    # だけ差し替えても、ja_JP の fontconfig や日本語 OS の font picker は
    # 日本語ロケール側の record を優先するので、結果として等幅派生が
    # 上流と同じ "ひな明朝" 名で見えてしまい区別できない。
    # 該当 nameID のレコードを (ロケール問わず) 一旦すべて削除してから、
    # Windows 英語 (3,1,0x409) と Mac Roman (1,0,0) に新しい英語名だけを
    # 入れ直す。日本語ロケール用の record は意図的に残さない (残すと
    # その名前が再び表に出てきて元のと衝突するため)。
    name_tbl = font["name"]
    name_tbl.names = [
        r for r in name_tbl.names if r.nameID not in NAME_RENAMES
    ]
    for name_id, value in NAME_RENAMES.items():
        name_tbl.setName(value, name_id, 3, 1, 0x409)
        name_tbl.setName(value, name_id, 1, 0, 0)

    # ターミナル (fontconfig :spacing=mono / Pango monospace) で拾われる
    # ように post.isFixedPitch と OS/2.panose を立てる。
    # 半角/全角 2 値なので厳密には "単一 advance" ではないが、CJK 等幅
    # フォント (Source Han Mono, BIZ UDGothic, HackGen, UDEV Gothic 等) は
    # 一様にこのフラグを立てる慣習に従う。さもないと fontconfig がこの
    # フォントを monospace ファミリとして認識せず、ターミナルから
    # `Hina Mincho Mono` を選んでも fallback されて意味が無い。
    font["post"].isFixedPitch = 1
    font["OS/2"].panose.bProportion = 9
    # OS/2.xAvgCharWidth はターミナルでの 1 セル幅基準。半角に合わせる。
    font["OS/2"].xAvgCharWidth = half


def main(src_path: str, dst_path: str) -> None:
    font = TTFont(src_path)
    monospacify(font)
    font.save(dst_path)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(f"usage: {sys.argv[0]} <input.ttf> <output.ttf>")
    main(sys.argv[1], sys.argv[2])
