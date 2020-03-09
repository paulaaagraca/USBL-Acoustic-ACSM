`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:20:56 01/08/2020 
// Design Name: 
// Module Name:    calibwspd 
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
module calibwspd
(	 input clk,
    input reset,
    input enable,
    input [16-1:0] in,
	 output ready,
    output reg [16-1:0] out
    );
// The lookup table, 16 locations, in and out pairs:
reg [32-1:0] LUTcalib[0:15];
reg [4:0] L, R;

wire [16:0] m;

reg [3:0] counter;

//Load initial contents to the LUT from file "datafile.hex":
initial
begin
	$readmemh("../simdata/LUTdatafile.hex", LUTcalib);
end

assign m = (LUTcalib[R-1][16-1:0] - LUTcalib[L][16-1:0]) ;

always @(posedge clk)
begin
	if(reset)begin
		out <= 0;
		L <= 5'd0;
		R <= 5'd16;
	end
	else if (counter) begin
		if ((R-L) == 2) begin
			out <= m*(in-LUTcalib[L][32-1:16]) + LUTcalib[L][32-1:16];
		end 
		else if (in < ((LUTcalib[R-1][32-1:16]-LUTcalib[L][32-1:16])/2)+LUTcalib[L][32-1:16]) begin
			R <= (R-L)/2+L;
		end 
		else begin
			L <=(R-L)/2-1+L;
		end
	end
end

always @(posedge clk)
begin
	if (reset) begin
		counter <= 4'd0;
	end
	else if (enable) begin
		counter <= 4'd4;
	end
	else if (counter != 0) begin
		counter <= counter - 4'd1;
	end
	else begin
		counter <= 4'd0;
	end
end
	
endmodule
