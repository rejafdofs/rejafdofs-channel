;;; rejafdofs channel --- 日本語フォント。
;;;
;;; 提供パッケージ:
;;;   - font-hina-mincho      : 古風で可愛い日本語明朝体 (satsuyako 氏)
;;;   - font-hina-mincho-mono : 上記の等幅 (半角/全角 2 値) 派生。
;;;                             ソース (.glyphspackage) から fontmake で
;;;                             ビルドし、fontTools でアドバンス幅を
;;;                             丸めて等幅化する。
;;;
;;; 上流: https://github.com/satsuyako/Hina-Mincho  (SIL OFL 1.1)
;;;
;;; === 実装メモ ===
;;;
;;; 上流リポジトリは git tag / GitHub Release を切っていないため、
;;; commit hash で固定し、version 文字列は Guix 慣例の
;;; "<upstream-ver>-<revision>.<short-hash>" 形式で表現する
;;; (`(git-version ...)` ヘルパで生成)。上流の内部 version は
;;; README / ファイル `fontVersion.plist` に "1.004" と記載されている。
;;;
;;; font-hina-mincho:
;;;   上流配布の TTF (fonts/ttf/Hina-Mincho-Regular.ttf) をそのまま
;;;   share/fonts/truetype/ 以下に配置するだけの素朴な
;;;   copy-build-system パッケージ。
;;;
;;; font-hina-mincho-mono:
;;;   上流が同梱している Glyphs 3 ソース (sources/Hina-Mincho.glyphspackage)
;;;   から python-fontmake (内部で python-glyphslib が .glyphspackage を
;;;   UFO/designspace に変換) で TTF をビルドし、付属スクリプト
;;;   hina-mincho-monospace.py が fontTools 経由で hmtx/OS2/name を書き換え
;;;   半角=500/全角=1000 の等幅 TTF として吐き出す。Glyphs 本体 (非自由)
;;;   は不要。

(define-module (rejafdofs packages fonts)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:))

(define-public font-hina-mincho
  (let ((commit "1bdbf0b059c16810db0f71657e1ed4c723a3b139")
        (revision "0"))
    (package
      (name "font-hina-mincho")
      (version (git-version "1.004" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/satsuyako/Hina-Mincho")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0rcni8k0vj4z40h7pby7b3dhm29pm2c22fyd50fzk5qq1gjjrsmq"))))
      (build-system copy-build-system)
      (arguments
       (list
        #:install-plan
        #~'(("fonts/ttf/Hina-Mincho-Regular.ttf"
             "share/fonts/truetype/")
            ("OFL.txt"
             "share/doc/font-hina-mincho/")
            ("README.md"
             "share/doc/font-hina-mincho/")
            ("AUTHORS.txt"
             "share/doc/font-hina-mincho/")
            ("CONTRIBUTORS.txt"
             "share/doc/font-hina-mincho/"))))
      (synopsis "古風でかわいい日本語明朝体 (Hina Mincho)")
      (description
       "Hina Mincho は satsuyako 氏による日本語明朝体フォント。
雛人形にインスパイアされた古風で柔らかな字形で、ひらがな・カタカナ・
JIS X 0208 第一/第二水準漢字に加え、拡張ラテン (Google Latin Plus)・
キリル・ギリシャ・各種記号類までをカバーする。
Google Fonts および Adobe Fonts に収録されている。")
      (home-page "https://github.com/satsuyako/Hina-Mincho")
      (license license:silofl1.1))))

(define-public font-hina-mincho-mono
  (package
    (inherit font-hina-mincho)
    (name "font-hina-mincho-mono")
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          ;; .glyphspackage → UFO/designspace → TTF を fontmake が一発で行う。
          ;; configure / check / strip は不要。
          (delete 'configure)
          (delete 'check)
          (delete 'strip)
          (replace 'build
            (lambda _
              ;; ソースの .glyphspackage を読み込んで等幅 TTF を吐くまでを
              ;; 1 つの Python スクリプトで行う (glyphsLib + ufo2ft +
              ;; fontTools)。fontmake パッケージが Guix 1.4 系に存在しない
              ;; ため、fontmake が内部でやっている GSFont→designspace→
              ;; compileTTF のパイプラインを直接呼んでいる。
              (mkdir-p "build")
              (invoke "python3"
                      #$(local-file "hina-mincho-monospace.py")
                      "sources/Hina-Mincho.glyphspackage"
                      "build/HinaMinchoMono-Regular.ttf")))
          (replace 'install
            (lambda _
              (let ((ttf (string-append #$output "/share/fonts/truetype"))
                    (doc (string-append #$output
                                        "/share/doc/font-hina-mincho-mono")))
                (mkdir-p ttf)
                (mkdir-p doc)
                (install-file "build/HinaMinchoMono-Regular.ttf" ttf)
                (for-each (lambda (f)
                            (when (file-exists? f) (install-file f doc)))
                          '("OFL.txt" "README.md"
                            "AUTHORS.txt" "CONTRIBUTORS.txt"))))))))
    (native-inputs
     (list python-wrapper
           python-glyphslib
           python-ufo2ft
           python-fonttools))
    (synopsis "Hina Mincho の等幅派生 (半角/全角 2 値、ソースからビルド)")
    (description
     "Hina Mincho を日本語フォント慣習の \"等幅\" 形式 (半角 = UPM/2、
全角 = UPM の 2 値固定) に変換した派生フォント。上流が同梱する
Glyphs 3 ソース @file{sources/Hina-Mincho.glyphspackage} から
@command{fontmake} (内部で glyphsLib が UFO/designspace に変換) で
TTF をビルドし、付属スクリプトが fontTools で hmtx と name テーブルを
書き換えて等幅化する。Glyphs 本体は不要。フォントファミリ名は
@code{Hina Mincho Mono} として登録されるため、@code{font-hina-mincho}
と同時にインストールしても衝突しない。")))
