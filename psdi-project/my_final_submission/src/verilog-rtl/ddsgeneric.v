`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*

DDS reference design
 
jca@fe.up.pt, Sep 2019

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
	
	Sampling frequency: Fs
	Number of samples in sine table: Nsamples
	Number of bits of table address: Nbitsaddr = Log2( Nsamples )
	
	Output frequency: F = Fs / Nsamples * phaseinc
	Input phase increment: phaseinc = Nsamples * F / Fs
	Minimum output frequency unit: = Fs / Nsamples * ( 2^ ( -( 32 - Nbitsaddr ) ) )
	
	Example: 
	Nsamples = 512, Nbitsaddr = 9
	Fs = 48000 Hz
	Fout = 2000 Hz => phaseinc = 21.3(3) 
	  phase int with 22 bit fracional part =  21.33333337306976
	  output frequency =  2000.000003725290 Hz
 
*/
//////////////////////////////////////////////////////////////////////////////////
module ddsgeneric( 
            input clock,
            input reset,
			input enable,
			input enableclk,
			input [31:0] phaseinc,
			input signed [31:0] phaseoffset, // phase offset
			output reg [17:0] outsine
    );
	 
// Always define the LUT with 32 bits	 
reg signed [17:0] sineLUT[0:4095];

initial
begin
  $readmemh("../simdata/DDSLUT.hex", sineLUT );
end

reg signed  [32-1:0] phasereg;
wire signed [32-1:0] phasetotal;
wire [12-1:0] lutaddress;
assign phasetotal = phasereg + phaseoffset;
assign lutaddress = phasetotal[31:20];

always @(posedge clock)
if ( reset )
begin
  phasereg <= {12'h800,20'd0}; // Start the phase register in 180º
  outsine  <= 18'd0;
end
else
begin
  if ( enableclk )
  begin
    phasereg <= phasereg + phaseinc;
    outsine  <= enable ? sineLUT[ lutaddress ] : 18'd0;
  end
end


endmodule
