`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module phasediff - calculates the difference between multiplexed input phases

	This module receives 4 phases as input and multiplexes them in order to 
	calculate the difference between every pair of inputs.
	There are 6 outputs, one for each of the differences between the 4 inputs
	(pairs: 12, 13, 14, 23, 24, 34)
	
	-----------------------------------------------------------------------------	
	Date of creation: 13/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)

*/

module phasediff (
		input clock,					 // global clock
		input reset,					 // global reset
		input enable,					 // enables new input
		input signed [15:0] phase1, 	// phase 1
		input signed [15:0] phase2, 	// phase 2
		input signed [15:0] phase3, 	// phase 3
		input signed [15:0] phase4,  	// phase 4
		output reg signed [15:0] angle1,		// output angle 1
		output reg signed [15:0] angle2,		// output angle 2
		output reg signed [15:0] angle3,		// output angle 3
		output reg signed [15:0] angle4,		// output angle 4
		output reg signed [15:0] angle5,		// output angle 5
		output reg signed [15:0] angle6		// output angle 6
);

//FSM signals
reg [3:0] state;
parameter IDLE = 4'd0,
		  DIF12 = 4'd1,
		  DIF13 = 4'd2,
		  DIF14 = 4'd3,
		  DIF23 = 4'd4,
		  DIF24 = 4'd5,
		  DIF34 = 4'd6;


reg run_state;  		 // ative while operations are running
reg signed [15:0] ang1;	 // holds first operand of subtraction
reg signed [15:0] ang2;	 // holds second operand of subtraction
wire signed [31:0] diff; // difference between phases

// difference between 2 phases
assign diff = ang1 - ang2;

//	--------------------------------------------------------------------------------------------
//	FSM : calculates all the 6 differences between 4 phases
// 
//	- The inputs to be used in the calculation are updated in the previous state to the operation
//	- DIFxy state holds the calculation of the difference between phase x and phase y

always @(posedge clock)
begin
	if(reset) begin
		state <= IDLE;
		run_state <= 0;
		ang1 <= 16'd0; 
		ang2 <= 16'd0; 
		angle1 <= 16'd0;
		angle2 <= 16'd0;
		angle3 <= 16'd0;
		angle4 <= 16'd0;
		angle5 <= 16'd0;
		angle6 <= 16'd0;
	end
	else begin
	
		case (state)
			// IDLE : wait for new input; activates the calculation state (run_state high)
			IDLE : 	begin
						if (enable) begin
							state <= DIF12;
							ang1 <= phase1;
							ang2 <= phase2;
							run_state <= 1;
						end
					end
					
			// DIF12: difference between phase 1 and 2
			DIF12 :  begin
						if (run_state) begin
							state <= DIF13;
							ang1 <= phase1;
							ang2 <= phase3;
							angle1 <= diff[16:1];
						end
			        end
					
			// DIF13: difference between phase 1 and 3
			DIF13 :  begin
						if (run_state) begin
							state <= DIF14;
							ang1 <= phase1;
							ang2 <= phase4;
							angle2 <= diff[16:1];
						end
			        end
					
			// DIF14: difference between phase 1 and 4
			DIF14 :  begin
						if (run_state) begin
							state <= DIF23;
							ang1 <= phase2;
							ang2 <= phase3;
							angle3 <= diff[16:1];
						end
			       end
				   
			// DIF23: difference between phase 2 and 3
			DIF23 :  begin
						if (run_state) begin
							state <= DIF24;
							ang1 <= phase2;
							ang2 <= phase4;
							angle4 <= diff[16:1];
						end
			        end
					
			// DIF24: difference between phase 2 and 4
			DIF24 :  begin
						if (run_state) begin
							state <= DIF34;
							ang1 <= phase3;
							ang2 <= phase4;
							angle5 <= diff[16:1];
						end
			        end
					
			// DIF34: difference between phase 3 and 4	
			DIF34 :  begin
						run_state <= 0;
						if (run_state) begin
							state <= IDLE;
							angle6 <= diff[16:1];
							run_state <= 0;
						end
			        end
		endcase	
	end
end 

endmodule
