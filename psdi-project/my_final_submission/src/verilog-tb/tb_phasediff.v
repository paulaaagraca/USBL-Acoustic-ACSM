`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module tb_phasediff;

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg [18:0] in_phase1;
	reg [18:0] in_phase2;

	// Outputs
	wire [18:0] out;

	// Instantiate the Unit Under Test (UUT)
	phasediff uut (
		.clk(clk), 
		.reset(reset), 
		.data_rdy(data_rdy),
		.in_phase1(in_phase1), 
		.in_phase2(in_phase2), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_rdy = 0;
		in_phase1 = 0;
		in_phase2 = 0;
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
		
		in_phase1 = 19'h00000;
		in_phase2 = 19'h00000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		in_phase1 = 19'h2D000;
		in_phase2 = 19'h00000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		in_phase1 = 19'h2D000;
		in_phase2 = 19'h53000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		in_phase1 = 19'h53000;
		in_phase2 = 19'h2D000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		in_phase1 = 19'h08000;
		in_phase2 = 19'h04000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		in_phase1 = 19'hF8000;
		in_phase2 = 19'h04000;
		data_rdy = 1;
		#10
		$display("%d %d out:%d expt:%d", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), (in_phase1-in_phase2)/(1<<10));
		data_rdy = 0;
		#190
		
//		in_phase1 = 19'h697fd;
//		in_phase2 = 19'h697fd;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
//		in_phase1 = 19'h783db;
//		in_phase2 = 19'h780bb;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
//		in_phase1 = 19'h0001c;
//		in_phase2 = 19'h06b13;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
//		in_phase1 = 19'h00048;
//		in_phase2 = 19'h11d65;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
//		in_phase1 = 19'h00078;
//		in_phase2 = 19'h1dab7;
//		data_rdy = 1;
//		#10
//		data_rdy = 0;
//		#190
		
		$stop;
	end
      
endmodule

