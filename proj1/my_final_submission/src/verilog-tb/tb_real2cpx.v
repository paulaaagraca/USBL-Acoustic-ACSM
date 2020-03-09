`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module tb_real2cpx;

	// Inputs
	reg clk;
	reg reset;
	reg [11:0] x_rx;
	reg data_rdy;

	// Outputs
	wire [12:0] re;
	wire [12:0] im;

	// Instantiate the Unit Under Test (UUT)
	real2cpx uut (
		.clk(clk), 
		.reset(reset),
		.data_rdy(data_rdy),		
		.x_rx(x_rx), 
		.re(re), 
		.im(im)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		x_rx = 0;
		data_rdy = 0;
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
	  repeat (10)
	  	@(negedge clk);
		
		x_rx = 12'hd32;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h46a;
		data_rdy = 1;	
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h7ff;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h4fc;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'hddd;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h881;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h953;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'hfa6;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		//------------------------------------------------
		x_rx = 12'h643;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h7b7;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h2ce;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'hb96;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h801;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'hb04;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h223;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h77f;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h6ad;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h05a;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h9bd;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h849;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'hd32;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h46a;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		x_rx = 12'h000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		

		$stop;
	end
      
endmodule

