#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-3.0-or-later
"""Hina Mincho ソースから等幅 TTF をビルドする。

  python3 hina-mincho-monospace.py <source.glyphspackage> <output.ttf>

処理手順:
  1. .glyphspackage (= ディレクトリ形式の Glyphs 3 ソース) を 1 ファイルの
     .glyphs (= openstep plist) に結合する。Guix 1.4 同梱の glyphsLib 6.0.7
     は .glyphspackage を直接読めない (6.1+ で対応) ため、ここで前処理する。
  2. glyphsLib で .glyphs を読み込み designspace + UFO に変換。
  3. ufo2ft.compileTTF で UFO → fontTools.TTFont を生成
     (= fontmake が内部でやっているのと同じ呼び出しを直接行う)。
  4. fontTools の hmtx を半角=UPM/2、全角=UPM の 2 値に丸めて
     等幅化、name と OS/2 を更新して保存。
"""
import sys
import tempfile
from pathlib import Path

import glyphsLib
import openstep_plist
from ufo2ft import compileTTF


FAMILY = "Hina Mincho Mono"
FULL_NAME = "Hina Mincho Mono Regular"
POSTSCRIPT_NAME = "HinaMinchoMono-Regular"


def _dedup_custom_parameters(node) -> None:
    """`customParameters` の重複 (同名複数) を再帰的に潰す。

    Glyphs エディタは customParameters の重複を許容し、新しい順 (リスト
    末尾) の値で上書きする。一方 glyphsLib 6.0.7 は重複に対して
    `RuntimeError: More than one value for this customParameter` を
    投げるため、ファイルを glyphsLib に渡す前に正規化する。
    Hina Mincho では fontMaster の hheaLineGap が 350 と 0 の 2 回
    現れるのが既知。
    """
    if isinstance(node, dict):
        if "customParameters" in node and isinstance(node["customParameters"], list):
            seen = {}
            for entry in node["customParameters"]:
                if isinstance(entry, dict) and "name" in entry:
                    seen[entry["name"]] = entry  # 後勝ち
                else:
                    seen[id(entry)] = entry  # 名無しはそのまま残す
            node["customParameters"] = list(seen.values())
        for value in node.values():
            _dedup_custom_parameters(value)
    elif isinstance(node, list):
        for item in node:
            _dedup_custom_parameters(item)


def glyphspackage_to_glyphs(pkg_path: Path, out_path: Path) -> Path:
    """`.glyphspackage` ディレクトリを単一の `.glyphs` plist に結合する。

    .glyphspackage の構成:
      fontinfo.plist  - フォントレベルのメタデータ (.appVersion, familyName,
                        masters, instances ...)。`glyphs` キーは含まない。
      glyphs/*.glyph  - 1 グリフ 1 ファイルの plist。
      order.plist     - グリフ名の表示順を表す配列。
      UIState.plist   - エディタの UI 状態 (ビルドには不要)。
    """
    # use_numbers=True を必ず付ける。これが無いと "1.004" や "100" 等が
    # 文字列で読み込まれ、glyphsLib の setter (setVersionMinor 等) が
    # int 比較で TypeError を投げる。
    with open(pkg_path / "fontinfo.plist", encoding="utf-8") as f:
        merged = openstep_plist.load(f, use_numbers=True)
    with open(pkg_path / "order.plist", encoding="utf-8") as f:
        order = openstep_plist.load(f, use_numbers=True)
    order_idx = {name: i for i, name in enumerate(order)}

    glyph_dicts = []
    for gpath in sorted((pkg_path / "glyphs").iterdir()):
        if gpath.suffix != ".glyph":
            continue
        with open(gpath, encoding="utf-8") as f:
            glyph_dicts.append(openstep_plist.load(f, use_numbers=True))
    # order.plist に無いグリフは末尾にまとめる。
    glyph_dicts.sort(key=lambda g: order_idx.get(g.get("glyphname"), 1 << 30))
    merged["glyphs"] = glyph_dicts

    _dedup_custom_parameters(merged)

    with open(out_path, "w", encoding="utf-8") as f:
        openstep_plist.dump(merged, f)
    return out_path


def build_ttf(glyphs_source_path: str):
    """`.glyphs` または `.glyphspackage` を読んで fontTools.TTFont を返す。"""
    src = Path(glyphs_source_path)
    if src.suffix == ".glyphspackage":
        tmp_glyphs = Path(tempfile.mkdtemp()) / (src.stem + ".glyphs")
        glyphspackage_to_glyphs(src, tmp_glyphs)
        src = tmp_glyphs
    gs_font = glyphsLib.GSFont(str(src))
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

