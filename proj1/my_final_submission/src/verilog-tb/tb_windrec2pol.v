`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:56:00 12/29/2019
// Design Name:   windrec2pol
// Module Name:   /home/gpereira/Documents/Wind_Sensor_SigProc/src/verilog-tb/tb_windrec2pol.v
// Project Name:  PSDI_Proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: windrec2pol
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_windrec2pol;

	parameter CLOCK_PERIOD = 10; // ns

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg [15:0] xspeed;
	reg [15:0] yspeed;

	// Outputs
	wire [15:0] speed;
	wire [15:0] direction;

	// Instantiate the Unit Under Test (UUT)
	windrec2pol uut (
		.clock(clk), 
		.reset(reset), 
		.data_rdy(data_rdy), 
		.xspeed(xspeed), 
		.yspeed(yspeed), 
		.speed(speed), 
		.direction(direction)
	);

	integer               data_file1    ; // file handler
	integer               real_file    ; // file handler
	integer               data_file2    ; // file handler
	integer               imag_file    ; // file handler
	real error;
	reg signed  [12:0] rxx;
	reg signed  [12:0] rxy;
	reg	[4:0]	 cnt;
	reg	[18:0]	 nerror;

	`define NULL 0
	
	parameter cadence = 20-1;
	
	initial begin
		// Generate the clock signal:
		forever #(CLOCK_PERIOD) clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		data_rdy = 0;
		xspeed = 0;
		yspeed = 0;
		cnt = cadence;
		nerror = 0;

		// Wait 100 ns for global reset to finish
		#50;
		$display("Starting\n");
		
		data_file1 = $fopen("../simdata/speed_X.hex", "r");
		data_file2 = $fopen("../simdata/speed_Y.hex", "r");
		if (data_file1 == `NULL || data_file2 == `NULL) begin
			$display("data_file handle was NULL");
			$finish;
		end
        
		// Add stimulus here
		@(posedge clk);
		#10
		reset = 1;
		@(posedge clk);
		#10
		reset = 0;
		
		//data_rdy = 1;
		real_file = $fscanf(data_file1, "%x\n", rxx);
		imag_file = $fscanf(data_file2, "%x\n", rxy);

		xspeed = rxx;
		yspeed = rxy;

	end

	always @(posedge clk) begin
			if (cnt) begin
				cnt <= cnt - 5'd1;
				data_rdy = 0;

			end
			else begin
				cnt <= cadence;
				data_rdy = 1;

				if (!$feof(data_file1) || !$feof(data_file2)) begin
					
					$display("[file]->%d, %d", rxx/(1<<10), rxy/(1<<10));
					#1
					$display("[firm]->%d, %d\n", speed, direction/(1<<7));
					
					real_file <= $fscanf(data_file1, "%x\n", rxx);
					imag_file <= $fscanf(data_file2, "%x\n", rxy);

					xspeed <= rxx;
					yspeed <= rxy;
				end
				else begin
					$display("[Total errors]->%d\n", nerror);
					$stop;
				end
		end
	end
      
endmodule

