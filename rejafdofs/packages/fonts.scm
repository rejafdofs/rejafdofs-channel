;;; rejafdofs channel --- 日本語フォント。
;;;
;;; 提供パッケージ:
;;;   - font-hina-mincho : 古風で可愛い日本語明朝体 (satsuyako 氏)
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
;;; 上流配布の TTF (fonts/ttf/Hina-Mincho-Regular.ttf) をそのまま
;;; share/fonts/truetype/ 以下に配置するだけの素朴な
;;; copy-build-system パッケージ。Glyphs 3 ソース (.glyphspackage)
;;; からのリビルドは Glyphs が非自由のため行わない。

(define-module (rejafdofs packages fonts)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
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
