`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module tb_phasemean - test bench for module phasemean

	-----------------------------------------------------------------------------	
	Date of creation: 17/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)

*/

module tb_phasemean;

reg clock;
reg reset;
reg enable;
reg [9:0] K;
reg signed [15:0] in_sampl_1, 
				  in_sampl_2, 
				  in_sampl_3, 
				  in_sampl_4, 
				  in_sampl_5, 
				  in_sampl_6;

wire signed [15:0] phaseout_1, 
				   phaseout_2, 
				   phaseout_3, 
				   phaseout_4, 
				   phaseout_5, 
				   phaseout_6;

phasemean uut(
		.clock(clock),					// global clock
		.reset(reset),					// global reset
		.enable(enable),					// enables new input
		.K(K), 					// 2^K = N is the number of accumulated samples
		.in_sampl_1(in_sampl_1),		// input sample 1
		.in_sampl_2(in_sampl_2),		// input sample 2
		.in_sampl_3(in_sampl_3),		// input sample 3
		.in_sampl_4(in_sampl_4),		// input sample 4
		.in_sampl_5(in_sampl_5),		// input sample 5
		.in_sampl_6(in_sampl_6),		// input sample 6
		.phaseout_1(phaseout_1),		// output of phase mean for input 1
		.phaseout_2(phaseout_2),		// output of phase mean for input 2
		.phaseout_3(phaseout_3),		// output of phase mean for input 3
		.phaseout_4(phaseout_4),		// output of phase mean for input 4
		.phaseout_5(phaseout_5),		// output of phase mean for input 5
		.phaseout_6(phaseout_6)		// output of phase mean for input 6
);

initial begin
	clock = 0;
	reset = 0;
	enable = 0;
	K = 3;
	in_sampl_1 = 0;
	in_sampl_2 = 0;
	in_sampl_3 = 0;
	in_sampl_4 = 0;
	in_sampl_5 = 0;
	in_sampl_6 = 0;
end

// Generate the clock (4.1 -> 4 ns period, frequency = 244.14 kHz)
initial begin
	#11
	forever #5 clock= ~clock;
end

// reset
initial begin
	#101
	reset = 1;
	#20
	reset = 0;
end

initial begin 
	#10
	//wait to detect reset
	@(negedge reset);
	//wait 10 clocl cycles
	repeat(10)
	@(negedge clock);
		
	
	in_sampl_1 = 16'd1000;
	in_sampl_2 = 16'd17000;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd2000;
	in_sampl_2 = 16'd17500;
	in_sampl_3 = -16'd4000;
	in_sampl_4 = 16'd15564;
	in_sampl_5 = 16'd5759;
	in_sampl_6 = 16'd5553;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd1000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd2000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd1000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd2000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd1000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd2000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd10000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	in_sampl_1 = 16'd15000;
	in_sampl_2 = 16'd17504;
	in_sampl_3 = -16'd5985;
	in_sampl_4 = 16'd5759;
	in_sampl_5 = 16'd5535;
	in_sampl_6 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#300
	
	
	$stop;
end

endmodule