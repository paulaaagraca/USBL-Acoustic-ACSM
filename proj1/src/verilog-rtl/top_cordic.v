`timescale 1ns/1ps

module top_cordic (
		input clock,					 // global clock
		input reset,					 // global reset
		input enable,					 // enables new input
		input signed [27:0] re1, 		 // real hilbert_chain 1
		input signed [27:0] im1,	 // imaginary
		input signed [27:0] re2, 		 // real hilbert_chain 2
		input signed [27:0] im2,	 // imaginary
		input signed [27:0] re3, 		 // real hilbert_chain 3
		input signed [27:0] im3,	 // imaginary
		input signed [27:0] re4, 		 // real hilbert_chain 4
		input signed [27:0] im4,	 	 // imaginary
		output reg signed [15:0] phase1,  // phase 1
		output reg signed [15:0] phase2,  // phase 2
		output reg signed [15:0] phase3,  // phase 3
		output reg signed [15:0] phase4  // phase 4
);

reg state;
parameter IDLE = 4'd0,
		  C1   = 4'd1;
		//  C2   = 4'd2,
		//  C3   = 4'd3,
		//  C4   = 4'd4;
		
parameter in_bits = 6'd28;

reg [2:0] sel_in;
wire rdy_cordic;

wire [in_bits:0] x, y;

assign x = (sel_in == 3'd1)? re1 : ((sel_in == 3'd2)? re2 : ((sel_in == 3'd3)? re3 : re4));
assign y = (sel_in == 3'd1)? im1 : ((sel_in == 3'd2)? im2 : ((sel_in == 3'd3)? im3 : im4));

//instanciate 1 cordic module and use generic x and y
// cordic sents signal that indicates that is calculation ready -> rdy_cordic

always @(posedge clock)
begin
	if(reset) begin
		state <= IDLE;
		sel_in <= 3'd0;
	end
	else begin	
		case (state)
			IDLE : 	begin
						if (enable) begin
							state <= C1;
							sel_in <= 3'd1;
						end
						else if (sel_in != 3'd0) begin
							state <= C1;
						end
					end

			C1 :	begin
						if (rdy_cordic) begin
							state <= IDLE;
							if (sel_in == 3'd4) begin
								sel_in <= 3'd0;
							end 
							else begin
								sel_in <= sel_in + 3'd1;
							end
						end
					end
					
		
		endcase
	end
end

endmodule
