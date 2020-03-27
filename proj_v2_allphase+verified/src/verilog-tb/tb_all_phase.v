`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module tb_all_phase - test bench for module all_phase

	-----------------------------------------------------------------------------	
	Date of creation: 06/03/2020
	Author: Paula Graa (paula.graca@fe.up.pt)

*/

module tb_all_phase;

reg clock;
reg reset;
reg enable;

reg signed[15:0] rx1, rx2, rx3, rx4;

wire signed [15:0] diff_phase_1, diff_phase_2,
				   diff_phase_3, diff_phase_4,
				   diff_phase_5, diff_phase_6;	
				   
all_phase uut1(
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.rx1(rx1), 
		.rx2(rx2), 
		.rx3(rx3), 
		.rx4(rx4),
		.diff_phase_1(diff_phase_1),
		.diff_phase_2(diff_phase_2),
		.diff_phase_3(diff_phase_3),
		.diff_phase_4(diff_phase_4),
		.diff_phase_5(diff_phase_5),
		.diff_phase_6(diff_phase_6)		
);

initial begin
	clock = 0;
	reset = 0;
	enable = 0;
	rx1 = 0;
	rx2 = 0;
	rx3 = 0;
	rx4 = 0;
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
		
	
		
rx1 = 16'd0;
rx2 = 16'd0;
rx3 = 16'd0;
rx4 = 16'd0;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd5004;
rx2 = 16'd5004;
rx3 = 16'd5004;
rx4 = 16'd5004;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd9890;
rx2 = 16'd9890;
rx3 = 16'd9890;
rx4 = 16'd9890;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd14545;
rx2 = 16'd14545;
rx3 = 16'd14545;
rx4 = 16'd14545;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd18858;
rx2 = 16'd18858;
rx3 = 16'd18858;
rx4 = 16'd18858;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd22729;
rx2 = 16'd22729;
rx3 = 16'd22729;
rx4 = 16'd22729;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd26067;
rx2 = 16'd26067;
rx3 = 16'd26067;
rx4 = 16'd26067;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd28793;
rx2 = 16'd28793;
rx3 = 16'd28793;
rx4 = 16'd28793;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd30844;
rx2 = 16'd30844;
rx3 = 16'd30844;
rx4 = 16'd30844;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd32171;
rx2 = 16'd32171;
rx3 = 16'd32171;
rx4 = 16'd32171;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd32744;
rx2 = 16'd32744;
rx3 = 16'd32744;
rx4 = 16'd32744;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd32548;
rx2 = 16'd32548;
rx3 = 16'd32548;
rx4 = 16'd32548;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd31589;
rx2 = 16'd31589;
rx3 = 16'd31589;
rx4 = 16'd31589;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd29889;
rx2 = 16'd29889;
rx3 = 16'd29889;
rx4 = 16'd29889;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd27488;
rx2 = 16'd27488;
rx3 = 16'd27488;
rx4 = 16'd27488;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd24442;
rx2 = 16'd24442;
rx3 = 16'd24442;
rx4 = 16'd24442;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd20823;
rx2 = 16'd20823;
rx3 = 16'd20823;
rx4 = 16'd20823;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd16715;
rx2 = 16'd16715;
rx3 = 16'd16715;
rx4 = 16'd16715;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd12215;
rx2 = 16'd12215;
rx3 = 16'd12215;
rx4 = 16'd12215;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd7429;
rx2 = 16'd7429;
rx3 = 16'd7429;
rx4 = 16'd7429;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd2468;
rx2 = 16'd2468;
rx3 = 16'd2468;
rx4 = 16'd2468;
enable = 1;
#10
enable = 0;
#1900
//---- negative portion ----
rx1 = -16'd2550;
rx2 = -16'd2550;
rx3 = -16'd2550;
rx4 = -16'd2550;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd7509;
rx2 = -16'd7509;
rx3 = -16'd7509;
rx4 = -16'd7509;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd12292;
rx2 = -16'd12292;
rx3 = -16'd12292;
rx4 = -16'd12292;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd16786;
rx2 = -16'd16786;
rx3 = -16'd16786;
rx4 = -16'd16786;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd20886;
rx2 = -16'd20886;
rx3 = -16'd20886;
rx4 = -16'd20886;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd24497;
rx2 = -16'd24497;
rx3 = -16'd24497;
rx4 = -16'd24497;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd27533;
rx2 = -16'd27533;
rx3 = -16'd27533;
rx4 = -16'd27533;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd29923;
rx2 = -16'd29923;
rx3 = -16'd29923;
rx4 = -16'd29923;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd31611;
rx2 = -16'd31611;
rx3 = -16'd31611;
rx4 = -16'd31611;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd32558;
rx2 = -16'd32558;
rx3 = -16'd32558;
rx4 = -16'd32558;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd32741;
rx2 = -16'd32741;
rx3 = -16'd32741;
rx4= -16'd32741;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd32155;
rx2 = -16'd32155;
rx3 = -16'd32155;
rx4 = -16'd32155;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd30816;
rx2 = -16'd30816;
rx3 = -16'd30816;
rx4 = -16'd30816;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd28754;
rx2 = -16'd28754;
rx3 = -16'd28754;
rx4 = -16'd28754;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd26017;
rx2 = -16'd26017;
rx3 = -16'd26017;
rx4 = -16'd26017;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd22670;
rx2 = -16'd22670;
rx3 = -16'd22670;
rx4 = -16'd22670;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd18791;
rx2 = -16'd18791;
rx3 = -16'd18791;
rx4 = -16'd18791;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd14471;
rx2 = -16'd14471;
rx3 = -16'd14471;
rx4 = -16'd14471;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd9812;
rx2 = -16'd9812;
rx3 = -16'd9812;
rx4 = -16'd9812;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd4922;
rx2 = -16'd4922;
rx3 = -16'd4922;
rx4 = -16'd4922;
enable = 1;
#10
enable = 0;
#1900
rx1 = -16'd82;
rx2 = -16'd82;
rx3 = -16'd82;
rx4 = -16'd82;
enable = 1;
#10
enable = 0;
#1900
//---- positive portion ----
rx1 = 16'd5085;
rx2 = 16'd5085;
rx3 = 16'd5085;
rx4 = 16'd5085;
enable = 1;
#10
enable = 0;
#1900

rx1 = 16'd9969;
rx2 = 16'd9969;
rx3 = 16'd9969;
rx4 = 16'd9969;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd14619;
rx2 = 16'd14619;
rx3 = 16'd14619;
rx4 = 16'd14619;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd18925;
rx2 = 16'd18925;
rx3 = 16'd18925;
rx4 = 16'd18925;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd22788;
rx2 = 16'd22788;
rx3 = 16'd22788;
rx4 = 16'd22788;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd26116;
rx2 = 16'd26116;
rx3 = 16'd26116;
rx4 = 16'd26116;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd28832;
rx2 = 16'd28832;
rx3 = 16'd28832;
rx4 = 16'd28832;
enable = 1;
#10
enable = 0;
#1900
rx1 = 16'd30871;
rx2 = 16'd30871;
rx3 = 16'd30871;
rx4 = 16'd30871;
enable = 1;
#10
enable = 0;
#1900
	
		$stop;
end

endmodule
