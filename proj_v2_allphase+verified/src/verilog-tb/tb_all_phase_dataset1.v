`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module tb_all_phase - test bench for module all_phase

	-----------------------------------------------------------------------------	
	Date of creation: 06/03/2020
	Author: Paula Graa (paula.graca@fe.up.pt)

*/

module tb_all_phase;

parameter CLOCK_PERIOD = 10;

//inputs
reg clock;
reg reset;
reg enable;
reg signed[15:0] rx1, rx2, rx3, rx4;
reg [9:0] K;

//outputs
wire signed [15:0] diff_phase_1, diff_phase_2,
				   diff_phase_3, diff_phase_4,
				   diff_phase_5, diff_phase_6;	
//instantiate uut			   
all_phase uut1(
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.K(K),
		.rx1(rx1), 
		.rx2(rx2), 
		.rx3(rx3), 
		.rx4(rx4),
		.diff_phase_1(diff_phase_1),
		.diff_phase_2(diff_phase_2),
		.diff_phase_3(diff_phase_3),
		.diff_phase_4(diff_phase_4),
		.diff_phase_5(diff_phase_5),
		.diff_phase_6(diff_phase_6)		
);

// variables for file reading
integer data_h0;
integer scan_h0;
integer data_h1;
integer scan_h1;
integer data_h2;
integer scan_h2;
integer data_h3;
integer scan_h3;

reg signed [15:0] data0, data1, data2, data3;
reg [9:0] cnt;
reg [9:0] cnt_n_inputs;

parameter cadence = 512-1;

`define NULL 0

initial begin
		// Generate the clock signal:
		forever #(CLOCK_PERIOD) clock = ~clock;
	end
	

initial begin
	clock = 0;
	reset = 0;
	enable = 0;
	rx1 = 0;
	rx2 = 0;
	rx3 = 0;
	rx4 = 0;
	cnt = cadence;
	K = 3;
	
	// Wait 100 ns for global reset to finish
	#50;
	$display("Starting\n");
	
	data_h0 = $fopen("../simdata/signal0.dat", "r");
	data_h1 = $fopen("../simdata/signal1.dat", "r");
	data_h2 = $fopen("../simdata/signal2.dat", "r");
	data_h3 = $fopen("../simdata/signal3.dat", "r");
	
	//precaution conditions
	if (data_h0 == `NULL) begin
		$display("data_file handle was NULL");
		$finish;
	end
	if (data_h1 == `NULL) begin
		$display("data_file handle was NULL");
		$finish;
	end
	if (data_h2 == `NULL) begin
		$display("data_file handle was NULL");
		$finish;
	end
	if (data_h3 == `NULL) begin
		$display("data_file handle was NULL");
		$finish;
	end
        
		// Add stimulus here
		@(posedge clock);
		#10
		reset = 1;
		@(posedge clock);
		#10
		reset = 0;
		
		enable = 1;
		scan_h0 = $fscanf(data_h0, "%d\n", data0);
		scan_h1 = $fscanf(data_h1, "%d\n", data1);
		scan_h2 = $fscanf(data_h2, "%d\n", data2);
		scan_h3 = $fscanf(data_h3, "%d\n", data3);
		rx1 = data0;
		rx2 = data1;
		rx3 = data2;
		rx4 = data3;
	end

always @(posedge clock) begin
	if (reset) begin
		cnt_n_inputs <= 0;
	end
	if (cnt) begin
		cnt <= cnt - 10'd1;
		enable = 0;

	end
	else begin
		cnt <= cadence;
		enable = 1;
	
		if (!$feof(data_h0)) begin
						
			scan_h0 = $fscanf(data_h0, "%d\n", data0);
			scan_h1 = $fscanf(data_h1, "%d\n", data1);
			scan_h2 = $fscanf(data_h2, "%d\n", data2);
			scan_h3 = $fscanf(data_h3, "%d\n", data3);
			rx1 = data0;
			rx2 = data1;
			rx3 = data2;
			rx4 = data3;
			
			cnt_n_inputs  <= cnt_n_inputs + 10'd1;
		
			$display("[file]->%d; %d; %d; %d", data0, data1, data2, data3);
		end
		
		if(cnt_n_inputs == 50) begin	// number of inputs to simulate
			$stop;
		end
		
	end	
end	

endmodule
