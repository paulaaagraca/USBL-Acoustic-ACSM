/*
    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	Module ITERCOUNTER - 6 bit binary counter
	
	Summary
	This module implements a 6-bit binary counter with synchronous reset,
	enable and re-start control. This is intended to be used as the iteration
	counter for the CORDIC algorithm. The counter output is also the address
	of the arctangent ROM (module ATAN_ROM).
		
	----------------------------------------------------------------------	
	Date created: 4 Oct 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
*/

module ITERCOUNTER(
             input clock,
				 input reset,
				 input start,
				 output enable,
				 output reg [4:0] count
			   );
		
// CORDIC iteration counter:
always @(posedge clock)
if ( reset )
begin
  count <= 5'd16;
end
else begin
	if ( start ) begin
		count <= 5'd0;
	end
	else begin
		if(count != 5'd16) begin
			count <= count + 1;
		end
	end
end

assign enable = (start | count < 5'd16);

endmodule
// end of module ITERCOUNTER		   