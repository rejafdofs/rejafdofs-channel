;;; rejafdofs channel --- SBCL overrides.
;;;
;;; Guix 本家の SBCL は 2.5.8 だが、2.5 シリーズには save-lisp-and-die
;;; 時の GC (tune-image-for-dump → scavenge_immobile_newspace) に
;;; regression があり、Nyxt 3.12.0 などの image dump で
;;; "-1 is not of type (UNSIGNED-BYTE 44)" や "NO-APPLICABLE-METHOD"
;;; エラーで落ちる。nixpkgs は同じ理由で 2.5 系を採用せず
;;; 2.4.x / 2.6.x のみを提供している。
;;;
;;; 本モジュールは Guix 本家の sbcl 定義を継承しつつ、version と source
;;; だけを差し替えた variant を複数提供する。
;;;
;;;   sbcl-2.6    — 2.6.3 (最新 2.6 系、2026-03-29)
;;;   sbcl-2.4    — 2.4.11 (最新 2.4 系、長期安定)
;;;   sbcl-2.4.10 — 2.4.10 (nixpkgs のデフォルトと同版)
;;;
;;; nyxt などで (native-inputs (list sbcl-2.4 ...)) のように指定して使用。

(define-module (rejafdofs packages lisp-overrides)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((gnu packages lisp) #:prefix upstream:)
  #:use-module ((gnu packages lisp-xyz) #:prefix upstream:))

(define (make-sbcl-variant display-version base32-hash)
  "Guix 本家 sbcl パッケージを継承し version と source のみ差し替える。
2.5.8 用の arm64 patch は他のバージョンでは不要なので外す。"
  (package
    (inherit upstream:sbcl)
    (name "sbcl")
    (version display-version)
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/sbcl/sbcl/"
                           display-version "/sbcl-" display-version
                           "-source.tar.bz2"))
       (sha256 (base32 base32-hash))
       (modules '((guix build utils)))
       (snippet
        '(begin
           ;; Don't force ARMv5 (upstream snippet).
           (substitute* "src/runtime/Config.arm-linux"
             (("-march=armv5t") ""))))))))

;; 最新 2.6 系 (release 2026-03-29)。
(define-public sbcl-2.6
  (make-sbcl-variant "2.6.3"
                     "12lqd5ywl6q9hgx3xls2rsbaa2ixiwhnvif0bxdd4bcm8av2yhz7"))

;; 最新 2.4 系 (長期安定、nixpkgs のサポート対象)。
(define-public sbcl-2.4
  (make-sbcl-variant "2.4.11"
                     "05d4axv2j96ysjqsrk5xh6zvv90vlhnj7ghbf084r0rmdy2fa0sg"))

;; Debian stable / Ubuntu noble の apt と同じ版。upstream の Nyxt 公式
;; AppImage / .deb はこの SBCL でビルドされていると推測される。
(define-public sbcl-2.2.9
  (make-sbcl-variant "2.2.9"
                     "0wn1nzzc55rjk0h4y466vsdm507qf48zlwh3gc3zgzr341nvvgky"))

;; nixpkgs のデフォルトと同版 (conservative fallback)。
(define-public sbcl-2.4.10
  (make-sbcl-variant "2.4.10"
                     "1y72ql8dxwjkwkikyk26w4n38p6apvv2l7440kp3x4fjd5mkksyf"))


;;;
;;; cl-webkit fix: WORLD パラメータが NIL を許容するよう型宣言を緩和
;;;
;;; 本家 sbcl-cl-webkit 3.5.10 は webkit-web-view-evaluate-javascript の
;;; declaim ftype で WORLD を `string` 必須型として宣言しているが、
;;; 関数本体は `(if world ...)` で NIL を扱う前提になっている。
;;; SBCL 厳格型検査下で NIL を渡すと
;;;   "The value NIL is not of type STRING when binding CL-WEBKIT2::WORLD"
;;; が発生し Nyxt のページレンダリングが妨げられる。
;;;
;;; 型宣言を `(or null string)` に緩める patch を当てた cl-webkit を
;;; 提供する。

(define-public sbcl-cl-webkit-patched
  (let ((base upstream:sbcl-cl-webkit))
    (package
      (inherit base)
      (name "sbcl-cl-webkit")
      (source
       (origin
         (inherit (package-source base))
         (patches
          (append (or (origin-patches (package-source base)) '())
                  (list (local-file "cl-webkit-fix.patch")))))))))
