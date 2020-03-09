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
module tb_rec2pol;

	// Inputs
	reg clock;
	reg reset;
	reg start;
	reg [128:0] x0;
	reg [128:0] y0;

	// Outputs
	wire signed [18:0] angle;

	// Instantiate the Unit Under Test (UUT)
	rec2pol_all uut (
		.clock(clock), 
		.reset(reset), 
		.start(start), 
		.busy(busy),
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
	integer printresults = 0;
	
	//real fracfactor = 1<<4; //---------------ERASE----------------
	
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
	  
	  // Call the task to start a conversion:
	  execcordic( 24, 3072 );  //--------------UNCOMMENT-----------------
	  execcordic( 24, -3072 );  //--------------UNCOMMENT-----------------
	  execcordic( 4095, 2047 );
	  execcordic( 4095, 4095 );
	  execcordic( -4095, 4095 );
	  execcordic( 4095, -4095 );
	  execcordic( -4095, -4095 );
	  execcordic( 4095, 0);
	  execcordic( -4095, 0);
	  execcordic( 0, 4095);
	  execcordic( 0, -4095);
	  
	  //$display("%f", (4'b1000 * 4'b0010)/fracfactor); //--------------ERASE-----------------
	  $stop;
	  
	end
	


	//--------------------------------------------------------------------
	// float parameters to convert the integer results to fractional results:
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
	input signed [128:0] X;
	input signed [128:0] Y;
	begin
	   x0 = X;
	   y0 = Y;
	   
	   start = 1;
	   @(negedge clock);
	   start = 0;
	   
	   // Wait some clocks to separate the calls to the task
	   repeat( 20 )
	   	@(negedge clock);
	   
	   /*if ( printresults )
	   begin  
	   	// Calculate the expected results:
	   	  Xr = X;
	   	  Yr = Y;
	   	  real_mod = $sqrt( Xr*Xr+Yr*Yr);
	   	  real_atan = $atan2(Yr,Xr) * 180 / PI;
	   	  err_mod = 100 * ( real_mod - (mod / fracfactor) ) / (mod / fracfactor);
	   	  err_atan = 100 * ( real_atan - (angle / fracfactorangle) ) / (angle / fracfactorangle);
	      
	   	  $display("Xi=%d, Yi = %d, Mod=%f  Angle=%f drg Exptd: M=%f, A=%f drg (ERRORs = %f%% %f%%)",
	   	  		       X, Y, mod / fracfactor, angle / fracfactorangle,
	   	  		       real_mod, real_atan, err_mod, err_atan );	
	    end*/
		 $display("Xi=%d, Yi = %d  Angle=%f drg", X, Y, angle / fracfactorangle);
	
	end
	endtask


endmodule
// end of module tb_rec2pol
