;;; Auto-generated from build.zig.zon.json (ghostty 1.3.1).
;;; Used by (rejafdofs packages ghostty) to populate the Zig
;;; offline cache during build. DO NOT hand-edit; regenerate via
;;; the python helper in scripts/.

(define-module (rejafdofs packages ghostty-zig-deps)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:export (%ghostty-zig-deps))

(define %ghostty-zig-deps
  (list
   ;; bindings
   (list "N-V-__8AANT61wB--nJ95Gj_ctmzAtcjloZ__hRqNw5lC1Kr"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/DearBindings_v0.17_ImGui_v1.92.5-docking.tar.gz")
           (sha256 (base32 "12zyql0f0296yrwqagp27mkwqf9d7hqq2wrwliq4ff353lzp1fm3"))))
   ;; breakpad
   (list "N-V-__8AALw2uwF_03u4JRkZwRLc3Y9hakkYV7NKRR9-RIZJ"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/breakpad-b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz")
           (sha256 (base32 "0v6ak2a3s6lr0xkcxxhhfz09mzsr7033zqbs3vz14a7584mnssnr"))))
   ;; fontconfig
   (list "N-V-__8AAIrfdwARSa-zMmxWwFuwpXf1T3asIN7s5jqi9c1v"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz")
           (sha256 (base32 "0fx2vn91b1qqmkn5rapilwb08fssl1aw4yq83n8lmwycnh6wx2jm"))))
   ;; freetype
   (list "N-V-__8AAKLKpwC4H27Ps_0iL3bPkQb-z6ZVSrB-x_3EEkub"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/freetype-1220b81f6ecfb3fd222f76cf9106fecfa6554ab07ec7fdc4124b9bb063ae2adf969d.tar.gz")
           (sha256 (base32 "0hkj07sxa58nf385q7sv8nzgbpd1ybkxv5qyym7hzsmagzyjmf8c"))))
   ;; gettext
   (list "N-V-__8AADcZkgn4cMhTUpIz6mShCKyqqB-NBtf_S2bHaTC-"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/gettext-0.24.tar.gz")
           (sha256 (base32 "1j8qa0ymjgbhvbs88k8pb89xh5mgmjv6gh3gp8gckp6m00n1a65p"))))
   ;; glslang
   (list "N-V-__8AABzkUgISeKGgXAzgtutgJsZc0-kkeqBBscJgMkvy"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/glslang-12201278a1a05c0ce0b6eb6026c65cd3e9247aa041b1c260324bf29cee559dd23ba1.tar.gz")
           (sha256 (base32 "0552xnxm175kwld9llz3ypj3bnzmjwb09d5q6gk3wq3nx30ak5xm"))))
   ;; gobject
   (list "gobject-0.3.0-Skun7ANLnwDvEfIpVmohcppXgOvg_I6YOJFmPIsKfXk-"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/gobject-2025-11-08-23-1.tar.zst")
           (sha256 (base32 "1ndx8c3g020xir5q92vavzmbsbxb9612xqmng7mlh0fwxpsxc328"))))
   ;; gtk4_layer_shell
   (list "N-V-__8AALiNBAA-_0gprYr92CjrMj1I5bqNu0TSJOnjFNSr"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/gtk4-layer-shell-1.1.0.tar.gz")
           (sha256 (base32 "16188a0jc2jyxxdlyqx5bwbc9gvag2510856vc1pxjqgf7x36sc8"))))
   ;; harfbuzz
   (list "N-V-__8AAG02ugUcWec-Ndp-i7JTsJ0dgF8nnJRUInkGLG7G"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/harfbuzz-11.0.0.tar.xz")
           (sha256 (base32 "1wb3a6xgw8a74pz2q7avb7qdjgj9j1d4n93qk7xr1mqczyaklawv"))))
   ;; highway
   (list "N-V-__8AAGmZhABbsPJLfbqrh6JTHsXhY6qCaLAQyx25e0XE"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/highway-66486a10623fa0d72fe91260f96c892e41aceb06.tar.gz")
           (sha256 (base32 "11ylz24kxx70iwi4jwv0izzbz516ia0kh2x7kh9fi10rd340m8hj"))))
   ;; imgui
   (list "N-V-__8AAEbOfQBnvcFcCX2W5z7tDaN8vaNZGamEQtNOe0UI"
         (origin
           (method url-fetch)
           (uri "https://github.com/ocornut/imgui/archive/refs/tags/v1.92.5-docking.tar.gz")
           (sha256 (base32 "1j0nq878qxgkw5dfhrrm1rwr4m82s6kahn9qpcd77f4jgrgk3yfb"))))
   ;; iterm2_themes
   (list "N-V-__8AABVbAwBwDRyZONfx553tvMW8_A2OKUoLzPUSRiLF"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/ghostty-themes-release-20260216-151611-fc73ce3.tgz")
           (sha256 (base32 "05101fw6l3419av9c2fm02r81cwnnv9fp0syvw37dpjag2f0ma7x"))))
   ;; jetbrains_mono
   (list "N-V-__8AAIC5lwAVPJJzxnCAahSvZTIlG-HhtOvnM1uh-66x"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/JetBrainsMono-2.304.tar.gz")
           (sha256 (base32 "1ibsd4g8p0md165mjqzkjn835r03iwwi11xgfwaqhnx5j1310p64"))))
   ;; libpng
   (list "N-V-__8AAJrvXQCqAT8Mg9o_tk6m0yf5Fz-gCNEOKLyTSerD"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/libpng-1220aa013f0c83da3fb64ea6d327f9173fa008d10e28bc9349eac3463457723b1c66.tar.gz")
           (sha256 (base32 "1zncjns6rw2yiqzwi90lfl70p9das06qksgxy5syjkzh875g381s"))))
   ;; libxev
   (list "libxev-0.0.0-86vtc4IcEwCqEYxEYoN_3KXmc6A9VLcm22aVImfvecYs"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/libxev-34fa50878aec6e5fa8f532867001ab3c36fae23e.tar.gz")
           (sha256 (base32 "0q03x9mrdr5532hjiy9j69ypk88vsc4rdc9vffxfnacicdwlhzfp"))))
   ;; libxml2
   (list "N-V-__8AAG3RoQEyRC2Vw7Qoro5SYBf62IHn3HjqtNVY6aWK"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/libxml2-2.11.5.tar.gz")
           (sha256 (base32 "0v180ng2wgpb8asv9cb4i7ir2sk38v0hjnklzvivqrfdqpc9lqhm"))))
   ;; nerd_fonts_symbols_only
   (list "N-V-__8AAMVLTABmYkLqhZPLXnMl-KyN38R8UVYqGrxqO26s"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/NerdFontsSymbolsOnly-3.4.0.tar.gz")
           (sha256 (base32 "04b4s6wmdm5xw94dgcphk6647k4lylh28cd1ar57jf4mn7kkn384"))))
   ;; oniguruma
   (list "N-V-__8AAHjwMQDBXnLq3Q2QhaivE0kE2aD138vtX2Bq1g7c"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/oniguruma-1220c15e72eadd0d9085a8af134904d9a0f5dfcbed5f606ad60edc60ebeccd9706bb.tar.gz")
           (sha256 (base32 "000sl4h2wy24ix60pwd4iivfaml7dcvg2vcjrqr0gv6gsqfrkwm0"))))
   ;; pixels
   (list "N-V-__8AADYiAAB_80AWnH1AxXC0tql9thT-R-DYO1gBqTLc"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/pixels-12207ff340169c7d40c570b4b6a97db614fe47e0d83b5801a932dcd44917424c8806.tar.gz")
           (sha256 (base32 "0mg87cbd14884l1by54vyibz67s214n5k0k51qzzpbkv923ipw8s"))))
   ;; plasma_wayland_protocols
   (list "N-V-__8AAKYZBAB-CFHBKs3u4JkeiT4BMvyHu3Y5aaWF3Bbs"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/plasma_wayland_protocols-12207e0851c12acdeee0991e893e0132fc87bb763969a585dc16ecca33e88334c566.tar.gz")
           (sha256 (base32 "0p2qp8hlmkcfdg5389nw12q25i3aipcrgcls3cz2ifnzf710vx21"))))
   ;; sentry
   (list "N-V-__8AAPlZGwBEa-gxrcypGBZ2R8Bse4JYSfo_ul8i2jlG"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/sentry-1220446be831adcca918167647c06c7b825849fa3fba5f22da394667974537a9c77e.tar.gz")
           (sha256 (base32 "0an695ycimhsilqhjgj7mpdqr6rc8nqnn1q5pcrlm0svchiw666z"))))
   ;; spirv_cross
   (list "N-V-__8AANb6pwD7O1WG6L5nvD_rNMvnSc9Cpg1ijSlTYywv"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/spirv_cross-1220fb3b5586e8be67bc3feb34cbe749cf42a60d628d2953632c2f8141302748c8da.tar.gz")
           (sha256 (base32 "1d9bdz7w8pkzlsdiy1m16qn1am3k8i72rh4rjmann5bcafx6cmz3"))))
   ;; utfcpp
   (list "N-V-__8AAHffAgDU0YQmynL8K35WzkcnMUmBVQHQ0jlcKpjH"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/utfcpp-1220d4d18426ca72fc2b7e56ce47273149815501d0d2395c2a98c726b31ba931e641.tar.gz")
           (sha256 (base32 "1zy6d2ii1rvn0z9r7wy1icr72pr27nhymi64svh5g6hivy76nnfg"))))
   ;; uucode
   (list "uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM"
         (origin
           (method git-fetch)
           (uri (git-reference
                 (url "https://github.com/jacobsandlund/uucode")
                 (commit "5f05f8f83a75caea201f12cc8ea32a2d82ea9732")))
           (file-name (git-file-name "uucode" "5f05f8f8"))
           (sha256 (base32 "1c3kw7wk84km86pb7x0kdqzclj4jci7f6lxcmqakcr03ilnz8bgz"))))
   ;; uucode
   (list "uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9.tar.gz")
           (sha256 (base32 "1l5bxq7lz2ynxbiw0lbpgqbfgi1di5jamah1an8w9rb5f0zlcpwm"))))
   ;; vaxis
   (list "vaxis-0.5.1-BWNV_LosCQAGmCCNOLljCIw6j6-yt53tji6n6rwJ2BhS"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/vaxis-7dbb9fd3122e4ffad262dd7c151d80d863b68558.tar.gz")
           (sha256 (base32 "0bkj6cmwi72vahgcdrmx91v9w7rznxbw803g7ldgjh5m9ydhi3pn"))))
   ;; wayland
   (list "N-V-__8AAKrHGAAs2shYq8UkE6bGcR1QJtLTyOE_lcosMn6t"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/wayland-9cb3d7aa9dc995ffafdbdef7ab86a949d0fb0e7d.tar.gz")
           (sha256 (base32 "1sj1j7b8whvnfzjiyfmcvqkq560h2i79679rg8r7vih3bqn3ki8d"))))
   ;; wayland_protocols
   (list "N-V-__8AAKw-DAAaV8bOAAGqA0-oD7o-HNIlPFYKRXSPT03S"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/wayland-protocols-258d8f88f2c8c25a830c6316f87d23ce1a0f12d9.tar.gz")
           (sha256 (base32 "0p7drbfyh6vmwq7j7rg87dfx5f7b9vxrz3vrpmx38z8libmhac7q"))))
   ;; wuffs
   (list "N-V-__8AAAzZywE3s51XfsLbP9eyEw57ae9swYB9aGB6fCMs"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/wuffs-122037b39d577ec2db3fd7b2130e7b69ef6cc1807d68607a7c232c958315d381b5cd.tar.gz")
           (sha256 (base32 "17jcs85bx5p6qk3fvsf30mqhi1h14vkvwbic7qsm2m3nq98bw70k"))))
   ;; z2d
   (list "z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ.tar.gz")
           (sha256 (base32 "0sgj3nifzmgf14vzwmf4s2g4iby4zcpr380yy5kwihkmmq26g5zp"))))
   ;; zf
   (list "zf-0.10.3-OIRy8RuJAACKA3Lohoumrt85nRbHwbpMcUaLES8vxDnh"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/zf-3c52637b7e937c5ae61fd679717da3e276765b23.tar.gz")
           (sha256 (base32 "0fq1bn98mw2fkqk2fay1bssdpd6rm7a6ksvd5450vnp6ffvpqib8"))))
   ;; zig_js
   (list "zig_js-0.0.0-rjCAV-6GAADxFug7rDmPH-uM_XcnJ5NmuAMJCAscMjhi"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/zig_js-04db83c617da1956ac5adc1cb9ba1e434c1cb6fd.tar.gz")
           (sha256 (base32 "0k1033jn05fkjl2bh283hsnrrs9r7ww3h045v71j6wxzgrbgqwx3"))))
   ;; zig_objc
   (list "zig_objc-0.0.0-Ir_Sp5gTAQCvxxR7oVIrPXxXwsfKgVP7_wqoOQrZjFeK"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/zig_objc-f356ed02833f0f1b8e84d50bed9e807bf7cdc0ae.tar.gz")
           (sha256 (base32 "1pc4mxrpc99mdz6p4b5k144z7cp8sw16cz7mg5qlm9zaph5c13nc"))))
   ;; zig_wayland
   (list "wayland-0.5.0-dev-lQa1khrMAQDJDwYFKpdH3HizherB7sHo5dKMECfvxQHe"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/zig_wayland-1b5c038ec10da20ed3a15b0b2a6db1c21383e8ea.tar.gz")
           (sha256 (base32 "0kqlddrmxl6m4zsj1qxzf79yjgvjqg8gln1sx3nx79453xq7j4jf"))))
   ;; zigimg
   (list "zigimg-0.1.0-8_eo2vHnEwCIVW34Q14Ec-xUlzIoVg86-7FU2ypPtxms"
         (origin
           (method url-fetch)
           (uri "https://github.com/ivanstepanovftw/zigimg/archive/d7b7ab0ba0899643831ef042bd73289510b39906.tar.gz")
           (sha256 (base32 "0b0ysxms5csm2ia4n317r5ikxjx7qcdyj20f6zks04697dd1piak"))))
   ;; zlib
   (list "N-V-__8AAB0eQwD-0MdOEBmz7intriBReIsIDNlukNVoNu6o"
         (origin
           (method url-fetch)
           (uri "https://deps.files.ghostty.org/zlib-1220fed0c74e1019b3ee29edae2051788b080cd96e90d56836eea857b0b966742efb.tar.gz")
           (sha256 (base32 "05z8i1iz6q06famlj61g45r83dpw9ly7cayy6qckbr1nm5919l2w"))))
   ))
