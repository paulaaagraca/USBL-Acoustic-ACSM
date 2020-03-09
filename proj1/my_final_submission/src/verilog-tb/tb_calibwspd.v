`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:51:15 01/10/2020
// Design Name:   calibwspd
// Module Name:   C:/Users/up201503979/Downloads/Wind_Sensor_SigProc-master/Wind_Sensor_SigProc-master/src/verilog-tb/tb_calibwspd.v
// Project Name:  PSDI_Proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: calibwspd
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_calibwspd;

	// Inputs
	reg clk;
	reg reset;
	reg enable;
	reg [15:0] in;


	// Outputs
	wire ready;
	wire [15:0] out;
	wire [3:0] M;
	wire [3:0] N;
	
	
	assign M = 4'd16;
	assign N = 4'd16;

	// Instantiate the Unit Under Test (UUT)
	calibwspd uut ( //  #(.N(4'd16),.M(4'd16))
		.clk(clk), 
		.reset(reset), 
		.enable(enable), 
		.in(in), 
		.ready(ready), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		enable = 0;
		in = 0;
	end
	
	// Generate the clock (10 ns period, frequency = 100 MHz)
	initial
	begin
		#11
	forever #5 clk = ~clk;
	end
	
	// Apply reset:
	initial
	begin
	  #101 
	  reset = 1;
	  #20
	  reset = 0;
	end
	
	initial 
	begin
	#10
	  // Wait for realising the reset:
	  @(negedge reset);
	  // Wait 10 clock cycles
	  //	This is not required but helps analysing the signals in the
      //    waveform window.

		in = 16'h6EEE;
		enable = 1;
		#10
		enable = 0;
		#190
		$stop;
		
		
	end
      
endmodule

