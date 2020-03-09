/*
    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module ATAN_ROM - ROM pre-loaded with the arctangent( 2^-i )
	
	Summary
	This module implements the arc-tangent lookup-table (a ROM) required
	for the sequential CORDIC module. The initialization datafile is located 
	in folder ../simdata is created by the Matlab program ../matlab/genatanlut.m
	
	Two data files can be used to initialize the lookup-table, depending on
	the desired angle units (degrees or radians). The file is set by 
	the parameter ATANLUT_FILENAME:
	
	"../simdata/atanLUTd.hex": the arctangents in degrees, represented 
	with 8 integer bits and 24 fractional bits
	
	"../simdata/atanLUT.hex": the arctangents in radians, represented 
	with 1 integer bit and 31 fractional bits
	
	----------------------------------------------------------------------	
	Date created: 4 Oct 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
*/

// ROM of size 16, with 16 bits each entries
module ATAN_ROM(
                 input  [ 5:0] addr,
				 output [15:0] data
			   );
		
parameter ROMSIZE = 16;
parameter ATANLUT_FILENAME = "atanLUTd.hex";	

reg [15:0] atanLUT[ 0 : ROMSIZE-1 ];	
initial
begin
  $readmemh( ATANLUT_FILENAME, atanLUT );
end		

assign data = atanLUT[ addr ];  
			
endmodule	
// end of module ATAN_ROM		   