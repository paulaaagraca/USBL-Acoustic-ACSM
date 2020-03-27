`timescale 1ns/1ps

/* -------------------------------------------------------------------------------
	Module top_cordic - CORDIC for multiplexed inputs and outputs
	
	This model uses one CORDIC system to cumpute the calculations for each of the 
	selected input pair [rex,imx]. 
	A 2 states FSM is used to select the inputs and output to be used in each round
	of CORDIC calculations.

	-----------------------------------------------------------------------------	
	Date of creation: 06/03/2020
	Author: Paula Graça (paula.graca@fe.up.pt)

*/

module top_cordic (
		input clock,					 // global clock
		input reset,					 // global reset
		input enable,					 // enables new input
		input signed [15:0] re1, 		 // real hilbert_chain 1
		input signed [15:0] im1,	 	 // imaginary
		input signed [15:0] re2, 		 // real hilbert_chain 2
		input signed [15:0] im2,		 // imaginary
		input signed [15:0] re3, 		 // real hilbert_chain 3
		input signed [15:0] im3,		 // imaginary
		input signed [15:0] re4, 		 // real hilbert_chain 4
		input signed [15:0] im4,	 	 // imaginary
		output reg signed [15:0] phase1, // phase 1
		output reg signed [15:0] phase2, // phase 2
		output reg signed [15:0] phase3, // phase 3
		output reg signed [15:0] phase4  // phase 4
);

// FSM 
reg state;
parameter IDLE = 4'd0,
		  RUN_CORDIC = 4'd1;


// 5 state alternative FSM
//reg start_cordic;
//reg [3:0] state;
//		  C1   = 4'd1,
//		  C2   = 4'd2,
//		  C3   = 4'd3,
//		  C4   = 4'd4;

reg [2:0] sel_in;
wire busy_cordic;
wire start_cordic;


wire signed [15:0] x, y;
wire signed [4:0] aux_x, aux_y;

// generic output for cordic module
wire signed [15:0] mod;
wire signed [15:0] ang;

// select input x of cordic module, according to multiplexed inputs
assign x = (sel_in == 3'd1)? re1 : ((sel_in == 3'd2)? re2 : ((sel_in == 3'd3)? re3 : re4));

// select input y of cordic module, according to multiplexed inputs
assign y = (sel_in == 3'd1)? im1 : ((sel_in == 3'd2)? im2 : ((sel_in == 3'd3)? im3 : im4));

//instanciate 1 cordic module with generic x and y
cordic cordic_1( 
                .clock(clock),
				.reset(reset),
				.start(start_cordic),   // set to 1 for one clock to start 
				.busy(busy_cordic), 	// 1: module is busy and does not accept new inputs
				.x(x),    				// X component, 6Q10
				.y(y),    				// Y component, 6Q10
				.angle(ang),			// Angle in degrees, 9Q7
				.mod(mod)  				// modulus, 6Q10
			  );

//start signal to enable cordic module
 assign start_cordic = enable | (state == IDLE && sel_in != 3'd0);

/* --------------------------------------------------------------------------
	FSM controller which multiplexes cordic outputs
		- IDLE : waits for new/next input to the cordic module
		- RUN_CORDIC   : while cordic is running; selects output that holds cordic angle 
	
*/
always @(posedge clock)
begin
	if(reset) begin
		state <= IDLE;
		sel_in <= 3'd0;
		phase1 <= 16'd0;
		phase2 <= 16'd0;
		phase3 <= 16'd0;
		phase4 <= 16'd0;
	end
	else begin	
		case (state)
			// IDLE : wait for new external outputs or next multiplexed input 
			IDLE : 	begin
						if (enable) begin
							state <= RUN_CORDIC;
							//sel_in <= 3'd1;
						end
						else if (sel_in != 3'd0) begin //if not all 4 inputs were computed in cordic
							state <= RUN_CORDIC;
						end
					end
			// RUN_CORDIC : stays in this state while cordic module is calculating output for selected input
			RUN_CORDIC :	begin
						if (busy_cordic) begin					// if cordic calculations are finished
							state <= IDLE;
							if (sel_in == 3'd4) begin			// if input number 4 (last) is selected
								sel_in <= 3'd0;
								phase4 <= ang;
							end 
							else begin
								sel_in <= sel_in + 3'd1;
								if (sel_in == 3'd1) begin		// if input number 1 is selected
									phase1 <= ang;
								end
								else if (sel_in == 3'd2) begin	// if input number 2 is selected
									phase2 <= ang;
								end
								else if (sel_in == 3'd3) begin // if input number 3 is selected
									phase3 <= ang;
								end
							end
						end
					end
		endcase
	end
end

//5 state alternative FSM 
/*
always @(posedge clock)
begin
	if(reset) begin
		state <= IDLE;
		sel_in <= 3'd0;
		phase1 <= 16'd0;
		phase2 <= 16'd0;
		phase3 <= 16'd0;
		phase4 <= 16'd0;
	end
	else begin	
		case (state)
			IDLE : 	begin
			            sel_in <= 0;
						if (enable) begin
							state <= C1;
							start_cordic <= 1'b1;
							//sel_in <= 3'd1;
						end
					end
			C1   :  begin
			          start_cordic <= 0;
			          if ( busy_cordic )
					  begin
					    phase1 <= ang;
						sel_in <= 1;
						start_cordic <= 1;
						state <= C2;
					  end
			        end

			C2   :  begin
			          start_cordic <= 0;
			          if ( busy_cordic )
					  begin
					    phase2 <= ang;
						sel_in <= 2;
						start_cordic <= 1;
						state <= C3;
					  end
			        end

			C3  :  begin
			          start_cordic <= 0;
			          if ( busy_cordic )
					  begin
					    phase3 <= ang;
						sel_in <= 3;
						start_cordic <= 1;
						state <= C4;
					  end
			        end

			C4   :  begin
			          start_cordic <= 0;
			          if ( busy_cordic )
					  begin
					    phase4 <= ang;
						sel_in <= 0;
						// start_cordic <= 1;
						state <= IDLE;
					  end
			        end
			endcase
		end
	end
*/

endmodule
