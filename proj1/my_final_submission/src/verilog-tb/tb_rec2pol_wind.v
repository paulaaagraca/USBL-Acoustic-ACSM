`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:45:40 01/06/2020
// Design Name:   rec2pol_wind
// Module Name:   /home/gpereira/Documents/Wind_Sensor_SigProc/src/verilog-tb/tb_rec2pol_wind.v
// Project Name:  PSDI_Proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rec2pol_wind
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_rec2pol_wind;

	// Inputs
	reg clock;
	reg reset;
	reg start;
	reg [15:0] x0;
	reg [15:0] y0;

	// Outputs
	wire signed [15:0] mod;
	wire signed [15:0] angle;

	// Instantiate the Unit Under Test (UUT)
	rec2pol_wind uut (
		.clock(clock), 
		.reset(reset), 
		.start(start), 
		.x(x0),
		.y(y0),
		.mod(mod),
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
	  execcordic( 1000, 0 );  //--------------UNCOMMENT-----------------
	  execcordic( 1600, 1600 );  //--------------UNCOMMENT-----------------
	  execcordic( 1600, 1600);
	  execcordic( 0, 5000 );
	  execcordic( 8050, -2048 );
	  execcordic( 1024, -2000);
	  
	  //$display("%f", (4'b1000 * 4'b0010)/fracfactor); //--------------ERASE-----------------
	  $stop;
	  
	end
	


	//--------------------------------------------------------------------
	// float parameters to convert the integer results to fractional results:
	real fracfactor = 1<<10;
	real fracfactorangle = 1<<7;
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
	input signed [13:0] X;
	input signed [13:0] Y;
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
		 $display("Xi=%f, Yi = %f, Mod=%f  Angle=%f drg", X/ fracfactor, Y/ fracfactor, mod/fracfactor, angle / fracfactorangle);
	
	end
	endtask
      
endmodule

