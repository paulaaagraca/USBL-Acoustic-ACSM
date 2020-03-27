`timescale 1ns/1ps

/*
	Module hilbert_chain - rotating register chain of length order_hf+1 

	This module receives one input that is saved in the first register of 
	the chain which provokes the shift of all other values to the next register.
	When the input value is back in the first register, then one full circular 
	shift has been performed and the system waits until new input arrives.

*/

module hilbert_chain (
		input clock,				 // global clock
		input reset,				 // global reset
		input enable,				 // enables new input
		input cnt_stop,			 	 // active when counter = 0 (finishes)
		input [15:0] in,	 	 	 // input sample
		output reg signed [15:0] re, // real 
		output signed [15:0] out	 // last register of chain
);

// Hilbert Filter coefficients: 1Q10	
parameter ha = 11'd245, //0.2392578125
		  hb = 11'd641; //0.6259765625

// Hilbert Filter (8 order): 9 register chain 
parameter order_hf = 8;		      // hilbert filter order
reg signed [15:0] xa [0:order_hf]; // array of registers for hilbert filter

// auxiliar signals
integer i, j, k;	// integers used in for loops


// Hilbert filter register chain logic:
always @(posedge clock)
begin
		if (reset) begin
		re  <= 28'd0;
		for(i=0; i<=order_hf; i=i+1)
			xa[i] <= 16'd10 + i;
	end
	// multiplexer chooses between 'uploading new input' or 'computing circular shift'
	else begin
		// upload input
		if (enable) begin
			//re <= $signed({xa[2],12'b000_000_000_000});	// 28b = 16+12
			re <= $signed(xa[2]);
			xa[0] <= in;
			for(j=1; j<=order_hf; j=j+1)
				xa[j] <= xa[j-1];
		end
		// circular shift
		else if (!cnt_stop) begin 
			xa[0] <= xa[order_hf];
			for(k=1; k<=order_hf; k=k+1)
				xa[k] <= xa[k-1];
		end
	end
end

// assing output as last register of the chain
assign out = xa[order_hf];

endmodule
