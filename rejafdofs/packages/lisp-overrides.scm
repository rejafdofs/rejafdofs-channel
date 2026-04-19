;;; rejafdofs channel --- SBCL override.
;;;
;;; Guix 本家の SBCL は 2.5.8 だが、2.5.x シリーズには save-lisp-and-die
;;; 時の GC (tune-image-for-dump → collect_garbage → scavenge_immobile_newspace)
;;; に regression があり、Nyxt 3.12.0 を image dump する際に
;;; "-1 is not of type (UNSIGNED-BYTE 44)" で落ちる。
;;;
;;; nixpkgs の sbcl パッケージは 2.4.x / 2.6.x 系のみ採用しており、
;;; 2.5 系はスキップされている。本パッケージは 2.6.1 を採用して本家版を
;;; 上書きすることで Nyxt 3.12.0 のビルドを通す。

(define-module (rejafdofs packages lisp-overrides)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module ((gnu packages lisp) #:prefix upstream:))

(define-public sbcl-2.6
  (package
    (inherit upstream:sbcl)
    (name "sbcl")
    (version "2.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/sbcl/sbcl/" version "/sbcl-"
                           version "-source.tar.bz2"))
       (sha256
        (base32 "0zvd34g007a56xd9wxhija2f2fwv8bcaq1cwlm4r2v9ygnxxab2z"))
       ;; 本家 2.5.8 の sbcl-fix-arm64-shared-lib.patch は 2.6.1 で不要。
       (modules '((guix build utils)))
       (snippet
        '(begin
           ;; Don't force ARMv5.
           (substitute* "src/runtime/Config.arm-linux"
             (("-march=armv5t") ""))))))))
