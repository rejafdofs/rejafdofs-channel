#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
"""Hina Mincho 等幅化ポストプロセス。

fontmake が `.glyphspackage` から書き出した可変幅 TTF を読み込み、
各グリフの advance width を「半角 = UPM/2」「全角 = UPM」の 2 値に
丸めて、日本語フォントで言う "等幅" (= 半角/全角 2 種固定) に変換する。

  python3 hina-mincho-monospace.py <input.ttf> <output.ttf>
"""
import sys

from fontTools.ttLib import TTFont


FAMILY = "Hina Mincho Mono"
FULL_NAME = "Hina Mincho Mono Regular"
POSTSCRIPT_NAME = "HinaMinchoMono-Regular"


def monospacify(src_path: str, dst_path: str) -> None:
    font = TTFont(src_path)
    upm = font["head"].unitsPerEm
    half, full = upm // 2, upm
    # 半角と全角のちょうど中点。Hina Mincho の UPM=1000 では 750。
    # プロポーショナル Latin (~200..700) は半角に、CJK (=1000) は全角に倒れる。
    threshold = (half + full) // 2

    hmtx = font["hmtx"]
    new_metrics = {}
    for name, (adv, lsb) in hmtx.metrics.items():
        if adv == 0:
            target = 0
        elif adv < threshold:
            target = half
        else:
            target = full
        # グリフを左右中央へ寄せる (LSB を半分だけずらす)
        if target and target != adv:
            lsb += (target - adv) // 2
        new_metrics[name] = (target, lsb)
    hmtx.metrics = new_metrics

    # name テーブル書き換え。Windows (3,1,0x409) と Mac (1,0,0) の両方に
    # 英語名を入れておけば fc-list / Pango / CoreText いずれも拾える。
    name_tbl = font["name"]
    for name_id, value in (
        (1, FAMILY),          # Family
        (4, FULL_NAME),       # Full name
        (6, POSTSCRIPT_NAME), # PostScript name
        (16, FAMILY),         # Typographic Family
    ):
        name_tbl.setName(value, name_id, 3, 1, 0x409)
        name_tbl.setName(value, name_id, 1, 0, 0)

    # OS/2 panose の bProportion = 9 (Monospaced)。
    # 厳密には半角/全角 2 値なので post.isFixedPitch は立てない
    # (= "全グリフ単一 advance" を意味するため誤情報になる)。
    font["OS/2"].panose.bProportion = 9

    font.save(dst_path)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(f"usage: {sys.argv[0]} <input.ttf> <output.ttf>")
    monospacify(sys.argv[1], sys.argv[2])
