/*

    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module phasecalc
	
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

module cordic_calc( 
                input clock,
				input reset,
				input enable,              // set and keep high to enable iteration
				input start,               // set to 1 for one clock to start 
				input  signed [15:0] x,    // X component, 6Q10
				input  signed [15:0] y,    // Y component, 6Q10
				output signed [15:0] mod,   // modulus, 6Q10
				output signed [15:0] angle // angle, 9Q7
			  );
			  

// ROM address is the iteration counter:
wire [3:0] icnt;

// ROM data out:
wire [15:0] rom_data;
			  
ATAN_ROM_16  ATAN_ROM_1(
                 .addr( icnt ),
				 .data( rom_data )
			   );

// Iteration counter:
ITERCOUNTER_16 ITERCOUNTER_1(
             .clock(clock),
				 .reset(reset),
				 .start(start),
				 .enable(enable),
				 .count( icnt )
			   );

	
// Registers for the Cordic vectoring mode:
reg signed [17:0] xr, yr;
reg signed [15:0] xini, yini;
reg signed [18:0] zr;

// register to hold the raw angle value in 19 bits:
wire signed [18:0] anglei;

// Main datapath:
always @(posedge clock)
if ( reset )
begin
  xr <= 18'd0;
  yr <= 18'd0;
  zr <= 19'd0;
  xini <= 16'd0;
  yini <= 16'd0;
end
else
begin
  if ( enable )
  begin
    if ( start )
    begin
      xr <= x[15] ? -x : x;   // Input the abs(x)
	  xini <= x;  // register initial y value
	  yr <= y;
	  yini <= y;  // register initial y value
	  zr <= 19'd0;
    end
    else
    begin
      xr <= ~yr[17] ? xr + (yr >>> icnt) : xr - (yr >>> icnt);
      yr <= ~yr[17] ? yr - (xr >>> icnt) : yr + (xr >>> icnt);
	  zr <= ~yr[17] ? zr + ( $signed( { 1'b0, rom_data} ) ) : zr - ( $signed( { 1'b0, rom_data} ) );
    end
  end
end

// Final correction to -180 +180:
/* if ( X0 < 0 )
    if ( Y0 < 0 )
        angxy = -180 - angxy;
    else
        angxy = 180 - angxy;
    end
end
 */
 
// Add an extra output register (ACTUALLY NOT NEEDED !) to avoid propagating the intermediate values of "angle"
// while CORDIC is executing. This delays the output of the phase data by 1 sampling period.
//always @(posedge clock)
//if ( reset )
//  anglei <= 19'd0;
//else
//  if ( start )
assign anglei = xini[15] ? ( yini[15] ? ( {-9'd180, 10'd0} - zr ) : ( {+9'd180, 10'd0} - zr ) ) : zr;

assign angle = anglei[18]? anglei[18:3] - anglei[2] : anglei[18:3] + anglei[2]; 	// added rounding

// output scaling of the modulus:
MODSCALE_16 MODSCALE_1(
                 .XF( xr ),
				 .MODUL( mod )
			   );
		
endmodule
