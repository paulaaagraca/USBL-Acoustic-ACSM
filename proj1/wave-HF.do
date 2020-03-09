onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_hilbert/uut/clock
add wave -noupdate /tb_hilbert/uut/reset
add wave -noupdate /tb_hilbert/uut/enable
add wave -noupdate -radix decimal /tb_hilbert/uut/xin1
add wave -noupdate -radix decimal /tb_hilbert/uut/xin2
add wave -noupdate -radix decimal /tb_hilbert/uut/xin3
add wave -noupdate -radix decimal /tb_hilbert/uut/xin4
add wave -noupdate -radix decimal /tb_hilbert/uut/re1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/im1
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/re2
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/im2
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/re3
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/im3
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/re4
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/im4
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/im
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/addsub_sel
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/mult_coef
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/xf1
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/xf2
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/xf3
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/xf4
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/aux_xf
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/cnt_stop
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/en_calc
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/cnt_in
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_1/xa
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_1/out
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_2/xa
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_2/out
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_3/xa
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_3/out
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_4/xa
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/hfchain_4/out
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/mult
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/addsub
add wave -noupdate -radix decimal -radixshowbase 1 /tb_hilbert/uut/xf
add wave -noupdate -radix decimal -radixshowbase 0 /tb_hilbert/uut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {333212 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 143
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {144867 ps} {627763 ps}
