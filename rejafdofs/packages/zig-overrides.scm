;;; rejafdofs channel --- Zig overrides.
;;;
;;; Guix の zig-0.15.2 (本家) は `lib/std/posix.zig` の
;;; `copy_file_range` ラッパが ENOSYS を fallback (pread+pwrite) せずに
;;; `else => unexpectedErrno(err)` に落ち、結果として zig 自身が
;;; `thread N panic: TODO` で死ぬ。
;;;
;;; ENOSYS が起きる典型例:
;;;   - gVisor (`runsc`) sandbox 内 (Claude Code 環境はこれ)
;;;   - 厳格な seccomp フィルタが入っている container
;;;   - Linux kernel < 4.5 (古い)
;;;
;;; 本オーバーライドは `zig-fix-enosys.patch` を本家 zig-0.15 source に
;;; 適用してリビルドし、ENOSYS でも fallback が効くようにする。
;;; 通常の Linux 環境では `copy_file_range` 利用可能なので無害。
;;;
;;; Ghostty 等 Zig アプリの本チャンネル定義は本パッチ版を経由して
;;; ビルドできる (gVisor 環境でも reproducible build を実現)。

(define-module (rejafdofs packages zig-overrides)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module ((gnu packages zig) #:prefix upstream:))

(define-public zig-0.15-fixed
  (let ((base upstream:zig-0.15))
    (package
      (inherit base)
      (name "zig")
      (source
       (origin
         (inherit (package-source base))
         (patches
          (append (or (origin-patches (package-source base)) '())
                  (list (local-file "zig-fix-enosys.patch")))))))))
