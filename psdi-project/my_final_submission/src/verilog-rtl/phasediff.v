`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

 module phasediff(
    input clk,
    input reset,
	 input data_rdy,	// external enable may be used
    input signed [18:0] in_phase1,	// 9Q10
    input signed [18:0] in_phase2,	// 9Q10
    output reg signed [18:0] out		// 9Q10
    );

wire signed [19:0] diff; 	  // 10Q10 [-360,360]

assign diff = in_phase1 - in_phase2;

always @(posedge clk)
begin
	if (reset) begin
		out <= 0;
	end
	else if (data_rdy) begin
		if (diff > $signed({10'd180,10'd0})) begin  //when diff > 180
			out <= diff - $signed({10'd360,10'd0});
		end
		else if(diff < -$signed({10'd180,10'd0})) begin	 //when diff < -180
			out <= diff + $signed({10'd360,10'd0});
		end
		else begin
			out <= $signed(diff[18:0]);
		end
	end
	else begin
		out <= out;
	end
end

endmodule
