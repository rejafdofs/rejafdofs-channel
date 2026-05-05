;;; rejafdofs channel --- Rust crates for vrc-get / kanata.
;;;
;;; このファイルは `guix import crate -f Cargo.lock <PKG>` 相当の
;;; ロジックで生成されます。`define-cargo-inputs` の各節
;;; (`(<PKG> => (list ...))`) ごとに対応する Cargo.lock を参照し、
;;; 上流の Cargo.lock が変わった時は再生成してください。
;;;
;;; vrc-get 用エントリは Guix の `guix import crate -f Cargo.lock vrc-get`
;;; を、kanata 用エントリは Cargo.lock の `[[package]]` から checksum を
;;; 直接 nix-base32 化する小スクリプトで生成しています (Guix 1.4 の
;;; `guix import crate` が `(semver ranges)` 不在で動かないための回避)。

(define-module (rejafdofs packages rust-crates)
  #:use-module (guix build-system cargo)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (lookup-cargo-inputs))

(define rust-addr2line-0.24.2
  (crate-source "addr2line" "0.24.2"
                "1hd1i57zxgz08j6h5qrhsnm2fi0bcqvsh389fw400xm3arz2ggnz"))

(define rust-adler2-2.0.1
  (crate-source "adler2" "2.0.1"
                "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))

(define rust-aho-corasick-1.1.3
  (crate-source "aho-corasick" "1.1.3"
                "05mrpkvdgp5d20y2p989f187ry9diliijgwrs254fs9s1m1x6q4f"))

(define rust-alloc-no-stdlib-2.0.4
  (crate-source "alloc-no-stdlib" "2.0.4"
                "1cy6r2sfv5y5cigv86vms7n5nlwhx1rbyxwcraqnmm1rxiib2yyc"))

(define rust-alloc-stdlib-0.2.2
  (crate-source "alloc-stdlib" "0.2.2"
                "1kkfbld20ab4165p29v172h8g0wvq8i06z8vnng14whw0isq5ywl"))

(define rust-android-system-properties-0.1.5
  (crate-source "android_system_properties" "0.1.5"
                "04b3wrz12837j7mdczqd95b732gw5q7q66cv4yn4646lvccp57l1"))

(define rust-android-tzdata-0.1.1
  (crate-source "android-tzdata" "0.1.1"
                "1w7ynjxrfs97xg3qlcdns4kgfpwcdv824g611fq32cag4cdr96g9"))

(define rust-anstream-0.6.19
  (crate-source "anstream" "0.6.19"
                "0crr9a207dyn8k66xgvhvmlxm9raiwpss3syfa35c6265s9z26ih"))

(define rust-anstyle-1.0.11
  (crate-source "anstyle" "1.0.11"
                "1gbbzi0zbgff405q14v8hhpi1kz2drzl9a75r3qhks47lindjbl6"))

(define rust-anstyle-parse-0.2.7
  (crate-source "anstyle-parse" "0.2.7"
                "1hhmkkfr95d462b3zf6yl2vfzdqfy5726ya572wwg8ha9y148xjf"))

(define rust-anstyle-query-1.1.3
  (crate-source "anstyle-query" "1.1.3"
                "1sgs2hq54wayrmpvy784ww2ccv9f8yhhpasv12z872bx0jvdx2vc"))

(define rust-anstyle-wincon-3.0.9
  (crate-source "anstyle-wincon" "3.0.9"
                "10n8mcgr89risdf35i73zc67aaa392bhggwzqlri1fv79297ags0"))

(define rust-anyhow-1.0.98
  (crate-source "anyhow" "1.0.98"
                "11ylvjdrcjs0q9jgk1af4r5cx1qppj63plxqkq595vmc24rjsvg1"))

(define rust-arbitrary-1.4.1
  (crate-source "arbitrary" "1.4.1"
                "08zj2yanll5s5gsbmvgwvbq39iqzy3nia3yx3db3zwba08yhpqnx"))

(define rust-arc-swap-1.7.1
  (crate-source "arc-swap" "1.7.1"
                "0mrl9a9r9p9bln74q6aszvf22q1ijiw089jkrmabfqkbj31zixv9"))

(define rust-ashpd-0.11.0
  (crate-source "ashpd" "0.11.0"
                "1pwrxm1dky7i0xb1wj5k5rfx7hhx06vks2d2dvpamlvzsw8g7gbc"))

(define rust-async-broadcast-0.7.2
  (crate-source "async-broadcast" "0.7.2"
                "0ckmqcwyqwbl2cijk1y4r0vy60i89gqc86ijrxzz5f2m4yjqfnj3"))

(define rust-async-channel-2.3.1
  (crate-source "async-channel" "2.3.1"
                "0skvwxj6ysfc6d7bhczz9a2550260g62bm5gl0nmjxxyn007id49"))

(define rust-async-compression-0.4.27
  (crate-source "async-compression" "0.4.27"
                "1s0l81yxckazg1zs3kqhhj3i4ss4p822hqcic3p3rq2advb3kffx"))

(define rust-async-executor-1.13.2
  (crate-source "async-executor" "1.13.2"
                "1yjgdh62iqn2bvp792j3q980kk015x79fz8dhq8dsjsjb3xjz0dv"))

(define rust-async-io-2.4.1
  (crate-source "async-io" "2.4.1"
                "1cybmbq3gwv26bi7sk1gmcwynbm1s36zj3wib1gpdwx0fnpc0dqj"))

(define rust-async-lock-3.4.0
  (crate-source "async-lock" "3.4.0"
                "060vh45i809wcqyxzs5g69nqiqah7ydz0hpkcjys9258vqn4fvpz"))

(define rust-async-process-2.3.1
  (crate-source "async-process" "2.3.1"
                "1p459ckyndgl69cdxl8375cwnm6wsv5ra069zyndf8b01vjg9qyd"))

(define rust-async-recursion-1.1.1
  (crate-source "async-recursion" "1.1.1"
                "04ac4zh8qz2xjc79lmfi4jlqj5f92xjvfaqvbzwkizyqd4pl4hrv"))

(define rust-async-signal-0.2.11
  (crate-source "async-signal" "0.2.11"
                "03ffmhkvr4si21rlnhxhb68fslfybyzp0nldi7rnvc6la175lq6p"))

(define rust-async-stream-0.3.6
  (crate-source "async-stream" "0.3.6"
                "0xl4zqncrdmw2g6241wgr11dxdg4h7byy6bz3l6si03qyfk72nhb"))

(define rust-async-stream-impl-0.3.6
  (crate-source "async-stream-impl" "0.3.6"
                "0kaplfb5axsvf1gfs2gk6c4zx6zcsns0yf3ssk7iwni7bphlvhn7"))

(define rust-async-task-4.7.1
  (crate-source "async-task" "4.7.1"
                "1pp3avr4ri2nbh7s6y9ws0397nkx1zymmcr14sq761ljarh3axcb"))

(define rust-async-trait-0.1.88
  (crate-source "async-trait" "0.1.88"
                "1dgxvz7g75cmz6vqqz0mri4xazc6a8xfj1db6r9fxz29lzyd6fg5"))

(define rust-async-zip-0.0.17
  (crate-source "async_zip" "0.0.17"
                "0lkvp0ggkk9dvqakdhp93phxb7ajcfsh95ma015yvm9k50jzgf80"))

(define rust-atk-0.18.2
  (crate-source "atk" "0.18.2"
                "0jw2n5xln62px4dh0hxdzbkbfraznkjakwznwhxrjbh72c9646r4"))

(define rust-atk-sys-0.18.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "atk-sys" "0.18.2"
                "11nh2h3g7s772wb6lmjdsjbwi8rf9i11gvyyp8mpv9qc9dl8pr65"))

(define rust-atomic-waker-1.1.2
  (crate-source "atomic-waker" "1.1.2"
                "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))

(define rust-atomicbox-0.4.0
  (crate-source "atomicbox" "0.4.0"
                "0xmdshqkdb08nsyyck15zzs9k1al1142m71qr1haz6lyphh3i6la"))

(define rust-autocfg-1.4.0
  (crate-source "autocfg" "1.4.0"
                "09lz3by90d2hphbq56znag9v87gfpd9gb8nr82hll8z6x2nhprdc"))

(define rust-backtrace-0.3.75
  (crate-source "backtrace" "0.3.75"
                "00hhizz29mvd7cdqyz5wrj98vqkihgcxmv2vl7z0d0f53qrac1k8"))

(define rust-base64-0.21.7
  (crate-source "base64" "0.21.7"
                "0rw52yvsk75kar9wgqfwgb414kvil1gn7mqkrhn9zf1537mpsacx"))

(define rust-base64-0.22.1
  (crate-source "base64" "0.22.1"
                "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))

(define rust-bitflags-1.3.2
  (crate-source "bitflags" "1.3.2"
                "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy"))

(define rust-bitflags-2.9.1
  (crate-source "bitflags" "2.9.1"
                "0rz9rpp5wywwqb3mxfkywh4drmzci2fch780q7lifbf6bsc5d3hv"))

(define rust-block-buffer-0.10.4
  (crate-source "block-buffer" "0.10.4"
                "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))

(define rust-block2-0.5.1
  (crate-source "block2" "0.5.1"
                "0pyiha5his2grzqr3mynmq244laql2j20992i59asp0gy7mjw4rc"))

(define rust-block2-0.6.1
  (crate-source "block2" "0.6.1"
                "1wnwha7wjjqiamj9abq5l45fyzdxna2k2la0rp9w2hravc5jy39l"))

(define rust-blocking-1.6.1
  (crate-source "blocking" "1.6.1"
                "1si99l8zp7c4zq87y35ayjgc5c9b60jb8h0k14zfcs679z2l2gvh"))

(define rust-brotli-8.0.1
  (crate-source "brotli" "8.0.1"
                "038fdq2whhzsxxav5wyy5nqv5c49xr0qwr1q85997wm41skyx4cr"))

(define rust-brotli-decompressor-5.0.0
  (crate-source "brotli-decompressor" "5.0.0"
                "00yyswj1rj20ma4wr4wcci4r9ywlgvxa87nqsv5rik5y588vhjw7"))

(define rust-bumpalo-3.18.1
  (crate-source "bumpalo" "3.18.1"
                "1vmfniqr484l4ffkf0056g6hakncr7kdh11hyggh9kc7c5nvfgbr"))

(define rust-bytemuck-1.23.1
  (crate-source "bytemuck" "1.23.1"
                "08ilqv7x5lckj82i41j5lx2is9krcxiibgrs9pispr245rwsaxjw"))

(define rust-byteorder-1.5.0
  (crate-source "byteorder" "1.5.0"
                "0jzncxyf404mwqdbspihyzpkndfgda450l0893pz5xj685cg5l0z"))

(define rust-bytes-1.10.1
  (crate-source "bytes" "1.10.1"
                "0smd4wi2yrhp5pmq571yiaqx84bjqlm1ixqhnvfwzzc6pqkn26yp"))

(define rust-cairo-rs-0.18.5
  (crate-source "cairo-rs" "0.18.5"
                "1qjfkcq3mrh3p01nnn71dy3kn99g21xx3j8xcdvzn8ll2pq6x8lc"))

(define rust-cairo-sys-rs-0.18.2
  (crate-source "cairo-sys-rs" "0.18.2"
                "0lfsxl7ylw3phbnwmz3k58j1gnqi6kc2hdc7g3bb7f4hwnl9yp38"))

(define rust-camino-1.1.10
  (crate-source "camino" "1.1.10"
                "1asw3160i5x2r98lsfym3my8dps0fyk25qi206bddn3i271mp90d"))

(define rust-cargo-metadata-0.19.2
  (crate-source "cargo_metadata" "0.19.2"
                "1fkr8jp6vhva4kc3rhx13yrnl8g3zch463j20vbwa9scxlabcpnx"))

(define rust-cargo-platform-0.1.9
  (crate-source "cargo-platform" "0.1.9"
                "1sinpmqjdk3q9llbmxr0h0nyvqrif1r5qs34l000z73b024z2np3"))

(define rust-cargo-toml-0.22.1
  (crate-source "cargo_toml" "0.22.1"
                "0mqjkaz6x63jkcm04nfpzis1skdmij7flkfhmxf6wd4mj140s9h2"))

(define rust-cc-1.2.27
  (crate-source "cc" "1.2.27"
                "1p5zfsl2mw3j46w58j2sxqkbfi49azilis5335pxlr2z3c3sm1yl"))

(define rust-cesu8-1.1.0
  (crate-source "cesu8" "1.1.0"
                "0g6q58wa7khxrxcxgnqyi9s1z2cjywwwd3hzr5c55wskhx6s0hvd"))

(define rust-cfb-0.7.3
  (crate-source "cfb" "0.7.3"
                "03y6p3dlm7gfds19bq4ba971za16rjbn7q2v0vqcri52l2kjv3yk"))

(define rust-cfg-aliases-0.2.1
  (crate-source "cfg_aliases" "0.2.1"
                "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))

(define rust-cfg-expr-0.15.8
  (crate-source "cfg-expr" "0.15.8"
                "00lgf717pmf5qd2qsxxzs815v6baqg38d6m5i6wlh235p14asryh"))

(define rust-cfg-if-1.0.1
  (crate-source "cfg-if" "1.0.1"
                "0s0jr5j797q1vqjcd41l0v5izlmlqm7lxy512b418xz5r65mfmcm"))

(define rust-chrono-0.4.41
  (crate-source "chrono" "0.4.41"
                "0k8wy2mph0mgipq28vv3wirivhb31pqs7jyid0dzjivz0i9djsf4"))

(define rust-clap-4.5.41
  (crate-source "clap" "4.5.41"
                "1ydd3a22bxkn2a7bajnw57cwjhawqciyhz2x3rqm8fi4h0pd74my"))

(define rust-clap-builder-4.5.41
  (crate-source "clap_builder" "4.5.41"
                "0g8w6da5y13kv93psl8c00c7f4q01753wmwx84wr2bv2x50snzkh"))

(define rust-clap-complete-4.5.55
  (crate-source "clap_complete" "4.5.55"
                "16i2qv263ndlmnms4vyzdqiqd7y4cqdqz3wbpv2p1bvd912dxax5"))

(define rust-clap-derive-4.5.41
  (crate-source "clap_derive" "4.5.41"
                "14glxqpfjs7z6m37f3ycrhgdkpyqmgwbr4vk1y34rjjrd8w54kzg"))

(define rust-clap-lex-0.7.5
  (crate-source "clap_lex" "0.7.5"
                "0xb6pjza43irrl99axbhs12pxq4sr8x7xd36p703j57f5i3n2kxr"))

(define rust-color-print-0.3.7
  (crate-source "color-print" "0.3.7"
                "1x5nrpwwl3n8qawdyywiawv4j6yrd6mxjiz04db7sy8334bm9a9s"))

(define rust-color-print-proc-macro-0.3.7
  (crate-source "color-print-proc-macro" "0.3.7"
                "08la26krj5n9rl2c69hk2j711d4yrrza9bjrbbj0fh75xfsqc8b9"))

(define rust-colorchoice-1.0.4
  (crate-source "colorchoice" "1.0.4"
                "0x8ymkz1xr77rcj1cfanhf416pc4v681gmkc9dzb3jqja7f62nxh"))

(define rust-combine-4.6.7
  (crate-source "combine" "4.6.7"
                "1z8rh8wp59gf8k23ar010phgs0wgf5i8cx4fg01gwcnzfn5k0nms"))

(define rust-concurrent-queue-2.5.0
  (crate-source "concurrent-queue" "2.5.0"
                "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))

(define rust-convert-case-0.4.0
  (crate-source "convert_case" "0.4.0"
                "03jaf1wrsyqzcaah9jf8l1iznvdw5mlsca2qghhzr9w27sddaib2"))

(define rust-cookie-0.18.1
  (crate-source "cookie" "0.18.1"
                "0iy749flficrlvgr3hjmf3igr738lk81n5akzf4ym4cs6cxg7pjd"))

(define rust-core-foundation-0.10.1
  (crate-source "core-foundation" "0.10.1"
                "1xjns6dqf36rni2x9f47b65grxwdm20kwdg9lhmzdrrkwadcv9mj"))

(define rust-core-foundation-0.9.4
  (crate-source "core-foundation" "0.9.4"
                "13zvbbj07yk3b61b8fhwfzhy35535a583irf23vlcg59j7h9bqci"))

(define rust-core-foundation-sys-0.8.7
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "core-foundation-sys" "0.8.7"
                "12w8j73lazxmr1z0h98hf3z623kl8ms7g07jch7n4p8f9nwlhdkp"))

(define rust-core-graphics-0.24.0
  (crate-source "core-graphics" "0.24.0"
                "1w8n8gqqm8swkanaibilqya8ryldp9fvf80byjxsaprn493a75gs"))

(define rust-core-graphics-types-0.2.0
  (crate-source "core-graphics-types" "0.2.0"
                "1sqka1rz84lr3p69i1s6lggnpnznmrw4ngc5q76w9xhky80s2i1x"))

(define rust-cpufeatures-0.2.17
  (crate-source "cpufeatures" "0.2.17"
                "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))

(define rust-crc32fast-1.4.2
  (crate-source "crc32fast" "1.4.2"
                "1czp7vif73b8xslr3c9yxysmh9ws2r8824qda7j47ffs9pcnjxx9"))

(define rust-crossbeam-channel-0.5.15
  (crate-source "crossbeam-channel" "0.5.15"
                "1cicd9ins0fkpfgvz9vhz3m9rpkh6n8d3437c3wnfsdkd3wgif42"))

(define rust-crossbeam-queue-0.3.12
  (crate-source "crossbeam-queue" "0.3.12"
                "059igaxckccj6ndmg45d5yf7cm4ps46c18m21afq3pwiiz1bnn0g"))

(define rust-crossbeam-utils-0.8.21
  (crate-source "crossbeam-utils" "0.8.21"
                "0a3aa2bmc8q35fb67432w16wvi54sfmb69rk9h5bhd18vw0c99fh"))

(define rust-crypto-common-0.1.6
  (crate-source "crypto-common" "0.1.6"
                "1cvby95a6xg7kxdz5ln3rl9xh66nz66w46mm3g56ri1z5x815yqv"))

(define rust-cssparser-0.29.6
  (crate-source "cssparser" "0.29.6"
                "1yp0zl5cmw9x95np9a51153fdb1ng8fgzwyssg7hr5dmki0h6ggr"))

(define rust-cssparser-macros-0.6.1
  (crate-source "cssparser-macros" "0.6.1"
                "0cfkzj60avrnskdmaf7f8zw6pp3di4ylplk455zrzaf19ax8id8k"))

(define rust-ctor-0.2.9
  (crate-source "ctor" "0.2.9"
                "00b5vprqi4a2cr29xhqijg800b4dwkhrr5wj2kf3s7vnambpi8ij"))

(define rust-darling-0.20.11
  (crate-source "darling" "0.20.11"
                "1vmlphlrlw4f50z16p4bc9p5qwdni1ba95qmxfrrmzs6dh8lczzw"))

(define rust-darling-core-0.20.11
  (crate-source "darling_core" "0.20.11"
                "0bj1af6xl4ablnqbgn827m43b8fiicgv180749f5cphqdmcvj00d"))

(define rust-darling-macro-0.20.11
  (crate-source "darling_macro" "0.20.11"
                "1bbfbc2px6sj1pqqq97bgqn6c8xdnb2fmz66f7f40nrqrcybjd7w"))

(define rust-deflate64-0.1.9
  (crate-source "deflate64" "0.1.9"
                "06scix17pa7wzzfsnhkycpcc6s04shs49cdaxx2k1sl0226jnsfs"))

(define rust-deranged-0.4.0
  (crate-source "deranged" "0.4.0"
                "13h6skwk411wzhf1l9l7d3yz5y6vg9d7s3dwhhb4a942r88nm7lw"))

(define rust-derive-arbitrary-1.4.1
  (crate-source "derive_arbitrary" "1.4.1"
                "000839h4mbgs65x1f8540kbjk2ifw68c4d8r5b9f7q0jv4d2qm1h"))

(define rust-derive-more-0.99.20
  (crate-source "derive_more" "0.99.20"
                "0zvz94kbc5d4r817wni1l7xk8f289nhf73vqk677p5rxlij4pnvf"))

(define rust-digest-0.10.7
  (crate-source "digest" "0.10.7"
                "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))

(define rust-dirs-6.0.0
  (crate-source "dirs" "6.0.0"
                "0knfikii29761g22pwfrb8d0nqpbgw77sni9h2224haisyaams63"))

(define rust-dirs-next-2.0.0
  (crate-source "dirs-next" "2.0.0"
                "1q9kr151h9681wwp6is18750ssghz6j9j7qm7qi1ngcwy7mzi35r"))

(define rust-dirs-sys-0.5.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "dirs-sys" "0.5.0"
                "1aqzpgq6ampza6v012gm2dppx9k35cdycbj54808ksbys9k366p0"))

(define rust-dirs-sys-next-0.1.2
  (crate-source "dirs-sys-next" "0.1.2"
                "0kavhavdxv4phzj4l0psvh55hszwnr0rcz8sxbvx20pyqi2a3gaf"))

(define rust-dispatch-0.2.0
  (crate-source "dispatch" "0.2.0"
                "0fwjr9b7582ic5689zxj8lf7zl94iklhlns3yivrnv8c9fxr635x"))

(define rust-dispatch2-0.2.0
  (crate-source "dispatch2" "0.2.0"
                "186alxavw48mnnyclrhb1w68wsa881cllkp1w227gwiz02g5c38s"))

(define rust-dispatch2-0.3.0
  (crate-source "dispatch2" "0.3.0"
                "1v1ak9w0s8z1g13x4mj2y5im9wmck0i2vf8f8wc9l1n6lqi9z849"))

(define rust-displaydoc-0.2.5
  (crate-source "displaydoc" "0.2.5"
                "1q0alair462j21iiqwrr21iabkfnb13d6x5w95lkdg21q2xrqdlp"))

(define rust-dlopen2-0.7.0
  (crate-source "dlopen2" "0.7.0"
                "19hmafkfsqbgdw7pvm4s3w4b2l1d9hlydkjgfa2ymfib7l89f4ly"))

(define rust-dlopen2-derive-0.4.1
  (crate-source "dlopen2_derive" "0.4.1"
                "1x6hr5la6yqjqyr3f9zwx3n1cjwhflk6l77kga2xv76y63xn10bq"))

(define rust-dpi-0.1.2
  (crate-source "dpi" "0.1.2"
                "0xhsvzgjvdch2fwmfc9vkb708b0q59b6imypyjlgbiigyb74rcfq"))

(define rust-dtoa-1.0.10
  (crate-source "dtoa" "1.0.10"
                "016gid01rarcdv57h049d7nr9daxc2hc2gqzx0mji57krywd7bfn"))

(define rust-dtoa-short-0.3.5
  (crate-source "dtoa-short" "0.3.5"
                "11rwnkgql5jilsmwxpx6hjzkgyrbdmx1d71s0jyrjqm5nski25fd"))

(define rust-dunce-1.0.5
  (crate-source "dunce" "1.0.5"
                "04y8wwv3vvcqaqmqzssi6k0ii9gs6fpz96j5w9nky2ccsl23axwj"))

(define rust-dyn-clone-1.0.19
  (crate-source "dyn-clone" "1.0.19"
                "01ahm5abl20480v48nxy4ffyx80cs6263q9zf0gnrxpvm6w8yyhw"))

(define rust-either-1.15.0
  (crate-source "either" "1.15.0"
                "069p1fknsmzn9llaizh77kip0pqmcwpdsykv2x30xpjyija5gis8"))

(define rust-embed-plist-1.2.2
  (crate-source "embed_plist" "1.2.2"
                "1drvfi1lh9lh8b7pcqp98jdigzsji0kfavbrv126c69pbfgbixjf"))

(define rust-embed-resource-3.0.3
  (crate-source "embed-resource" "3.0.3"
                "12fll6mp6f8w7fl8cihy8kfrkkaa4ky9mv555iwabcx6ih37vzp8"))

(define rust-encoding-rs-0.8.35
  (crate-source "encoding_rs" "0.8.35"
                "1wv64xdrr9v37rqqdjsyb8l8wzlcbab80ryxhrszvnj59wy0y0vm"))

(define rust-endi-1.1.0
  (crate-source "endi" "1.1.0"
                "1gxp388g2zzbncp3rdn60wxkr49xbhhx94nl9p4a6c41w4ma7n53"))

(define rust-enum-map-2.7.3
  (crate-source "enum-map" "2.7.3"
                "1sgjgl4mmz93jdkfdsmapc3dmaq8gddagw9s0fd501w2vyzz6rk8"))

(define rust-enum-map-derive-0.17.0
  (crate-source "enum-map-derive" "0.17.0"
                "1sv4mb343rsz4lc3rh7cyn0pdhf7fk18k1dgq8kfn5i5x7gwz0pj"))

(define rust-enumflags2-0.7.12
  (crate-source "enumflags2" "0.7.12"
                "1vzcskg4dca2jiflsfx1p9yw1fvgzcakcs7cpip0agl51ilgf9qh"))

(define rust-enumflags2-derive-0.7.12
  (crate-source "enumflags2_derive" "0.7.12"
                "09rqffacafl1b83ir55hrah9gza0x7pzjn6lr6jm76fzix6qmiv7"))

(define rust-env-filter-0.1.3
  (crate-source "env_filter" "0.1.3"
                "1l4p6f845cylripc3zkxa0lklk8rn2q86fqm522p6l2cknjhavhq"))

(define rust-env-logger-0.11.8
  (crate-source "env_logger" "0.11.8"
                "17q6zbjam4wq75fa3m4gvvmv3rj3ch25abwbm84b28a0j3q67j0k"))

(define rust-equivalent-1.0.2
  (crate-source "equivalent" "1.0.2"
                "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))

(define rust-erased-serde-0.4.6
  (crate-source "erased-serde" "0.4.6"
                "1dx5hj16hsl143czwl2g7ymdi1y84lsjyyii2zprzjqzyn3xh170"))

(define rust-errno-0.3.12
  (crate-source "errno" "0.3.12"
                "066ss2qln9z5q4816d3wcvq2bzasn7dajfkhcfqflfsy6pwlx8ff"))

(define rust-event-listener-5.4.0
  (crate-source "event-listener" "5.4.0"
                "1bii2gn3vaa33s0gr2zph7cagiq0ppcfxcxabs24ri9z9kgar4il"))

(define rust-event-listener-strategy-0.5.4
  (crate-source "event-listener-strategy" "0.5.4"
                "14rv18av8s7n8yixg38bxp5vg2qs394rl1w052by5npzmbgz7scb"))

(define rust-fastrand-2.3.0
  (crate-source "fastrand" "2.3.0"
                "1ghiahsw1jd68df895cy5h3gzwk30hndidn3b682zmshpgmrx41p"))

(define rust-fdeflate-0.3.7
  (crate-source "fdeflate" "0.3.7"
                "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))

(define rust-field-offset-0.3.6
  (crate-source "field-offset" "0.3.6"
                "0zq5sssaa2ckmcmxxbly8qgz3sxpb8g1lwv90sdh1z74qif2gqiq"))

(define rust-filetime-0.2.25
  (crate-source "filetime" "0.2.25"
                "11l5zr86n5sr6g6k6sqldswk0jzklm0q95rzikxcns0yk0p55h1m"))

(define rust-flate2-1.1.2
  (crate-source "flate2" "1.1.2"
                "07abz7v50lkdr5fjw8zaw2v8gm2vbppc0f7nqm8x3v3gb6wpsgaa"))

(define rust-fnv-1.0.7
  (crate-source "fnv" "1.0.7"
                "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))

(define rust-foreign-types-0.3.2
  (crate-source "foreign-types" "0.3.2"
                "1cgk0vyd7r45cj769jym4a6s7vwshvd0z4bqrb92q1fwibmkkwzn"))

(define rust-foreign-types-0.5.0
  (crate-source "foreign-types" "0.5.0"
                "0rfr2zfxnx9rz3292z5nyk8qs2iirznn5ff3rd4vgdwza6mdjdyp"))

(define rust-foreign-types-macros-0.2.3
  (crate-source "foreign-types-macros" "0.2.3"
                "0hjpii8ny6l7h7jpns2cp9589016l8mlrpaigcnayjn9bdc6qp0s"))

(define rust-foreign-types-shared-0.1.1
  (crate-source "foreign-types-shared" "0.1.1"
                "0jxgzd04ra4imjv8jgkmdq59kj8fsz6w4zxsbmlai34h26225c00"))

(define rust-foreign-types-shared-0.3.1
  (crate-source "foreign-types-shared" "0.3.1"
                "0nykdvv41a3d4py61bylmlwjhhvdm0b3bcj9vxhqgxaxnp5ik6ma"))

(define rust-form-urlencoded-1.2.1
  (crate-source "form_urlencoded" "1.2.1"
                "0milh8x7nl4f450s3ddhg57a3flcv6yq8hlkyk6fyr3mcb128dp1"))

(define rust-fs-extra-1.3.0
  (crate-source "fs_extra" "1.3.0"
                "075i25z70j2mz9r7i9p9r521y8xdj81q7skslyb7zhqnnw33fw22"))

(define rust-futf-0.1.5
  (crate-source "futf" "0.1.5"
                "0hvqk2r7v4fnc34hvc3vkri89gn52d5m9ihygmwn75l1hhp0whnz"))

(define rust-futures-0.3.31
  (crate-source "futures" "0.3.31"
                "0xh8ddbkm9jy8kc5gbvjp9a4b6rqqxvc8471yb2qaz5wm2qhgg35"))

(define rust-futures-channel-0.3.31
  (crate-source "futures-channel" "0.3.31"
                "040vpqpqlbk099razq8lyn74m0f161zd0rp36hciqrwcg2zibzrd"))

(define rust-futures-core-0.3.31
  (crate-source "futures-core" "0.3.31"
                "0gk6yrxgi5ihfanm2y431jadrll00n5ifhnpx090c2f2q1cr1wh5"))

(define rust-futures-executor-0.3.31
  (crate-source "futures-executor" "0.3.31"
                "17vcci6mdfzx4gbk0wx64chr2f13wwwpvyf3xd5fb1gmjzcx2a0y"))

(define rust-futures-io-0.3.31
  (crate-source "futures-io" "0.3.31"
                "1ikmw1yfbgvsychmsihdkwa8a1knank2d9a8dk01mbjar9w1np4y"))

(define rust-futures-lite-2.6.0
  (crate-source "futures-lite" "2.6.0"
                "0cmmgszlmkwsac9pyw5rfjakmshgx4wmzmlyn6mmjs0jav4axvgm"))

(define rust-futures-macro-0.3.31
  (crate-source "futures-macro" "0.3.31"
                "0l1n7kqzwwmgiznn0ywdc5i24z72zvh9q1dwps54mimppi7f6bhn"))

(define rust-futures-sink-0.3.31
  (crate-source "futures-sink" "0.3.31"
                "1xyly6naq6aqm52d5rh236snm08kw8zadydwqz8bip70s6vzlxg5"))

(define rust-futures-task-0.3.31
  (crate-source "futures-task" "0.3.31"
                "124rv4n90f5xwfsm9qw6y99755y021cmi5dhzh253s920z77s3zr"))

(define rust-futures-util-0.3.31
  (crate-source "futures-util" "0.3.31"
                "10aa1ar8bgkgbr4wzxlidkqkcxf77gffyj8j7768h831pcaq784z"))

(define rust-fxhash-0.2.1
  (crate-source "fxhash" "0.2.1"
                "037mb9ichariqi45xm6mz0b11pa92gj38ba0409z3iz239sns6y3"))

(define rust-gdk-0.18.2
  (crate-source "gdk" "0.18.2"
                "14967h4pac5gjyrd47yls4wbicrzhbwnd4ajisfwjyk2ijalbwnr"))

(define rust-gdk-pixbuf-0.18.5
  (crate-source "gdk-pixbuf" "0.18.5"
                "1v7svvl0g7zybndmis5inaqqgi1mvcc6s1n8rkb31f5zn3qzbqah"))

(define rust-gdk-pixbuf-sys-0.18.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdk-pixbuf-sys" "0.18.0"
                "1xya543c4ffd2n7aiwwrdxsyc9casdbasafi6ixcknafckm3k61z"))

(define rust-gdk-sys-0.18.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdk-sys" "0.18.2"
                "1xzkl9mdfsj1zja7ikrg3g8rinqsb9nqq64yc5k1xb4lhpri6baw"))

(define rust-gdkwayland-sys-0.18.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdkwayland-sys" "0.18.2"
                "0sgyipcl2k39ybw7mk6mii17ggdgaphva2cz5dbzf8yj0vap200l"))

(define rust-gdkx11-0.18.2
  (crate-source "gdkx11" "0.18.2"
                "1zpvndnqasyk9gfnh8mwkb27gsr70dlkcg1v334bpgji8ghh1aiw"))

(define rust-gdkx11-sys-0.18.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gdkx11-sys" "0.18.2"
                "13a2yjqac7i6bqxkpdjfa5rf33v0v06jdnq12vqjdb01zr2p8bkf"))

(define rust-generic-array-0.14.7
  (crate-source "generic-array" "0.14.7"
                "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))

(define rust-getrandom-0.1.16
  (crate-source "getrandom" "0.1.16"
                "1kjzmz60qx9mn615ks1akjbf36n3lkv27zfwbcam0fzmj56wphwg"))

(define rust-getrandom-0.2.16
  (crate-source "getrandom" "0.2.16"
                "14l5aaia20cc6cc08xdlhrzmfcylmrnprwnna20lqf746pqzjprk"))

(define rust-getrandom-0.3.3
  (crate-source "getrandom" "0.3.3"
                "1x6jl875zp6b2b6qp9ghc84b0l76bvng2lvm8zfcmwjl7rb5w516"))

(define rust-gimli-0.31.1
  (crate-source "gimli" "0.31.1"
                "0gvqc0ramx8szv76jhfd4dms0zyamvlg4whhiz11j34hh3dqxqh7"))

(define rust-gio-0.18.4
  (crate-source "gio" "0.18.4"
                "0wsc6mnx057s4ailacg99dwgna38dbqli5x7a6y9rdw75x9qzz6l"))

(define rust-gio-sys-0.18.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gio-sys" "0.18.1"
                "1lip8z35iy9d184x2qwjxlbxi64q9cpayy7v1p5y9xdsa3w6smip"))

(define rust-glib-0.18.5
  (crate-source "glib" "0.18.5"
                "1r8fw0627nmn19bgk3xpmcfngx3wkn7mcpq5a8ma3risx3valg93"))

(define rust-glib-macros-0.18.5
  (crate-source "glib-macros" "0.18.5"
                "1p5cla53fcp195zp0hkqpmnn7iwmkdswhy7xh34002bw8y7j5c0b"))

(define rust-glib-sys-0.18.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "glib-sys" "0.18.1"
                "164qhsfmlzd5mhyxs8123jzbdfldwxbikfpq5cysj3lddbmy4g06"))

(define rust-glob-0.3.2
  (crate-source "glob" "0.3.2"
                "1cm2w34b5w45fxr522h5b0fv1bxchfswcj560m3pnjbia7asvld8"))

(define rust-gobject-sys-0.18.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gobject-sys" "0.18.0"
                "0i6fhp3m6vs3wkzyc22rk2cqj68qvgddxmpaai34l72da5xi4l08"))

(define rust-gtk-0.18.2
  (crate-source "gtk" "0.18.2"
                "0sjh12mvvcmkz54nn30lb2xrzxagshbz1x2i4xfvshpwgccznmpx"))

(define rust-gtk-sys-0.18.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "gtk-sys" "0.18.2"
                "0524c9mwx5jxkl8pb6q45g2n1kfwajz1isa0vnvkwmar3k1a2acg"))

(define rust-gtk3-macros-0.18.2
  (crate-source "gtk3-macros" "0.18.2"
                "179yszj83hgfxl4h4g2zfbsyn9a2zc5zrp6nzqv0fkzi45dkrzsj"))

(define rust-h2-0.4.10
  (crate-source "h2" "0.4.10"
                "19f0va87lhzrc0lmwkgcz1z0haf6glajb4icp0b7n50vdmkilhm9"))

(define rust-hashbrown-0.12.3
  (crate-source "hashbrown" "0.12.3"
                "1268ka4750pyg2pbgsr43f0289l5zah4arir2k4igx5a8c6fg7la"))

(define rust-hashbrown-0.15.4
  (crate-source "hashbrown" "0.15.4"
                "1mg045sm1nm00cwjm7ndi80hcmmv1v3z7gnapxyhd9qxc62sqwar"))

(define rust-heck-0.4.1
  (crate-source "heck" "0.4.1"
                "1a7mqsnycv5z4z5vnv1k34548jzmc0ajic7c1j8jsaspnhw5ql4m"))

(define rust-heck-0.5.0
  (crate-source "heck" "0.5.0"
                "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))

(define rust-hermit-abi-0.5.2
  (crate-source "hermit-abi" "0.5.2"
                "1744vaqkczpwncfy960j2hxrbjl1q01csm84jpd9dajbdr2yy3zw"))

(define rust-hex-0.4.3
  (crate-source "hex" "0.4.3"
                "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))

(define rust-home-0.5.11
  (crate-source "home" "0.5.11"
                "1kxb4k87a9sayr8jipr7nq9wpgmjk4hk4047hmf9kc24692k75aq"))

(define rust-html5ever-0.29.1
  (crate-source "html5ever" "0.29.1"
                "07518h5gbw0c6x7w5br76bgxvgphs6zlrb4q7ii7bg1ww7510x1v"))

(define rust-http-1.3.1
  (crate-source "http" "1.3.1"
                "0r95i5h7dr1xadp1ac9453w0s62s27hzkam356nyx2d9mqqmva7l"))

(define rust-http-body-1.0.1
  (crate-source "http-body" "1.0.1"
                "111ir5k2b9ihz5nr9cz7cwm7fnydca7dx4hc7vr16scfzghxrzhy"))

(define rust-http-body-util-0.1.3
  (crate-source "http-body-util" "0.1.3"
                "0jm6jv4gxsnlsi1kzdyffjrj8cfr3zninnxpw73mvkxy4qzdj8dh"))

(define rust-httparse-1.10.1
  (crate-source "httparse" "1.10.1"
                "11ycd554bw2dkgw0q61xsa7a4jn1wb1xbfacmf3dbwsikvkkvgvd"))

(define rust-hyper-1.6.0
  (crate-source "hyper" "1.6.0"
                "103ggny2k31z0iq2gzwk2vbx601wx6xkpjpxn40hr3p3b0b5fayc"))

(define rust-hyper-rustls-0.27.7
  (crate-source "hyper-rustls" "0.27.7"
                "0n6g8998szbzhnvcs1b7ibn745grxiqmlpg53xz206v826v3xjg3"))

(define rust-hyper-tls-0.6.0
  (crate-source "hyper-tls" "0.6.0"
                "1q36x2yps6hhvxq5r7mc8ph9zz6xlb573gx0x3yskb0fi736y83h"))

(define rust-hyper-util-0.1.14
  (crate-source "hyper-util" "0.1.14"
                "1nqvf5azmv8p7hs5ghjlbgfya7xaafq377vppdazxbq8zzdxybyw"))

(define rust-iana-time-zone-0.1.63
  (crate-source "iana-time-zone" "0.1.63"
                "1n171f5lbc7bryzmp1h30zw86zbvl5480aq02z92lcdwvvjikjdh"))

(define rust-iana-time-zone-haiku-0.1.2
  (crate-source "iana-time-zone-haiku" "0.1.2"
                "17r6jmj31chn7xs9698r122mapq85mfnv98bb4pg6spm0si2f67k"))

(define rust-ico-0.4.0
  (crate-source "ico" "0.4.0"
                "162bxmrg008x1zhrvl0ah6rhgvl2mm1yr27gf47gxy5cwj8vhl6c"))

(define rust-icu-collections-2.0.0
  (crate-source "icu_collections" "2.0.0"
                "0izfgypv1hsxlz1h8fc2aak641iyvkak16aaz5b4aqg3s3sp4010"))

(define rust-icu-locale-core-2.0.0
  (crate-source "icu_locale_core" "2.0.0"
                "02phv7vwhyx6vmaqgwkh2p4kc2kciykv2px6g4h8glxfrh02gphc"))

(define rust-icu-normalizer-2.0.0
  (crate-source "icu_normalizer" "2.0.0"
                "0ybrnfnxx4sf09gsrxri8p48qifn54il6n3dq2xxgx4dw7l80s23"))

(define rust-icu-normalizer-data-2.0.0
  (crate-source "icu_normalizer_data" "2.0.0"
                "1lvjpzxndyhhjyzd1f6vi961gvzhj244nribfpdqxjdgjdl0s880"))

(define rust-icu-properties-2.0.1
  (crate-source "icu_properties" "2.0.1"
                "0az349pjg8f18lrjbdmxcpg676a7iz2ibc09d2wfz57b3sf62v01"))

(define rust-icu-properties-data-2.0.1
  (crate-source "icu_properties_data" "2.0.1"
                "0cnn3fkq6k88w7p86w7hsd1254s4sl783rpz4p6hlccq74a5k119"))

(define rust-icu-provider-2.0.0
  (crate-source "icu_provider" "2.0.0"
                "1bz5v02gxv1i06yhdhs2kbwxkw3ny9r2vvj9j288fhazgfi0vj03"))

(define rust-ident-case-1.0.1
  (crate-source "ident_case" "1.0.1"
                "0fac21q6pwns8gh1hz3nbq15j8fi441ncl6w4vlnd1cmc55kiq5r"))

(define rust-idna-1.0.3
  (crate-source "idna" "1.0.3"
                "0zlajvm2k3wy0ay8plr07w22hxkkmrxkffa6ah57ac6nci984vv8"))

(define rust-idna-adapter-1.2.1
  (crate-source "idna_adapter" "1.2.1"
                "0i0339pxig6mv786nkqcxnwqa87v4m94b2653f6k3aj0jmhfkjis"))

(define rust-indexmap-1.9.3
  (crate-source "indexmap" "1.9.3"
                "16dxmy7yvk51wvnih3a3im6fp5lmx0wx76i03n06wyak6cwhw1xx"))

(define rust-indexmap-2.10.0
  (crate-source "indexmap" "2.10.0"
                "0qd6g26gxzl6dbf132w48fa8rr95glly3jhbk90i29726d9xhk7y"))

(define rust-infer-0.19.0
  (crate-source "infer" "0.19.0"
                "1xzwzzg7s3i9jhcd304rb7b7838zkcysd67gmhffg4pxzmmr3255"))

(define rust-inflector-0.11.4
  (crate-source "Inflector" "0.11.4"
                "1lqmcni21ifzyq41fhz6k1j2b23cmsx469s4g4sf01l78miqqhzy"))

(define rust-io-uring-0.7.8
  (crate-source "io-uring" "0.7.8"
                "04whnj5a4pml44jhsmmf4p87bpgr7swkcijx4yjcng8900pj0vmq"))

(define rust-ipnet-2.11.0
  (crate-source "ipnet" "2.11.0"
                "0c5i9sfi2asai28m8xp48k5gvwkqrg5ffpi767py6mzsrswv17s6"))

(define rust-iri-string-0.7.8
  (crate-source "iri-string" "0.7.8"
                "1cl0wfq97wq4s1p4dl0ix5cfgsc5fn7l22ljgw9ab9x1qglypifv"))

(define rust-is-docker-0.2.0
  (crate-source "is-docker" "0.2.0"
                "1cyibrv6817cqcpf391m327ss40xlbik8wxcv5h9pj9byhksx2wj"))

(define rust-is-terminal-polyfill-1.70.1
  (crate-source "is_terminal_polyfill" "1.70.1"
                "1kwfgglh91z33kl0w5i338mfpa3zs0hidq5j4ny4rmjwrikchhvr"))

(define rust-is-wsl-0.4.0
  (crate-source "is-wsl" "0.4.0"
                "19bs5pq221d4bknnwiqqkqrnsx2in0fsk8fylxm1747iim4hjdhp"))

(define rust-itertools-0.14.0
  (crate-source "itertools" "0.14.0"
                "118j6l1vs2mx65dqhwyssbrxpawa90886m3mzafdvyip41w2q69b"))

(define rust-itoa-1.0.15
  (crate-source "itoa" "1.0.15"
                "0b4fj9kz54dr3wam0vprjwgygvycyw8r0qwg7vp19ly8b2w16psa"))

(define rust-javascriptcore-rs-1.1.2
  (crate-source "javascriptcore-rs" "1.1.2"
                "1k3z4pmg46znxfmjqvx63d5zr9vdj070f97wgajzp3yfzzlp2mna"))

(define rust-javascriptcore-rs-sys-1.1.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "javascriptcore-rs-sys" "1.1.1"
                "092igagxm561lx65sin2z18jpxzyg0288cfzcrdvg97z2j6yf6xg"))

(define rust-jiff-0.2.15
  (crate-source "jiff" "0.2.15"
                "0jby6kbs2ra33ji0rx4swcp66jzmcvgszc5v4izwfsgbn6w967xy"))

(define rust-jiff-static-0.2.15
  (crate-source "jiff-static" "0.2.15"
                "1d4l4pvlhz3w487gyhnzvagpbparspv4c8f35qk6g5w9zx8k8d03"))

(define rust-jni-0.21.1
  (crate-source "jni" "0.21.1"
                "15wczfkr2r45slsljby12ymf2hij8wi5b104ghck9byjnwmsm1qs"))

(define rust-jni-sys-0.3.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "jni-sys" "0.3.0"
                "0c01zb9ygvwg9wdx2fii2d39myzprnpqqhy7yizxvjqp5p04pbwf"))

(define rust-js-sys-0.3.77
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "js-sys" "0.3.77"
                "13x2qcky5l22z4xgivi59xhjjx4kxir1zg7gcj0f1ijzd4yg7yhw"))

(define rust-json-patch-3.0.1
  (crate-source "json-patch" "3.0.1"
                "023gm1q5xhhnhz7jqk009yb5wpjl4gckawgzxs82bg5nmzbjcdw6"))

(define rust-jsonptr-0.6.3
  (crate-source "jsonptr" "0.6.3"
                "0w6xkr6ns46nm3136x7www1dczz45y2bl9bsxmb2b6r3vlkjpsjx"))

(define rust-keyboard-types-0.7.0
  (crate-source "keyboard-types" "0.7.0"
                "12jjfk7dwa1cqp6wzw0xl1zzg3arsrnqy4afsynxn2csqfnxql5p"))

(define rust-kuchikiki-0.8.8-speedreader
  (crate-source "kuchikiki" "0.8.8-speedreader"
                "1hhc4wccczgjiy7ir9g58cafm1xr2b0ra37s9bx36zv8fmqrgjq2"))

(define rust-lazy-static-1.5.0
  (crate-source "lazy_static" "1.5.0"
                "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))

(define rust-libappindicator-0.9.0
  (crate-source "libappindicator" "0.9.0"
                "02nwjmm5qqbkvzbz4j1dd50xs0ywr0i2l2scwmxcqs680yb9nn03"))

(define rust-libappindicator-sys-0.9.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "libappindicator-sys" "0.9.0"
                "1bsw2mcxil3zm4zzdir76i7xnaqaq30cd9qpviccrvdb70hwb7kf"))

(define rust-libc-0.2.173
  (crate-source "libc" "0.2.173"
                "1fv4bm97pvzzxmcqfvxwiw59zsjjklv53cjgnrv23hyvzzxfmkyq"))

(define rust-libloading-0.7.4
  (crate-source "libloading" "0.7.4"
                "17wbccnjvhjd9ibh019xcd8kjvqws8lqgq86lqkpbgig7gyq0wxn"))

(define rust-libredox-0.1.3
  (crate-source "libredox" "0.1.3"
                "139602gzgs0k91zb7dvgj1qh4ynb8g1lbxsswdim18hcb6ykgzy0"))

(define rust-linux-raw-sys-0.9.4
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "linux-raw-sys" "0.9.4"
                "04kyjdrq79lz9ibrf7czk6cv9d3jl597pb9738vzbsbzy1j5i56d"))

(define rust-litemap-0.8.0
  (crate-source "litemap" "0.8.0"
                "0mlrlskwwhirxk3wsz9psh6nxcy491n0dh8zl02qgj0jzpssw7i4"))

(define rust-lock-api-0.4.13
  (crate-source "lock_api" "0.4.13"
                "0rd73p4299mjwl4hhlfj9qr88v3r0kc8s1nszkfmnq2ky43nb4wn"))

(define rust-log-0.4.27
  (crate-source "log" "0.4.27"
                "150x589dqil307rv0rwj0jsgz5bjbwvl83gyl61jf873a7rjvp0k"))

(define rust-log-panics-2.1.0
  (crate-source "log-panics" "2.1.0"
                "0pxcq9f4jmcs2l9lgs6hj2w3ba80zzsj4zgnxi81h70r8s2xvyb8"))

(define rust-lru-slab-0.1.2
  (crate-source "lru-slab" "0.1.2"
                "0m2139k466qj3bnpk66bwivgcx3z88qkxvlzk70vd65jq373jaqi"))

(define rust-mac-0.1.1
  (crate-source "mac" "0.1.1"
                "194vc7vrshqff72rl56f9xgb0cazyl4jda7qsv31m5l6xx7hq7n4"))

(define rust-markup5ever-0.14.1
  (crate-source "markup5ever" "0.14.1"
                "063sdq7hwxn2al9ygify8dd96mj57n9c4lig007lr1p128yj39y7"))

(define rust-match-token-0.1.0
  (crate-source "match_token" "0.1.0"
                "0sx3212vkjqfblfhr556ayabbjflbigjf5j591j9kgs4infniac8"))

(define rust-matches-0.1.10
  (crate-source "matches" "0.1.10"
                "1994402fq4viys7pjhzisj4wcw894l53g798kkm2y74laxk0jci5"))

(define rust-memchr-2.7.5
  (crate-source "memchr" "2.7.5"
                "1h2bh2jajkizz04fh047lpid5wgw2cr9igpkdhl3ibzscpd858ij"))

(define rust-memoffset-0.9.1
  (crate-source "memoffset" "0.9.1"
                "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))

(define rust-mime-0.3.17
  (crate-source "mime" "0.3.17"
                "16hkibgvb9klh0w0jk5crr5xv90l3wlf77ggymzjmvl1818vnxv8"))

(define rust-minimal-lexical-0.2.1
  (crate-source "minimal-lexical" "0.2.1"
                "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))

(define rust-minisign-verify-0.2.4
  (crate-source "minisign-verify" "0.2.4"
                "0hsdqhkj9m93vp72p9pl1sl9cajh97pa8xj6yprgb8i36v8zsmp8"))

(define rust-miniz-oxide-0.8.9
  (crate-source "miniz_oxide" "0.8.9"
                "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))

(define rust-mio-1.0.4
  (crate-source "mio" "1.0.4"
                "073n3kam3nz8j8had35fd2nn7j6a33pi3y5w3kq608cari2d9gkq"))

(define rust-muda-0.17.0
  (crate-source "muda" "0.17.0"
                "1209c058ckb6rsz031kwcv00h3sn3jl8bazi8xih7gqr3kwrpf2q"))

(define rust-native-tls-0.2.14
  (crate-source "native-tls" "0.2.14"
                "03hga800x8bzkp8h7frnm7yp545dwwawgmaq673vx7byk1139pl7"))

(define rust-ndk-0.9.0
  (crate-source "ndk" "0.9.0"
                "1m32zpmi5w1pf3j47k6k5fw395dc7aj8d0mdpsv53lqkprxjxx63"))

(define rust-ndk-context-0.1.1
  (crate-source "ndk-context" "0.1.1"
                "12sai3dqsblsvfd1l1zab0z6xsnlha3xsfl7kagdnmj3an3jvc17"))

(define rust-ndk-sys-0.6.0+11769913
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "ndk-sys" "0.6.0+11769913"
                "0wx8r6pji20if4xs04g73gxl98nmjrfc73z0v6w1ypv6a4qdlv7f"))

(define rust-new-debug-unreachable-1.0.6
  (crate-source "new_debug_unreachable" "1.0.6"
                "11phpf1mjxq6khk91yzcbd3ympm78m3ivl7xg6lg2c0lf66fy3k5"))

(define rust-nix-0.30.1
  (crate-source "nix" "0.30.1"
                "1dixahq9hk191g0c2ydc0h1ppxj0xw536y6rl63vlnp06lx3ylkl"))

(define rust-nodrop-0.1.14
  (crate-source "nodrop" "0.1.14"
                "1fz1v9r8ijacf0hlq0pdv5l9mz8vgqg1snmhvpjmi9aci1b4mvvj"))

(define rust-nom-7.1.3
  (crate-source "nom" "7.1.3"
                "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))

(define rust-num-conv-0.1.0
  (crate-source "num-conv" "0.1.0"
                "1ndiyg82q73783jq18isi71a7mjh56wxrk52rlvyx0mi5z9ibmai"))

(define rust-num-enum-0.7.3
  (crate-source "num_enum" "0.7.3"
                "0yai0vafhy85mvhknzfqd7lm04hzaln7i5c599rhy8mj831kyqaf"))

(define rust-num-enum-derive-0.7.3
  (crate-source "num_enum_derive" "0.7.3"
                "0mksna1jj87ydh146gn6jcqkvvs920c3dgh0p4f3xk184kpl865g"))

(define rust-num-traits-0.2.19
  (crate-source "num-traits" "0.2.19"
                "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))

(define rust-objc-sys-0.3.5
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "objc-sys" "0.3.5"
                "0423gry7s3rmz8s3pzzm1zy5mdjif75g6dbzc2lf2z0c77fipffd"))

(define rust-objc2-0.5.2
  (crate-source "objc2" "0.5.2"
                "015qa2d3vh7c1j2736h5wjrznri7x5ic35vl916c22gzxva8b9s6"))

(define rust-objc2-0.6.1
  (crate-source "objc2" "0.6.1"
                "0l85a8r77i8i183fqyx55kqm2nh9rzg2z3z59kjb4fj92iz5kil8"))

(define rust-objc2-app-kit-0.3.1
  (crate-source "objc2-app-kit" "0.3.1"
                "1k4vz0s63rpp1yyhx96mh9nndn1zzv2cwxzpvw6rnigcidb9zwp6"))

(define rust-objc2-cloud-kit-0.3.1
  (crate-source "objc2-cloud-kit" "0.3.1"
                "0pd1iq5gw1c024gipy3x7al8p40g2p8b3pqp27zyc4dlv7f4yq8p"))

(define rust-objc2-core-data-0.3.1
  (crate-source "objc2-core-data" "0.3.1"
                "179j6k4a7m5780qn41xnsh7p0x4w4gvpqhc6hs7531wjsbvvn7r9"))

(define rust-objc2-core-foundation-0.3.1
  (crate-source "objc2-core-foundation" "0.3.1"
                "0rn19d70mwxyv74kx7aqm5in6x320vavq9v0vrm81vbg9a4w440w"))

(define rust-objc2-core-graphics-0.3.1
  (crate-source "objc2-core-graphics" "0.3.1"
                "197mf2a4yvvigkd9hsp8abbpip7rn3mmc55psv1ba89hq5l6r74q"))

(define rust-objc2-core-image-0.3.1
  (crate-source "objc2-core-image" "0.3.1"
                "0zh0ihcb46lh09azhr5hfn74rx576hdmjmy1477nqsrqqh6drcvr"))

(define rust-objc2-encode-4.1.0
  (crate-source "objc2-encode" "4.1.0"
                "0cqckp4cpf68mxyc2zgnazj8klv0z395nsgbafa61cjgsyyan9gg"))

(define rust-objc2-exception-helper-0.1.1
  (crate-source "objc2-exception-helper" "0.1.1"
                "12nrg6fhhp2rzmnym6s37h7w9v9sa9wbaixvfsq3axrdnzxwb8f7"))

(define rust-objc2-foundation-0.2.2
  (crate-source "objc2-foundation" "0.2.2"
                "1a6mi77jsig7950vmx9ydvsxaighzdiglk5d229k569pvajkirhf"))

(define rust-objc2-foundation-0.3.1
  (crate-source "objc2-foundation" "0.3.1"
                "0g5hl47dxzabs7wndcg6kz3q137v9hwfay1jd2da1q9gglj3224h"))

(define rust-objc2-io-surface-0.3.1
  (crate-source "objc2-io-surface" "0.3.1"
                "0g0c89swz8hgfrh0j1iqhcz3ig7cyhavn3p9gi2s77sjjanfk0kj"))

(define rust-objc2-metal-0.2.2
  (crate-source "objc2-metal" "0.2.2"
                "1mmdga66qpxrcfq3gxxhysfx3zg1hpx4z886liv3j0pnfq9bl36x"))

(define rust-objc2-osa-kit-0.3.1
  (crate-source "objc2-osa-kit" "0.3.1"
                "0pfwgcz7l6ai0dgvq1xiavfmfpmz0x343lhmlnxhs1as9d88ifr6"))

(define rust-objc2-quartz-core-0.2.2
  (crate-source "objc2-quartz-core" "0.2.2"
                "0ynw8819c36l11rim8n0yzk0fskbzrgaqayscyqi8swhzxxywaz4"))

(define rust-objc2-quartz-core-0.3.1
  (crate-source "objc2-quartz-core" "0.3.1"
                "1mfcnbgs4akjwb2xxqmkfixpz98j1db8hhrkck4js62zrnhbdzwh"))

(define rust-objc2-ui-kit-0.3.1
  (crate-source "objc2-ui-kit" "0.3.1"
                "1vfs4w85jaq27fcrnbw332v1zbhaz48al5xfmn90x2mwswm33c95"))

(define rust-objc2-web-kit-0.3.1
  (crate-source "objc2-web-kit" "0.3.1"
                "1ba77j84fk3v7n5j9f8lknnwjj8nikpbp59f4p1f274bvq4jjrwi"))

(define rust-object-0.36.7
  (crate-source "object" "0.36.7"
                "11vv97djn9nc5n6w1gc6bd96d2qk2c8cg1kw5km9bsi3v4a8x532"))

(define rust-object-0.37.1
  (crate-source "object" "0.37.1"
                "0jhvws8f1rq4mba5czpmj3jk11x41f4m1l5knil1g7h6c4qr9z83"))

(define rust-once-cell-1.21.3
  (crate-source "once_cell" "1.21.3"
                "0b9x77lb9f1j6nqgf5aka4s2qj0nly176bpbrv6f9iakk5ff3xa2"))

(define rust-once-cell-polyfill-1.70.1
  (crate-source "once_cell_polyfill" "1.70.1"
                "1bg0w99srq8h4mkl68l1mza2n2f2hvrg0n8vfa3izjr5nism32d4"))

(define rust-open-5.3.2
  (crate-source "open" "5.3.2"
                "15ggfx1p8rl7w4rr1n5qj1wxy1kk7757lsjpyc947a9fwri3aj72"))

(define rust-openssl-0.10.73
  (crate-source "openssl" "0.10.73"
                "1y7b3kanpgb92wiqhwbyqfsdr1xdjzssxqywl4cixay88r6p61c5"))

(define rust-openssl-macros-0.1.1
  (crate-source "openssl-macros" "0.1.1"
                "173xxvfc63rr5ybwqwylsir0vq6xsj4kxiv4hmg4c3vscdmncj59"))

(define rust-openssl-probe-0.1.6
  (crate-source "openssl-probe" "0.1.6"
                "0bl52x55laalqb707k009h8kfawliwp992rlsvkzy49n47p2fpnh"))

(define rust-openssl-src-300.5.0+3.5.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "openssl-src" "300.5.0+3.5.0"
                "0bww7zpd21hss5xix46sfl4354bx92c92r1b0pkb09lkaipm9kp8"))

(define rust-openssl-sys-0.9.109
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "openssl-sys" "0.9.109"
                "0wc54dshsac1xicq6b5wz01p358zcbf542f2s6vph3b38wp6w2ch"))

(define rust-opool-0.1.1
  (crate-source "opool" "0.1.1"
                "1gp2qjvjlfgxgjc0qcj9vri76zim9q7i9rdq4dpmkirmhhfvd3f3"))

(define rust-option-ext-0.2.0
  (crate-source "option-ext" "0.2.0"
                "0zbf7cx8ib99frnlanpyikm1bx8qn8x602sw1n7bg6p9x94lyx04"))

(define rust-ordered-float-2.10.1
  (crate-source "ordered-float" "2.10.1"
                "075i108hr95pr7hy4fgxivib5pky3b6b22rywya5qyd2wmkrvwb8"))

(define rust-ordered-stream-0.2.0
  (crate-source "ordered-stream" "0.2.0"
                "0l0xxp697q7wiix1gnfn66xsss7fdhfivl2k7bvpjs4i3lgb18ls"))

(define rust-osakit-0.3.1
  (crate-source "osakit" "0.3.1"
                "06r6spdjjgjir4pl0lglliilhgxx2y3s0zlxnrdhcb57xb572b3k"))

(define rust-pango-0.18.3
  (crate-source "pango" "0.18.3"
                "1r5ygq7036sv7w32kp8yxr6vgggd54iaavh3yckanmq4xg0px8kw"))

(define rust-pango-sys-0.18.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "pango-sys" "0.18.0"
                "1iaxalcaaj59cl9n10svh4g50v8jrc1a36kd7n9yahx8j7ikfrs3"))

(define rust-parking-2.2.1
  (crate-source "parking" "2.2.1"
                "1fnfgmzkfpjd69v4j9x737b1k8pnn054bvzcn5dm3pkgq595d3gk"))

(define rust-parking-lot-0.12.4
  (crate-source "parking_lot" "0.12.4"
                "04sab1c7304jg8k0d5b2pxbj1fvgzcf69l3n2mfpkdb96vs8pmbh"))

(define rust-parking-lot-core-0.9.11
  (crate-source "parking_lot_core" "0.9.11"
                "19g4d6m5k4ggacinqprnn8xvdaszc3y5smsmbz1adcdmaqm8v0xw"))

(define rust-paste-1.0.15
  (crate-source "paste" "1.0.15"
                "02pxffpdqkapy292harq6asfjvadgp1s005fip9ljfsn9fvxgh2p"))

(define rust-pathdiff-0.2.3
  (crate-source "pathdiff" "0.2.3"
                "1lrqp4ip05df8dzldq6gb2c1sq2gs54gly8lcnv3rhav1qhwx56z"))

(define rust-percent-encoding-2.3.1
  (crate-source "percent-encoding" "2.3.1"
                "0gi8wgx0dcy8rnv1kywdv98lwcx67hz0a0zwpib5v2i08r88y573"))

(define rust-phf-0.10.1
  (crate-source "phf" "0.10.1"
                "0naj8n5nasv5hj5ldlva3cl6y3sv7zp3kfgqylhbrg55v3mg3fzs"))

(define rust-phf-0.11.3
  (crate-source "phf" "0.11.3"
                "0y6hxp1d48rx2434wgi5g8j1pr8s5jja29ha2b65435fh057imhz"))

(define rust-phf-0.8.0
  (crate-source "phf" "0.8.0"
                "04pyv8bzqvw69rd5dynd5nb85py1hf7wa4ixyhrvdz1l5qin3yrx"))

(define rust-phf-codegen-0.11.3
  (crate-source "phf_codegen" "0.11.3"
                "0si1n6zr93kzjs3wah04ikw8z6npsr39jw4dam8yi9czg2609y5f"))

(define rust-phf-codegen-0.8.0
  (crate-source "phf_codegen" "0.8.0"
                "05d8w7aqqjb6039pfm6404gk5dlwrrf97kiy1n21212vb1hyxzyb"))

(define rust-phf-generator-0.10.0
  (crate-source "phf_generator" "0.10.0"
                "1mlq6hlajsvlsx6rhw49g9ricsm017lrxmgmmbk85sxm7f4qaljx"))

(define rust-phf-generator-0.11.3
  (crate-source "phf_generator" "0.11.3"
                "0gc4np7s91ynrgw73s2i7iakhb4lzdv1gcyx7yhlc0n214a2701w"))

(define rust-phf-generator-0.8.0
  (crate-source "phf_generator" "0.8.0"
                "09i5338d1kixq6a60fcayz6awgxjlxcfw9ic5f02abbgr067ydhp"))

(define rust-phf-macros-0.10.0
  (crate-source "phf_macros" "0.10.0"
                "1q5ljwvb10dx188i6jxzckqfimjw5pm2p4kkvmhg2q6m9lcg7zaq"))

(define rust-phf-macros-0.11.3
  (crate-source "phf_macros" "0.11.3"
                "05kjfbyb439344rhmlzzw0f9bwk9fp95mmw56zs7yfn1552c0jpq"))

(define rust-phf-shared-0.10.0
  (crate-source "phf_shared" "0.10.0"
                "15n02nc8yqpd8hbxngblar2g53p3nllc93d8s8ih3p5cf7bnlydn"))

(define rust-phf-shared-0.11.3
  (crate-source "phf_shared" "0.11.3"
                "1rallyvh28jqd9i916gk5gk2igdmzlgvv5q0l3xbf3m6y8pbrsk7"))

(define rust-phf-shared-0.8.0
  (crate-source "phf_shared" "0.8.0"
                "1xssnqrrcn0nr9ayqrnm8xm37ac4xvwcx8pax7jxss7yxawzh360"))

(define rust-pin-project-1.1.10
  (crate-source "pin-project" "1.1.10"
                "12kadbnfm1f43cyadw9gsbyln1cy7vj764wz5c8wxaiza3filzv7"))

(define rust-pin-project-internal-1.1.10
  (crate-source "pin-project-internal" "1.1.10"
                "0qgqzfl0f4lzaz7yl5llhbg97g68r15kljzihaw9wm64z17qx4bf"))

(define rust-pin-project-lite-0.2.16
  (crate-source "pin-project-lite" "0.2.16"
                "16wzc7z7dfkf9bmjin22f5282783f6mdksnr0nv0j5ym5f9gyg1v"))

(define rust-pin-utils-0.1.0
  (crate-source "pin-utils" "0.1.0"
                "117ir7vslsl2z1a7qzhws4pd01cg2d3338c47swjyvqv2n60v1wb"))

(define rust-piper-0.2.4
  (crate-source "piper" "0.2.4"
                "0rn0mjjm0cwagdkay77wgmz3sqf8fqmv9d9czm79mvr2yj8c9j4n"))

(define rust-pkg-config-0.3.32
  (crate-source "pkg-config" "0.3.32"
                "0k4h3gnzs94sjb2ix6jyksacs52cf1fanpwsmlhjnwrdnp8dppby"))

(define rust-plist-1.7.4
  (crate-source "plist" "1.7.4"
                "1qg7zkvnm4r4n9s9hbwwjnwznvkg6v0f035hza4agib3w64vbxis"))

(define rust-png-0.17.16
  (crate-source "png" "0.17.16"
                "09kmkms9fmkbkarw0lnf0scqvjwwg3r7riddag0i3q39r0pil5c2"))

(define rust-polling-3.8.0
  (crate-source "polling" "3.8.0"
                "0l7xlnzans2hc4zjxgplfp7gs16h9z3vdklnlpb2s05dj51nhfmm"))

(define rust-portable-atomic-1.11.1
  (crate-source "portable-atomic" "1.11.1"
                "10s4cx9y3jvw0idip09ar52s2kymq8rq9a668f793shn1ar6fhpq"))

(define rust-portable-atomic-util-0.2.4
  (crate-source "portable-atomic-util" "0.2.4"
                "01rmx1li07ixsx3sqg2bxqrkzk7b5n8pibwwf2589ms0s3cg18nq"))

(define rust-potential-utf-0.1.2
  (crate-source "potential_utf" "0.1.2"
                "11dm6k3krx3drbvhgjw8z508giiv0m09wzl6ghza37176w4c79z5"))

(define rust-powerfmt-0.2.0
  (crate-source "powerfmt" "0.2.0"
                "14ckj2xdpkhv3h6l5sdmb9f1d57z8hbfpdldjc2vl5givq2y77j3"))

(define rust-ppv-lite86-0.2.21
  (crate-source "ppv-lite86" "0.2.21"
                "1abxx6qz5qnd43br1dd9b2savpihzjza8gb4fbzdql1gxp2f7sl5"))

(define rust-precomputed-hash-0.1.1
  (crate-source "precomputed-hash" "0.1.1"
                "075k9bfy39jhs53cb2fpb9klfakx2glxnf28zdw08ws6lgpq6lwj"))

(define rust-proc-macro-crate-1.3.1
  (crate-source "proc-macro-crate" "1.3.1"
                "069r1k56bvgk0f58dm5swlssfcp79im230affwk6d9ck20g04k3z"))

(define rust-proc-macro-crate-2.0.0
  (crate-source "proc-macro-crate" "2.0.0"
                "1s23imns07vmacn2xjd5hv2h6rr94iqq3fd2frwa6i4h2nk6d0vy"))

(define rust-proc-macro-crate-3.3.0
  (crate-source "proc-macro-crate" "3.3.0"
                "0d9xlymplfi9yv3f5g4bp0d6qh70apnihvqcjllampx4f5lmikpd"))

(define rust-proc-macro-error-1.0.4
  (crate-source "proc-macro-error" "1.0.4"
                "1373bhxaf0pagd8zkyd03kkx6bchzf6g0dkwrwzsnal9z47lj9fs"))

(define rust-proc-macro-error-attr-1.0.4
  (crate-source "proc-macro-error-attr" "1.0.4"
                "0sgq6m5jfmasmwwy8x4mjygx5l7kp8s4j60bv25ckv2j1qc41gm1"))

(define rust-proc-macro-hack-0.5.20+deprecated
  (crate-source "proc-macro-hack" "0.5.20+deprecated"
                "0s402hmcs3k9nd6rlp07zkr1lz7yimkmcwcbgnly2zr44wamwdyw"))

(define rust-proc-macro2-1.0.95
  (crate-source "proc-macro2" "1.0.95"
                "0y7pwxv6sh4fgg6s715ygk1i7g3w02c0ljgcsfm046isibkfbcq2"))

(define rust-quick-xml-0.38.0
  (crate-source "quick-xml" "0.38.0"
                "06vvgd9arm1nrsd4d0ii6lhnp6m11bwy7drqa4k9hnjw9xkb09w9"))

(define rust-quinn-0.11.8
  (crate-source "quinn" "0.11.8"
                "1j02h87nfxww5mjcw4vjcnx8b70q0yinnc8xvjv82ryskii18qk2"))

(define rust-quinn-proto-0.11.12
  (crate-source "quinn-proto" "0.11.12"
                "0bj2yyrf1mrg2bcj19ipsspvrj5sq0di0pz5maw5pj31j4x89ps9"))

(define rust-quinn-udp-0.5.12
  (crate-source "quinn-udp" "0.5.12"
                "0hm89bv7mm383lv2c8z5r9512pdgp1q26lsmazicajgrj6cm4kpf"))

(define rust-quote-1.0.40
  (crate-source "quote" "1.0.40"
                "1394cxjg6nwld82pzp2d4fp6pmaz32gai1zh9z5hvh0dawww118q"))

(define rust-r-efi-5.2.0
  (crate-source "r-efi" "5.2.0"
                "1ig93jvpqyi87nc5kb6dri49p56q7r7qxrn8kfizmqkfj5nmyxkl"))

(define rust-rand-0.7.3
  (crate-source "rand" "0.7.3"
                "00sdaimkbz491qgi6qxkv582yivl32m2jd401kzbn94vsiwicsva"))

(define rust-rand-0.8.5
  (crate-source "rand" "0.8.5"
                "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))

(define rust-rand-0.9.1
  (crate-source "rand" "0.9.1"
                "15yxfcxbgmwba5cv7mjg9bhc1r5c9483dfcdfspg62x4jk8dkgwz"))

(define rust-rand-chacha-0.2.2
  (crate-source "rand_chacha" "0.2.2"
                "00il36fkdbsmpr99p9ksmmp6dn1md7rmnwmz0rr77jbrca2yvj7l"))

(define rust-rand-chacha-0.3.1
  (crate-source "rand_chacha" "0.3.1"
                "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))

(define rust-rand-chacha-0.9.0
  (crate-source "rand_chacha" "0.9.0"
                "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))

(define rust-rand-core-0.5.1
  (crate-source "rand_core" "0.5.1"
                "06bdvx08v3rkz451cm7z59xwwqn1rkfh6v9ay77b14f8dwlybgch"))

(define rust-rand-core-0.6.4
  (crate-source "rand_core" "0.6.4"
                "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))

(define rust-rand-core-0.9.3
  (crate-source "rand_core" "0.9.3"
                "0f3xhf16yks5ic6kmgxcpv1ngdhp48mmfy4ag82i1wnwh8ws3ncr"))

(define rust-rand-hc-0.2.0
  (crate-source "rand_hc" "0.2.0"
                "0g31sqwpmsirdlwr0svnacr4dbqyz339im4ssl9738cjgfpjjcfa"))

(define rust-rand-pcg-0.2.1
  (crate-source "rand_pcg" "0.2.1"
                "0ab4h6s6x3py833jk61lwadq83qd1c8bih2hgi6yps9rnv0x1aqn"))

(define rust-raw-window-handle-0.6.2
  (crate-source "raw-window-handle" "0.6.2"
                "0ff5c648hncwx7hm2a8fqgqlbvbl4xawb6v3xxv9wkpjyrr5arr0"))

(define rust-redox-syscall-0.5.13
  (crate-source "redox_syscall" "0.5.13"
                "1mlzna9bcd7ss1973bmysr3hpjrys82b3bd7l03h4jkbxv8bf10d"))

(define rust-redox-users-0.4.6
  (crate-source "redox_users" "0.4.6"
                "0hya2cxx6hxmjfxzv9n8rjl5igpychav7zfi1f81pz6i4krry05s"))

(define rust-redox-users-0.5.0
  (crate-source "redox_users" "0.5.0"
                "0awxx66izdw6kz97r3zxrl5ms5f6dqi5l0f58mlsvlmx8wyrsvyx"))

(define rust-ref-cast-1.0.24
  (crate-source "ref-cast" "1.0.24"
                "1kx57g118vs9sqi6d2dcxy6vp8jbx8n5hilmv1sacip9vc8y82ja"))

(define rust-ref-cast-impl-1.0.24
  (crate-source "ref-cast-impl" "1.0.24"
                "1ir7dm7hpqqdgg60hlspsc1ck6wli7wa3xcqrsxz7wdz45f24r8i"))

(define rust-regex-1.11.1
  (crate-source "regex" "1.11.1"
                "148i41mzbx8bmq32hsj1q4karkzzx5m60qza6gdw4pdc9qdyyi5m"))

(define rust-regex-automata-0.4.9
  (crate-source "regex-automata" "0.4.9"
                "02092l8zfh3vkmk47yjc8d631zhhcd49ck2zr133prvd3z38v7l0"))

(define rust-regex-syntax-0.8.5
  (crate-source "regex-syntax" "0.8.5"
                "0p41p3hj9ww7blnbwbj9h7rwxzxg0c1hvrdycgys8rxyhqqw859b"))

(define rust-reqwest-0.12.22
  (crate-source "reqwest" "0.12.22"
                "0cbmfrcrk6wbg93apmji0fln1ca9322af2kc7dpa18vcgs9k3jfb"))

(define rust-rfd-0.15.3
  (crate-source "rfd" "0.15.3"
                "0p87ax7bqk2n8larbrrx0vqvwzkfkfl98igfabiam0nwixs49j40"))

(define rust-ring-0.17.14
  (crate-source "ring" "0.17.14"
                "1dw32gv19ccq4hsx3ribhpdzri1vnrlcfqb2vj41xn4l49n9ws54"))

(define rust-ringbuffer-0.15.0
  (crate-source "ringbuffer" "0.15.0"
                "0lzd15aplym0rb037iv1h67gdssnvmqd2xn06ffgy1gjf67kdxix"))

(define rust-rustc-demangle-0.1.25
  (crate-source "rustc-demangle" "0.1.25"
                "0kxq6m0drr40434ch32j31dkg00iaf4zxmqg7sqxajhcz0wng7lq"))

(define rust-rustc-hash-2.1.1
  (crate-source "rustc-hash" "2.1.1"
                "03gz5lvd9ghcwsal022cgkq67dmimcgdjghfb5yb5d352ga06xrm"))

(define rust-rustc-version-0.4.1
  (crate-source "rustc_version" "0.4.1"
                "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))

(define rust-rustix-1.0.7
  (crate-source "rustix" "1.0.7"
                "0rhjh16bnxi86nrn9qwcnw5632mvd5m1vdy61s4n9zz7mzb867n7"))

(define rust-rustls-0.23.27
  (crate-source "rustls" "0.23.27"
                "08d3nipyhmy4apksjyrb98s9k91wjyg1k7y0flx2671w135482bk"))

(define rust-rustls-native-certs-0.8.1
  (crate-source "rustls-native-certs" "0.8.1"
                "1ls7laa3748mkn23fmi3g4mlwk131lx6chq2lyc8v2mmabfz5kvz"))

(define rust-rustls-pki-types-1.12.0
  (crate-source "rustls-pki-types" "1.12.0"
                "0yawbdpix8jif6s8zj1p2hbyb7y3bj66fhx0y7hyf4qh4964m6i2"))

(define rust-rustls-webpki-0.103.3
  (crate-source "rustls-webpki" "0.103.3"
                "0ddl9qxx94iyichk05r7l30d9dxfd35ybffhsxpsr9pppki2z9z4"))

(define rust-rustversion-1.0.21
  (crate-source "rustversion" "1.0.21"
                "07bb1xx05hhwpnl43sqrhsmxyk5sd5m5baadp19nxp69s9xij3ca"))

(define rust-ryu-1.0.20
  (crate-source "ryu" "1.0.20"
                "07s855l8sb333h6bpn24pka5sp7hjk2w667xy6a0khkf6sqv5lr8"))

(define rust-same-file-1.0.6
  (crate-source "same-file" "1.0.6"
                "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))

(define rust-schannel-0.1.27
  (crate-source "schannel" "0.1.27"
                "0gbbhy28v72kd5iina0z2vcdl3vz63mk5idvkzn5r52z6jmfna8z"))

(define rust-schemars-0.8.22
  (crate-source "schemars" "0.8.22"
                "05an9nbi18ynyxv1rjmwbg6j08j0496hd64mjggh53mwp3hjmgrz"))

(define rust-schemars-0.9.0
  (crate-source "schemars" "0.9.0"
                "0pqncln5hqbzbl2r3yayyr4a82jjf93h2cfxrn0xamvx77wr3lac"))

(define rust-schemars-1.0.4
  (crate-source "schemars" "1.0.4"
                "1l7w773jfk6mz0v8wpahp60aslksjijlbm65ysi4y5mwj520rll2"))

(define rust-schemars-derive-0.8.22
  (crate-source "schemars_derive" "0.8.22"
                "0kakyzrp5801s4i043l4ilv96lzimnlh01pap958h66n99w6bqij"))

(define rust-scopeguard-1.2.0
  (crate-source "scopeguard" "1.2.0"
                "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))

(define rust-security-framework-2.11.1
  (crate-source "security-framework" "2.11.1"
                "00ldclwx78dm61v7wkach9lcx76awlrv0fdgjdwch4dmy12j4yw9"))

(define rust-security-framework-3.2.0
  (crate-source "security-framework" "3.2.0"
                "05mkrddi9i18h9p098d0iimqv1xxz0wd8mbgpbvh9jj67x0205r7"))

(define rust-security-framework-sys-2.14.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "security-framework-sys" "2.14.0"
                "0chwn01qrnvs59i5220bymd38iddy4krbnmfnhf4k451aqfj7ns9"))

(define rust-selectors-0.24.0
  (crate-source "selectors" "0.24.0"
                "05il06smqbhf7p18fawm5fd0pmdkysvmyih455lh17cnh20mfdqc"))

(define rust-semver-1.0.26
  (crate-source "semver" "1.0.26"
                "1l5q2vb8fjkby657kdyfpvv40x2i2xqq9bg57pxqakfj92fgmrjn"))

(define rust-serde-1.0.219
  (crate-source "serde" "1.0.219"
                "1dl6nyxnsi82a197sd752128a4avm6mxnscywas1jq30srp2q3jz"))

(define rust-serde-derive-1.0.219
  (crate-source "serde_derive" "1.0.219"
                "001azhjmj7ya52pmfiw4ppxm16nd44y15j2pf5gkcwrcgz7pc0jv"))

(define rust-serde-derive-internals-0.29.1
  (crate-source "serde_derive_internals" "0.29.1"
                "04g7macx819vbnxhi52cx0nhxi56xlhrybgwybyy7fb9m4h6mlhq"))

(define rust-serde-json-1.0.140
  (crate-source "serde_json" "1.0.140"
                "0wwkp4vc20r87081ihj3vpyz5qf7wqkqipq17v99nv6wjrp8n1i0"))

(define rust-serde-path-to-error-0.1.17
  (crate-source "serde_path_to_error" "0.1.17"
                "0alb447z25dvczd6ll3vfjbf51pypn23mgs5hv8978vzjczv3yjr"))

(define rust-serde-repr-0.1.20
  (crate-source "serde_repr" "0.1.20"
                "1755gss3f6lwvv23pk7fhnjdkjw7609rcgjlr8vjg6791blf6php"))

(define rust-serde-spanned-0.6.9
  (crate-source "serde_spanned" "0.6.9"
                "18vmxq6qfrm110caszxrzibjhy2s54n1g5w1bshxq9kjmz7y0hdz"))

(define rust-serde-untagged-0.1.7
  (crate-source "serde-untagged" "0.1.7"
                "0vp6gvl4a40rzsxdn5js5bn5sqac7rqdbp8an55dnrnlswcrr799"))

(define rust-serde-urlencoded-0.7.1
  (crate-source "serde_urlencoded" "0.7.1"
                "1zgklbdaysj3230xivihs30qi5vkhigg323a9m62k8jwf4a1qjfk"))

(define rust-serde-value-0.7.0
  (crate-source "serde-value" "0.7.0"
                "0b18ngk7n4f9zmwsfdkhgsp31192smzyl5z143qmx1qi28sa78gk"))

(define rust-serde-with-3.14.0
  (crate-source "serde_with" "3.14.0"
                "1manlm83865xwlvgv8frc472x19b75pd89a54mpxpagg3zb5ri7j"))

(define rust-serde-with-macros-3.14.0
  (crate-source "serde_with_macros" "3.14.0"
                "03xk9ghj2s6n331r565mgh22w0749vnq50094nd0vkk5cmg9946y"))

(define rust-serialize-to-javascript-0.1.1
  (crate-source "serialize-to-javascript" "0.1.1"
                "1yyacsd48w7qkfzjn13sba2sf1l2hjpxw7qm521dk0ba7cnkz0n9"))

(define rust-serialize-to-javascript-impl-0.1.1
  (crate-source "serialize-to-javascript-impl" "0.1.1"
                "0qqpky462g47za56cdmzmc8b9rnh09wn5jzkq425z8gnx5s4h1kl"))

(define rust-servo-arc-0.2.0
  (crate-source "servo_arc" "0.2.0"
                "0hgp453zvrj7ry501jhxlcph0hc42gc26zyfwn8ys3yziwps8anm"))

(define rust-sha1-0.10.6
  (crate-source "sha1" "0.10.6"
                "1fnnxlfg08xhkmwf2ahv634as30l1i3xhlhkvxflmasi5nd85gz3"))

(define rust-sha2-0.10.9
  (crate-source "sha2" "0.10.9"
                "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))

(define rust-shlex-1.3.0
  (crate-source "shlex" "1.3.0"
                "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))

(define rust-signal-hook-registry-1.4.5
  (crate-source "signal-hook-registry" "1.4.5"
                "042lkqrpnlrgvrrcirgigxyp1zk70d8v0fsr5w7a18k3bw2vh0wj"))

(define rust-simd-adler32-0.3.7
  (crate-source "simd-adler32" "0.3.7"
                "1zkq40c3iajcnr5936gjp9jjh1lpzhy44p3dq3fiw75iwr1w2vfn"))

(define rust-siphasher-0.3.11
  (crate-source "siphasher" "0.3.11"
                "03axamhmwsrmh0psdw3gf7c0zc4fyl5yjxfifz9qfka6yhkqid9q"))

(define rust-siphasher-1.0.1
  (crate-source "siphasher" "1.0.1"
                "17f35782ma3fn6sh21c027kjmd227xyrx06ffi8gw4xzv9yry6an"))

(define rust-slab-0.4.9
  (crate-source "slab" "0.4.9"
                "0rxvsgir0qw5lkycrqgb1cxsvxzjv9bmx73bk5y42svnzfba94lg"))

(define rust-smallvec-1.15.1
  (crate-source "smallvec" "1.15.1"
                "00xxdxxpgyq5vjnpljvkmy99xij5rxgh913ii1v16kzynnivgcb7"))

(define rust-socket2-0.5.10
  (crate-source "socket2" "0.5.10"
                "0y067ki5q946w91xlz2sb175pnfazizva6fi3kfp639mxnmpc8z2"))

(define rust-softbuffer-0.4.6
  (crate-source "softbuffer" "0.4.6"
                "025v65wsfncn1wp571rr9vj3ghfgnb6y06ai0nnjqy9favfiq18q"))

(define rust-soup3-0.5.0
  (crate-source "soup3" "0.5.0"
                "17sgrkvx5jy6r6pyyhh8cl5mrm96rf0yfl3lqypm24pk815947s7"))

(define rust-soup3-sys-0.5.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "soup3-sys" "0.5.0"
                "09vcp2m0hcddjqsv979d4jnribxp1pvipgjyy4j2z8c0lr88kgky"))

(define rust-specta-2.0.0-rc.20
  (crate-source "specta" "2.0.0-rc.20"
                "1g6943b99cz5xsj3c949va848v6n76qbgv0mpivw2baxaq9b5jsc"))

(define rust-specta-macros-2.0.0-rc.17
  (crate-source "specta-macros" "2.0.0-rc.17"
                "0wlg1f0vqfk5irz1lrhik09i4rd70bn0mxh1aagfnrb9h4lrv6b8"))

(define rust-specta-serde-0.0.7
  (crate-source "specta-serde" "0.0.7"
                "0nifrm9fa30m0qi7iyksibnkl3licwc55cbm0cxficmb46xhq9hj"))

(define rust-specta-typescript-0.0.7
  (crate-source "specta-typescript" "0.0.7"
                "1p4s5j89iw4nqgnfl1mdz4hqxb91v5h3lzj8jmiynp1n54i4gr5i"))

(define rust-stable-deref-trait-1.2.0
  (crate-source "stable_deref_trait" "1.2.0"
                "1lxjr8q2n534b2lhkxd6l6wcddzjvnksi58zv11f9y0jjmr15wd8"))

(define rust-static-assertions-1.1.0
  (crate-source "static_assertions" "1.1.0"
                "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2"))

(define rust-string-cache-0.8.9
  (crate-source "string_cache" "0.8.9"
                "03z7km2kzlwiv2r2qifq5riv4g8phazwng9wnvs3py3lzainnxxz"))

(define rust-string-cache-codegen-0.5.4
  (crate-source "string_cache_codegen" "0.5.4"
                "181ir4d6y053s1kka2idpjx5g9d9jgll6fy517jhzzpi2n3r44f7"))

(define rust-strsim-0.11.1
  (crate-source "strsim" "0.11.1"
                "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))

(define rust-subtle-2.6.1
  (crate-source "subtle" "2.6.1"
                "14ijxaymghbl1p0wql9cib5zlwiina7kall6w7g89csprkgbvhhk"))

(define rust-swift-rs-1.0.7
  (crate-source "swift-rs" "1.0.7"
                "1my4s3w5a5nvlpnzjnfi38snn7spgfn2m0yarzym2bc55s7cjms0"))

(define rust-syn-1.0.109
  (crate-source "syn" "1.0.109"
                "0ds2if4600bd59wsv7jjgfkayfzy3hnazs394kz6zdkmna8l3dkj"))

(define rust-syn-2.0.103
  (crate-source "syn" "2.0.103"
                "1s517h7zk5bwkfq0y08z7cig6cly3wxdmwhjyapxcvwx10q7wc74"))

(define rust-sync-wrapper-1.0.2
  (crate-source "sync_wrapper" "1.0.2"
                "0qvjyasd6w18mjg5xlaq5jgy84jsjfsvmnn12c13gypxbv75dwhb"))

(define rust-synstructure-0.13.2
  (crate-source "synstructure" "0.13.2"
                "1lh9lx3r3jb18f8sbj29am5hm9jymvbwh6jb1izsnnxgvgrp12kj"))

(define rust-sys-locale-0.3.2
  (crate-source "sys-locale" "0.3.2"
                "1i16hq9mkwpzqvixjfy1ph4i2q5klgagjg4hibz6k894l2crmawf"))

(define rust-system-configuration-0.6.1
  (crate-source "system-configuration" "0.6.1"
                "0sxslml567zm0v8g732314vd2gk9sd3k4xj22xk6p64xir29v1rw"))

(define rust-system-configuration-sys-0.6.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "system-configuration-sys" "0.6.0"
                "1i5sqrmgy58l4704hibjbl36hclddglh73fb3wx95jnmrq81n7cf"))

(define rust-system-deps-6.2.2
  (crate-source "system-deps" "6.2.2"
                "0j93ryw031n3h8b0nfpj5xwh3ify636xmv8kxianvlyyipmkbrd3"))

(define rust-tao-0.34.0
  (crate-source "tao" "0.34.0"
                "12pxgyd4i418kh5c99yif5qjw09my146kn4xdixvhcd2fp581hs9"))

(define rust-tao-macros-0.1.3
  (crate-source "tao-macros" "0.1.3"
                "1zbx0ifpn6xi4sc6vp7wq0sbpgrdwr0cm2xbisr7vh9aigmnpqgl"))

(define rust-tar-0.4.44
  (crate-source "tar" "0.4.44"
                "0yk69a8j9xv51mdcy0853jai5zh1pd9yn456q4cpmj0js9w3i1hx"))

(define rust-target-lexicon-0.12.16
  (crate-source "target-lexicon" "0.12.16"
                "1cg3bnx1gdkdr5hac1hzxy64fhw4g7dqkd0n3dxy5lfngpr1mi31"))

(define rust-tauri-2.6.2
  (crate-source "tauri" "2.6.2"
                "03daxylg1r8cvx2902rv2fa01jc6kv44hn9cg7n6pahgkjf14khj"))

(define rust-tauri-build-2.3.0
  (crate-source "tauri-build" "2.3.0"
                "10zczb722phcfmy9qygcqqpyhhiijzd09ixy2hqvibfki71jbw0j"))

(define rust-tauri-codegen-2.3.0
  (crate-source "tauri-codegen" "2.3.0"
                "01p4y3aagync1szw1zbsdkkw3yyhz1gfsrf8bc3438km20x4kpzm"))

(define rust-tauri-macros-2.3.1
  (crate-source "tauri-macros" "2.3.1"
                "1g4vckag5h0al71qj387vdwh6vidga0fl6x2c0m5zyk6b3mgndzj"))

(define rust-tauri-plugin-2.3.0
  (crate-source "tauri-plugin" "2.3.0"
                "1lq1i4xp59ri8xzmvml64s1c3adjnq78pl04lv8hm4zi1g80p6hx"))

(define rust-tauri-plugin-dialog-2.3.0
  (crate-source "tauri-plugin-dialog" "2.3.0"
                "0a4cd7hpl3vfqc876ih30qndvjj729dpnr0j1frsz4ml351b3vqs"))

(define rust-tauri-plugin-fs-2.4.0
  (crate-source "tauri-plugin-fs" "2.4.0"
                "13vp7g8i28nx357phdhmn45hgnzv7p3i5m1iifivq7cr646jjhf3"))

(define rust-tauri-plugin-single-instance-2.3.0
  (crate-source "tauri-plugin-single-instance" "2.3.0"
                "0p92icybr3ppis61y3jq1xfq9v9dc06zwn5kw3zfk551s7avchdl"))

(define rust-tauri-plugin-updater-2.7.1
  (crate-source "tauri-plugin-updater" "2.7.1"
                "02b27hg341cbfnr1w65s8s5bnpxvrpqvd3wfv67lnynpmww5rw3k"))

(define rust-tauri-runtime-2.7.0
  (crate-source "tauri-runtime" "2.7.0"
                "193v76phsw7kii50i0q0nlh3pc9ci8n5nx9z1g10db6f3cyvfywy"))

(define rust-tauri-runtime-wry-2.7.1
  (crate-source "tauri-runtime-wry" "2.7.1"
                "1b8bg17glwkns38mwlm227j0ha6wrh3bzy34xd1g65jy0flmlawh"))

(define rust-tauri-specta-2.0.0-rc.20
  (crate-source "tauri-specta" "2.0.0-rc.20"
                "0598wyyqr45bs9dn12aphi83ddqzpj6ff6c7s34d1sm35xm361jx"))

(define rust-tauri-utils-2.5.0
  (crate-source "tauri-utils" "2.5.0"
                "0bm0ij1bzzbs5j360q96iw3amma61ava1r9ls80a3hwnxfxknx21"))

(define rust-tauri-winres-0.3.1
  (crate-source "tauri-winres" "0.3.1"
                "1d0ks7qjhlrr5k6f439dmhd8c3417rkn439zmcjxi67rqvdj3lz8"))

(define rust-tempfile-3.20.0
  (crate-source "tempfile" "3.20.0"
                "18fnp7mjckd9c9ldlb2zhp1hd4467y2hpvx9l50j97rlhlwlx9p8"))

(define rust-tendril-0.4.3
  (crate-source "tendril" "0.4.3"
                "1c3vip59sqwxn148i714nmkrvjzbk7105vj0h92s6r64bw614jnj"))

(define rust-thiserror-1.0.69
  (crate-source "thiserror" "1.0.69"
                "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))

(define rust-thiserror-2.0.12
  (crate-source "thiserror" "2.0.12"
                "024791nsc0np63g2pq30cjf9acj38z3jwx9apvvi8qsqmqnqlysn"))

(define rust-thiserror-impl-1.0.69
  (crate-source "thiserror-impl" "1.0.69"
                "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))

(define rust-thiserror-impl-2.0.12
  (crate-source "thiserror-impl" "2.0.12"
                "07bsn7shydaidvyyrm7jz29vp78vrxr9cr9044rfmn078lmz8z3z"))

(define rust-thread-local-1.1.9
  (crate-source "thread_local" "1.1.9"
                "1191jvl8d63agnq06pcnarivf63qzgpws5xa33hgc92gjjj4c0pn"))

(define rust-time-0.3.41
  (crate-source "time" "0.3.41"
                "0h0cpiyya8cjlrh00d2r72bmgg4lsdcncs76qpwy0rn2kghijxla"))

(define rust-time-core-0.1.4
  (crate-source "time-core" "0.1.4"
                "0z5h9fknvdvbs2k2s1chpi3ab3jvgkfhdnqwrvixjngm263s7sf9"))

(define rust-time-macros-0.2.22
  (crate-source "time-macros" "0.2.22"
                "0jcaxpw220han2bzbrdlpqhy1s5k9i8ri3lw6n5zv4zcja9p69im"))

(define rust-tinystr-0.8.1
  (crate-source "tinystr" "0.8.1"
                "12sc6h3hnn6x78iycm5v6wrs2xhxph0ydm43yyn7gdfw8l8nsksx"))

(define rust-tinyvec-1.9.0
  (crate-source "tinyvec" "1.9.0"
                "0w9w8qcifns9lzvlbfwa01y0skhr542anwa3rpn28rg82wgndcq9"))

(define rust-tinyvec-macros-0.1.1
  (crate-source "tinyvec_macros" "0.1.1"
                "081gag86208sc3y6sdkshgw3vysm5d34p431dzw0bshz66ncng0z"))

(define rust-tokio-1.46.1
  (crate-source "tokio" "1.46.1"
                "05sxldy7kcgysnxyzz1h1l8j3d9mjyqfh7r48ni27gmg9lsa5hqc"))

(define rust-tokio-macros-2.5.0
  (crate-source "tokio-macros" "2.5.0"
                "1f6az2xbvqp7am417b78d1za8axbvjvxnmkakz9vr8s52czx81kf"))

(define rust-tokio-native-tls-0.3.1
  (crate-source "tokio-native-tls" "0.3.1"
                "1wkfg6zn85zckmv4im7mv20ca6b1vmlib5xwz9p7g19wjfmpdbmv"))

(define rust-tokio-rustls-0.26.2
  (crate-source "tokio-rustls" "0.26.2"
                "16wf007q3584j46wc4s0zc4szj6280g23hka6x6bgs50l4v7nwlf"))

(define rust-tokio-util-0.7.15
  (crate-source "tokio-util" "0.7.15"
                "1pypd9lm1fdnpw0779pqvc16qqrxjy63dgfm20ajhpbdmnlkk9b6"))

(define rust-toml-0.8.23
  (crate-source "toml" "0.8.23"
                "0qnkrq4lm2sdhp3l6cb6f26i8zbnhqb7mhbmksd550wxdfcyn6yw"))

(define rust-toml-datetime-0.6.11
  (crate-source "toml_datetime" "0.6.11"
                "077ix2hb1dcya49hmi1avalwbixmrs75zgzb3b2i7g2gizwdmk92"))

(define rust-toml-edit-0.19.15
  (crate-source "toml_edit" "0.19.15"
                "08bl7rp5g6jwmfpad9s8jpw8wjrciadpnbaswgywpr9hv9qbfnqv"))

(define rust-toml-edit-0.20.7
  (crate-source "toml_edit" "0.20.7"
                "10bdyrl1yj5jxkiqfa2fyx9inlzlm7s8nf1jnysp4k6qwky2gx3h"))

(define rust-toml-edit-0.22.27
  (crate-source "toml_edit" "0.22.27"
                "16l15xm40404asih8vyjvnka9g0xs9i4hfb6ry3ph9g419k8rzj1"))

(define rust-toml-write-0.1.2
  (crate-source "toml_write" "0.1.2"
                "008qlhqlqvljp1gpp9rn5cqs74gwvdgbvs92wnpq8y3jlz4zi6ax"))

(define rust-tower-0.5.2
  (crate-source "tower" "0.5.2"
                "1ybmd59nm4abl9bsvy6rx31m4zvzp5rja2slzpn712y9b68ssffh"))

(define rust-tower-http-0.6.6
  (crate-source "tower-http" "0.6.6"
                "1wh51y4rf03f91c6rvli6nwzsarx7097yx6sqlm75ag27pbjzj5d"))

(define rust-tower-layer-0.3.3
  (crate-source "tower-layer" "0.3.3"
                "03kq92fdzxin51w8iqix06dcfgydyvx7yr6izjq0p626v9n2l70j"))

(define rust-tower-service-0.3.3
  (crate-source "tower-service" "0.3.3"
                "1hzfkvkci33ra94xjx64vv3pp0sq346w06fpkcdwjcid7zhvdycd"))

(define rust-tracing-0.1.41
  (crate-source "tracing" "0.1.41"
                "1l5xrzyjfyayrwhvhldfnwdyligi1mpqm8mzbi2m1d6y6p2hlkkq"))

(define rust-tracing-attributes-0.1.29
  (crate-source "tracing-attributes" "0.1.29"
                "0qpn22v675pbgmrkjsx3abj6lr5s12v4wi77hv9rjsvgkk7zn7qv"))

(define rust-tracing-core-0.1.34
  (crate-source "tracing-core" "0.1.34"
                "0y3nc4mpnr79rzkrcylv5f5bnjjp19lsxwis9l4kzs97ya0jbldr"))

(define rust-trash-5.2.2
  (crate-source "trash" "5.2.2"
                "0wdq8ax8z47cabs7j9hkghli3pyzaxq8z18diw5dd1bd1imnqx12"))

(define rust-tray-icon-0.21.0
  (crate-source "tray-icon" "0.21.0"
                "0sk63kpd93v3w1nn1qxyll9jz5xbvbq1sdhbdqgs4ylmfz35x9rd"))

(define rust-try-lock-0.2.5
  (crate-source "try-lock" "0.2.5"
                "0jqijrrvm1pyq34zn1jmy2vihd4jcrjlvsh4alkjahhssjnsn8g4"))

(define rust-typed-arena-2.0.2
  (crate-source "typed-arena" "2.0.2"
                "0shj0jpmglhgw2f1i4b33ycdzwd1z205pbs1rd5wx7ks2qhaxxka"))

(define rust-typeid-1.0.3
  (crate-source "typeid" "1.0.3"
                "0727ypay2p6mlw72gz3yxkqayzdmjckw46sxqpaj08v0b0r64zdw"))

(define rust-typenum-1.18.0
  (crate-source "typenum" "1.18.0"
                "0gwgz8n91pv40gabrr1lzji0b0hsmg0817njpy397bq7rvizzk0x"))

(define rust-uds-windows-1.1.0
  (crate-source "uds_windows" "1.1.0"
                "1fb4y65pw0rsp0gyfyinjazlzxz1f6zv7j4zmb20l5pxwv1ypnl9"))

(define rust-unic-char-property-0.9.0
  (crate-source "unic-char-property" "0.9.0"
                "08g21dn3wwix3ycfl0vrbahn0835nv2q3swm8wms0vwvgm07mid8"))

(define rust-unic-char-range-0.9.0
  (crate-source "unic-char-range" "0.9.0"
                "1g0z7iwvjhqspi6194zsff8vy6i3921hpqcrp3v1813hbwnh5603"))

(define rust-unic-common-0.9.0
  (crate-source "unic-common" "0.9.0"
                "1g1mm954m0zr497dl4kx3vr09yaly290zs33bbl4wrbaba1gzmw0"))

(define rust-unic-ucd-ident-0.9.0
  (crate-source "unic-ucd-ident" "0.9.0"
                "11v9mfyl9rqnvd9a8hgmbgnzyxd3lcx0dkv7klhskjl10dya6c72"))

(define rust-unic-ucd-version-0.9.0
  (crate-source "unic-ucd-version" "0.9.0"
                "1i5hnzpfnxkp4ijfk8kvhpvj84bij575ybqx1b6hyigy6wi2zgcn"))

(define rust-unicode-ident-1.0.18
  (crate-source "unicode-ident" "1.0.18"
                "04k5r6sijkafzljykdq26mhjpmhdx4jwzvn1lh90g9ax9903jpss"))

(define rust-unicode-properties-0.1.3
  (crate-source "unicode-properties" "0.1.3"
                "1l3mbgzwz8g14xcs09p4ww3hjkjcf0i1ih13nsg72bhj8n5jl3z7"))

(define rust-unicode-segmentation-1.12.0
  (crate-source "unicode-segmentation" "1.12.0"
                "14qla2jfx74yyb9ds3d2mpwpa4l4lzb9z57c6d2ba511458z5k7n"))

(define rust-untrusted-0.9.0
  (crate-source "untrusted" "0.9.0"
                "1ha7ib98vkc538x0z60gfn0fc5whqdd85mb87dvisdcaifi6vjwf"))

(define rust-url-2.5.4
  (crate-source "url" "2.5.4"
                "0q6sgznyy2n4l5lm16zahkisvc9nip9aa5q1pps7656xra3bdy1j"))

(define rust-urlencoding-2.1.3
  (crate-source "urlencoding" "2.1.3"
                "1nj99jp37k47n0hvaz5fvz7z6jd0sb4ppvfy3nphr1zbnyixpy6s"))

(define rust-urlpattern-0.3.0
  (crate-source "urlpattern" "0.3.0"
                "0vds6wyawgap069q34wl0yf8w5qdmpi6r2ffxv10nid1787d7b3h"))

(define rust-utf-8-0.7.6
  (crate-source "utf-8" "0.7.6"
                "1a9ns3fvgird0snjkd3wbdhwd3zdpc2h5gpyybrfr6ra5pkqxk09"))

(define rust-utf8-iter-1.0.4
  (crate-source "utf8_iter" "1.0.4"
                "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))

(define rust-utf8parse-0.2.2
  (crate-source "utf8parse" "0.2.2"
                "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))

(define rust-uuid-1.17.0
  (crate-source "uuid" "1.17.0"
                "07ckq4fdiygy02gmislzfp727hx9zw6lskk9dbcds5ax3sfikx1w"))

(define rust-vcpkg-0.2.15
  (crate-source "vcpkg" "0.2.15"
                "09i4nf5y8lig6xgj3f7fyrvzd3nlaw4znrihw8psidvv5yk4xkdc"))

(define rust-version-check-0.9.5
  (crate-source "version_check" "0.9.5"
                "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))

(define rust-version-compare-0.2.0
  (crate-source "version-compare" "0.2.0"
                "12y9262fhjm1wp0aj3mwhads7kv0jz8h168nn5fb8b43nwf9abl5"))

(define rust-vrc-get-litedb-0.3.0-beta.7
  (crate-source "vrc-get-litedb" "0.3.0-beta.7"
                "1imc934hxr6ryiizxy7hmy1h090m2p0nqzkcfqdj7kkw1hf5sr1b"))

(define rust-vswhom-0.1.0
  (crate-source "vswhom" "0.1.0"
                "12v0fjjzxdc3y5c0lcwycfhphz7zf2s06hl5krwhawah0xzrp5xy"))

(define rust-vswhom-sys-0.1.3
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "vswhom-sys" "0.1.3"
                "0l0i4fijapsybmfckfqh53yqxsg0bm5ikja6vz8ngw0zpm67w1pv"))

(define rust-walkdir-2.5.0
  (crate-source "walkdir" "2.5.0"
                "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))

(define rust-want-0.3.1
  (crate-source "want" "0.3.1"
                "03hbfrnvqqdchb5kgxyavb9jabwza0dmh2vw5kg0dq8rxl57d9xz"))

(define rust-wasi-0.11.1+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.1+wasi-snapshot-preview1"
                "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))

(define rust-wasi-0.14.2+wasi-0.2.4
  (crate-source "wasi" "0.14.2+wasi-0.2.4"
                "1cwcqjr3dgdq8j325awgk8a715h0hg0f7jqzsb077n4qm6jzk0wn"))

(define rust-wasi-0.9.0+wasi-snapshot-preview1
  (crate-source "wasi" "0.9.0+wasi-snapshot-preview1"
                "06g5v3vrdapfzvfq662cij7v8a1flwr2my45nnncdv2galrdzkfc"))

(define rust-wasm-bindgen-0.2.100
  (crate-source "wasm-bindgen" "0.2.100"
                "1x8ymcm6yi3i1rwj78myl1agqv2m86i648myy3lc97s9swlqkp0y"))

(define rust-wasm-bindgen-backend-0.2.100
  (crate-source "wasm-bindgen-backend" "0.2.100"
                "1ihbf1hq3y81c4md9lyh6lcwbx6a5j0fw4fygd423g62lm8hc2ig"))

(define rust-wasm-bindgen-futures-0.4.50
  (crate-source "wasm-bindgen-futures" "0.4.50"
                "0q8ymi6i9r3vxly551dhxcyai7nc491mspj0j1wbafxwq074fpam"))

(define rust-wasm-bindgen-macro-0.2.100
  (crate-source "wasm-bindgen-macro" "0.2.100"
                "01xls2dvzh38yj17jgrbiib1d3nyad7k2yw9s0mpklwys333zrkz"))

(define rust-wasm-bindgen-macro-support-0.2.100
  (crate-source "wasm-bindgen-macro-support" "0.2.100"
                "1plm8dh20jg2id0320pbmrlsv6cazfv6b6907z19ys4z1jj7xs4a"))

(define rust-wasm-bindgen-shared-0.2.100
  (crate-source "wasm-bindgen-shared" "0.2.100"
                "0gffxvqgbh9r9xl36gprkfnh3w9gl8wgia6xrin7v11sjcxxf18s"))

(define rust-wasm-streams-0.4.2
  (crate-source "wasm-streams" "0.4.2"
                "0rddn007hp6k2cm91mm9y33n79b0jxv0c3znzszcvv67hn6ks18m"))

(define rust-web-sys-0.3.77
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "web-sys" "0.3.77"
                "1lnmc1ffbq34qw91nndklqqm75rasaffj2g4f8h1yvqqz4pdvdik"))

(define rust-web-time-1.1.0
  (crate-source "web-time" "1.1.0"
                "1fx05yqx83dhx628wb70fyy10yjfq1jpl20qfqhdkymi13rq0ras"))

(define rust-webkit2gtk-2.0.1
  (crate-source "webkit2gtk" "2.0.1"
                "06inf9qy6hpymyhk9mpj3bxmi8rba4w0p78pkwgdm0f5ahgbrcbn"))

(define rust-webkit2gtk-sys-2.0.1
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "webkit2gtk-sys" "2.0.1"
                "0z6mlrkw5syy0k6k1kikxmygfgwrslq3ssdq2a7iykaizj5a7nk2"))

(define rust-webpki-roots-1.0.0
  (crate-source "webpki-roots" "1.0.0"
                "1nyg365shpxkbazrsvh9c4cv7ar16xnfq62w48xdmwn43j6p6lr8"))

(define rust-webview2-com-0.38.0
  (crate-source "webview2-com" "0.38.0"
                "196ni9kqz3x0a24i2rmpfkcxcg8f50zgnnnxhqwfyxwjk0m65fnl"))

(define rust-webview2-com-macros-0.8.0
  (crate-source "webview2-com-macros" "0.8.0"
                "0cg430mp9a7lrhl533dl2yylaid2dzkbxpcbvrnxbfd3pcaqy8hx"))

(define rust-webview2-com-sys-0.38.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "webview2-com-sys" "0.38.0"
                "0p6psl176lcvm3hyg28bxczbf4mcxppj35i8qksknfmml435js9n"))

(define rust-winapi-0.3.9
  (crate-source "winapi" "0.3.9"
                "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))

(define rust-winapi-i686-pc-windows-gnu-0.4.0
  (crate-source "winapi-i686-pc-windows-gnu" "0.4.0"
                "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))

(define rust-winapi-util-0.1.9
  (crate-source "winapi-util" "0.1.9"
                "1fqhkcl9scd230cnfj8apfficpf5c9vhwnk4yy9xfc1sw69iq8ng"))

(define rust-winapi-x86-64-pc-windows-gnu-0.4.0
  (crate-source "winapi-x86_64-pc-windows-gnu" "0.4.0"
                "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))

(define rust-window-vibrancy-0.6.0
  (crate-source "window-vibrancy" "0.6.0"
                "174srq6qy9a4qiwcq1kk5r1wmab1vp4ykl4g4pr654rz3yiwbgnr"))

(define rust-windows-0.56.0
  (crate-source "windows" "0.56.0"
                "0cp10nzrqgrlk91dpwxjcpzyy6imr5vxr5f898pss7nz3gq9vrhx"))

(define rust-windows-0.60.0
  (crate-source "windows" "0.60.0"
                "0aa5jgm86j0yzfwkygbwwwjs80dzg9173imic8z7g6bs9kkp9y6x"))

(define rust-windows-0.61.3
  (crate-source "windows" "0.61.3"
                "14v8dln7i4ccskd8danzri22bkjkbmgzh284j3vaxhd4cykx7awv"))

(define rust-windows-aarch64-gnullvm-0.42.2
  (crate-source "windows_aarch64_gnullvm" "0.42.2"
                "1y4q0qmvl0lvp7syxvfykafvmwal5hrjb4fmv04bqs0bawc52yjr"))

(define rust-windows-aarch64-gnullvm-0.52.6
  (crate-source "windows_aarch64_gnullvm" "0.52.6"
                "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))

(define rust-windows-aarch64-gnullvm-0.53.0
  (crate-source "windows_aarch64_gnullvm" "0.53.0"
                "0r77pbpbcf8bq4yfwpz2hpq3vns8m0yacpvs2i5cn6fx1pwxbf46"))

(define rust-windows-aarch64-msvc-0.42.2
  (crate-source "windows_aarch64_msvc" "0.42.2"
                "0hsdikjl5sa1fva5qskpwlxzpc5q9l909fpl1w6yy1hglrj8i3p0"))

(define rust-windows-aarch64-msvc-0.52.6
  (crate-source "windows_aarch64_msvc" "0.52.6"
                "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))

(define rust-windows-aarch64-msvc-0.53.0
  (crate-source "windows_aarch64_msvc" "0.53.0"
                "0v766yqw51pzxxwp203yqy39ijgjamp54hhdbsyqq6x1c8gilrf7"))

(define rust-windows-collections-0.1.1
  (crate-source "windows-collections" "0.1.1"
                "1v2dq9dy2lm8v5c98hn3diixprxqb6sdnhgdnbmm4gxsq6fgfrsl"))

(define rust-windows-collections-0.2.0
  (crate-source "windows-collections" "0.2.0"
                "1s65anr609qvsjga7w971p6iq964h87670dkfqfypnfgwnswxviv"))

(define rust-windows-core-0.56.0
  (crate-source "windows-core" "0.56.0"
                "19pj57bm0rzhlk0ghrccd3i5zvh0ghm52f8cmdc8d3yhs8pfb626"))

(define rust-windows-core-0.60.1
  (crate-source "windows-core" "0.60.1"
                "0iv25wamzs29cy9mfvbfvw6i0dq8rs6kdy2wmv6g96xfkhmaj8fa"))

(define rust-windows-core-0.61.2
  (crate-source "windows-core" "0.61.2"
                "1qsa3iw14wk4ngfl7ipcvdf9xyq456ms7cx2i9iwf406p7fx7zf0"))

(define rust-windows-future-0.1.1
  (crate-source "windows-future" "0.1.1"
                "1w296g00054hzqpjy1xb8gixhqqkzfmqpkklkciq1sz7jm2xp1x7"))

(define rust-windows-future-0.2.1
  (crate-source "windows-future" "0.2.1"
                "13mdzcdn51ckpzp3frb8glnmkyjr1c30ym9wnzj9zc97hkll2spw"))

(define rust-windows-i686-gnu-0.42.2
  (crate-source "windows_i686_gnu" "0.42.2"
                "0kx866dfrby88lqs9v1vgmrkk1z6af9lhaghh5maj7d4imyr47f6"))

(define rust-windows-i686-gnu-0.52.6
  (crate-source "windows_i686_gnu" "0.52.6"
                "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))

(define rust-windows-i686-gnu-0.53.0
  (crate-source "windows_i686_gnu" "0.53.0"
                "1hvjc8nv95sx5vdd79fivn8bpm7i517dqyf4yvsqgwrmkmjngp61"))

(define rust-windows-i686-gnullvm-0.52.6
  (crate-source "windows_i686_gnullvm" "0.52.6"
                "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))

(define rust-windows-i686-gnullvm-0.53.0
  (crate-source "windows_i686_gnullvm" "0.53.0"
                "04df1in2k91qyf1wzizvh560bvyzq20yf68k8xa66vdzxnywrrlw"))

(define rust-windows-i686-msvc-0.42.2
  (crate-source "windows_i686_msvc" "0.42.2"
                "0q0h9m2aq1pygc199pa5jgc952qhcnf0zn688454i7v4xjv41n24"))

(define rust-windows-i686-msvc-0.52.6
  (crate-source "windows_i686_msvc" "0.52.6"
                "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))

(define rust-windows-i686-msvc-0.53.0
  (crate-source "windows_i686_msvc" "0.53.0"
                "0pcvb25fkvqnp91z25qr5x61wyya12lx8p7nsa137cbb82ayw7sq"))

(define rust-windows-implement-0.56.0
  (crate-source "windows-implement" "0.56.0"
                "16rgkvlx4syqmajfdwmkcvn6nvh126wjj8sg3jvsk5fdivskbz7n"))

(define rust-windows-implement-0.59.0
  (crate-source "windows-implement" "0.59.0"
                "1ha89vc4v4vabwdjkz46hdsnl2jp7ckpzw88qdca0j9g3q2pnmw3"))

(define rust-windows-implement-0.60.0
  (crate-source "windows-implement" "0.60.0"
                "0dm88k3hlaax85xkls4gf597ar4z8m5vzjjagzk910ph7b8xszx4"))

(define rust-windows-interface-0.56.0
  (crate-source "windows-interface" "0.56.0"
                "1k2prfxna0mw47f8gi8qhw9jfpw66bh2cqzs67sgipjfpx30b688"))

(define rust-windows-interface-0.59.1
  (crate-source "windows-interface" "0.59.1"
                "1a4zr8740gyzzhq02xgl6vx8l669jwfby57xgf0zmkcdkyv134mx"))

(define rust-windows-link-0.1.3
  (crate-source "windows-link" "0.1.3"
                "12kr1p46dbhpijr4zbwr2spfgq8i8c5x55mvvfmyl96m01cx4sjy"))

(define rust-windows-numerics-0.1.1
  (crate-source "windows-numerics" "0.1.1"
                "1vgfh8qh0i4ggj32339d99rvbwrw7dq8z6r7xqn9yjgnw9aflp80"))

(define rust-windows-numerics-0.2.0
  (crate-source "windows-numerics" "0.2.0"
                "1cf2j8nbqf0hqqa7chnyid91wxsl2m131kn0vl3mqk3c0rlayl4i"))

(define rust-windows-registry-0.5.2
  (crate-source "windows-registry" "0.5.2"
                "0848hyj0irwljppy5j9lkphrx9m8isx8m6xr1cja20ykpn9v1fmk"))

(define rust-windows-result-0.1.2
  (crate-source "windows-result" "0.1.2"
                "1y274q1v0vy21lhkgslpxpq1m08hvr1mcs2l88h1b1gcx0136f2y"))

(define rust-windows-result-0.3.4
  (crate-source "windows-result" "0.3.4"
                "1il60l6idrc6hqsij0cal0mgva6n3w6gq4ziban8wv6c6b9jpx2n"))

(define rust-windows-strings-0.3.1
  (crate-source "windows-strings" "0.3.1"
                "06bkhkyclbfchcsv5bnhz77r290k20m15glj2xq60ra0bp64iyl7"))

(define rust-windows-strings-0.4.2
  (crate-source "windows-strings" "0.4.2"
                "0mrv3plibkla4v5kaakc2rfksdd0b14plcmidhbkcfqc78zwkrjn"))

(define rust-windows-sys-0.45.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.45.0"
                "1l36bcqm4g89pknfp8r9rl1w4bn017q6a8qlx8viv0xjxzjkna3m"))

(define rust-windows-sys-0.52.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.52.0"
                "0gd3v4ji88490zgb6b5mq5zgbvwv7zx1ibn8v3x83rwcdbryaar8"))

(define rust-windows-sys-0.59.0
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.59.0"
                "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))

(define rust-windows-sys-0.60.2
  ;; TODO REVIEW: Check bundled sources.
  (crate-source "windows-sys" "0.60.2"
                "1jrbc615ihqnhjhxplr2kw7rasrskv9wj3lr80hgfd42sbj01xgj"))

(define rust-windows-targets-0.42.2
  (crate-source "windows-targets" "0.42.2"
                "0wfhnib2fisxlx8c507dbmh97kgij4r6kcxdi0f9nk6l1k080lcf"))

(define rust-windows-targets-0.52.6
  (crate-source "windows-targets" "0.52.6"
                "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))

(define rust-windows-targets-0.53.2
  (crate-source "windows-targets" "0.53.2"
                "1vwanhx2br7dh8mmrszdbcf01bccjr01mcyxcscxl4ffr7y6jvy6"))

(define rust-windows-threading-0.1.0
  (crate-source "windows-threading" "0.1.0"
                "19jpn37zpjj2q7pn07dpq0ay300w65qx7wdp13wbp8qf5snn6r5n"))

(define rust-windows-version-0.1.4
  (crate-source "windows-version" "0.1.4"
                "0p16g570yvgxiqyh0bgbck4n1wkxdhl8711ms8xa44734xk5qjp0"))

(define rust-windows-x86-64-gnu-0.42.2
  (crate-source "windows_x86_64_gnu" "0.42.2"
                "0dnbf2xnp3xrvy8v9mgs3var4zq9v9yh9kv79035rdgyp2w15scd"))

(define rust-windows-x86-64-gnu-0.52.6
  (crate-source "windows_x86_64_gnu" "0.52.6"
                "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))

(define rust-windows-x86-64-gnu-0.53.0
  (crate-source "windows_x86_64_gnu" "0.53.0"
                "1flh84xkssn1n6m1riddipydcksp2pdl45vdf70jygx3ksnbam9f"))

(define rust-windows-x86-64-gnullvm-0.42.2
  (crate-source "windows_x86_64_gnullvm" "0.42.2"
                "18wl9r8qbsl475j39zvawlidp1bsbinliwfymr43fibdld31pm16"))

(define rust-windows-x86-64-gnullvm-0.52.6
  (crate-source "windows_x86_64_gnullvm" "0.52.6"
                "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))

(define rust-windows-x86-64-gnullvm-0.53.0
  (crate-source "windows_x86_64_gnullvm" "0.53.0"
                "0mvc8119xpbi3q2m6mrjcdzl6afx4wffacp13v76g4jrs1fh6vha"))

(define rust-windows-x86-64-msvc-0.42.2
  (crate-source "windows_x86_64_msvc" "0.42.2"
                "1w5r0q0yzx827d10dpjza2ww0j8iajqhmb54s735hhaj66imvv4s"))

(define rust-windows-x86-64-msvc-0.52.6
  (crate-source "windows_x86_64_msvc" "0.52.6"
                "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))

(define rust-windows-x86-64-msvc-0.53.0
  (crate-source "windows_x86_64_msvc" "0.53.0"
                "11h4i28hq0zlnjcaqi2xdxr7ibnpa8djfggch9rki1zzb8qi8517"))

(define rust-winnow-0.5.40
  (crate-source "winnow" "0.5.40"
                "0xk8maai7gyxda673mmw3pj1hdizy5fpi7287vaywykkk19sk4zm"))

(define rust-winnow-0.7.11
  (crate-source "winnow" "0.7.11"
                "1kfb2m5ahpqg037a34rgkm18x6nj2mw4fwn89ya0gdw06ipb5ivl"))

(define rust-winreg-0.55.0
  (crate-source "winreg" "0.55.0"
                "15xy060vylrsp91bc0ximx3xziwipzlrn1n2ab19w3n56x9pcnnb"))

(define rust-wit-bindgen-rt-0.39.0
  (crate-source "wit-bindgen-rt" "0.39.0"
                "1hd65pa5hp0nl664m94bg554h4zlhrzmkjsf6lsgsb7yc4734hkg"))

(define rust-wmi-0.17.2
  (crate-source "wmi" "0.17.2"
                "0byfph3pyv2mi83w1drbvixa6ijbrrw8xlfmc73cvjz4vivyfg9x"))

(define rust-writeable-0.6.1
  (crate-source "writeable" "0.6.1"
                "1fx29zncvbrqzgz7li88vzdm8zvgwgwy2r9bnjqxya09pfwi0bza"))

(define rust-wry-0.52.1
  (crate-source "wry" "0.52.1"
                "1f8il666kq8dqslad6abfy2dbqq9c6fj4l3f9bhalxbhpbci99qj"))

(define rust-x11-2.21.0
  (crate-source "x11" "2.21.0"
                "0bnvl09d7044k067gqdx1ln2r0ljp5f4675icwb0216d9i3aabah"))

(define rust-x11-dl-2.21.0
  (crate-source "x11-dl" "2.21.0"
                "0vsiq62xpcfm0kn9zjw5c9iycvccxl22jya8wnk18lyxzqj5jwrq"))

(define rust-xattr-1.5.0
  (crate-source "xattr" "1.5.0"
                "17nq2c23zcjciz8sxwhisqjkv4l7zcylx3yl2915c59cy7rcnr8d"))

(define rust-yoke-0.8.0
  (crate-source "yoke" "0.8.0"
                "1k4mfr48vgi7wh066y11b7v1ilakghlnlhw9snzz8vi2p00vnhaz"))

(define rust-yoke-derive-0.8.0
  (crate-source "yoke-derive" "0.8.0"
                "1dha5jrjz9jaq8kmxq1aag86b98zbnm9lyjrihy5sv716sbkrniq"))

(define rust-zbus-5.7.1
  (crate-source "zbus" "5.7.1"
                "0s3gvx605m4cf73ppfknrbj7j33mrf1ag3zllgy49l0kwg7cg9yk"))

(define rust-zbus-macros-5.7.1
  (crate-source "zbus_macros" "5.7.1"
                "0sinpb3vs672qhwmzagnl0xq30ws3bw8s18swx3zfl0mxig7wzm1"))

(define rust-zbus-names-4.2.0
  (crate-source "zbus_names" "4.2.0"
                "15ybdd6zic7simi9wjg0ywrxfq4sxg3z0wiyysadps3cpxj8xrkv"))

(define rust-zerocopy-0.8.25
  (crate-source "zerocopy" "0.8.25"
                "1jx07cd3b3456c9al9zjqqdzpf1abb0vf6z0fj8xnb93hfajsw51"))

(define rust-zerocopy-derive-0.8.25
  (crate-source "zerocopy-derive" "0.8.25"
                "1vsmpq0hp61xpqj9yk8b5jihkqkff05q1wv3l2568mhifl6y59i8"))

(define rust-zerofrom-0.1.6
  (crate-source "zerofrom" "0.1.6"
                "19dyky67zkjichsb7ykhv0aqws3q0jfvzww76l66c19y6gh45k2h"))

(define rust-zerofrom-derive-0.1.6
  (crate-source "zerofrom-derive" "0.1.6"
                "00l5niw7c1b0lf1vhvajpjmcnbdp2vn96jg4nmkhq2db0rp5s7np"))

(define rust-zeroize-1.8.1
  (crate-source "zeroize" "1.8.1"
                "1pjdrmjwmszpxfd7r860jx54cyk94qk59x13sc307cvr5256glyf"))

(define rust-zerotrie-0.2.2
  (crate-source "zerotrie" "0.2.2"
                "15gmka7vw5k0d24s0vxgymr2j6zn2iwl12wpmpnpjgsqg3abpw1n"))

(define rust-zerovec-0.11.2
  (crate-source "zerovec" "0.11.2"
                "0a2457fmz39k9vrrj3rm82q5ykdhgxgbwfz2r6fa6nq11q4fn1aa"))

(define rust-zerovec-derive-0.11.1
  (crate-source "zerovec-derive" "0.11.1"
                "13zms8hj7vzpfswypwggyfr4ckmyc7v3di49pmj8r1qcz9z275jv"))

(define rust-zip-2.4.2
  (crate-source "zip" "2.4.2"
                "0l5s7sycj0w42hnkmj6vnrzcp3dn4smffg06a8f5my08x4j67gps"))

(define rust-zvariant-5.5.3
  (crate-source "zvariant" "5.5.3"
                "1cgzkngj9nsmz5ql9fxiqm98s0sc9l3zkr0xl9iyx4z3fmpphc4x"))

(define rust-zvariant-derive-5.5.3
  (crate-source "zvariant_derive" "5.5.3"
                "104m9pp4821mz2q6rgqnjq79q89j0iiv25w1sk63bms2rl1agzbm"))

(define rust-zvariant-utils-3.2.0
  (crate-source "zvariant_utils" "3.2.0"
                "0d7wllndiv7vwgapmji3q9sxmzbaqfdxjwkqnx9vbmz58gpdyvp1"))

(define rust-adler2-2.0.0
  (crate-source "adler2" "2.0.0"
                "09r6drylvgy8vv8k20lnbvwq8gp09h7smfn6h1rxsy15pgh629si"))

(define rust-anstream-0.6.17
  (crate-source "anstream" "0.6.17"
                "0f0k3g8hl8k8cd8f3rq6yj04415jhd3k3kz1mwnki1jx1wzyb893"))

(define rust-anstyle-1.0.9
  (crate-source "anstyle" "1.0.9"
                "0mlc5jmbrgikk700m1sjwgil019rm4mhkq5gzks5y0vcn59dwrc3"))

(define rust-anstyle-parse-0.2.6
  (crate-source "anstyle-parse" "0.2.6"
                "1acqayy22fwzsrvr6n0lz6a4zvjjcvgr5sm941m7m0b2fr81cb9v"))

(define rust-anstyle-query-1.1.2
  (crate-source "anstyle-query" "1.1.2"
                "036nm3lkyk43xbps1yql3583fp4hg3b1600is7mcyxs1gzrpm53r"))

(define rust-anstyle-wincon-3.0.6
  (crate-source "anstyle-wincon" "3.0.6"
                "099ir0w3lbpsp1nxdzbf4anq98ww8ykyc9pd1g03xgkj1v7dn291"))

(define rust-anyhow-1.0.91
  (crate-source "anyhow" "1.0.91"
                "1j2hg3d0lk2pihfsknxrncmijhz07fspkzd5c0vxhzyp7s7i0hn0"))

(define rust-arboard-3.4.1
  (crate-source "arboard" "3.4.1"
                "1x2p8dfhzm3w0cpw81ab2rbyzvkzqs9g66xcakq4y0fd2v5rq2fz"))

(define rust-arraydeque-0.5.1
  (crate-source "arraydeque" "0.5.1"
                "0dn2xdfg3rkiqsh8a6achnmvf5nf11xk33xgjzpksliab4yjx43x"))

(define rust-atomic-polyfill-1.0.3
  (crate-source "atomic-polyfill" "1.0.3"
                "1x00ndablb89zvbr8m03cgjzgajg86fqn8pgz85yy2gy1pivrwlc"))

(define rust-backtrace-0.3.74
  (crate-source "backtrace" "0.3.74"
                "06pfif7nwx66qf2zaanc2fcq7m64i91ki9imw9xd3bnz5hrwp0ld"))

(define rust-backtrace-ext-0.2.1
  (crate-source "backtrace-ext" "0.2.1"
                "0l4xacjnx4jrn9k14xbs2swks018mviq03sp7c1gn62apviywysk"))

(define rust-bitvec-1.0.1
  (crate-source "bitvec" "1.0.1"
                "173ydyj2q5vwj88k6xgjnfsshs4x9wbvjjv7sm0h36r34hn87hhv"))

(define rust-bumpalo-3.19.0
  (crate-source "bumpalo" "3.19.0"
                "0hsdndvcpqbjb85ghrhska2qxvp9i75q2vb70hma9fxqawdy9ia6"))

(define rust-bytemuck-1.19.0
  (crate-source "bytemuck" "1.19.0"
                "0ka96agz9kqmsd71q7xpr08bnh2g8x4hivxqpnks0674h5dj2d43"))

(define rust-byteorder-lite-0.1.0
  (crate-source "byteorder-lite" "0.1.0"
                "15alafmz4b9az56z6x7glcbcb6a8bfgyd109qc3bvx07zx4fj7wg"))

(define rust-cc-1.1.31
  (crate-source "cc" "1.1.31"
                "0vscf59yxf665s4fv9yn3l39gfw99mgp6wnbc76cyv80ahmrdry2"))

(define rust-cfg-if-1.0.0
  (crate-source "cfg-if" "1.0.0"
                "1za0vb97n4brpzpv8lsbnzmq5r8f2b0cpqqr0sy8h5bn751xxwds"))

(define rust-clap-4.5.20
  (crate-source "clap" "4.5.20"
                "1s37v23gcxkjy4800qgnkxkpliz68vslpr5sgn1xar56hmnkfzxr"))

(define rust-clap-builder-4.5.20
  (crate-source "clap_builder" "4.5.20"
                "0m6w10l2f65h3ch0d53lql6p26xxrh20ffipra9ysjsfsjmq1g0r"))

(define rust-clap-derive-4.5.18
  (crate-source "clap_derive" "4.5.18"
                "1ardb26bvcpg72q9myr7yir3a8c83gx7vxk1cccabsd9n73s1ija"))

(define rust-clap-lex-0.7.2
  (crate-source "clap_lex" "0.7.2"
                "15zcrc2fa6ycdzaihxghf48180bnvzsivhf0fmah24bnnaf76qhl"))

(define rust-clipboard-win-5.4.0
  (crate-source "clipboard-win" "5.4.0"
                "14n87fc0vzbd0wdhqzvcs1lqgafsncplzcanhpik93xhhalfgvqm"))

(define rust-colorchoice-1.0.3
  (crate-source "colorchoice" "1.0.3"
                "1439m3r3jy3xqck8aa13q658visn71ki76qa93cy55wkmalwlqsv"))

(define rust-console-error-panic-hook-0.1.7
  (crate-source "console_error_panic_hook" "0.1.7"
                "1g5v8s0ndycc10mdn6igy914k645pgpcl8vjpz6nvxkhyirynsm0"))

(define rust-core-foundation-0.10.0
  (crate-source "core-foundation" "0.10.0"
                "0qscay14s2rwkg8nd8ljhiaf149hj8sfy95d70zssy64r3jp2lmm"))

(define rust-core-graphics-0.23.2
  (crate-source "core-graphics" "0.23.2"
                "10dhv3gk4kmbzl14xxkrhhky4fdp8h6nzff6h0019qgr6nz84xy0"))

(define rust-core-graphics-types-0.1.3
  (crate-source "core-graphics-types" "0.1.3"
                "1bxg8nxc8fk4kxnqyanhf36wq0zrjr552c58qy6733zn2ihhwfa5"))

(define rust-critical-section-1.2.0
  (crate-source "critical-section" "1.2.0"
                "02ylhcykxjc40xrfhk1lwc21jqgz4dbwv3jr49ymw733c51yl3kr"))

(define rust-deranged-0.5.5
  (crate-source "deranged" "0.5.5"
                "11z5939gv2klp1r1lgrp4w5fnlkj18jqqf0h9zxmia3vkrjwpv7c"))

(define rust-dirs-5.0.1
  (crate-source "dirs" "5.0.1"
                "0992xk5vx75b2x91nw9ssb51mpl8x73j9rxmpi96cryn0ffmmi24"))

(define rust-dirs-sys-0.4.1
  (crate-source "dirs-sys" "0.4.1"
                "071jy0pvaad9lsa6mzawxrh7cmr7hsmsdxwzm7jzldfkrfjha3sj"))

(define rust-either-1.13.0
  (crate-source "either" "1.13.0"
                "1w2c1mybrd7vljyxk77y9f4w9dyjrmp3yp82mk7bcm8848fazcb0"))

(define rust-embed-resource-2.5.0
  (crate-source "embed-resource" "2.5.0"
                "1ymzvcrgxn3zrmdzsr2szmy26zgyyrbia80cnppz0wdysx941qpl"))

(define rust-encode-unicode-0.3.6
  (crate-source "encode_unicode" "0.3.6"
                "07w3vzrhxh9lpjgsg2y5bwzfar2aq35mdznvcp3zjl0ssj7d4mx3"))

(define rust-endian-type-0.1.2
  (crate-source "endian-type" "0.1.2"
                "0bbh88zaig1jfqrm7w3gx0pz81kw2jakk3055vbgapw3dmk08ky3"))

(define rust-equivalent-1.0.1
  (crate-source "equivalent" "1.0.1"
                "1malmx5f4lkfvqasz319lq6gb3ddg19yzf9s8cykfsgzdmyq0hsl"))

(define rust-errno-0.3.10
  (crate-source "errno" "0.3.10"
                "0pgblicz1kjz9wa9m0sghkhh2zw1fhq1mxzj7ndjm746kg5m5n1k"))

(define rust-error-code-3.3.1
  (crate-source "error-code" "3.3.1"
                "0bx9hw3pahzqym8jvb0ln4qsabnysgn98mikyh2afhk9rif31nd5"))

(define rust-evdev-0.13.1
  (crate-source "evdev" "0.13.1"
                "1y5q8xdf8ppgcgnkbwjnnqkm4zycimp09mn2nfcp66mbmrjhihd3"))

(define rust-flate2-1.0.35
  (crate-source "flate2" "1.0.35"
                "0z6h0wa095wncpfngx75wyhyjnqwld7wax401gsvnzjhzgdbydn9"))

(define rust-funty-2.0.0
  (crate-source "funty" "2.0.0"
                "177w048bm0046qlzvp33ag3ghqkqw4ncpzcm5lq36gxf2lla7mg6"))

(define rust-gethostname-0.4.3
  (crate-source "gethostname" "0.4.3"
                "063qqhznyckwx9n4z4xrmdv10s0fi6kbr17r6bi1yjifki2y0xh1"))

(define rust-getrandom-0.2.15
  (crate-source "getrandom" "0.2.15"
                "1mzlnrb3dgyd1fb84gvw10pyr8wdqdl4ry4sr64i1s8an66pqmn4"))

(define rust-hash32-0.2.1
  (crate-source "hash32" "0.2.1"
                "0rrbv5pc5b1vax6j6hk7zvlrpw0h6aybshxy9vbpgsrgfrc5zhxh"))

(define rust-hashbrown-0.15.0
  (crate-source "hashbrown" "0.15.0"
                "1yx4xq091s7i6mw6bn77k8cp4jrpcac149xr32rg8szqsj27y20y"))

(define rust-heapless-0.7.17
  (crate-source "heapless" "0.7.17"
                "0kwn2wzk9fnsqnwp6rqjqhvh6hfq4rh225xwqjm72b5n1ry4bind"))

(define rust-hermit-abi-0.4.0
  (crate-source "hermit-abi" "0.4.0"
                "1k1zwllx6nfq417hy38x4akw1ivlv68ymvnzyxs76ffgsqcskxpv"))

(define rust-image-0.25.5
  (crate-source "image" "0.25.5"
                "0fsnfgg8hr66ag5nxipvb7d50kbg40qfpbsql59qkwa2ssp48vyd"))

(define rust-indexmap-2.6.0
  (crate-source "indexmap" "2.6.0"
                "1nmrwn8lbs19gkvhxaawffzbvrpyrb5y3drcrr645x957kz0fybh"))

(define rust-indoc-2.0.5
  (crate-source "indoc" "2.0.5"
                "1dgjk49rkmx4kjy07k4b90qb5vl89smgb5rcw02n0q0x9ligaj5j"))

(define rust-inotify-0.10.2
  (crate-source "inotify" "0.10.2"
                "1k2m6a95827yspax1icmwiz4szr7c01w3dnn2b2bil4hfvcnilgx"))

(define rust-inotify-sys-0.1.5
  (crate-source "inotify-sys" "0.1.5"
                "1syhjgvkram88my04kv03s0zwa66mdwa5v7ddja3pzwvx2sh4p70"))

(define rust-interception-sys-0.1.3
  (crate-source "interception-sys" "0.1.3"
                "1lgwbml7gzq5a5rriy708w68gx6yiw9cdg7xy2c5vsrrck7pbs5b"))

(define rust-is-ci-1.2.0
  (crate-source "is_ci" "1.2.0"
                "0ifwvxmrsj4r29agfzr71bjq6y1bihkx38fbzafq5vl0jn1wjmbn"))

(define rust-is-terminal-0.4.13
  (crate-source "is-terminal" "0.4.13"
                "0jwgjjz33kkmnwai3nsdk1pz9vb6gkqvw1d1vq7bs3q48kinh7r6"))

(define rust-itertools-0.12.1
  (crate-source "itertools" "0.12.1"
                "0s95jbb3ndj1lvfxyq5wanc0fm0r6hg6q4ngb92qlfdxvci10ads"))

(define rust-itoa-1.0.11
  (crate-source "itoa" "1.0.11"
                "0nv9cqjwzr3q58qz84dcz63ggc54yhf1yqar1m858m1kfd4g3wa9"))

(define rust-jobserver-0.1.32
  (crate-source "jobserver" "0.1.32"
                "1l2k50qmj84x9mn39ivjz76alqmx72jhm12rw33zx9xnpv5xpla8"))

(define rust-jpeg-decoder-0.3.1
  (crate-source "jpeg-decoder" "0.3.1"
                "1c1k53svpdyfhibkmm0ir5w0v3qmcmca8xr8vnnmizwf6pdagm7m"))

(define rust-kanata-interception-0.3.0
  (crate-source "kanata-interception" "0.3.0"
                "01mn1dskhm124x0nxfcw5cyb07h0i256x9bfj23aq6adjsdpprg2"))

(define rust-kanata-keyberon-macros-0.2.0
  (crate-source "kanata-keyberon-macros" "0.2.0"
                "0lj7ldiazmszh0k01h7mjzhjg59bdakvx2pnpc9mq2ir0czzixkk"))

(define rust-karabiner-driverkit-0.2.0
  (crate-source "karabiner-driverkit" "0.2.0"
                "0zpfv26m6jlh1516qvpw1qpwmirbfcp908frl1qlfr35pqz9aj3k"))

(define rust-libc-0.2.161
  (crate-source "libc" "0.2.161"
                "1lc5s3zd0491x9zxrv2kvclai1my1spz950pkkyry4vwh318k54f"))

(define rust-linux-raw-sys-0.4.15
  (crate-source "linux-raw-sys" "0.4.15"
                "1aq7r2g7786hyxhv40spzf2nhag5xbw2axxc1k8z5k1dsgdm4v6j"))

(define rust-lock-api-0.4.12
  (crate-source "lock_api" "0.4.12"
                "05qvxa6g27yyva25a5ghsg85apdxkvr77yhkyhapj6r8vnf8pbq7"))

(define rust-log-0.4.22
  (crate-source "log" "0.4.22"
                "093vs0wkm1rgyykk7fjbqp2lwizbixac1w52gv109p5r4jh0p9x7"))

(define rust-malloc-buf-0.0.6
  (crate-source "malloc_buf" "0.0.6"
                "1jqr77j89pwszv51fmnknzvd53i1nkmcr8rjrvcxhm4dx1zr1fv2"))

(define rust-memchr-2.7.4
  (crate-source "memchr" "2.7.4"
                "18z32bhxrax0fnjikv475z7ii718hq457qwmaryixfxsl2qrmjkq"))

(define rust-memoffset-0.7.1
  (crate-source "memoffset" "0.7.1"
                "1x2zv8hv9c9bvgmhsjvr9bymqwyxvgbca12cm8xkhpyy5k1r7s2x"))

(define rust-miette-5.10.0
  (crate-source "miette" "5.10.0"
                "0vl5qvl3bgha6nnkdl7kiha6v4ypd6d51wyc4q1bvdpamr75ifsr"))

(define rust-miette-derive-5.10.0
  (crate-source "miette-derive" "5.10.0"
                "0p33msrngkxlp5ajm8nijamii9vcwwpy8gfh4m53qnmrc0avrrs9"))

(define rust-miniz-oxide-0.8.0
  (crate-source "miniz_oxide" "0.8.0"
                "1wadxkg6a6z4lr7kskapj5d8pxlx7cp1ifw4daqnkzqjxych5n72"))

(define rust-mio-0.8.11
  (crate-source "mio" "0.8.11"
                "034byyl0ardml5yliy1hmvx8arkmn9rv479pid794sm07ia519m4"))

(define rust-muldiv-0.2.1
  (crate-source "muldiv" "0.2.1"
                "014jlry2l2ph56mp8knw65637hh49q7fmrraim2bx9vz0a638684"))

(define rust-muldiv-1.0.1
  (crate-source "muldiv" "1.0.1"
                "1c6ljsp41n8ijsx7zicwfm135drgyhcms12668ivvsbm1r98frwm"))

(define rust-native-windows-gui-1.0.13
  (crate-source "native-windows-gui" "1.0.13"
                "0m44lbslzvs04i4rgcphld23qlwf9zzlzmspgimyp3gnd6k06w2g"))

(define rust-nibble-vec-0.1.0
  (crate-source "nibble_vec" "0.1.0"
                "0hsdp3s724s30hkqz74ky6sqnadhp2xwcj1n1hzy4vzkz4yxi9bp"))

(define rust-nix-0.26.4
  (crate-source "nix" "0.26.4"
                "06xgl4ybb8pvjrbmc3xggbgk3kbs1j0c4c0nzdfrmpbgrkrym2sr"))

(define rust-nix-0.29.0
  (crate-source "nix" "0.29.0"
                "0ikvn7s9r2lrfdm3mx1h7nbfjvcc6s9vxdzw7j5xfkd2qdnp9qki"))

(define rust-num-conv-0.2.0
  (crate-source "num-conv" "0.2.0"
                "0l4hj7lp8zbb9am4j3p7vlcv47y9bbazinvnxx9zjhiwkibyr5yg"))

(define rust-num-enum-0.6.1
  (crate-source "num_enum" "0.6.1"
                "18bna04g6zq978z2b4ygz0f8pbva37id4xnpgwh8l41w1m1mn0bs"))

(define rust-num-enum-derive-0.6.1
  (crate-source "num_enum_derive" "0.6.1"
                "19k57c0wg56vzzj2w77jsi8nls1b8xh8pvpzjnrgf8d9cnvpsrln"))

(define rust-num-threads-0.1.7
  (crate-source "num_threads" "0.1.7"
                "1ngajbmhrgyhzrlc4d5ga9ych1vrfcvfsiqz6zv0h2dpr2wrhwsw"))

(define rust-objc-0.2.7
  (crate-source "objc" "0.2.7"
                "1cbpf6kz8a244nn1qzl3xyhmp05gsg4n313c9m3567625d3innwi"))

(define rust-objc2-app-kit-0.2.2
  (crate-source "objc2-app-kit" "0.2.2"
                "1zqyi5l1bm26j1bgmac9783ah36m5kcrxlqp5carglnpwgcrms74"))

(define rust-objc2-core-data-0.2.2
  (crate-source "objc2-core-data" "0.2.2"
                "1vvk8zjylfjjj04dzawydmqqz5ajvdkhf22cnb07ihbiw14vyzv1"))

(define rust-objc2-core-image-0.2.2
  (crate-source "objc2-core-image" "0.2.2"
                "102csfb82zi2sbzliwsfd589ckz0gysf7y6434c9zj97lmihj9jm"))

(define rust-object-0.36.5
  (crate-source "object" "0.36.5"
                "0gk8lhbs229c68lapq6w6qmnm4jkj48hrcw5ilfyswy514nhmpxf"))

(define rust-once-cell-1.20.2
  (crate-source "once_cell" "1.20.2"
                "0xb7rw1aqr7pa4z3b00y7786gyf8awx2gca3md73afy76dzgwq8j"))

(define rust-open-5.3.0
  (crate-source "open" "5.3.0"
                "1cy40lf0hk8b0pwm9ix5zi53m4lqnjgviw9ylm16cwdxdazpga31"))

(define rust-ordered-float-5.1.0
  (crate-source "ordered-float" "5.1.0"
                "0b8gs4syw1bb008ds3h6qb0sggbg5hchhvbqqd028mhsj337jivz"))

(define rust-os-info-3.8.2
  (crate-source "os_info" "3.8.2"
                "14hhnnln768z7zhdpc2rhqpmlmcg9y05w27cw6ppr36kdpxcg6df"))

(define rust-os-pipe-1.2.1
  (crate-source "os_pipe" "1.2.1"
                "10nrh0i507560rsiy4c79fajdmqgbr6dha2pbl9mncrlaq52pzaz"))

(define rust-owo-colors-3.5.0
  (crate-source "owo-colors" "3.5.0"
                "0vyvry6ba1xmpd45hpi6savd8mbx09jpmvnnwkf6z62pk6s4zc61"))

(define rust-parking-lot-0.12.3
  (crate-source "parking_lot" "0.12.3"
                "09ws9g6245iiq8z975h8ycf818a66q3c6zv4b5h8skpm7hc1igzi"))

(define rust-parking-lot-core-0.9.10
  (crate-source "parking_lot_core" "0.9.10"
                "1y3cf9ld9ijf7i4igwzffcn0xl16dxyn4c5bwgjck1dkgabiyh0y"))

(define rust-pathdiff-0.2.2
  (crate-source "pathdiff" "0.2.2"
                "0qg33zcjlb90mfjyxnbxzcnr8gk1zkkw8x60s24vdd9s2phmq76n"))

(define rust-patricia-tree-0.8.0
  (crate-source "patricia_tree" "0.8.0"
                "0s5fya6rvgg2gxxp5mbv0xdq8jqikps1sc6snk23zrgzkd9z9wii"))

(define rust-proc-macro2-1.0.89
  (crate-source "proc-macro2" "1.0.89"
                "0vlq56v41dsj69pnk7lil7fxvbfid50jnzdn3xnr31g05mkb0fgi"))

(define rust-quote-1.0.37
  (crate-source "quote" "1.0.37"
                "1brklraw2g34bxy9y4q1nbrccn7bv36ylihv12c9vlcii55x7fdm"))

(define rust-radium-0.7.0
  (crate-source "radium" "0.7.0"
                "02cxfi3ky3c4yhyqx9axqwhyaca804ws46nn4gc1imbk94nzycyw"))

(define rust-radix-trie-0.2.1
  (crate-source "radix_trie" "0.2.1"
                "1zaq3im5ss03w91ij11cj97vvzc5y1f3064d9pi2ysnwziww2sf0"))

(define rust-redox-syscall-0.5.7
  (crate-source "redox_syscall" "0.5.7"
                "07vpgfr6a04k0x19zqr1xdlqm6fncik3zydbdi3f5g3l5k7zwvcv"))

(define rust-regex-automata-0.4.8
  (crate-source "regex-automata" "0.4.8"
                "18wd530ndrmygi6xnz3sp345qi0hy2kdbsa89182nwbl6br5i1rn"))

(define rust-rustc-demangle-0.1.24
  (crate-source "rustc-demangle" "0.1.24"
                "07zysaafgrkzy2rjgwqdj2a8qdpsm6zv6f5pgpk9x0lm40z9b6vi"))

(define rust-rustc-hash-1.1.0
  (crate-source "rustc-hash" "1.1.0"
                "1qkc5khrmv5pqi5l5ca9p5nl5hs742cagrndhbrlk3dhlrx3zm08"))

(define rust-rustix-0.38.44
  (crate-source "rustix" "0.38.44"
                "0m61v0h15lf5rrnbjhcb9306bgqrhskrqv7i1n0939dsw8dbrdgx"))

(define rust-rustversion-1.0.22
  (crate-source "rustversion" "1.0.22"
                "0vfl70jhv72scd9rfqgr2n11m5i9l1acnk684m2w83w0zbqdx75k"))

(define rust-ryu-1.0.18
  (crate-source "ryu" "1.0.18"
                "17xx2s8j1lln7iackzd9p0sv546vjq71i779gphjq923vjh5pjzk"))

(define rust-sd-notify-0.4.3
  (crate-source "sd-notify" "0.4.3"
                "0la4d28ym4rarm8bax07yh9f5r0jb2iqxwmjz00ffgirgxghrqhv"))

(define rust-semver-1.0.23
  (crate-source "semver" "1.0.23"
                "12wqpxfflclbq4dv8sa6gchdh92ahhwn4ci1ls22wlby3h57wsb1"))

(define rust-serde-1.0.228
  (crate-source "serde" "1.0.228"
                "17mf4hhjxv5m90g42wmlbc61hdhlm6j9hwfkpcnd72rpgzm993ls"))

(define rust-serde-core-1.0.228
  (crate-source "serde_core" "1.0.228"
                "1bb7id2xwx8izq50098s5j2sqrrvk31jbbrjqygyan6ask3qbls1"))

(define rust-serde-derive-1.0.228
  (crate-source "serde_derive" "1.0.228"
                "0y8xm7fvmr2kjcd029g9fijpndh8csv5m20g4bd76w8qschg4h6m"))

(define rust-serde-json-1.0.132
  (crate-source "serde_json" "1.0.132"
                "00yv8vyn1qiplziswm1vwam4a0xs1rfr162q75njc85kyjpvy9np"))

(define rust-serde-spanned-0.6.8
  (crate-source "serde_spanned" "0.6.8"
                "1q89g70azwi4ybilz5jb8prfpa575165lmrffd49vmcf76qpqq47"))

(define rust-signal-hook-0.3.17
  (crate-source "signal-hook" "0.3.17"
                "0098nsah04spqf3n8niirmfym4wsdgjl57c78kmzijlq8xymh8c6"))

(define rust-signal-hook-registry-1.4.2
  (crate-source "signal-hook-registry" "1.4.2"
                "1cb5akgq8ajnd5spyn587srvs4n26ryq0p78nswffwhv46sf1sd9"))

(define rust-simplelog-0.12.2
  (crate-source "simplelog" "0.12.2"
                "1h59cp84gwdmbxiljq6qmqq1x3lv9ikc1gb32f5ya7pgzbdpl98n"))

(define rust-smallvec-1.13.2
  (crate-source "smallvec" "1.13.2"
                "0rsw5samawl3wsw6glrsb127rx6sh89a8wyikicw6dkdcjd1lpiw"))

(define rust-smawk-0.3.2
  (crate-source "smawk" "0.3.2"
                "0344z1la39incggwn6nl45k8cbw2x10mr5j0qz85cdz9np0qihxp"))

(define rust-spin-0.9.8
  (crate-source "spin" "0.9.8"
                "0rvam5r0p3a6qhc18scqpvpgb3ckzyqxpgdfyjnghh8ja7byi039"))

(define rust-strip-ansi-escapes-0.2.0
  (crate-source "strip-ansi-escapes" "0.2.0"
                "1ymwcax1vyacqxx5xisfsynm7n1bvmhskvsaylac915k8gwqxzsm"))

(define rust-supports-color-2.1.0
  (crate-source "supports-color" "2.1.0"
                "12csf7chawxinaapm9rh718nha9hggk6ra86fdaw9hxdagg8qffn"))

(define rust-supports-hyperlinks-2.1.0
  (crate-source "supports-hyperlinks" "2.1.0"
                "0g93nh1db3f9lyd0ry35bqjrxkg6sbysn36x9hgd9m5h5rlk2hpq"))

(define rust-supports-unicode-2.1.0
  (crate-source "supports-unicode" "2.1.0"
                "0yp703pvpzpmaw9mpncvwf0iqis4xmhs569ii1g20jhqvngc2l7q"))

(define rust-syn-2.0.85
  (crate-source "syn" "2.0.85"
                "0mhvs8j1ykp26d504z14gbpn3p2xrkabrn1l43rzhknizhnic8sh"))

(define rust-tap-1.0.1
  (crate-source "tap" "1.0.1"
                "0sc3gl4nldqpvyhqi3bbd0l9k7fngrcl4zs47n314nqqk4bpx4sm"))

(define rust-termcolor-1.4.1
  (crate-source "termcolor" "1.4.1"
                "0mappjh3fj3p2nmrg4y7qv94rchwi9mzmgmfflr8p2awdj7lyy86"))

(define rust-terminal-size-0.1.17
  (crate-source "terminal_size" "0.1.17"
                "1pq60ng1a7fjp597ifk1cqlz8fv9raz9xihddld1m1pfdia1lg33"))

(define rust-textwrap-0.15.2
  (crate-source "textwrap" "0.15.2"
                "0galmidi6gpn308b1kv3r4qbb48j2926lcj0idwhdhlylhjybcxp"))

(define rust-thiserror-1.0.65
  (crate-source "thiserror" "1.0.65"
                "1mdkawq9l9p02zvq7y4py739rjk9wk2ha27mbsb3i6sdb7csn4ax"))

(define rust-thiserror-impl-1.0.65
  (crate-source "thiserror-impl" "1.0.65"
                "00l6gyrx6qlm1d7if3dcfl2sl0mg8k21caknkpk7glnb481pfwdf"))

(define rust-tiff-0.9.1
  (crate-source "tiff" "0.9.1"
                "0ghyxlz566dzc3scvgmzys11dhq2ri77kb8sznjakijlxby104xs"))

(define rust-time-0.3.47
  (crate-source "time" "0.3.47"
                "0b7g9ly2iabrlgizliz6v5x23yq5d6bpp0mqz6407z1s526d8fvl"))

(define rust-time-core-0.1.8
  (crate-source "time-core" "0.1.8"
                "1jidl426mw48i7hjj4hs9vxgd9lwqq4vyalm4q8d7y4iwz7y353n"))

(define rust-time-macros-0.2.27
  (crate-source "time-macros" "0.2.27"
                "058ja265waq275wxvnfwavbz9r1hd4dgwpfn7a1a9a70l32y8w1f"))

(define rust-toml-0.8.19
  (crate-source "toml" "0.8.19"
                "0knjd3mkxyb87qcs2dark3qkpadidap3frqfj5nqvhpxwfc1zvd1"))

(define rust-toml-datetime-0.6.8
  (crate-source "toml_datetime" "0.6.8"
                "0hgv7v9g35d7y9r2afic58jvlwnf73vgd1mz2k8gihlgrf73bmqd"))

(define rust-toml-edit-0.22.22
  (crate-source "toml_edit" "0.22.22"
                "1xf7sxfzmnc45f75x302qrn5aph52vc8w226v59yhrm211i8vr2a"))

(define rust-unicode-ident-1.0.13
  (crate-source "unicode-ident" "1.0.13"
                "1zm1xylzsdfvm2a5ib9li3g5pp7qnkv4amhspydvgbmd9k6mc6z9"))

(define rust-unicode-linebreak-0.1.5
  (crate-source "unicode-linebreak" "0.1.5"
                "07spj2hh3daajg335m4wdav6nfkl0f6c0q72lc37blr97hych29v"))

(define rust-unicode-width-0.1.14
  (crate-source "unicode-width" "0.1.14"
                "1bzn2zv0gp8xxbxbhifw778a7fc93pa6a1kj24jgg9msj07f7mkx"))

(define rust-vswhom-sys-0.1.2
  (crate-source "vswhom-sys" "0.1.2"
                "065s8kx9sbrgjpmzxgiczyhb90xzxq9d95nd0s2v58n8yvhpmcfk"))

(define rust-vte-0.11.1
  (crate-source "vte" "0.11.1"
                "15r1ff4j8ndqj9vsyil3wqwxhhl7jsz5g58f31n0h1wlpxgjn0pm"))

(define rust-vte-generate-state-changes-0.1.2
  (crate-source "vte_generate_state_changes" "0.1.2"
                "0biwgpcji3w4llz7h4bi8c2rwqchm9gmyr7dnjki1m853gp9ndif"))

(define rust-wasi-0.11.0+wasi-snapshot-preview1
  (crate-source "wasi" "0.11.0+wasi-snapshot-preview1"
                "08z4hxwkpdpalxjps1ai9y7ihin26y9f476i53dv98v45gkqg3cw"))

(define rust-weezl-0.1.8
  (crate-source "weezl" "0.1.8"
                "10lhndjgs6y5djpg3b420xngcr6jkmv70q8rb1qcicbily35pa2k"))

(define rust-widestring-1.1.0
  (crate-source "widestring" "1.1.0"
                "048kxd6iykzi5la9nikpc5hvpp77hmjf1sw43sl3z2dcdrmx66bj"))

(define rust-win-dbg-logger-0.1.0
  (crate-source "win_dbg_logger" "0.1.0"
                "0yd7b73rww8bqbppgw8hq180xcnnxz1nybqyv0s7bhjd4hi4q6vx"))

(define rust-winapi-build-0.1.1
  (crate-source "winapi-build" "0.1.1"
                "1g4rqsgjky0a7530qajn2bbfcrl2v0zb39idgdws9b1l7gp5wc9d"))

(define rust-windows-aarch64-gnullvm-0.48.5
  (crate-source "windows_aarch64_gnullvm" "0.48.5"
                "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))

(define rust-windows-aarch64-msvc-0.48.5
  (crate-source "windows_aarch64_msvc" "0.48.5"
                "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))

(define rust-windows-i686-gnu-0.48.5
  (crate-source "windows_i686_gnu" "0.48.5"
                "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))

(define rust-windows-i686-msvc-0.48.5
  (crate-source "windows_i686_msvc" "0.48.5"
                "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))

(define rust-windows-sys-0.48.0
  (crate-source "windows-sys" "0.48.0"
                "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))

(define rust-windows-targets-0.48.5
  (crate-source "windows-targets" "0.48.5"
                "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))

(define rust-windows-x86-64-gnu-0.48.5
  (crate-source "windows_x86_64_gnu" "0.48.5"
                "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))

(define rust-windows-x86-64-gnullvm-0.48.5
  (crate-source "windows_x86_64_gnullvm" "0.48.5"
                "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))

(define rust-windows-x86-64-msvc-0.48.5
  (crate-source "windows_x86_64_msvc" "0.48.5"
                "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))

(define rust-winnow-0.6.20
  (crate-source "winnow" "0.6.20"
                "16y4i8z9vh8hazjxg5mvmq0c5i35wlk8rxi5gkq6cn5vlb0zxh9n"))

(define rust-winreg-0.52.0
  (crate-source "winreg" "0.52.0"
                "19gh9vp7mp1ab84kc3ag48nm9y7xgjhh3xa4vxss1gylk1rsaxx2"))

(define rust-wyz-0.5.1
  (crate-source "wyz" "0.5.1"
                "1vdrfy7i2bznnzjdl9vvrzljvs4s3qm8bnlgqwln6a941gy61wq5"))

(define rust-x11rb-0.13.1
  (crate-source "x11rb" "0.13.1"
                "04jyfm0xmc538v09pzsyr2w801yadsgvyl2p0p76hzzffg5gz4ax"))

(define rust-x11rb-protocol-0.13.1
  (crate-source "x11rb-protocol" "0.13.1"
                "0gfbxf2k7kbk577j3rjhfx7hm70kmwln6da7xyc4l2za0d2pq47c"))

(define-cargo-inputs lookup-cargo-inputs
                     (vrc-get =>
                              (list rust-inflector-0.11.4
                                    rust-addr2line-0.24.2
                                    rust-adler2-2.0.1
                                    rust-aho-corasick-1.1.3
                                    rust-alloc-no-stdlib-2.0.4
                                    rust-alloc-stdlib-0.2.2
                                    rust-android-tzdata-0.1.1
                                    rust-android-system-properties-0.1.5
                                    rust-anstream-0.6.19
                                    rust-anstyle-1.0.11
                                    rust-anstyle-parse-0.2.7
                                    rust-anstyle-query-1.1.3
                                    rust-anstyle-wincon-3.0.9
                                    rust-anyhow-1.0.98
                                    rust-arbitrary-1.4.1
                                    rust-arc-swap-1.7.1
                                    rust-ashpd-0.11.0
                                    rust-async-broadcast-0.7.2
                                    rust-async-channel-2.3.1
                                    rust-async-compression-0.4.27
                                    rust-async-executor-1.13.2
                                    rust-async-io-2.4.1
                                    rust-async-lock-3.4.0
                                    rust-async-process-2.3.1
                                    rust-async-recursion-1.1.1
                                    rust-async-signal-0.2.11
                                    rust-async-stream-0.3.6
                                    rust-async-stream-impl-0.3.6
                                    rust-async-task-4.7.1
                                    rust-async-trait-0.1.88
                                    rust-async-zip-0.0.17
                                    rust-atk-0.18.2
                                    rust-atk-sys-0.18.2
                                    rust-atomic-waker-1.1.2
                                    rust-atomicbox-0.4.0
                                    rust-autocfg-1.4.0
                                    rust-backtrace-0.3.75
                                    rust-base64-0.21.7
                                    rust-base64-0.22.1
                                    rust-bitflags-1.3.2
                                    rust-bitflags-2.9.1
                                    rust-block-buffer-0.10.4
                                    rust-block2-0.5.1
                                    rust-block2-0.6.1
                                    rust-blocking-1.6.1
                                    rust-brotli-8.0.1
                                    rust-brotli-decompressor-5.0.0
                                    rust-bumpalo-3.18.1
                                    rust-bytemuck-1.23.1
                                    rust-byteorder-1.5.0
                                    rust-bytes-1.10.1
                                    rust-cairo-rs-0.18.5
                                    rust-cairo-sys-rs-0.18.2
                                    rust-camino-1.1.10
                                    rust-cargo-platform-0.1.9
                                    rust-cargo-metadata-0.19.2
                                    rust-cargo-toml-0.22.1
                                    rust-cc-1.2.27
                                    rust-cesu8-1.1.0
                                    rust-cfb-0.7.3
                                    rust-cfg-expr-0.15.8
                                    rust-cfg-if-1.0.1
                                    rust-cfg-aliases-0.2.1
                                    rust-chrono-0.4.41
                                    rust-clap-4.5.41
                                    rust-clap-builder-4.5.41
                                    rust-clap-complete-4.5.55
                                    rust-clap-derive-4.5.41
                                    rust-clap-lex-0.7.5
                                    rust-color-print-0.3.7
                                    rust-color-print-proc-macro-0.3.7
                                    rust-colorchoice-1.0.4
                                    rust-combine-4.6.7
                                    rust-concurrent-queue-2.5.0
                                    rust-convert-case-0.4.0
                                    rust-cookie-0.18.1
                                    rust-core-foundation-0.9.4
                                    rust-core-foundation-0.10.1
                                    rust-core-foundation-sys-0.8.7
                                    rust-core-graphics-0.24.0
                                    rust-core-graphics-types-0.2.0
                                    rust-cpufeatures-0.2.17
                                    rust-crc32fast-1.4.2
                                    rust-crossbeam-channel-0.5.15
                                    rust-crossbeam-queue-0.3.12
                                    rust-crossbeam-utils-0.8.21
                                    rust-crypto-common-0.1.6
                                    rust-cssparser-0.29.6
                                    rust-cssparser-macros-0.6.1
                                    rust-ctor-0.2.9
                                    rust-darling-0.20.11
                                    rust-darling-core-0.20.11
                                    rust-darling-macro-0.20.11
                                    rust-deflate64-0.1.9
                                    rust-deranged-0.4.0
                                    rust-derive-arbitrary-1.4.1
                                    rust-derive-more-0.99.20
                                    rust-digest-0.10.7
                                    rust-dirs-6.0.0
                                    rust-dirs-next-2.0.0
                                    rust-dirs-sys-0.5.0
                                    rust-dirs-sys-next-0.1.2
                                    rust-dispatch-0.2.0
                                    rust-dispatch2-0.2.0
                                    rust-dispatch2-0.3.0
                                    rust-displaydoc-0.2.5
                                    rust-dlopen2-0.7.0
                                    rust-dlopen2-derive-0.4.1
                                    rust-dpi-0.1.2
                                    rust-dtoa-1.0.10
                                    rust-dtoa-short-0.3.5
                                    rust-dunce-1.0.5
                                    rust-dyn-clone-1.0.19
                                    rust-either-1.15.0
                                    rust-embed-resource-3.0.3
                                    rust-embed-plist-1.2.2
                                    rust-encoding-rs-0.8.35
                                    rust-endi-1.1.0
                                    rust-enum-map-2.7.3
                                    rust-enum-map-derive-0.17.0
                                    rust-enumflags2-0.7.12
                                    rust-enumflags2-derive-0.7.12
                                    rust-env-filter-0.1.3
                                    rust-env-logger-0.11.8
                                    rust-equivalent-1.0.2
                                    rust-erased-serde-0.4.6
                                    rust-errno-0.3.12
                                    rust-event-listener-5.4.0
                                    rust-event-listener-strategy-0.5.4
                                    rust-fastrand-2.3.0
                                    rust-fdeflate-0.3.7
                                    rust-field-offset-0.3.6
                                    rust-filetime-0.2.25
                                    rust-flate2-1.1.2
                                    rust-fnv-1.0.7
                                    rust-foreign-types-0.3.2
                                    rust-foreign-types-0.5.0
                                    rust-foreign-types-macros-0.2.3
                                    rust-foreign-types-shared-0.1.1
                                    rust-foreign-types-shared-0.3.1
                                    rust-form-urlencoded-1.2.1
                                    rust-fs-extra-1.3.0
                                    rust-futf-0.1.5
                                    rust-futures-0.3.31
                                    rust-futures-channel-0.3.31
                                    rust-futures-core-0.3.31
                                    rust-futures-executor-0.3.31
                                    rust-futures-io-0.3.31
                                    rust-futures-lite-2.6.0
                                    rust-futures-macro-0.3.31
                                    rust-futures-sink-0.3.31
                                    rust-futures-task-0.3.31
                                    rust-futures-util-0.3.31
                                    rust-fxhash-0.2.1
                                    rust-gdk-0.18.2
                                    rust-gdk-pixbuf-0.18.5
                                    rust-gdk-pixbuf-sys-0.18.0
                                    rust-gdk-sys-0.18.2
                                    rust-gdkwayland-sys-0.18.2
                                    rust-gdkx11-0.18.2
                                    rust-gdkx11-sys-0.18.2
                                    rust-generic-array-0.14.7
                                    rust-getrandom-0.1.16
                                    rust-getrandom-0.2.16
                                    rust-getrandom-0.3.3
                                    rust-gimli-0.31.1
                                    rust-gio-0.18.4
                                    rust-gio-sys-0.18.1
                                    rust-glib-0.18.5
                                    rust-glib-macros-0.18.5
                                    rust-glib-sys-0.18.1
                                    rust-glob-0.3.2
                                    rust-gobject-sys-0.18.0
                                    rust-gtk-0.18.2
                                    rust-gtk-sys-0.18.2
                                    rust-gtk3-macros-0.18.2
                                    rust-h2-0.4.10
                                    rust-hashbrown-0.12.3
                                    rust-hashbrown-0.15.4
                                    rust-heck-0.4.1
                                    rust-heck-0.5.0
                                    rust-hermit-abi-0.5.2
                                    rust-hex-0.4.3
                                    rust-home-0.5.11
                                    rust-html5ever-0.29.1
                                    rust-http-1.3.1
                                    rust-http-body-1.0.1
                                    rust-http-body-util-0.1.3
                                    rust-httparse-1.10.1
                                    rust-hyper-1.6.0
                                    rust-hyper-rustls-0.27.7
                                    rust-hyper-tls-0.6.0
                                    rust-hyper-util-0.1.14
                                    rust-iana-time-zone-0.1.63
                                    rust-iana-time-zone-haiku-0.1.2
                                    rust-ico-0.4.0
                                    rust-icu-collections-2.0.0
                                    rust-icu-locale-core-2.0.0
                                    rust-icu-normalizer-2.0.0
                                    rust-icu-normalizer-data-2.0.0
                                    rust-icu-properties-2.0.1
                                    rust-icu-properties-data-2.0.1
                                    rust-icu-provider-2.0.0
                                    rust-ident-case-1.0.1
                                    rust-idna-1.0.3
                                    rust-idna-adapter-1.2.1
                                    rust-indexmap-1.9.3
                                    rust-indexmap-2.10.0
                                    rust-infer-0.19.0
                                    rust-io-uring-0.7.8
                                    rust-ipnet-2.11.0
                                    rust-iri-string-0.7.8
                                    rust-is-docker-0.2.0
                                    rust-is-wsl-0.4.0
                                    rust-is-terminal-polyfill-1.70.1
                                    rust-itertools-0.14.0
                                    rust-itoa-1.0.15
                                    rust-javascriptcore-rs-1.1.2
                                    rust-javascriptcore-rs-sys-1.1.1
                                    rust-jiff-0.2.15
                                    rust-jiff-static-0.2.15
                                    rust-jni-0.21.1
                                    rust-jni-sys-0.3.0
                                    rust-js-sys-0.3.77
                                    rust-json-patch-3.0.1
                                    rust-jsonptr-0.6.3
                                    rust-keyboard-types-0.7.0
                                    rust-kuchikiki-0.8.8-speedreader
                                    rust-lazy-static-1.5.0
                                    rust-libappindicator-0.9.0
                                    rust-libappindicator-sys-0.9.0
                                    rust-libc-0.2.173
                                    rust-libloading-0.7.4
                                    rust-libredox-0.1.3
                                    rust-linux-raw-sys-0.9.4
                                    rust-litemap-0.8.0
                                    rust-lock-api-0.4.13
                                    rust-log-0.4.27
                                    rust-log-panics-2.1.0
                                    rust-lru-slab-0.1.2
                                    rust-mac-0.1.1
                                    rust-markup5ever-0.14.1
                                    rust-match-token-0.1.0
                                    rust-matches-0.1.10
                                    rust-memchr-2.7.5
                                    rust-memoffset-0.9.1
                                    rust-mime-0.3.17
                                    rust-minimal-lexical-0.2.1
                                    rust-minisign-verify-0.2.4
                                    rust-miniz-oxide-0.8.9
                                    rust-mio-1.0.4
                                    rust-muda-0.17.0
                                    rust-native-tls-0.2.14
                                    rust-ndk-0.9.0
                                    rust-ndk-context-0.1.1
                                    rust-ndk-sys-0.6.0+11769913
                                    rust-new-debug-unreachable-1.0.6
                                    rust-nix-0.30.1
                                    rust-nodrop-0.1.14
                                    rust-nom-7.1.3
                                    rust-num-conv-0.1.0
                                    rust-num-traits-0.2.19
                                    rust-num-enum-0.7.3
                                    rust-num-enum-derive-0.7.3
                                    rust-objc-sys-0.3.5
                                    rust-objc2-0.5.2
                                    rust-objc2-0.6.1
                                    rust-objc2-app-kit-0.3.1
                                    rust-objc2-cloud-kit-0.3.1
                                    rust-objc2-core-data-0.3.1
                                    rust-objc2-core-foundation-0.3.1
                                    rust-objc2-core-graphics-0.3.1
                                    rust-objc2-core-image-0.3.1
                                    rust-objc2-encode-4.1.0
                                    rust-objc2-exception-helper-0.1.1
                                    rust-objc2-foundation-0.2.2
                                    rust-objc2-foundation-0.3.1
                                    rust-objc2-io-surface-0.3.1
                                    rust-objc2-metal-0.2.2
                                    rust-objc2-osa-kit-0.3.1
                                    rust-objc2-quartz-core-0.2.2
                                    rust-objc2-quartz-core-0.3.1
                                    rust-objc2-ui-kit-0.3.1
                                    rust-objc2-web-kit-0.3.1
                                    rust-object-0.36.7
                                    rust-object-0.37.1
                                    rust-once-cell-1.21.3
                                    rust-once-cell-polyfill-1.70.1
                                    rust-open-5.3.2
                                    rust-openssl-0.10.73
                                    rust-openssl-macros-0.1.1
                                    rust-openssl-probe-0.1.6
                                    rust-openssl-src-300.5.0+3.5.0
                                    rust-openssl-sys-0.9.109
                                    rust-opool-0.1.1
                                    rust-option-ext-0.2.0
                                    rust-ordered-float-2.10.1
                                    rust-ordered-stream-0.2.0
                                    rust-osakit-0.3.1
                                    rust-pango-0.18.3
                                    rust-pango-sys-0.18.0
                                    rust-parking-2.2.1
                                    rust-parking-lot-0.12.4
                                    rust-parking-lot-core-0.9.11
                                    rust-paste-1.0.15
                                    rust-pathdiff-0.2.3
                                    rust-percent-encoding-2.3.1
                                    rust-phf-0.8.0
                                    rust-phf-0.10.1
                                    rust-phf-0.11.3
                                    rust-phf-codegen-0.8.0
                                    rust-phf-codegen-0.11.3
                                    rust-phf-generator-0.8.0
                                    rust-phf-generator-0.10.0
                                    rust-phf-generator-0.11.3
                                    rust-phf-macros-0.10.0
                                    rust-phf-macros-0.11.3
                                    rust-phf-shared-0.8.0
                                    rust-phf-shared-0.10.0
                                    rust-phf-shared-0.11.3
                                    rust-pin-project-1.1.10
                                    rust-pin-project-internal-1.1.10
                                    rust-pin-project-lite-0.2.16
                                    rust-pin-utils-0.1.0
                                    rust-piper-0.2.4
                                    rust-pkg-config-0.3.32
                                    rust-plist-1.7.4
                                    rust-png-0.17.16
                                    rust-polling-3.8.0
                                    rust-portable-atomic-1.11.1
                                    rust-portable-atomic-util-0.2.4
                                    rust-potential-utf-0.1.2
                                    rust-powerfmt-0.2.0
                                    rust-ppv-lite86-0.2.21
                                    rust-precomputed-hash-0.1.1
                                    rust-proc-macro-crate-1.3.1
                                    rust-proc-macro-crate-2.0.0
                                    rust-proc-macro-crate-3.3.0
                                    rust-proc-macro-error-1.0.4
                                    rust-proc-macro-error-attr-1.0.4
                                    rust-proc-macro-hack-0.5.20+deprecated
                                    rust-proc-macro2-1.0.95
                                    rust-quick-xml-0.38.0
                                    rust-quinn-0.11.8
                                    rust-quinn-proto-0.11.12
                                    rust-quinn-udp-0.5.12
                                    rust-quote-1.0.40
                                    rust-r-efi-5.2.0
                                    rust-rand-0.7.3
                                    rust-rand-0.8.5
                                    rust-rand-0.9.1
                                    rust-rand-chacha-0.2.2
                                    rust-rand-chacha-0.3.1
                                    rust-rand-chacha-0.9.0
                                    rust-rand-core-0.5.1
                                    rust-rand-core-0.6.4
                                    rust-rand-core-0.9.3
                                    rust-rand-hc-0.2.0
                                    rust-rand-pcg-0.2.1
                                    rust-raw-window-handle-0.6.2
                                    rust-redox-syscall-0.5.13
                                    rust-redox-users-0.4.6
                                    rust-redox-users-0.5.0
                                    rust-ref-cast-1.0.24
                                    rust-ref-cast-impl-1.0.24
                                    rust-regex-1.11.1
                                    rust-regex-automata-0.4.9
                                    rust-regex-syntax-0.8.5
                                    rust-reqwest-0.12.22
                                    rust-rfd-0.15.3
                                    rust-ring-0.17.14
                                    rust-ringbuffer-0.15.0
                                    rust-rustc-demangle-0.1.25
                                    rust-rustc-hash-2.1.1
                                    rust-rustc-version-0.4.1
                                    rust-rustix-1.0.7
                                    rust-rustls-0.23.27
                                    rust-rustls-native-certs-0.8.1
                                    rust-rustls-pki-types-1.12.0
                                    rust-rustls-webpki-0.103.3
                                    rust-rustversion-1.0.21
                                    rust-ryu-1.0.20
                                    rust-same-file-1.0.6
                                    rust-schannel-0.1.27
                                    rust-schemars-0.8.22
                                    rust-schemars-0.9.0
                                    rust-schemars-1.0.4
                                    rust-schemars-derive-0.8.22
                                    rust-scopeguard-1.2.0
                                    rust-security-framework-2.11.1
                                    rust-security-framework-3.2.0
                                    rust-security-framework-sys-2.14.0
                                    rust-selectors-0.24.0
                                    rust-semver-1.0.26
                                    rust-serde-1.0.219
                                    rust-serde-untagged-0.1.7
                                    rust-serde-value-0.7.0
                                    rust-serde-derive-1.0.219
                                    rust-serde-derive-internals-0.29.1
                                    rust-serde-json-1.0.140
                                    rust-serde-path-to-error-0.1.17
                                    rust-serde-repr-0.1.20
                                    rust-serde-spanned-0.6.9
                                    rust-serde-urlencoded-0.7.1
                                    rust-serde-with-3.14.0
                                    rust-serde-with-macros-3.14.0
                                    rust-serialize-to-javascript-0.1.1
                                    rust-serialize-to-javascript-impl-0.1.1
                                    rust-servo-arc-0.2.0
                                    rust-sha1-0.10.6
                                    rust-sha2-0.10.9
                                    rust-shlex-1.3.0
                                    rust-signal-hook-registry-1.4.5
                                    rust-simd-adler32-0.3.7
                                    rust-siphasher-0.3.11
                                    rust-siphasher-1.0.1
                                    rust-slab-0.4.9
                                    rust-smallvec-1.15.1
                                    rust-socket2-0.5.10
                                    rust-softbuffer-0.4.6
                                    rust-soup3-0.5.0
                                    rust-soup3-sys-0.5.0
                                    rust-specta-2.0.0-rc.20
                                    rust-specta-macros-2.0.0-rc.17
                                    rust-specta-serde-0.0.7
                                    rust-specta-typescript-0.0.7
                                    rust-stable-deref-trait-1.2.0
                                    rust-static-assertions-1.1.0
                                    rust-string-cache-0.8.9
                                    rust-string-cache-codegen-0.5.4
                                    rust-strsim-0.11.1
                                    rust-subtle-2.6.1
                                    rust-swift-rs-1.0.7
                                    rust-syn-1.0.109
                                    rust-syn-2.0.103
                                    rust-sync-wrapper-1.0.2
                                    rust-synstructure-0.13.2
                                    rust-sys-locale-0.3.2
                                    rust-system-configuration-0.6.1
                                    rust-system-configuration-sys-0.6.0
                                    rust-system-deps-6.2.2
                                    rust-tao-0.34.0
                                    rust-tao-macros-0.1.3
                                    rust-tar-0.4.44
                                    rust-target-lexicon-0.12.16
                                    rust-tauri-2.6.2
                                    rust-tauri-build-2.3.0
                                    rust-tauri-codegen-2.3.0
                                    rust-tauri-macros-2.3.1
                                    rust-tauri-plugin-2.3.0
                                    rust-tauri-plugin-dialog-2.3.0
                                    rust-tauri-plugin-fs-2.4.0
                                    rust-tauri-plugin-single-instance-2.3.0
                                    rust-tauri-plugin-updater-2.7.1
                                    rust-tauri-runtime-2.7.0
                                    rust-tauri-runtime-wry-2.7.1
                                    rust-tauri-specta-2.0.0-rc.20
                                    rust-tauri-utils-2.5.0
                                    rust-tauri-winres-0.3.1
                                    rust-tempfile-3.20.0
                                    rust-tendril-0.4.3
                                    rust-thiserror-1.0.69
                                    rust-thiserror-2.0.12
                                    rust-thiserror-impl-1.0.69
                                    rust-thiserror-impl-2.0.12
                                    rust-thread-local-1.1.9
                                    rust-time-0.3.41
                                    rust-time-core-0.1.4
                                    rust-time-macros-0.2.22
                                    rust-tinystr-0.8.1
                                    rust-tinyvec-1.9.0
                                    rust-tinyvec-macros-0.1.1
                                    rust-tokio-1.46.1
                                    rust-tokio-macros-2.5.0
                                    rust-tokio-native-tls-0.3.1
                                    rust-tokio-rustls-0.26.2
                                    rust-tokio-util-0.7.15
                                    rust-toml-0.8.23
                                    rust-toml-datetime-0.6.11
                                    rust-toml-edit-0.19.15
                                    rust-toml-edit-0.20.7
                                    rust-toml-edit-0.22.27
                                    rust-toml-write-0.1.2
                                    rust-tower-0.5.2
                                    rust-tower-http-0.6.6
                                    rust-tower-layer-0.3.3
                                    rust-tower-service-0.3.3
                                    rust-tracing-0.1.41
                                    rust-tracing-attributes-0.1.29
                                    rust-tracing-core-0.1.34
                                    rust-trash-5.2.2
                                    rust-tray-icon-0.21.0
                                    rust-try-lock-0.2.5
                                    rust-typed-arena-2.0.2
                                    rust-typeid-1.0.3
                                    rust-typenum-1.18.0
                                    rust-uds-windows-1.1.0
                                    rust-unic-char-property-0.9.0
                                    rust-unic-char-range-0.9.0
                                    rust-unic-common-0.9.0
                                    rust-unic-ucd-ident-0.9.0
                                    rust-unic-ucd-version-0.9.0
                                    rust-unicode-ident-1.0.18
                                    rust-unicode-properties-0.1.3
                                    rust-unicode-segmentation-1.12.0
                                    rust-untrusted-0.9.0
                                    rust-url-2.5.4
                                    rust-urlencoding-2.1.3
                                    rust-urlpattern-0.3.0
                                    rust-utf-8-0.7.6
                                    rust-utf8-iter-1.0.4
                                    rust-utf8parse-0.2.2
                                    rust-uuid-1.17.0
                                    rust-vcpkg-0.2.15
                                    rust-version-compare-0.2.0
                                    rust-version-check-0.9.5
                                    rust-vrc-get-litedb-0.3.0-beta.7
                                    rust-vswhom-0.1.0
                                    rust-vswhom-sys-0.1.3
                                    rust-walkdir-2.5.0
                                    rust-want-0.3.1
                                    rust-wasi-0.9.0+wasi-snapshot-preview1
                                    rust-wasi-0.11.1+wasi-snapshot-preview1
                                    rust-wasi-0.14.2+wasi-0.2.4
                                    rust-wasm-bindgen-0.2.100
                                    rust-wasm-bindgen-backend-0.2.100
                                    rust-wasm-bindgen-futures-0.4.50
                                    rust-wasm-bindgen-macro-0.2.100
                                    rust-wasm-bindgen-macro-support-0.2.100
                                    rust-wasm-bindgen-shared-0.2.100
                                    rust-wasm-streams-0.4.2
                                    rust-web-sys-0.3.77
                                    rust-web-time-1.1.0
                                    rust-webkit2gtk-2.0.1
                                    rust-webkit2gtk-sys-2.0.1
                                    rust-webpki-roots-1.0.0
                                    rust-webview2-com-0.38.0
                                    rust-webview2-com-macros-0.8.0
                                    rust-webview2-com-sys-0.38.0
                                    rust-winapi-0.3.9
                                    rust-winapi-i686-pc-windows-gnu-0.4.0
                                    rust-winapi-util-0.1.9
                                    rust-winapi-x86-64-pc-windows-gnu-0.4.0
                                    rust-window-vibrancy-0.6.0
                                    rust-windows-0.56.0
                                    rust-windows-0.60.0
                                    rust-windows-0.61.3
                                    rust-windows-collections-0.1.1
                                    rust-windows-collections-0.2.0
                                    rust-windows-core-0.56.0
                                    rust-windows-core-0.60.1
                                    rust-windows-core-0.61.2
                                    rust-windows-future-0.1.1
                                    rust-windows-future-0.2.1
                                    rust-windows-implement-0.56.0
                                    rust-windows-implement-0.59.0
                                    rust-windows-implement-0.60.0
                                    rust-windows-interface-0.56.0
                                    rust-windows-interface-0.59.1
                                    rust-windows-link-0.1.3
                                    rust-windows-numerics-0.1.1
                                    rust-windows-numerics-0.2.0
                                    rust-windows-registry-0.5.2
                                    rust-windows-result-0.1.2
                                    rust-windows-result-0.3.4
                                    rust-windows-strings-0.3.1
                                    rust-windows-strings-0.4.2
                                    rust-windows-sys-0.45.0
                                    rust-windows-sys-0.52.0
                                    rust-windows-sys-0.59.0
                                    rust-windows-sys-0.60.2
                                    rust-windows-targets-0.42.2
                                    rust-windows-targets-0.52.6
                                    rust-windows-targets-0.53.2
                                    rust-windows-threading-0.1.0
                                    rust-windows-version-0.1.4
                                    rust-windows-aarch64-gnullvm-0.42.2
                                    rust-windows-aarch64-gnullvm-0.52.6
                                    rust-windows-aarch64-gnullvm-0.53.0
                                    rust-windows-aarch64-msvc-0.42.2
                                    rust-windows-aarch64-msvc-0.52.6
                                    rust-windows-aarch64-msvc-0.53.0
                                    rust-windows-i686-gnu-0.42.2
                                    rust-windows-i686-gnu-0.52.6
                                    rust-windows-i686-gnu-0.53.0
                                    rust-windows-i686-gnullvm-0.52.6
                                    rust-windows-i686-gnullvm-0.53.0
                                    rust-windows-i686-msvc-0.42.2
                                    rust-windows-i686-msvc-0.52.6
                                    rust-windows-i686-msvc-0.53.0
                                    rust-windows-x86-64-gnu-0.42.2
                                    rust-windows-x86-64-gnu-0.52.6
                                    rust-windows-x86-64-gnu-0.53.0
                                    rust-windows-x86-64-gnullvm-0.42.2
                                    rust-windows-x86-64-gnullvm-0.52.6
                                    rust-windows-x86-64-gnullvm-0.53.0
                                    rust-windows-x86-64-msvc-0.42.2
                                    rust-windows-x86-64-msvc-0.52.6
                                    rust-windows-x86-64-msvc-0.53.0
                                    rust-winnow-0.5.40
                                    rust-winnow-0.7.11
                                    rust-winreg-0.55.0
                                    rust-wit-bindgen-rt-0.39.0
                                    rust-wmi-0.17.2
                                    rust-writeable-0.6.1
                                    rust-wry-0.52.1
                                    rust-x11-2.21.0
                                    rust-x11-dl-2.21.0
                                    rust-xattr-1.5.0
                                    rust-yoke-0.8.0
                                    rust-yoke-derive-0.8.0
                                    rust-zbus-5.7.1
                                    rust-zbus-macros-5.7.1
                                    rust-zbus-names-4.2.0
                                    rust-zerocopy-0.8.25
                                    rust-zerocopy-derive-0.8.25
                                    rust-zerofrom-0.1.6
                                    rust-zerofrom-derive-0.1.6
                                    rust-zeroize-1.8.1
                                    rust-zerotrie-0.2.2
                                    rust-zerovec-0.11.2
                                    rust-zerovec-derive-0.11.1
                                    rust-zip-2.4.2
                                    rust-zvariant-5.5.3
                                    rust-zvariant-derive-5.5.3
                                    rust-zvariant-utils-3.2.0))
                     (kanata =>
                              (list
                                    rust-addr2line-0.24.2
                                    rust-adler2-2.0.0
                                    rust-aho-corasick-1.1.3
                                    rust-anstream-0.6.17
                                    rust-anstyle-1.0.9
                                    rust-anstyle-parse-0.2.6
                                    rust-anstyle-query-1.1.2
                                    rust-anstyle-wincon-3.0.6
                                    rust-anyhow-1.0.91
                                    rust-arboard-3.4.1
                                    rust-arraydeque-0.5.1
                                    rust-atomic-polyfill-1.0.3
                                    rust-autocfg-1.4.0
                                    rust-backtrace-0.3.74
                                    rust-backtrace-ext-0.2.1
                                    rust-bitflags-1.3.2
                                    rust-bitflags-2.9.1
                                    rust-bitvec-1.0.1
                                    rust-block2-0.5.1
                                    rust-bumpalo-3.19.0
                                    rust-bytemuck-1.19.0
                                    rust-byteorder-1.5.0
                                    rust-byteorder-lite-0.1.0
                                    rust-cc-1.1.31
                                    rust-cfg-aliases-0.2.1
                                    rust-cfg-if-1.0.0
                                    rust-clap-4.5.20
                                    rust-clap-builder-4.5.20
                                    rust-clap-derive-4.5.18
                                    rust-clap-lex-0.7.2
                                    rust-clipboard-win-5.4.0
                                    rust-colorchoice-1.0.3
                                    rust-console-error-panic-hook-0.1.7
                                    rust-core-foundation-0.10.0
                                    rust-core-foundation-0.9.4
                                    rust-core-foundation-sys-0.8.7
                                    rust-core-graphics-0.23.2
                                    rust-core-graphics-0.24.0
                                    rust-core-graphics-types-0.1.3
                                    rust-core-graphics-types-0.2.0
                                    rust-crc32fast-1.4.2
                                    rust-critical-section-1.2.0
                                    rust-deranged-0.5.5
                                    rust-dirs-5.0.1
                                    rust-dirs-sys-0.4.1
                                    rust-either-1.13.0
                                    rust-embed-resource-2.5.0
                                    rust-encode-unicode-0.3.6
                                    rust-endian-type-0.1.2
                                    rust-equivalent-1.0.1
                                    rust-errno-0.3.10
                                    rust-error-code-3.3.1
                                    rust-evdev-0.13.1
                                    rust-fdeflate-0.3.7
                                    rust-flate2-1.0.35
                                    rust-foreign-types-0.5.0
                                    rust-foreign-types-macros-0.2.3
                                    rust-foreign-types-shared-0.3.1
                                    rust-funty-2.0.0
                                    rust-gethostname-0.4.3
                                    rust-getrandom-0.2.15
                                    rust-gimli-0.31.1
                                    rust-hash32-0.2.1
                                    rust-hashbrown-0.15.0
                                    rust-heapless-0.7.17
                                    rust-heck-0.5.0
                                    rust-hermit-abi-0.4.0
                                    rust-image-0.25.5
                                    rust-indexmap-2.6.0
                                    rust-indoc-2.0.5
                                    rust-inotify-0.10.2
                                    rust-inotify-sys-0.1.5
                                    rust-interception-sys-0.1.3
                                    rust-is-ci-1.2.0
                                    rust-is-docker-0.2.0
                                    rust-is-terminal-0.4.13
                                    rust-is-terminal-polyfill-1.70.1
                                    rust-is-wsl-0.4.0
                                    rust-itertools-0.12.1
                                    rust-itoa-1.0.11
                                    rust-jobserver-0.1.32
                                    rust-jpeg-decoder-0.3.1
                                    rust-js-sys-0.3.77
                                    rust-kanata-interception-0.3.0
                                    rust-kanata-keyberon-macros-0.2.0
                                    rust-karabiner-driverkit-0.2.0
                                    rust-lazy-static-1.5.0
                                    rust-libc-0.2.161
                                    rust-libredox-0.1.3
                                    rust-linux-raw-sys-0.4.15
                                    rust-lock-api-0.4.12
                                    rust-log-0.4.22
                                    rust-malloc-buf-0.0.6
                                    rust-memchr-2.7.4
                                    rust-memoffset-0.7.1
                                    rust-miette-5.10.0
                                    rust-miette-derive-5.10.0
                                    rust-miniz-oxide-0.8.0
                                    rust-mio-0.8.11
                                    rust-muldiv-0.2.1
                                    rust-muldiv-1.0.1
                                    rust-native-windows-gui-1.0.13
                                    rust-nibble-vec-0.1.0
                                    rust-nix-0.26.4
                                    rust-nix-0.29.0
                                    rust-num-conv-0.2.0
                                    rust-num-enum-0.6.1
                                    rust-num-enum-derive-0.6.1
                                    rust-num-threads-0.1.7
                                    rust-num-traits-0.2.19
                                    rust-objc-0.2.7
                                    rust-objc-sys-0.3.5
                                    rust-objc2-0.5.2
                                    rust-objc2-app-kit-0.2.2
                                    rust-objc2-core-data-0.2.2
                                    rust-objc2-core-image-0.2.2
                                    rust-objc2-encode-4.1.0
                                    rust-objc2-foundation-0.2.2
                                    rust-objc2-metal-0.2.2
                                    rust-objc2-quartz-core-0.2.2
                                    rust-object-0.36.5
                                    rust-once-cell-1.20.2
                                    rust-open-5.3.0
                                    rust-option-ext-0.2.0
                                    rust-ordered-float-5.1.0
                                    rust-os-info-3.8.2
                                    rust-os-pipe-1.2.1
                                    rust-owo-colors-3.5.0
                                    rust-parking-lot-0.12.3
                                    rust-parking-lot-core-0.9.10
                                    rust-pathdiff-0.2.2
                                    rust-patricia-tree-0.8.0
                                    rust-pin-utils-0.1.0
                                    rust-png-0.17.16
                                    rust-powerfmt-0.2.0
                                    rust-proc-macro-crate-1.3.1
                                    rust-proc-macro2-1.0.89
                                    rust-quote-1.0.37
                                    rust-radium-0.7.0
                                    rust-radix-trie-0.2.1
                                    rust-redox-syscall-0.5.7
                                    rust-redox-users-0.4.6
                                    rust-regex-1.11.1
                                    rust-regex-automata-0.4.8
                                    rust-regex-syntax-0.8.5
                                    rust-rustc-demangle-0.1.24
                                    rust-rustc-hash-1.1.0
                                    rust-rustc-version-0.4.1
                                    rust-rustix-0.38.44
                                    rust-rustversion-1.0.22
                                    rust-ryu-1.0.18
                                    rust-scopeguard-1.2.0
                                    rust-sd-notify-0.4.3
                                    rust-semver-1.0.23
                                    rust-serde-1.0.228
                                    rust-serde-core-1.0.228
                                    rust-serde-derive-1.0.228
                                    rust-serde-json-1.0.132
                                    rust-serde-spanned-0.6.8
                                    rust-shlex-1.3.0
                                    rust-signal-hook-0.3.17
                                    rust-signal-hook-registry-1.4.2
                                    rust-simd-adler32-0.3.7
                                    rust-simplelog-0.12.2
                                    rust-smallvec-1.13.2
                                    rust-smawk-0.3.2
                                    rust-spin-0.9.8
                                    rust-stable-deref-trait-1.2.0
                                    rust-strip-ansi-escapes-0.2.0
                                    rust-strsim-0.11.1
                                    rust-supports-color-2.1.0
                                    rust-supports-hyperlinks-2.1.0
                                    rust-supports-unicode-2.1.0
                                    rust-syn-2.0.85
                                    rust-tap-1.0.1
                                    rust-termcolor-1.4.1
                                    rust-terminal-size-0.1.17
                                    rust-textwrap-0.15.2
                                    rust-thiserror-1.0.65
                                    rust-thiserror-impl-1.0.65
                                    rust-tiff-0.9.1
                                    rust-time-0.3.47
                                    rust-time-core-0.1.8
                                    rust-time-macros-0.2.27
                                    rust-toml-0.8.19
                                    rust-toml-datetime-0.6.8
                                    rust-toml-edit-0.19.15
                                    rust-toml-edit-0.22.22
                                    rust-unicode-ident-1.0.13
                                    rust-unicode-linebreak-0.1.5
                                    rust-unicode-width-0.1.14
                                    rust-utf8parse-0.2.2
                                    rust-vswhom-0.1.0
                                    rust-vswhom-sys-0.1.2
                                    rust-vte-0.11.1
                                    rust-vte-generate-state-changes-0.1.2
                                    rust-wasi-0.11.0+wasi-snapshot-preview1
                                    rust-wasm-bindgen-0.2.100
                                    rust-wasm-bindgen-backend-0.2.100
                                    rust-wasm-bindgen-macro-0.2.100
                                    rust-wasm-bindgen-macro-support-0.2.100
                                    rust-wasm-bindgen-shared-0.2.100
                                    rust-web-time-1.1.0
                                    rust-weezl-0.1.8
                                    rust-widestring-1.1.0
                                    rust-win-dbg-logger-0.1.0
                                    rust-winapi-0.3.9
                                    rust-winapi-build-0.1.1
                                    rust-winapi-i686-pc-windows-gnu-0.4.0
                                    rust-winapi-util-0.1.9
                                    rust-winapi-x86-64-pc-windows-gnu-0.4.0
                                    rust-windows-aarch64-gnullvm-0.48.5
                                    rust-windows-aarch64-gnullvm-0.52.6
                                    rust-windows-aarch64-msvc-0.48.5
                                    rust-windows-aarch64-msvc-0.52.6
                                    rust-windows-i686-gnu-0.48.5
                                    rust-windows-i686-gnu-0.52.6
                                    rust-windows-i686-gnullvm-0.52.6
                                    rust-windows-i686-msvc-0.48.5
                                    rust-windows-i686-msvc-0.52.6
                                    rust-windows-sys-0.48.0
                                    rust-windows-sys-0.52.0
                                    rust-windows-sys-0.59.0
                                    rust-windows-targets-0.48.5
                                    rust-windows-targets-0.52.6
                                    rust-windows-x86-64-gnu-0.48.5
                                    rust-windows-x86-64-gnu-0.52.6
                                    rust-windows-x86-64-gnullvm-0.48.5
                                    rust-windows-x86-64-gnullvm-0.52.6
                                    rust-windows-x86-64-msvc-0.48.5
                                    rust-windows-x86-64-msvc-0.52.6
                                    rust-winnow-0.5.40
                                    rust-winnow-0.6.20
                                    rust-winreg-0.52.0
                                    rust-wyz-0.5.1
                                    rust-x11rb-0.13.1
                                    rust-x11rb-protocol-0.13.1)))
