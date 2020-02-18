`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:40:04 12/29/2019
// Design Name:   phasecalc
// Module Name:   /home/gpereira/Documents/Wind_Sensor_SigProc/src/verilog-tb/tb_phasecalc_file.v
// Project Name:  PSDI_Proj
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: phasecalc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_phasecalc_file;

	parameter CLOCK_PERIOD = 10; // ns

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg signed [12:0] x;
	reg signed [12:0] y;

	// Outputs
	wire signed [18:0] angle;

	// Instantiate the Unit Under Test (UUT)
	phasecalc uut (
		.clock(clk), 
		.reset(reset), 
		.data_rdy(data_rdy), 
		.x(x), 
		.y(y), 
		.angle(angle)
	);
	
	integer               data_file1    ; // file handler
	integer               real_file    ; // file handler
	integer               data_file2    ; // file handler
	integer               imag_file    ; // file handler
	integer               data_file3    ; // file handler
	integer               phase_file    ; // file handler
	real error;
	reg signed  [12:0] rxr;
	reg signed  [12:0] rxi;
	reg signed  [18:0] out_file;
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
		x = 0;
		y = 0;
		cnt = cadence;
		nerror = 0;

		// Wait 100 ns for global reset to finish
		#50;
		$display("Starting\n");
		
		data_file1 = $fopen("../simdata/real_rx1.hex", "r");
		data_file2 = $fopen("../simdata/imag_rx1.hex", "r");
		data_file3 = $fopen("../simdata/phase_rx1.hex", "r");
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
		
		real_file = $fscanf(data_file1, "%x\n", rxr);
		imag_file = $fscanf(data_file2, "%x\n", rxi);

		x = rxr;
		y = rxi;

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
					
					phase_file <= $fscanf(data_file3, "%x\n", out_file);
					
					$display("[file]->%d, %d : %d", rxr, rxi, out_file);
					#1
					error = 100 * ( $itor(out_file) - $itor(angle) ) / $itor(angle);
					if(error != 0)
					begin
						nerror=nerror+1;
					end
					$display("[firm]->%d, %d : %f --> delta: %f%%\n", x, y, angle, error);
					
					real_file <= $fscanf(data_file1, "%x\n", rxr);
					imag_file <= $fscanf(data_file2, "%x\n", rxi);

					x <= rxr;
					y <= rxi;
				end
				else begin
					$display("[Total errors]->%d\n", nerror);
					$stop;
				end
		end
	end
      
endmodule

