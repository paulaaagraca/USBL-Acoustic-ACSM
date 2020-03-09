`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module tb_phase2speed;

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg [18:0] in_phasediff;

	// Outputs
	wire [15:0] out_speed;

	// Instantiate the Unit Under Test (UUT)
	phase2speed uut (
		.clk(clk), 
		.reset(reset), 
		.data_rdy(data_rdy), 
		.N(8),
		.in_phasediff(in_phasediff), 
		.out_speed(out_speed)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_rdy = 0;
		in_phasediff = 0;
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
		
//		in_phasediff = 19'b1_0100_1100__00_0000_0000;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
		in_phasediff = 19'b0_0000_0001__00_0000_0000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		in_phasediff = 19'b0_0000_0001__00_0000_0000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		in_phasediff = 19'b0_0000_0001__00_0000_0000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		in_phasediff = 19'b0_0000_0001__00_0000_0000;
		data_rdy = 1;
		#10
		data_rdy = 0;
		#190
		
		
		$stop;
	end
      
endmodule

