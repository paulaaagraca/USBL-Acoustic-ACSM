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
				input  signed [128:0] x,    // X component, 16Q16
				input  signed [128:0] y,    // Y component, 16Q16
				//output signed [31:0] mod,  // Modulus, 16Q16
				output signed [18:0] angle // Angle in degrees, 9Q10
			  );
			  
parameter insize = 9'd129;
// ROM address is the iteration counter:
wire [5:0] icnt; 	// ROM size = 16

// ROM data out:
wire [15:0] rom_data; //ROM entries => 16 bits
			  
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
reg signed [insize+9:0] xr, yr; //129 bits + 10 decimal
reg signed [18:0] zr; //9Q10

// Main datapath:
always @(posedge clock)
if ( reset )
begin
  xr <= 139'd0;
  yr <= 139'd0;
  zr <= 19'd0;
end
else
begin
  if ( enable )
  begin
    if ( start )
    begin
      xr <= $signed({x,10'd0});
	  yr <= $signed({y,10'd0});
	  zr <= 19'd0;
    end
    else
    begin
      xr <= ~yr[insize+9] ? xr + (yr >>> icnt) : xr - (yr >>> icnt);
      yr <= ~yr[insize+9] ? yr - (xr >>> icnt) : yr + (xr >>> icnt);
	  zr <= ~yr[insize+9] ? zr + ( $signed({1'd0, rom_data}) ) : zr - ( $signed({1'd0, rom_data}) );
    end
  end
end

assign angle = zr ;

/* 
// output scaling of the modulus:
MODSCALE MODSCALE_1(
                 .XF( xr ),
				 .MODUL( mod )
			   ); 
*/
		
endmodule