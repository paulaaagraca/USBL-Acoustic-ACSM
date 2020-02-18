`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:20:03 12/29/2019 
// Design Name: 
// Module Name:    windrec2pol 
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
module windrec2pol(
    input clock,
    input reset,
    input data_rdy,
    input [15:0] xspeed,
    input [15:0] yspeed,
    output [15:0] speed,
    output [15:0] direction
    );

wire signed [15:0] x_edit;
wire signed [15:0] angle_23;
wire signed [15:0] angle_init;
wire signed [15:0] angle_neg;

// invert x to always be positive in the rec2pol input
assign x_edit = xspeed[15] ? -xspeed : xspeed;
// adaptation for outputing a 9Q10 binary number
assign direction = xspeed[15] ? angle_23 : angle_init;
// invert output angle from rec2pol and shifting the floating point
assign angle_neg = -angle_init;
// changing the modified angle to the correct quadrant -> 4th to 2nd; 1st to 3rd
assign angle_23 = (yspeed<0)? angle_neg - $signed({9'd180, 7'd0}): angle_neg + $signed({9'd180, 7'd0});

//instantiation of rec2pol base module
rec2pol_wind base_model(.clock(clock), .reset(reset), .start(data_rdy), .x(x_edit), .y(yspeed), .mod(speed), .angle(angle_init)); 
		   
endmodule
