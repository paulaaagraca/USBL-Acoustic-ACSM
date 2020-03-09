`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module tb_phasediff_file;

	parameter CLOCK_PERIOD = 10; // ns

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg signed[18:0] in_phase1;
	reg signed[18:0] in_phase2;

	// Outputs
	wire signed[18:0] out;

	// Instantiate the Unit Under Test (UUT)
	phasediff uut (
		.clk(clk), 
		.reset(reset), 
		.data_rdy(data_rdy),
		.in_phase1(in_phase1), 
		.in_phase2(in_phase2), 
		.out(out)
	);

	integer               data_file1    ; // file handler
	integer               scan_file1    ; // file handler
	integer               data_file2    ; // file handler
	integer               scan_file2    ; // file handler
	integer               data_file3    ; // file handler
	integer               scan_file3    ; // file handler
	real error;
	reg signed  [18:0] in1;
	reg signed  [18:0] in2;
	reg signed  [18:0] out_file;
	reg	[4:0]	 cnt;
	reg	[12:0]	 nerror;

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
		in_phase1 = 0;
		in_phase2 = 0;
		cnt = cadence;
		nerror = 0;

		// Wait 100 ns for global reset to finish
		#50;
		$display("Starting\n");
		
		data_file1 = $fopen("../simdata/phase_rx1.hex", "r");
		data_file2 = $fopen("../simdata/phase_rx3.hex", "r");
		data_file3 = $fopen("../simdata/phasediff_Y.hex", "r");
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
		
		scan_file1 = $fscanf(data_file1, "%x\n", in1);
		scan_file2 = $fscanf(data_file2, "%x\n", in2);

		in_phase1 = in1;
		in_phase2 = in2;
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
					
					scan_file3 <= $fscanf(data_file3, "%x\n", out_file);
					
					$display("[file]->%d; %d; %d", in1/(1<<10), in2/(1<<10), out_file/(1<<10));
					#1
					error = 100 * ( $itor(out_file) - $itor(out) ) / $itor(out);
					if(error != 0)
					begin
						nerror=nerror+1;
					end
					$display("[firm]->%d; %d; %d --> delta: %f%%\n", in_phase1/(1<<10), in_phase2/(1<<10), out/(1<<10), error);
					
					scan_file1 = $fscanf(data_file1, "%x\n", in1);
					scan_file2 = $fscanf(data_file2, "%x\n", in2);

					in_phase1 = in1;
					in_phase2 = in2;
				end
				else begin
					$display("[Total errors]->%d;\n", nerror);
					$finish;
				end
		end
	end
endmodule

