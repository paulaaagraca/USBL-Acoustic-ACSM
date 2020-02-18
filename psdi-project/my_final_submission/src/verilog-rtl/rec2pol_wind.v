
/*
    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module rec2pol - Converts rectangular coords to polar coords using the CORDIC algorithm
	
	Summary
	This module implements the CORDIC algorithm in vectoing mode to 
	convert the rectangular coordinates of a vector to polar coordinates.
	
	The inputs X and Y are 32 bit integers representing the X and Y coordinates
	with 16 integer bits and 16 fractional bits (16Q16 format)
	
	The outputs are the modulus represented in the same format and the 
	angle represented in degrees with 8 integer bits and 24 fractional bits
	
	Input range:
	The input X must be positive and less than 32767;
    The Y input can be positive or negative in the interval [-32768, 32767];
	The output modulus cannot exceed the 16-bit maximum positive in two's complement (32767)
	  
	----------------------------------------------------------------------	
	Date created: 4 Oct 2019
	Author: jca@fe.up.pt
	
	----------------------------------------------------------------------	
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
*/

module rec2pol_wind( 
            input clock,
				input reset,
				input start,               // set to 1 for one clock to start			
				input  signed [15:0] x,    // X component, 6Q10
				input  signed [15:0] y,    // Y component, 6Q10
				output signed [15:0] mod,  // Module, 6Q10
				output signed [15:0] angle // Angle in degrees, 9Q7
			  );
			  
wire [4:0] count;
wire signed[15:0] data;

reg signed[17:0] xr, yr; 
reg signed[18:0] zr;

ITERCOUNTER  intercounter_1(
	.clock (clock),	
	.reset (reset),
	.enable(enable),
	.start (start),
	.count (count)	
			);

ATAN_ROM atan_rom_1 (
	.addr(count),
	.data(data)
			);
			
MODSCALE modscale_2 (
	.XF(xr),
	.MODUL(mod)
			);

// D-Q registers
always @ (posedge clock)
begin
if (reset) begin
	xr <= 18'd0;
	yr <= 18'd0;
	zr <= 19'd0;
end
else if(enable) begin
	if (start) begin
		xr <= $signed(x); //$signed({{2{x[15]}},x})
		yr <= $signed(y); //$signed({{2{y[15]}},y})
		zr <= 19'd0;
	end
	else begin
		//$display("%d %d %d %d %d", xr, yr, zr, mod, count);
		xr <=(yr[17] ? xr - (yr >>> count) : xr + (yr >>> count));
		yr <= (yr[17] ? yr + (xr >>> count) : yr - (xr >>> count));
		zr <= (yr[17] ? zr - ($signed({1'd0, data})) : zr + ($signed({1'd0, data})));
	end
end
end

assign angle = $signed(zr[18:3]);
		   
endmodule
// end of module rec2pol
