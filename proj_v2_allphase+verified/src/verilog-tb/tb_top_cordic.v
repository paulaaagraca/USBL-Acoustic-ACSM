`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module tb_top_cordic - test bench for module top_cordic

	-----------------------------------------------------------------------------	
	Date of creation: 06/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)

*/

module tb_top_cordic;

reg clock;
reg reset;
reg enable;
reg signed [15:0] re1;
reg signed [15:0] re1a;
reg signed [15:0] im1;
reg signed [15:0] im1a;
reg signed [15:0] re2;
reg signed [15:0] re2a;
reg signed [15:0] im2;
reg signed [15:0] im2a;
reg signed [15:0] re3;
reg signed [15:0] re3a;
reg signed [15:0] im3;
reg signed [15:0] im3a;
reg signed [15:0] re4;
reg signed [15:0] re4a;
reg signed [15:0] im4;
reg signed [15:0] im4a;

wire signed [15:0] phase1;
wire signed [15:0] phase2;
wire signed [15:0] phase3;
wire signed [15:0] phase4;


top_cordic uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),		//enables new input
			.re1(re1), 		// real 
			.im1(im1),	 	// imaginary
			.re2(re2), 		// real 
			.im2(im2),	 	// imaginary
			.re3(re3), 		// real 
			.im3(im3),	 	// imaginary
			.re4(re4), 		// real 
			.im4(im4),	 	// imaginary
			.phase1(phase1),
			.phase2(phase2),
			.phase3(phase3),
			.phase4(phase4)
);

initial begin
	clock = 0;
	reset = 0;
	enable = 0;
	re1 = 0;
	re2 = 0;
	re3 = 0;
	re4 = 0;
	re1a = 0;
	re2a = 0;
	re3a = 0;
	re4a = 0;
	im1 = 0;
	im2 = 0;
	im3 = 0;
	im4 = 0;
	im1a = 0;
	im2a = 0;
	im3a = 0;
	im4a = 0;
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
		
	
	re1a = 16'd22741;
	re2a = 16'd12741;
	re3a = 16'd12741;
	re4a = 16'd18741;
	re1 = -re1a;
	re2 = -re2a;
	re3 = -re3a;
	re4 = -re4a;
	im1 = 16'd1493;
	im2 = 16'd1493;
	im3 = 16'd1493;
	im4 = 16'd1493;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1 = 16'd2;
	re2 = 16'd2;
	re3 = 16'd2;
	re4 = 16'd2;
	im1 = 16'd2;
	im2 = 16'd2;
	im3 = 16'd2;
	im4 = 16'd2;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1a = 16'd2;
	re2a = 16'd2;
	re3a = 16'd2;
	re4a = 16'd2;
	re1 = -re1a;
	re2 = -re2a;
	re3 = -re3a;
	re4 = -re4a;
	im1 = 16'd2;
	im2 = 16'd2;
	im3 = 16'd2;
	im4 = 16'd2;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1 = 16'd1;
	re2 = 16'd1;
	re3 = 16'd1;
	re4 = 16'd1;
	im1 = 16'd1;
	im2 = 16'd1;
	im3 = 16'd1;
	im4 = 16'd1;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1 = 16'd16383;
	re2 = 16'd16383;
	re3 = 16'd16383;
	re4 = 16'd16383;
	im1 = 16'd16383;
	im2 = 16'd16383;
	im3 = 16'd16383;
	im4 = 16'd16383;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1 = 16'd2;
	re2 = 16'd2;
	re3 = 16'd2;
	re4 = 16'd2;
	im1a = 16'd2;
	im2a = 16'd2;
	im3a = 16'd2;
	im4a = 16'd2;
	im1 = -im1a;
	im2 = -im2a;
	im3 = -im3a;
	im4 = -im4a;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	re1 = 16'd0;
	re2 = 16'd0;
	re3 = 16'd0;
	re4 = 16'd0;
	im1 = 16'd0;
	im2 = 16'd0;
	im3 = 16'd0;
	im4 = 16'd0;
	enable = 1;
	#10
	enable = 0;
	#1900
	
		$stop;
end

endmodule
