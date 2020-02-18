//-------------------------------------------------------------------------------
/*

Testbench for the ultrasonic wind sensor main signal processing path.
 
jca@fe.up.pt, Dec 2019

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
 
*/

`timescale 1ns/1ps

module winddir_tb;

parameter CLOCK_PERIOD = 500; // ns, 2 MHz

parameter MAXSIMDATA = 2000; // Number of input samples

// data filenames:
parameter
  // Input signals, 12 bits signed:
  rxuwX_filename = "../simdata/data_rx2.hex", // upwind along X (left receiver)
  rxdwX_filename = "../simdata/data_rx4.hex", // downwind along X (right receiver)
  rxuwY_filename = "../simdata/data_rx3.hex", // upwind along Y (bottom receiver)
  rxdwY_filename = "../simdata/data_rx1.hex", // downwind along Y (top receiver)
  
  params_filename = "../simdata/params.hex";   // simulation parameters	


  
// arrays for simulation data:
// Input signals, 12 bits signed:
reg signed [11:0]  vrxuwX[0:MAXSIMDATA-1];
reg signed [11:0]  vrxdwX[0:MAXSIMDATA-1];
reg signed [11:0]  vrxuwY[0:MAXSIMDATA-1];
reg signed [11:0]  vrxdwY[0:MAXSIMDATA-1];

reg        [ 7:0]  vparams[0:0];            // configuration parameters. For now only the length of the 
                                            // averaging filter (log2 of this value, 6 to 11)

reg  [3:0] spdmeanlen;  // log2( length_of_phase_averaging_filter ), read from params file

// Load simulation data files:
initial
begin
  $readmemh( rxuwX_filename, vrxuwX );
  $readmemh( rxdwX_filename, vrxdwX );
  $readmemh( rxuwY_filename, vrxuwY );
  $readmemh( rxdwY_filename, vrxdwY );
 
  $readmemh( params_filename, vparams );
  spdmeanlen = vparams[0];
end  
  
  
reg clock, reset;
reg [4:0] clkdiv;
wire      endata;
	
// generate the 2 MHz clock:	
initial
begin
  clock <= 0;
  # (CLOCK_PERIOD * 1.3 );
  forever # (CLOCK_PERIOD/2)
    clock = ~clock;
end

// generate the powerup reset:
initial
begin
  reset <= 0;
  clkdiv <= 0;
  # (CLOCK_PERIOD * 1.7 );
  @(negedge clock);
  reset <= 1;
  @(negedge clock);
  reset <= 0;
end

// the data enable sync pulse, one clock period @ 100 kHz
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

// main simulation task:
reg [11:0] rx1, rx2, rx3, rx4;
integer i;
initial
begin
  # 1;
  @( negedge reset );
  # 1;
  @( negedge clock );
  
  // apply input data:
  for (i=0; i< MAXSIMDATA; i = i + 1 )
  begin
    @(posedge endata); // When endata is high apply a new input sample:
	rx1 = vrxdwY[i];
	rx3 = vrxuwY[i];
	rx4 = vrxdwX[i];
	rx2 = vrxuwX[i];
  end
  repeat (100)
    @(negedge clock);
  $stop;
end

// The circuit under verification
// Inputs are the 4 acoustic signals, 12-bit, Fs=100 kHz
// The outputs are the two wind speeds along X and Y
wire signed [15:0] speedX, speedY;
wire speeden;

winddirectionXY  #( .MAXSIMDATA( MAXSIMDATA) )
               winddirectionXY_1
               (
                  .clock( clock ),
				  .reset( reset ),
				  .endata( endata ),
				  .rx1( rx1 ),
				  .rx2( rx2 ),
				  .rx3( rx3 ),
				  .rx4( rx4 ),
				  .spdmeanlen( spdmeanlen ),  // The length of the speed averaging filter
				  .speedX( speedX ),   // wind speed along X, 16 bits, 10 fractional
				  .speedY( speedY ),   // wind speed along Y, 16 bits, 10 fractional
				  .speeden( speeden )  // 1-clock pulse to sync with speedX/Y updates
			   );

real speedfracX;			   
real speedfracY;		

always @(posedge speeden)
begin
  speedfracX = real'(speedX) / (1 << 10);
  speedfracY = real'(speedY) / (1 << 10);	   
end

endmodule

