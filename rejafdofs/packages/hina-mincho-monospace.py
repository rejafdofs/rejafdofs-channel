#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
"""Hina Mincho ソースから等幅 TTF をビルドする。

  python3 hina-mincho-monospace.py <source.glyphspackage> <output.ttf>

処理手順:
  1. glyphsLib で .glyphspackage を読み込み designspace + UFO に変換。
  2. ufo2ft.compileTTF で UFO → fontTools.TTFont を生成
     (= fontmake が内部でやっているのと同じ呼び出しを直接行う。
      fontmake パッケージが Guix 1.4 系に無いためここで代替する)。
  3. fontTools の hmtx を半角=UPM/2、全角=UPM の 2 値に丸めて
     等幅化、name と OS/2 を更新して保存。
"""
import sys

import glyphsLib
from ufo2ft import compileTTF


FAMILY = "Hina Mincho Mono"
FULL_NAME = "Hina Mincho Mono Regular"
POSTSCRIPT_NAME = "HinaMinchoMono-Regular"


def build_ttf(glyphs_source_path: str):
    """`.glyphspackage` を読んで fontTools.TTFont を返す。"""
    gs_font = glyphsLib.GSFont(glyphs_source_path)
    ds = glyphsLib.to_designspace(gs_font)
    # Hina Mincho は単一マスター。先頭ソースの UFO を使う。
    ufo = ds.sources[0].font
    return compileTTF(ufo)


def monospacify(font) -> None:
    """hmtx の advance を半角/全角の 2 値に丸めて name/OS2 を書き換える。"""
    upm = font["head"].unitsPerEm  # Hina Mincho は 1000
    half, full = upm // 2, upm
    # プロポーショナル Latin (~200..700) は半角に、CJK (=1000) は全角に倒れる
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

    # name 書き換え。Windows (3,1,0x409) と Mac (1,0,0) の両方に英語名を入れて
    # おけば fc-list / Pango / CoreText いずれも拾える。
    name_tbl = font["name"]
    for name_id, value in (
        (1, FAMILY),
        (4, FULL_NAME),
        (6, POSTSCRIPT_NAME),
        (16, FAMILY),
    ):
        name_tbl.setName(value, name_id, 3, 1, 0x409)
        name_tbl.setName(value, name_id, 1, 0, 0)

    # OS/2 panose の bProportion = 9 (Monospaced)。
    # 厳密には半角/全角 2 値なので post.isFixedPitch は立てない
    # (= "全グリフ単一 advance" を意味するため誤情報になる)。
    font["OS/2"].panose.bProportion = 9


def main(src_path: str, dst_path: str) -> None:
    font = build_ttf(src_path)
    monospacify(font)
    font.save(dst_path)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(f"usage: {sys.argv[0]} <source.glyphspackage> <output.ttf>")
    main(sys.argv[1], sys.argv[2])
