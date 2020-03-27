`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module phasemean - accumulates N samples and outputs the given phase mean
	
	This module receives 6 inputs at a time. It uses 6 registers that accumulate the 
	addition of N input samples for each input channel. After the N samples are accumulated, 
	the mean is calculated and saved in the output. 
	_____________________________________________________________________________
	Note: we have 512 clock cycles to use per new input.
		- 1 regular input : 7 clock cycles
		- input + update outputs : 14 clock cycles
		
		N = 8  : 7*7  + 14 = 63  cycles
		N = 16 : 15*7 + 14 = 119 cycles
		N = 32 : 31*7 + 14 = 231 cycles
		N = 64 : 63*7 + 14 = 455 cycles
		N = 128: 127*7+ 14 = 903 cycles (above)
		
		.: maximum K = 6
	
	-----------------------------------------------------------------------------	
	Date of creation: 16/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)
*/

module phasemean (
		input clock,					// global clock
		input reset,					// global reset
		input enable,					// enables new input
		input [9:0] K, 					// 2^K = N is the number of accumulated samples
		input [15:0] in_sampl_1,		// input sample 1
		input [15:0] in_sampl_2,		// input sample 2
		input [15:0] in_sampl_3,		// input sample 3
		input [15:0] in_sampl_4,		// input sample 4
		input [15:0] in_sampl_5,		// input sample 5
		input [15:0] in_sampl_6,		// input sample 6
		output reg signed [15:0] phaseout_1,		// output of phase mean for input 1
		output reg signed [15:0] phaseout_2,		// output of phase mean for input 2
		output reg signed [15:0] phaseout_3,		// output of phase mean for input 3
		output reg signed [15:0] phaseout_4,		// output of phase mean for input 4
		output reg signed [15:0] phaseout_5,		// output of phase mean for input 5
		output reg signed [15:0] phaseout_6			// output of phase mean for input 6
);

//FSM signals
reg [2:0] state;
parameter IDLE = 3'd0,
		  ADD1 = 3'd1,
		  ADD2 = 3'd2,
		  ADD3 = 3'd3,
		  ADD4 = 3'd4,
		  ADD5 = 3'd5,
		  ADD6 = 3'd6;

parameter accum_size = 36; // size of the accumulator
//accumulator registers for each output
reg signed [accum_size-1:0] add_samples_1; 
reg signed [accum_size-1:0]	add_samples_2;
reg signed [accum_size-1:0]	add_samples_3;
reg signed [accum_size-1:0]	add_samples_4;
reg signed [accum_size-1:0]	add_samples_5;
reg signed [accum_size-1:0]	add_samples_6;


// control signals
reg [10:0] cnt_samples;	// counts accumulated samples (max 1024)
reg rdy_update;			// active when updating outputs
reg updating_out;		// active after updating outputs


wire [12:0] N;		// number of samples to accumulate
assign N = (1<<K); 	// N = 2^K

// FSM 
always @(posedge clock)
begin
	if (reset) begin
		state <= IDLE;
		
		rdy_update <= 0;
		
		updating_out <= 0;
		
		add_samples_1 <= 36'd0;
		add_samples_2 <= 36'd0;
		add_samples_3 <= 36'd0;
		add_samples_4 <= 36'd0;
		add_samples_5 <= 36'd0;
		add_samples_6 <= 36'd0;
		
		phaseout_1 <= 16'd0;
		phaseout_2 <= 16'd0;
		phaseout_3 <= 16'd0;
		phaseout_4 <= 16'd0;
		phaseout_5 <= 16'd0;
		phaseout_6 <= 16'd0;
	end
	else begin
	
		case (state)
		// IDLE: waits for new input || runs FSM a second time for Nth input to update the outputs
		IDLE: begin
				if (enable || rdy_update) begin
					state <= ADD1;
					updating_out <= 0;
				end
			  end
		
		// ADD1: accumulates input 1 to accumulator 1 || updates output phase 1 with mean
		ADD1: begin
				state <= ADD2;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_1 <= add_samples_1 >>> K;	// mean of the inputs samples phases 1
					add_samples_1 <= 36'd0;				// reset accumulator
				end
				else begin 
					// accumulate new sample
					add_samples_1 <= $signed(add_samples_1) + $signed(in_sampl_1);	
				end
			  end
			
		// ADD2: accumulates input 2 to accumulator 2 || updates output phase 2 with mean
		ADD2: begin
				state <= ADD3;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_2 <= add_samples_2 >>> K;	// mean of the inputs samples phases 2
					add_samples_2 <= 36'd0;				// reset accumulator
				end
				else begin 
					// accumulate new sample 
					add_samples_2 <= $signed(add_samples_2) + $signed(in_sampl_2);
				end
			  end
		
		// ADD3: accumulates input 3 to accumulator 3 || updates output phase 3 with mean
		ADD3: begin
				state <= ADD4;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_3 <= add_samples_3 >>> K;	// mean of the inputs samples phases 2
					add_samples_3 <= 36'd0;				// reset accumulator
				end
				else begin 
					add_samples_3 <= $signed(add_samples_3) + $signed(in_sampl_3);	// accumulate new sample
				end
			  end
		
		// ADD4: accumulates input 4 to accumulator 4 || updates output phase 4 with mean
		ADD4: begin
				state <= ADD5;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_4 <= add_samples_4 >>> K;	// mean of the inputs samples phases 2
					add_samples_4 <= 36'd0;				// reset accumulator
				end
				else begin 
					// accumulate new sample 
					add_samples_4 <= $signed(add_samples_4) + $signed(in_sampl_4);
				end
			  end
		
		// ADD5: accumulates input 5 to accumulator 5 || updates output phase 5 with mean		
		ADD5: begin
				state <= ADD6;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_5 <= add_samples_5 >>> K;	// mean of the inputs samples phases 2
					add_samples_5 <= 36'd0;				// reset accumulator
				end
				else begin 
					// accumulate new sample 
					add_samples_5 <= $signed(add_samples_5) + $signed(in_sampl_5);
				end
			  end
		
		// ADD6: accumulates input 6 to accumulator 6 || updates output phase 6 with mean
		ADD6: begin
				state <= IDLE;
				if (rdy_update) begin					// if N samples were accumulated, outputs can be updated
					phaseout_6 <= add_samples_6 >>> K;	// mean of the inputs samples phases 2
					add_samples_6 <= 36'd0;				// reset accumulator
				end
				else begin 
					// accumulate new sample 
					add_samples_6 <= $signed(add_samples_6) + $signed(in_sampl_6);
					if(cnt_samples == 0 && updating_out == 0) begin
						rdy_update <= 1;
					end
				end
			 end
		endcase
		
		// condition that translates that all Nth samples are added to the accumulators 
		// and the round that updates the outputs can start
		if(rdy_update && add_samples_5 == 36'd0) begin	
			rdy_update <= 0;	// end of Nth round
			updating_out <= 1;	// start updating round
		end
		
	end
end

// decreasing counter of N samples
always @(posedge clock)
begin
	if (reset) begin
			cnt_samples <= N;
	end
	else begin
		// new input sample
		if (enable) begin
			// if it is the Nth sample, resets counter
			if ( cnt_samples == 0 ) begin
				cnt_samples <= N; 
			end
			// else decreases counter
			else begin
				cnt_samples <= cnt_samples - 1;	
			end
		end
	end
end

endmodule

