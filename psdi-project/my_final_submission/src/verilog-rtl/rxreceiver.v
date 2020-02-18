/*
 
jca@fe.up.pt, Dec 2019

    

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
 
*/

`timescale 1ns/1ps

module rxreceiver
               (
                  input clock,
				  input reset,
				  output endata,
				  input  enout,
				  input  signed [31:0] phase1,       // signal phases relative to TX
				  input  signed [31:0] phase2,       // 12 integer bits, 20 fractional bits (?)
				  input  signed [31:0] phase3,
				  input  signed [31:0] phase4,
				  output signed [11:0] rx1,          // output channels: the sine waves received
				  output signed [11:0] rx2,          // at each RX
				  output signed [11:0] rx3,
				  output signed [11:0] rx4
			   );

	

// The data enable sync pulse, one clock period @ 100 kHz
reg [4:0] clkdiv;
always @(posedge clock)
begin
  if ( reset )
    clkdiv <= 5'd0;
  else
    if ( clkdiv == 5'd19 )
	  clkdiv <= 5'd0;
	else
	  clkdiv <= clkdiv + 1;
end

// the clock enale pulse
assign endata = (clkdiv == 5'd18); 

// The 4 sine wave generators:
// TXFREQ = 15000;
// parameter TXPHASEINC = TXFREQ / ( 100000 / 4096 ) * 2^20; // 20 fractional bits
parameter TXPHASEINC = 32'd644245094; // 15 KHz
//parameter TXPHASEINC = 32'd730144440; // 17 KHz
//parameter TXPHASEINC = 32'd816043786; // 19 kHz

// The DDS sine generator outputs 8 bits...
wire [17:0] rrx1, rrx2, rrx3, rrx4;

ddsgeneric ddsgeneric_1( 
            .clock( clock ),
            .reset( reset ),
			.enable( enout ),
			.enableclk( endata ),
			.phaseoffset( phase1 ),
			.phaseinc( TXPHASEINC ),
			.outsine( rrx1 )
           );
assign rx1 = rrx1[17:6];

ddsgeneric ddsgeneric_2( 
            .clock( clock ),
            .reset( reset ),
			.enable( enout ),
			.enableclk( endata ),
			.phaseoffset( phase2 ),
			.phaseinc( TXPHASEINC ),
			.outsine( rrx2 )
           );
assign rx2 = rrx2[17:6];

ddsgeneric ddsgeneric_3( 
            .clock( clock ),
            .reset( reset ),
			.enable( enout ),
			.enableclk( endata ),
			.phaseoffset( phase3 ),
			.phaseinc( TXPHASEINC ),
			.outsine( rrx3 )
           );
assign rx3 = rrx3[17:6];

ddsgeneric ddsgeneric_4( 
            .clock( clock ),
            .reset( reset ),
			.enable( enout ),
			.enableclk( endata ),
			.phaseoffset( phase4 ),
			.phaseinc( TXPHASEINC ),
			.outsine( rrx4 )
           );
assign rx4 = rrx4[17:6];

endmodule

				  