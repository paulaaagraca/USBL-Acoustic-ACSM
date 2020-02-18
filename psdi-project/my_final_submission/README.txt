--> ./src/data
**** atanLUT.hex ****
Stores the original 32 entries ROM values

**** atanLUTd.hex ****
ROM with 16 entries for the phasecalc and windrec2pol modules

**** s6base.ucf ****
Configurations file for top level final simulation 

-->  Modules of the system (./src/verilog-rtl)
**** ATAN_ROM.v ****
**** calibwspd.v ****
**** ITERCOUNTER.v ****
**** MODCALE.v ****
**** phase2speed.v ****
**** phasecalc.v ****
**** phasediff.v ****
**** real2cpx.v ****
**** rec2pol.v **** 	   --> rec2pol module of the phasecalc top module
**** rec2pol_wind.v ****   --> rec2pol module of the windrec2pol top module
**** wind.v **** 	   --> equivalent to data path from rec2cpx to windrec2pol
**** winddirection.v ****  --> professor's original file
**** windrec2pol.v ****

--> Test benches of the system (./src/verilog-tb)
**** real2cpx_tb_infile.v ****  --> real2cpx test bench with matlab files
**** tb_calibwspd.v ****
**** tb_phase2speed.v **** 	--> tb for phase2speed using random values
**** tb_phase2speed_file.v **** --> tb for phase2speed using matlab values
**** tb_phasecalc.v ****	--> tb for phasecalc using random values
**** tb_phasecal_file.v ****	--> tb for phasecalc using matlab values
**** tb_phasediff.v ****	--> tb for phasediff using random values
**** tb_phasediff_file.v ****	--> tb for phasediff using matlab values
**** tb_real2cpx.v ****		--> tb for real2cpx using random values
**** tb_rec2pol.v **** 		--> tb for rec2pol using random values
**** tb_windrec2pol_cordic.v **** --> tb for windrec2pol using random values
**** winddir_tb.v ****	--> test bench for wind.v
**** winddir_tb_prof.v **** --> original file


--> ./simdata
Generated MATLAB files









