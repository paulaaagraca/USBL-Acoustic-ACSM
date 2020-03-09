`timescale 1ns/1ps

/////////////
//
/////////////

module tb_hilbert;

reg clock;
reg reset;
reg signed [15:0] xin1;
reg signed [15:0] xin2;
reg signed [15:0] xin3;
reg signed [15:0] xin4;
reg signed [15:0] xin1a;
reg signed [15:0] xin2a;
reg signed [15:0] xin3a;
reg signed [15:0] xin4a;
reg enable;

wire signed [27:0] re1;
wire signed [27:0] im1;
wire signed [27:0] re2;
wire signed [27:0] im2;
wire signed [27:0] re3;
wire signed [27:0] im3;
wire signed [27:0] re4;
wire signed [27:0] im4;

hilbert uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),		//enables new input
			.xin1(xin1),	 		 // input sample
			.xin2(xin2),	 		 // input sample
			.xin3(xin3),	 		 // input sample
			.xin4(xin4),	 		 // input sample
			.re1(re1), 		// real 
			.im1(im1),	 // imaginary
			.re2(re2), 		// real 
			.im2(im2),	 // imaginary
			.re3(re3), 		// real 
			.im3(im3),	 // imaginary
			.re4(re4), 		// real 
			.im4(im4)	 // imaginary
);

// initialize inputs
initial begin
	clock = 0;
	reset = 0;
	xin1 = 0;
	xin2 = 0;
	xin3 = 0;
	xin4 = 0;
	xin1a = 0;
	xin2a = 0;
	xin3a = 0;
	xin4a = 0;
	enable = 0;
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
integer i;
initial begin 
	#10
	//wait to detect reset
	@(negedge reset);
	//wait 10 clocl cycles
	repeat(10)
	@(negedge clock);

// ------------------------------------ SINUSOIDAL WAVE ---------------------------------------------
	
xin1 = 16'd0;
xin2 = 16'd0;
xin3 = 16'd0;
xin4 = 16'd0;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd5004;
xin2 = 16'd5004;
xin3 = 16'd5004;
xin4 = 16'd5004;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd9890;
xin2 = 16'd9890;
xin3 = 16'd9890;
xin4 = 16'd9890;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd14545;
xin2 = 16'd14545;
xin3 = 16'd14545;
xin4 = 16'd14545;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd18858;
xin2 = 16'd18858;
xin3 = 16'd18858;
xin4 = 16'd18858;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd22729;
xin2 = 16'd22729;
xin3 = 16'd22729;
xin4 = 16'd22729;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd26067;
xin2 = 16'd26067;
xin3 = 16'd26067;
xin4 = 16'd26067;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd28793;
xin2 = 16'd28793;
xin3 = 16'd28793;
xin4 = 16'd28793;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd30844;
xin2 = 16'd30844;
xin3 = 16'd30844;
xin4 = 16'd30844;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32171;
xin2 = 16'd32171;
xin3 = 16'd32171;
xin4 = 16'd32171;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32744;
xin2 = 16'd32744;
xin3 = 16'd32744;
xin4 = 16'd32744;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32548;
xin2 = 16'd32548;
xin3 = 16'd32548;
xin4 = 16'd32548;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd31589;
xin2 = 16'd31589;
xin3 = 16'd31589;
xin4 = 16'd31589;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd29889;
xin2 = 16'd29889;
xin3 = 16'd29889;
xin4 = 16'd29889;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd27488;
xin2 = 16'd27488;
xin3 = 16'd27488;
xin4 = 16'd27488;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd24442;
xin2 = 16'd24442;
xin3 = 16'd24442;
xin4 = 16'd24442;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd20823;
xin2 = 16'd20823;
xin3 = 16'd20823;
xin4 = 16'd20823;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd16715;
xin2 = 16'd16715;
xin3 = 16'd16715;
xin4 = 16'd16715;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd12215;
xin2 = 16'd12215;
xin3 = 16'd12215;
xin4 = 16'd12215;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd7429;
xin2 = 16'd7429;
xin3 = 16'd7429;
xin4 = 16'd7429;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd2468;
xin2 = 16'd2468;
xin3 = 16'd2468;
xin4 = 16'd2468;
enable = 1;
#10
enable = 0;
#1900
//---- negative portion ----
xin1a = 16'd2550;
xin2a = 16'd2550;
xin3a = 16'd2550;
xin4a = 16'd2550;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd7509;
xin2a = 16'd7509;
xin3a = 16'd7509;
xin4a = 16'd7509;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd12292;
xin2a = 16'd12292;
xin3a = 16'd12292;
xin4a = 16'd12292;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd16786;
xin2a = 16'd16786;
xin3a = 16'd16786;
xin4a = 16'd16786;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd20886;
xin2a = 16'd20886;
xin3a = 16'd20886;
xin4a = 16'd20886;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd24497;
xin2a = 16'd24497;
xin3a = 16'd24497;
xin4a = 16'd24497;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd27533;
xin2a = 16'd27533;
xin3a = 16'd27533;
xin4a = 16'd27533;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd29923;
xin2a = 16'd29923;
xin3a = 16'd29923;
xin4a = 16'd29923;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd31611;
xin2a = 16'd31611;
xin3a = 16'd31611;
xin4a = 16'd31611;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd32558;
xin2a = 16'd32558;
xin3a = 16'd32558;
xin4a = 16'd32558;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd32741;
xin2a = 16'd32741;
xin3a = 16'd32741;
xin4a = 16'd32741;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd32155;
xin2a = 16'd32155;
xin3a = 16'd32155;
xin4a = 16'd32155;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd30816;
xin2a = 16'd30816;
xin3a = 16'd30816;
xin4a = 16'd30816;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd28754;
xin2a = 16'd28754;
xin3a = 16'd28754;
xin4a = 16'd28754;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd26017;
xin2a = 16'd26017;
xin3a = 16'd26017;
xin4a = 16'd26017;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd22670;
xin2a = 16'd22670;
xin3a = 16'd22670;
xin4a = 16'd22670;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd18791;
xin2a = 16'd18791;
xin3a = 16'd18791;
xin4a = 16'd18791;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd14471;
xin2a = 16'd14471;
xin3a = 16'd14471;
xin4a = 16'd14471;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd9812;
xin2a = 16'd9812;
xin3a = 16'd9812;
xin4a = 16'd9812;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd4922;
xin2a = 16'd4922;
xin3a = 16'd4922;
xin4a = 16'd4922;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
xin1a = 16'd82;
xin2a = 16'd82;
xin3a = 16'd82;
xin4a = 16'd82;
xin1 = - xin1a;
xin2 = - xin2a;
xin3 = - xin3a;
xin4 = - xin4a;
enable = 1;
#10
enable = 0;
#1900
//---- positive portion ----
xin1 = 16'd5085;
xin2 = 16'd5085;
xin3 = 16'd5085;
xin4 = 16'd5085;
enable = 1;
#10
enable = 0;
#1900

xin1 = 16'd9969;
xin2 = 16'd9969;
xin3 = 16'd9969;
xin4 = 16'd9969;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd14619;
xin2 = 16'd14619;
xin3 = 16'd14619;
xin4 = 16'd14619;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd18925;
xin2 = 16'd18925;
xin3 = 16'd18925;
xin4 = 16'd18925;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd22788;
xin2 = 16'd22788;
xin3 = 16'd22788;
xin4 = 16'd22788;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd26116;
xin2 = 16'd26116;
xin3 = 16'd26116;
xin4 = 16'd26116;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd28832;
xin2 = 16'd28832;
xin3 = 16'd28832;
xin4 = 16'd28832;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd30871;
xin2 = 16'd30871;
xin3 = 16'd30871;
xin4 = 16'd30871;
enable = 1;
#10
enable = 0;
#1900

// ---------------------------------- \SINUSOIDAL WAVE ---------------------------------

// ------------------------------------ POSITIVE SINUSOIDAL WAVE ---------------------------------------------
/*	
xin1 = 16'd0;
xin2 = 16'd0;
xin3 = 16'd0;
xin4 = 16'd0;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd5004;
xin2 = 16'd5004;
xin3 = 16'd5004;
xin4 = 16'd5004;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd9890;
xin2 = 16'd9890;
xin3 = 16'd9890;
xin4 = 16'd9890;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd14545;
xin2 = 16'd14545;
xin3 = 16'd14545;
xin4 = 16'd14545;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd18858;
xin2 = 16'd18858;
xin3 = 16'd18858;
xin4 = 16'd18858;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd22729;
xin2 = 16'd22729;
xin3 = 16'd22729;
xin4 = 16'd22729;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd26067;
xin2 = 16'd26067;
xin3 = 16'd26067;
xin4 = 16'd26067;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd28793;
xin2 = 16'd28793;
xin3 = 16'd28793;
xin4 = 16'd28793;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd30844;
xin2 = 16'd30844;
xin3 = 16'd30844;
xin4 = 16'd30844;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32171;
xin2 = 16'd32171;
xin3 = 16'd32171;
xin4 = 16'd32171;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32744;
xin2 = 16'd32744;
xin3 = 16'd32744;
xin4 = 16'd32744;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32548;
xin2 = 16'd32548;
xin3 = 16'd32548;
xin4 = 16'd32548;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd31589;
xin2 = 16'd31589;
xin3 = 16'd31589;
xin4 = 16'd31589;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd29889;
xin2 = 16'd29889;
xin3 = 16'd29889;
xin4 = 16'd29889;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd27488;
xin2 = 16'd27488;
xin3 = 16'd27488;
xin4 = 16'd27488;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd24442;
xin2 = 16'd24442;
xin3 = 16'd24442;
xin4 = 16'd24442;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd20823;
xin2 = 16'd20823;
xin3 = 16'd20823;
xin4 = 16'd20823;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd16715;
xin2 = 16'd16715;
xin3 = 16'd16715;
xin4 = 16'd16715;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd12215;
xin2 = 16'd12215;
xin3 = 16'd12215;
xin4 = 16'd12215;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd7429;
xin2 = 16'd7429;
xin3 = 16'd7429;
xin4 = 16'd7429;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd2468;
xin2 = 16'd2468;
xin3 = 16'd2468;
xin4 = 16'd2468;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd2550;
xin2 = 16'd2550;
xin3 = 16'd2550;
xin4 = 16'd2550;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd7509;
xin2 = 16'd7509;
xin3 = 16'd7509;
xin4 = 16'd7509;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd12292;
xin2 = 16'd12292;
xin3 = 16'd12292;
xin4 = 16'd12292;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd16786;
xin2 = 16'd16786;
xin3 = 16'd16786;
xin4 = 16'd16786;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd20886;
xin2 = 16'd20886;
xin3 = 16'd20886;
xin4 = 16'd20886;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd24497;
xin2 = 16'd24497;
xin3 = 16'd24497;
xin4 = 16'd24497;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd27533;
xin2 = 16'd27533;
xin3 = 16'd27533;
xin4 = 16'd27533;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd29923;
xin2 = 16'd29923;
xin3 = 16'd29923;
xin4 = 16'd29923;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd31611;
xin2 = 16'd31611;
xin3 = 16'd31611;
xin4 = 16'd31611;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32558;
xin2 = 16'd32558;
xin3 = 16'd32558;
xin4 = 16'd32558;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32741;
xin2 = 16'd32741;
xin3 = 16'd32741;
xin4 = 16'd32741;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd32155;
xin2 = 16'd32155;
xin3 = 16'd32155;
xin4 = 16'd32155;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd30816;
xin2 = 16'd30816;
xin3 = 16'd30816;
xin4 = 16'd30816;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd28754;
xin2 = 16'd28754;
xin3 = 16'd28754;
xin4 = 16'd28754;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd26017;
xin2 = 16'd26017;
xin3 = 16'd26017;
xin4 = 16'd26017;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd22670;
xin2 = 16'd22670;
xin3 = 16'd22670;
xin4 = 16'd22670;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd18791;
xin2 = 16'd18791;
xin3 = 16'd18791;
xin4 = 16'd18791;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd14471;
xin2 = 16'd14471;
xin3 = 16'd14471;
xin4 = 16'd14471;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd9812;
xin2 = 16'd9812;
xin3 = 16'd9812;
xin4 = 16'd9812;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd4922;
xin2 = 16'd4922;
xin3 = 16'd4922;
xin4 = 16'd4922;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd82;
xin2 = 16'd82;
xin3 = 16'd82;
xin4 = 16'd82;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd5085;
xin2 = 16'd5085;
xin3 = 16'd5085;
xin4 = 16'd5085;
enable = 1;
#10
enable = 0;
#1900

xin1 = 16'd9969;
xin2 = 16'd9969;
xin3 = 16'd9969;
xin4 = 16'd9969;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd14619;
xin2 = 16'd14619;
xin3 = 16'd14619;
xin4 = 16'd14619;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd18925;
xin2 = 16'd18925;
xin3 = 16'd18925;
xin4 = 16'd18925;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd22788;
xin2 = 16'd22788;
xin3 = 16'd22788;
xin4 = 16'd22788;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd26116;
xin2 = 16'd26116;
xin3 = 16'd26116;
xin4 = 16'd26116;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd28832;
xin2 = 16'd28832;
xin3 = 16'd28832;
xin4 = 16'd28832;
enable = 1;
#10
enable = 0;
#1900
xin1 = 16'd30871;
xin2 = 16'd30871;
xin3 = 16'd30871;
xin4 = 16'd30871;
enable = 1;
#10
enable = 0;
#1900
*/
// ---------------------------------- \POSITIVE SINUSOIDAL WAVE ---------------------------------	
	
// ---------------------------------- SIMPLE (RANDOM VALUES) ------------------------------------	
/* 	xin = 16'h0000;
	enable = 1;
	#10
	enable = 0;
	#190 */
	//xin = 16'h3e80;
	
	
/*	xin1 = 16'h0001;
	xin2 = 16'h0002;
	xin3 = 16'h0003;
	xin4 = 16'h0004;
	enable = 1;
	#10
	enable = 0;
	
	#1900
	//xin = 16'h6400;
	xin1 = 16'h0002;
	xin2 = 16'h0003;
	xin3 = 16'h0004;
	xin4 = 16'h0005;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'h7d00;
	xin1 = 16'h0003;
	xin2 = 16'h0004;
	xin3 = 16'h0005;
	xin4 = 16'h0006;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'h6400;
	xin1 = 16'h0000;
	xin2 = 16'h0000;
	xin3 = 16'h0000;
	xin4 = 16'h0000;
	enable = 1;
	#10
	enable = 0;
	#1900
 	//xin = 16'h3e80;
	xin1 = 16'h0001;
	xin2 = 16'h0001;
	xin3 = 16'h0001;
	xin4 = 16'h0001;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'h0000;
	xin1 = 16'h0002;
	xin2 = 16'h0002;
	xin3 = 16'h0002;
	xin4 = 16'h0002;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'hc180;
	xin1 = 16'h0001;
	xin2 = 16'h0001;
	xin3 = 16'h0001;
	xin4 = 16'h0001;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'h9c00;
	xin1 = 16'h0000;
	xin2 = 16'h0000;
	xin3 = 16'h0000;
	xin4 = 16'h0000;
	enable = 1;
	#10
	enable = 0;
	#1900
	//xin = 16'h8300;
	xin1 = 16'h0001;
	xin2 = 16'h0001;
	xin3 = 16'h0001;
	xin4 = 16'h0001;
	enable = 1;
	#10
	enable = 0;
	#190 */
	/*xin = 16'h9c00;
	enable = 1;
	#10
	enable = 0;
	#190
	xin = 16'hc180;
	enable = 1;
	#10
	enable = 0;
	#190 */
	/* xin = 16'h0000;
	enable = 1;
	#10
	enable = 0;
	#190 */
// -------------------------------- \SIMPLE (RANDOM VALUES) -------------------------------------
	
	$stop;
end

endmodule
