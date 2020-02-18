/*

    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module rec2pol 
	
	Summary
	CORDIC vectoring mode - convert rectangular coords to polar coords
	
	----------------------------------------------------------------------	
	Date created: 1 Nov 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.

*/

module rec2pol( 
                input clock,
				input reset,
				input enable,              // set and keep high to enable iteration
				input start,               // set to 1 for one clock to start 
				input  signed [31:0] x,    // X component, 16Q16
				input  signed [31:0] y,    // Y component, 16Q16
				output signed [31:0] mod,  // Modulus, 16Q16
				output signed [31:0] angle // Angle in degrees, 8Q24
			  );
			  

// ROM address is the iteration counter:
wire [5:0] icnt;

// ROM data out:
wire [31:0] rom_data;
			  
ATAN_ROM  ATAN_ROM_1(
                 .addr( icnt ),
				 .data( rom_data )
			   );

// Iteration counter:
ITERCOUNTER ITERCOUNTER_1(
                 .clock(clock),
				 .reset(reset),
				 .start(start),
				 .enable(enable),
				 .count( icnt )
			   );

	
// Registers for the Cordic vectoring mode:
reg signed [33:0] xr, yr;
reg signed [31:0] zr;

// Main datapath:
always @(posedge clock)
if ( reset )
begin
  xr <= 34'd0;
  yr <= 34'd0;
  zr <= 32'd0;
end
else
begin
  if ( enable )
  begin
    if ( start )
    begin
      xr <= x;
	  yr <= y;
	  zr <= 32'd0;
    end
    else
    begin
      xr <= ~yr[33] ? xr + (yr >>> icnt) : xr - (yr >>> icnt);
      yr <= ~yr[33] ? yr - (xr >>> icnt) : yr + (xr >>> icnt);
	  zr <= ~yr[33] ? zr + ( $signed(rom_data) ) : zr - ( $signed(rom_data) );
    end
  end
end

assign angle = zr ;

// output scaling of the modulus:
MODSCALE MODSCALE_1(
                 .XF( xr ),
				 .MODUL( mod )
			   );
		
endmodule