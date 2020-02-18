`timescale 1ns / 1ps

/*
    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module rec2pol_tb - Basic testbench for the rec2pol module.
	
	Summary
	This module implements a basic testbench for the rec2pol module. 
	Includes the task "execcordic(X,Y)" to execute a rectangular to polar conversion
	and print the results with the relative errors
	
	----------------------------------------------------------------------	
	Date created: 4 Oct 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
*/
module tb_phasecalc;

	// Inputs
	reg clock;
	reg reset;
	reg start;
	reg [12:0] x0;
	reg [12:0] y0;
	reg [12:0] ix;
	reg [12:0] iy;

	// Outputs
	//wire signed [31:0] mod;
	wire signed [18:0] angle;
	
	// Test
	real i;
	real j;

	// Instantiate the Unit Under Test (UUT)
	phasecalc uut (
		.clock(clock), 
		.reset(reset),  
		.data_rdy(start), 
		.x(x0), 
		.y(y0),
		.angle( angle )
	);

	// Initialize inputs:
	initial begin
		clock = 0;
		reset = 0;
		start = 0;
		x0 = 0;
		y0 = 0;
	end
	
	// Generate the clock (10 ns period, frequency = 100 MHz)
	initial
	begin
	  #11
	  forever #5 clock = ~clock;
	end
	
	// Apply reset:
	initial
	begin
	  #101 
	  reset = 1;
	  #20
	  reset = 0;
	end



	// set to zero to disable printing the simulation results 
	// by the task "execcordic"
	integer printresults = 1;

	
	// Main verification program:
	initial
	begin
	  #10
	  // Wait for realising the reset:
	  @(negedge reset);
	  // Wait 10 clock cycles
	  //	This is not required but helps analysing the signals in the
      //    waveform window.
	  repeat (10)
	  	@(negedge clock);
		

	  
	// Call the task to start a conversion for every possible bit toggle (0 and 1)
	
	execcordic( -1101, -2005 );
	
	for (ix = 13'b1100000000000; ix != 13'b0000000000000 ; ix=ix>>1) begin
		for (iy = 13'b1100000000000; iy != 13'b0000000000000 ; iy=iy>>1) begin
	  		execcordic( ix, iy );
		end
	end
	 
	  $stop;
	  
	end

	//--------------------------------------------------------------------
	// float parameters to convert the integer results to fractional results:
	real fracfactor = 1<<16;
	real fracfactorangle = 1<<10;
	real PI = 3.1415926536;
	
	
	// The X and Y in float format, required to compute the real values:
	real Xr, Yr;
	
	// The "true" values of modules, angle and the % errors:
	real real_mod, real_atan, err_mod, err_atan;
	
	//--------------------------------------------------------------------
	// Execute a CORDIC: 
	//   apply inputs, set enable to 1, raise start for 1 clock cycle, wait 32 clock cyles
	// set variable "printresults" to 1 to enable printing the results during simulation
	task execcordic;
	input signed [12:0] X;
	input signed [12:0] Y;
	begin
	   x0 = X;
	   y0 = Y;
	   
	   start = 1;
	   @(negedge clock);
	   start = 0;
		
		repeat( 20 )
	   	@(negedge clock);
	   
	   if ( printresults )
	   begin  
	   	// Calculate the expected results with adaptation to accept 32 bits instead of 16
	   	  Xr = X;
	   	  Yr = Y;
	   	  //real_mod = $sqrt( ((Xr/fracfactor)*(Xr/fracfactor))+((Yr/ fracfactor)*(Yr/ fracfactor)));
	   	  real_atan = $atan2(Yr,Xr) * 180 / PI;
	   	  //err_mod = 100 * ( real_mod - (mod / fracfactor) ) / (mod / fracfactor);
	   	  err_atan = 100 * ( real_atan - (angle / fracfactorangle) ) / (angle / fracfactorangle);
				
				//if(err_atan > 1)
				//begin
					$display("Xi=%d, Yi = %d, Angle=%f drg",
	   	  		       X, Y, angle / fracfactorangle);
				//end
	    end
	
	end
	endtask


endmodule
// end of module rec2pol_tb
