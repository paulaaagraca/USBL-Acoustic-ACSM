onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_all_phase/uut1/clock
add wave -noupdate /tb_all_phase/uut1/reset
add wave -noupdate /tb_all_phase/uut1/enable
add wave -noupdate -format Analog-Step -height 74 -max 747.99999999999977 -min -1892.0 -radix decimal /tb_all_phase/uut1/rx4
add wave -noupdate -format Analog-Step -height 74 -max 1151.9999999999998 -min -1800.0 -radix decimal /tb_all_phase/uut1/rx1
add wave -noupdate -format Analog-Step -height 74 -max 808.0 -min -1512.0 -radix decimal /tb_all_phase/uut1/rx3
add wave -noupdate -format Analog-Step -height 74 -max 468.00000000000017 -min -1496.0 -radix decimal /tb_all_phase/uut1/rx2
add wave -noupdate -divider Hilbert
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re1
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re2
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re3
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re4
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im1
add wave -noupdate -radix decimal -radixshowbase 0 /tb_all_phase/uut1/hilbert_uut/hfchain_1/xa
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/xf
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/mult_coef
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/mult
add wave -noupdate -radix decimal -radixshowbase 0 /tb_all_phase/uut1/hilbert_uut/addsub
add wave -noupdate /tb_all_phase/uut1/hilbert_uut/addsub_sel
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im2
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im3
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {102421993 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 204
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
WaveRestoreZoom {102317114 ps} {103245902 ps}
