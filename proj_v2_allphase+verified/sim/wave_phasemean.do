onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider HILBERT
add wave -noupdate -divider Hilbert_specs_channel_1
add wave -noupdate -divider Hilbert_specs_channel_2
add wave -noupdate -divider CORDIC
add wave -noupdate /tb_all_phase/uut1/clock
add wave -noupdate /tb_all_phase/uut1/reset
add wave -noupdate /tb_all_phase/uut1/enable
add wave -noupdate -format Analog-Step -height 74 -max 1151.9999999999998 -min -1800.0 -radix decimal /tb_all_phase/uut1/rx1
add wave -noupdate -format Analog-Step -height 74 -max 468.00000000000017 -min -1496.0 -radix decimal /tb_all_phase/uut1/rx2
add wave -noupdate -format Analog-Step -height 74 -max 808.0 -min -1512.0 -radix decimal /tb_all_phase/uut1/rx3
add wave -noupdate -format Analog-Step -height 74 -max 747.99999999999977 -min -1892.0 -radix decimal /tb_all_phase/uut1/rx4
add wave -noupdate -divider HILBERT
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re1
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im1
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re2
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im2
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re3
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im3
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/re4
add wave -noupdate -radix decimal /tb_all_phase/uut1/hilbert_uut/im4
add wave -noupdate -divider Hilbert_specs_channel_1
add wave -noupdate -group channel1 -radix decimal -radixshowbase 0 /tb_all_phase/uut1/hilbert_uut/hfchain_1/xa
add wave -noupdate -group channel1 -radix decimal /tb_all_phase/uut1/hilbert_uut/im
add wave -noupdate -group channel1 -radix decimal /tb_all_phase/uut1/hilbert_uut/xf
add wave -noupdate -group channel1 -radix decimal /tb_all_phase/uut1/hilbert_uut/mult_coef
add wave -noupdate -group channel1 -radix decimal /tb_all_phase/uut1/hilbert_uut/mult
add wave -noupdate -group channel1 -radix decimal -radixshowbase 0 /tb_all_phase/uut1/hilbert_uut/addsub
add wave -noupdate -group channel1 /tb_all_phase/uut1/hilbert_uut/addsub_sel
add wave -noupdate -divider Hilbert_specs_channel_2
add wave -noupdate -radix decimal -radixshowbase 0 /tb_all_phase/uut1/hilbert_uut/hfchain_2/xa
add wave -noupdate -divider CORDIC
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/re1
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/im1
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/phase1
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/re2
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/im2
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/phase2
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/re3
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/im3
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/phase3
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/re4
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/im4
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/phase4
add wave -noupdate -expand -group CORDIC /tb_all_phase/uut1/cordic_uut/sel_in
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/start_cordic
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/x
add wave -noupdate -expand -group CORDIC -radix decimal /tb_all_phase/uut1/cordic_uut/y
add wave -noupdate -divider PHASEDIFF
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/phase1
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/phase2
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/phase3
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/phase4
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle1
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle2
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle3
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle4
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle5
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasediff_uut/angle6
add wave -noupdate -divider PHASEMEAN
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_1
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_2
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_3
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_4
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_5
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/in_sampl_6
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_1
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_2
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_3
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_4
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_5
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/phaseout_6
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_1
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_2
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_3
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_4
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_5
add wave -noupdate -radix decimal /tb_all_phase/uut1/phasemean_uut/add_samples_6
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {130631922 ps} 0}
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
WaveRestoreZoom {11746546 ps} {249517298 ps}
