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

module MODSCALE_16(
                 input  signed [17:0] XF,
			     output signed [15:0] MODUL
			   );

// this is 0.607252935008881 * 2^10	( int(621.8) )
parameter CORDIC_SCALE_FACTOR = 32'd622;

// execute the mult in 32 bits
assign MODUL = ( $signed( { {14{XF[17]}},XF} ) * $signed( CORDIC_SCALE_FACTOR ) ) >>> 10;
			
endmodule	
// end of module MODSCALE		   