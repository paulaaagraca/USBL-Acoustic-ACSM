`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module tb_phase2speed_file;

	parameter CLOCK_PERIOD = 10; // ns

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg [3:0] N;
	reg [18:0] in_phasediff;

	// Outputs
	wire signed [15:0] out_speed;
	wire speeden;

	// Instantiate the Unit Under Test (UUT)
	phase2speed uut (
		.clk(clk), 
		.reset(reset), 
		.data_rdy(data_rdy),
		.N(N),
		.in_phasediff(in_phasediff),
		.out_speed(out_speed),
		.speeden (speeden)
	);

	integer               data_file1    ; // file handler
	integer               scan_file1    ; // file handler
	integer               data_file2    ; // file handler
	integer               scan_file2    ; // file handler
	real error;
	reg signed  [18:0] phasediff;
	reg signed  [15:0] speed;
	reg	[4:0]	 cnt;
	reg	[12:0] nerror;
	reg	[8:0]	N_count;

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
		in_phasediff = 0;
		N_count = 9'd255;
		N = 4'd8;

		// Wait 100 ns for global reset to finish
		#50;
		$display("Starting\n");
		
		data_file1 = $fopen("../simdata/phasediff_Y.hex", "r");
		data_file2 = $fopen("../simdata/speed_Y.hex", "r");
		if (data_file1 == `NULL) begin
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
		
		data_rdy = 1;
	end

	always @(posedge clk) begin
			if (cnt) begin
				cnt <= cnt - 5'd1;
				data_rdy = 0;

			end
			else begin
				cnt <= cadence;
				data_rdy = 1;

				if (!$feof(data_file1)) begin
					if(N_count == 9'd0) begin
						scan_file2 <= $fscanf(data_file2, "%x\n", speed);
						$display("");
						$display("[file]->%d; %d", phasediff, speed);
						#1
						error = 100 * ( $itor(speed) - $itor(out_speed)) / ($itor(out_speed));
						if(error != 0)
						begin
							nerror=nerror+1;
						end
						$display("[firm]->%d; %d --> delta: %f%%\n", in_phasediff, out_speed, error);
						N_count = 9'd255;
						// Read input
						scan_file1 <= $fscanf(data_file1, "%x\n", phasediff);
						in_phasediff <= phasediff;
						$write(" %d", phasediff); 
					end
					else begin
						// Read input
						scan_file1 <= $fscanf(data_file1, "%x\n", phasediff);
						in_phasediff <= phasediff;
						$write(" %d", phasediff); 
						N_count = N_count- 9'd1;
					end
				end
				else begin
					$display("[Total errors]->%d;\n", nerror);
					$finish;
				end
		end
	end
endmodule

