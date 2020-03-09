`timescale 10ns / 10ns

//---------------------------------------------------------------------
// Engineers:   Paula A A Graca
// Institution: FEUP University of Porto
//---------------------------------------------------------------------

module tb_hilbert_file;

	parameter CLOCK_PERIOD = 10; // ns

	// Inputs
	reg clk;
	reg reset;
	reg data_rdy;
	reg signed [15:0] x_rx;

	// Outputs
	wire signed [15:0] re;
	wire signed [15:0] im;

	// Instantiate the Unit Under Test (UUT)
	real2cpx uut (
		.clk(clk), 
		.reset(reset), 
		.data_rdy(data_rdy),
		.x_rx(x_rx),
		.re(re), 
		.im(im)
	);
	
	integer               data_file1    ; // file handler
	integer               scan_file1    ; // file handler
	integer               data_file2    ; // file handler
	integer               scan_file2    ; // file handler
	integer               data_file3    ; // file handler
	integer               scan_file3    ; // file handler
	real error;
	reg signed  [11:0] rxuw;
	reg signed  [12:0] realuw;
	reg signed  [12:0] imaguw;
	reg	[4:0]	 cnt;
	reg	[12:0]	 nerror;
	reg	[12:0]	 nberror;

	`define NULL 0
	
	parameter cadence = 20-1;
	
	initial begin
		// Generate the clock signal:
		forever #(CLOCK_PERIOD) clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		x_rx = 0;
		reset = 0;
		data_rdy = 0;
		cnt = cadence;
		nerror = 0;
		nberror = 0;

		// Wait 100 ns for global reset to finish
		#50;
		$display("Starting\n");
		
		data_file1 = $fopen("../data/data_rx1.hex", "r");
		data_file2 = $fopen("../data/real_rx1.hex", "r");
		data_file3 = $fopen("../data/imag_rx1.hex", "r");
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
		scan_file1 = $fscanf(data_file1, "%x\n", rxuw);
		x_rx = rxuw;
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
					
					scan_file2 <= $fscanf(data_file2, "%x\n", realuw);
					scan_file3 <= $fscanf(data_file3, "%x\n", imaguw);
					
					$display("[file]->%d; %d; %d", rxuw, realuw, imaguw);
					#1
					error = 100 * ( $itor(imaguw) - $itor(im) ) / $itor(im);
					if(error != 0)
					begin
						nerror=nerror+1;
					end
					if(error > 0.5 || error < -0.5)
					begin
						nberror=nberror+1;
					end
					$display("[firm]->%d; %d; %d --> delta: %f%%\n", x_rx, re, im, error);
					
					scan_file1 <= $fscanf(data_file1, "%x\n", rxuw);
					x_rx <= rxuw;
				end
				else begin
					$display("[Total errors]->%d; [Big errors]->%d;\n", nerror, nberror);
					$finish;
				end
		end
	end
      
endmodule

