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
  4. ターミナル表示用の等幅化を fontTools で実施:
     - 各グリフの advance を Unicode East Asian Width で
       半角 (UPM/2) / 全角 (UPM) のいずれかに丸める
     - post.isFixedPitch=1 / OS/2.panose.bProportion=9 /
       OS/2.xAvgCharWidth=半角値 を立て fontconfig に monospace 認識させる
     - name テーブルを `Hina Mincho Mono` に書き換える
"""
import sys
import tempfile
import unicodedata
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
    font = build_ttf(src_path)
    monospacify(font)
    font.save(dst_path)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(f"usage: {sys.argv[0]} <source.glyphspackage> <output.ttf>")
    main(sys.argv[1], sys.argv[2])

