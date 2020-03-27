`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module tb_phasediff - test bench for module phasediff

	-----------------------------------------------------------------------------	
	Date of creation: 13/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)

*/

module tb_phasediff;

reg clock;
reg reset;
reg enable;
reg signed [15:0] phase1;
reg signed [15:0] phase2;
reg signed [15:0] phase3;
reg signed [15:0] phase4;

wire signed [15:0] angle1;
wire signed [15:0] angle2;
wire signed [15:0] angle3;
wire signed [15:0] angle4;
wire signed [15:0] angle5;
wire signed [15:0] angle6;


phasediff uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),		//enables new input
			.phase1(phase1),
			.phase2(phase2),
			.phase3(phase3),
			.phase4(phase4),
			.angle1(angle1),		// output angle 1
			.angle2(angle2),		// output angle 2
			.angle3(angle3),		// output angle 3
			.angle4(angle4),		// output angle 4
			.angle5(angle5),		// output angle 5
			.angle6(angle6)		// output angle 6
);

initial begin
	clock = 0;
	reset = 0;
	enable = 0;
	phase1 = 0;
	phase2 = 0;
	phase3 = 0;
	phase4 = 0;
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
		
	
	phase1 = 16'd5535;
	phase2 = 16'd17504;
	phase3 = -16'd5985;
	phase4 = 16'd5759;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	phase1 = -16'd5985;
	phase2 = 16'd5759;
	phase3 = 16'd5535;
	phase4 = 16'd17504;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	phase1 = 16'd16383;
	phase2 = 16'd16383;
	phase3 = -16'd16383;
	phase4 = 0;
	enable = 1;
	#10
	enable = 0;
	#1900
	
	$stop;
end

endmodule
