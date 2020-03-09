`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:26:00 01/07/2020 
// Design Name: 
// Module Name:    wind 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module wind(
		input clock,
				  input reset,
				  input endata,
				  input signed [11:0] rx1,          // Input channels
				  input signed [11:0] rx2,
				  input signed [11:0] rx3,
				  input signed [11:0] rx4,
				  input [3:0]         spdmeanlen,  // The log2(length) of the speed averaging
				  output signed [15:0] speedX,      // wind speed along X, 16 bits, 10 fractional
				  output signed [15:0] speedY,      // wind speed along X, 16 bits, 10 fractional
				  output reg           speeden      // 1-clock pulse to sync with speedX/Y updates
    );
	 
// ................................REAL2CPX......................................
	 
wire signed [12:0] re_xuw_2;
wire signed [12:0] im_xuw_2;
wire signed [12:0] re_xdw_4;
wire signed [12:0] im_xdw_4;
wire signed [12:0] re_yuw_3;
wire signed [12:0] im_yuw_3;
wire signed [12:0] re_ydw_1;
wire signed [12:0] im_ydw_1;
//wire enable_next_1;
//wire enable_next_2;
//wire enable_next_3;
//wire enable_next_4;

real2cpx real2cpx_xuw (
	 .clk (clock),
    .reset (reset),
	 .data_rdy (endata),		  // enable
    .x_rx (rx2),	 			 // integer
    .re (re_xuw_2), // integer
    .im (im_xuw_2)  // integer
	// .enable_next(enable_next_1)
	);

real2cpx real2cpx_xdw (
	 .clk (clock),
    .reset (reset),
	 .data_rdy (endata),		 // enable
    .x_rx (rx4),	  			 // integer
    .re (re_xdw_4), // integer
    .im (im_xdw_4)  // integer
	// .enable_next(enable_next_2)
	);

real2cpx real2cpx_yuw (
	 .clk (clock),
    .reset (reset),
	 .data_rdy (endata),		  // enable
    .x_rx (rx3),				  // integer
    .re (re_yuw_3), // integer
    .im (im_yuw_3)  // integer
	// .enable_next(enable_next_3)
	);
	
real2cpx real2cpx_ydw (
	 .clk (clock),
    .reset (reset),
	 .data_rdy (endata),		  // enable
    .x_rx (rx1),				  // integer
    .re (re_ydw_1), // integer
    .im (im_ydw_1)  // integer
	// .enable_next(enable_next_4)
	);
	
// ............................PHASECALC ....................................

wire signed [18:0] phase_ydw_1;
wire signed [18:0] phase_xuw_2;
wire signed [18:0] phase_yuw_3;
wire signed [18:0] phase_xdw_4;

phasecalc phasecalc_ydw_1 (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(endata), 
		.x(re_ydw_1), 
		.y(im_ydw_1),
	//	.prev_rdy(enable_next_1),
		.angle(phase_ydw_1)
	);
	
phasecalc phasecalc_xuw_2 (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(endata), 
		.x(re_xuw_2), 
		.y(im_xuw_2),
	//	.prev_rdy(enable_next_2),
		.angle( phase_xuw_2 )
	);
	
phasecalc phasecalc_yuw_3 (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(endata), 
		.x(re_yuw_3), 
		.y(im_yuw_3),
	//	.prev_rdy(enable_next_3),
		.angle( phase_yuw_3 )
	);
	
phasecalc phasecalc_xdw_4 (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(endata), 
		.x(re_xdw_4), 
		.y(im_xdw_4),
	//	.prev_rdy(enable_next_4),
		.angle( phase_xdw_4 )
	);

// ............................PHASEDIFF ....................................

wire signed [18:0] phasediff_y_1_3;
wire signed [18:0] phasediff_x_2_4;

phasediff phasediff_y(
    .clk(clock),
    .reset(reset),  
	 .data_rdy(endata),
    .in_phase1(phase_ydw_1),	// 9Q10
    .in_phase2(phase_yuw_3),	// 9Q10
    .out(phasediff_y_1_3)		// 9Q10
    );
	 
phasediff phasediff_x(
    .clk(clock),
    .reset(reset),  
	 .data_rdy(endata),
    .in_phase1(phase_xdw_4),	// 9Q10
    .in_phase2(phase_xuw_2),	// 9Q10
    .out(phasediff_x_2_4)		// 9Q10
    );

// ............................PHASE2SPEED ....................................

wire signed [15:0] phase2speed_y_1_3;
wire signed [15:0] phase2speed_x_2_4;
wire speeden1;
wire speeden2;

phase2speed phase2speed_y(
		.clk(clock), 
		.reset(reset), 
		.data_rdy(endata),
		.N(spdmeanlen),
		.in_phasediff(phasediff_y_1_3), 
		.out_speed(speedY),
		.speeden(speeden1)
	);
	
phase2speed phase2speed_x(
		.clk(clock), 
		.reset(reset), 
		.data_rdy(endata),
		.N(spdmeanlen),		
		.in_phasediff(phasediff_x_2_4), 
		.out_speed(speedX),
		.speeden(speeden2)
	);
	
// ............................ WINDREC2POL ....................................
/*
wire signed [15:0] speed_out;
wire signed [15:0] direction_out;

windrec2pol wind2pol (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(endata), 
		.xspeed(speedY), 
		.yspeed(speedX),
		.speed(speed_out),
		.direction(direction_out)
	);*/

endmodule
