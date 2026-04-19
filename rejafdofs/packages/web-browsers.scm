;;; rejafdofs channel --- Web browsers.
;;;
;;; このモジュールは本家 Guix の (gnu packages web-browsers) から
;;; nyxt をそのまま再エクスポートします。rejafdofs チャンネルの
;;; 名前空間で `guix install nyxt` を使えるようにするためです。

(define-module (rejafdofs packages web-browsers)
  #:use-module (guix packages)
  #:use-module ((gnu packages web-browsers) #:prefix upstream:)
  #:export (nyxt))

;; 単純な再エクスポート。将来 rejafdofs 独自版を作りたくなった時は
;; 以下のように override できます:
;;
;;   (define-public nyxt
;;     (package
;;       (inherit upstream:nyxt)
;;       (version "X.Y.Z")
;;       (source (origin
;;                 (method git-fetch)
;;                 (uri (git-reference
;;                       (url "https://github.com/atlas-engineer/nyxt")
;;                       (commit version)))
;;                 (file-name (git-file-name "nyxt" version))
;;                 (sha256 (base32 "REPLACE-ME"))))))

(define-public nyxt upstream:nyxt)
