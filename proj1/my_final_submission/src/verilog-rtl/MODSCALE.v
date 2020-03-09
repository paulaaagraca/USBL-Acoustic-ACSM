/*
    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	Module MODSCALE - multiply by the CORDIC scale factor
	
	Summary
	This module implements the correction factor of the CORDIC algorithm
	The final X component computed by the CORDIC algorithm must be
	multiplied by the constant 0.607252935008882 to obtain the final
	vector modulus. This constant is represented in the 0Q18 format,
	using 18 fractional bits.
	
	----------------------------------------------------------------------	
	Date created: 4 Oct 2019
	Author: jca@fe.up.pt
	
	----------------------------------------------------------------------	
	
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
*/

module MODSCALE(
                 input  [17:0] XF,
					  output [15:0] MODUL
			   );
		
parameter CORDIC_SCALE_FACTOR = 50'd159188;

assign MODUL = ($signed({{33{XF[17]}},XF})* $signed( CORDIC_SCALE_FACTOR )) >>> 18;  //( $signed( { {24{XF[25]}},XF} ) * $signed( CORDIC_SCALE_FACTOR ) ) >>> 34;
			
endmodule	
// end of module MODSCALE		   
