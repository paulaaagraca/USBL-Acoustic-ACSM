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

module ITERCOUNTER_16(
                 input clock,
				 input reset,
				 input start,
				 input enable,
				 output reg [3:0] count
			   );
		
// CORDIC iteration counter:
always @(posedge clock)
if ( reset )
begin
  count <= 4'd0;
end
else
begin
  if ( enable )
  begin
    if ( start )
    begin
	  count <= 4'd0;
    end
    else
	begin
	  count <= count + 1;
    end
  end
end		
endmodule	
// end of module ITERCOUNTER		   