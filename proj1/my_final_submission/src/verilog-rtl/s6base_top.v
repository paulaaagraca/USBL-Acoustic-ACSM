/*

Generic top level module for the Atlys Board
 
jca@fe.up.pt, Nov 2015 - Nov 2016 - Nov 2017 - Nov 2018 - Nov 2019...

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
 
*/

`timescale 1ns/1ps

module s6base_top( 
								//------------------------------------------------------------------
                        // main clock sources:
                        clock100M,	// master clock input (external oscillator 100MHz)
                        reset_n,        // external reset, active low
						//------------------------------------------------------------------
                        // push buttons: button down = logic 1 (no debouncing hw)
						btnu,			// button up
						btnr,
						btnd,
						btnl,			// button left
						btnc,           // button center

						//------------------------------------------------------------------
                        // Slide switches: up position = logic 1
						sw0,
						sw1,
						sw2,
						sw3,
						sw4,
						sw5,
						sw6,
						sw7,

						//------------------------------------------------------------------
						// LEDs: logic 1 lights the LED
						ld7,			// LED 7 (leftmost)
						ld6,
						ld5,
						ld4,
						ld3,
						ld2,
						ld1,
						ld0,			// LED 6 (rightmost)


						//------------------------------------------------------------------
						// Serial interface (RS232 port)
                        tx,			// tx data (output from the user circuit)
                        rx			// rx data (input to the user circuit)

						);
								
// clocks:
input				clock100M, reset_n;
 
// push buttons:
input				btnu, btnr, btnd, btnl, btnc;

// slide switches:
input				sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0;

// LEDs:
output 			ld0, ld1, ld2, ld3, ld4, ld5, ld6, ld7;

// RS232:
input			rx;
output			tx;


// global synchronous reset, active high
reg			reset_d, reset;

// UART local signals:
wire        txen, rxready, txready;

// data bus between UART and the command interpreter:
wire [ 7:0] din, dout;

// General 32-bit I/O ports:
wire [31:0] P0out, P1out, P2out, P3out,
            P4out, P5out, P6out, P7out,
			P8out, P9out, PAout, PBout,
			PCout, PDout, PEout, PFout; // output ports (32 bits)
			
wire [31:0] P0in,  P1in,  P2in,  P3in,
            P4in,  P5in,  P6in,  P7in;  // input ports (32 bits)

 
// Clock divider, manual counter because DCM does not support the 2 MHz output clock.
reg [5:0] clkdiv;
reg uregclk;
initial clkdiv = 0;
initial uregclk = 0;

// The 2 MHz clock
wire clock;

always @(posedge clock100M)
if ( clkdiv == 49 )
begin
  clkdiv <= 0;
  uregclk <= 1'b1;
end
else
begin
  clkdiv <= clkdiv + 6'd1;
  uregclk <= 1'b0;  
end
  
BUFG bufg_clk( .I( uregclk ), .O( clock ) );

// Synchronize the external reset:
always @(posedge clock)
begin
  reset_d <= ~reset_n;
  reset   <= reset_d;
end

// SUART (simple USART: 115200 baud, 8bit, 1 stop bit, no parity):
uart  #(  .INPUT_CLOCK_FREQUENCY(2_000_000), // master clock frequency, Hz
          .TX_BAUD_RATE(115_200),     // transmit baudrate
		    .RX_BAUD_RATE(115_200)      // receive baudrate
        ) 
		  uart_1 ( 
				   .clock(clock),	// master clock (100MHz)
               .reset(reset),			// master reset, assynchronous, active high
               .tx(tx),					// tx data, connected to rx input
               .rx(rx),					// rx data, connected to tx output
               .txen(txen),			// load data into transmit buffer and initiate a transmission
               .txready(txready),	// ready to receive a new byte to tx
               .rxready(rxready),	// data is ready at dout port
               .dout(dout),			// data out (received data)
               .din(din)				// data in (data to transmit)
                );


// Command interpreter:
ioports ioports_1
                 ( 
				   .clk(clock),	// master clock 
               .reset(reset),		// master reset, assynchronous, active high
               
               .load(rxready),		// load enable for din bus
               .ready(txready),		// ready to consume dout data
               .enout(txen),			// enable loading of dout data
               
               .datain(dout),		// data in bus (8 bits), from USART
               .dataout(din),		// data out bus (8 bits), to USART
               
               .in0(P0in),		  
               .in1(P1in),			
               .in2(P2in),        
               .in3(P3in),			
               .in4(P4in),		  
               .in5(P5in),			
               .in6(P6in),        
               .in7(P7in),			
               
               .out0(P0out),			// P0 output port (32 bits)
               .out1(P1out),			
               .out2(P2out),			
               .out3(P3out),			
                   				 
				   .out4(P4out), 		
				   .out5(P5out),
				   .out6(P6out),
				   .out7(P7out),
                   
				   .out8(P8out), 					 
				   .out9(P9out),
				   .outa(PAout),
				   .outb(PBout),
                   
				   .outc(PCout), 					 
				   .outd(PDout),
				   .oute(PEout),
				   .outf(PFout)            // PF output port has automatic return to zero
					);



wire [11:0] rx1, rx2, rx3, rx4;
wire        endata;
wire        enableout;
	 
rxreceiver  rxreceiver_1
               (
              .clock( clock ),
				  .reset( reset ),
				  .endata( endata ),       // Output, syncs the rxi signals (100.000 kHz)
				  .enout( enableout ),     // Input, enable/disable the generation of outputs.
				  .phase1( P6out ),        // signal phases relative to TX
				  .phase2( P7out ),        // 12 integer bits, 20 fractional bits
				  .phase3( P8out ),
				  .phase4( P9out ),
				  .rx1( rx1 ),          // output channels: the sine waves received
				  .rx2( rx2 ),          // at each RX, 18 bits signed
				  .rx3( rx3 ),
				  .rx4( rx4 )
			   );

wire signed [15:0] speedX, speedY;
wire speeden;
wire [3:0] spdmeanlen; // This is the log2( the_length_of_averaging_filter )

// Instantiate the main datapath
winddirection  winddirection_1 
               (
              .clock( clock ),
				  .reset( reset ),
				  .endata( endata ),
				  .rx1( rx1 ),
				  .rx2( rx2 ),
				  .rx3( rx3 ),
				  .rx4( rx4 ),
				  .spdmeanlen( spdmeanlen ), // The length of the speed averaging filter
				  .speedX( speedX), 	 // wind speed along X, 16 bits, 10 fractional
				  .speedY(speedY ), 	 // wind speed along Y, 16 bits, 10 fractional
				  .speeden( speeden )  // 1-clock pulse to sync with speedX/Y updates
			   );
				
// Final modules should receive speedX and speedY and
// generate the signals windspeed and windangle:
wire [15:0] windspeed, windangle;

windrec2pol wind2pol(
    .clock(clock),
    .reset(reset),
    .data_rdy(speeden),
    .xspeed(speedX),
    .yspeed(speedY),
    .speed(windspeed),
    .direction(windangle)
    );


// For now assign these signals directly to output ports:
//assign windspeed = P2out << 7;
//assign windangle = P3out << 7;
//assign speedX    = P4out << 10;
//assign speedY    = P5out << 10;

	
// Enable signal generation:
assign enableout = P0out[0];

// Length of the speed averaging filter
assign spdmeanlen = P1out[3:0];

// read output values
assign P1in = { {16{windspeed[15]}}, windspeed}; // Sign extension
assign P2in = { {16{windangle[15]}}, windangle}; // Sign extension
assign P3in = { {16{speedX[15]}}, speedX}; // Sign extension
assign P4in = { {16{speedY[15]}}, speedY}; // Sign extension


// NOT USED...
assign P0in = 32'd0;
assign P5in = 32'd0;
assign P6in = 32'd0;
assign P7in = 32'd0;


// LEDs connected to the 8 low bits of xin:
assign { ld7, ld6, ld5, ld4, ld3, ld2, ld1, ld0 } = 8'd0;
 
endmodule

