//-------------------------------------------------------------------------------
/*

Testbench for the digital ultrasonic wind sensor 
 
jca@fe.up.pt, Nov 2018 / Nov 2019

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
 
*/

`timescale 1ns/1ps

module s6base_tb;

parameter CLOCK_PERIOD    = 10; // The external 100 MHz clock
								

// clock and reset:
reg				clk100M, reset_n;
 
// push buttons:
wire				btnu, btnr, btnd, btnl, btnc;
reg       [4:0]     btns;

// slide switches:
wire				sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0;
reg       [7:0]     sws;

// LEDs:
wire 			    ld0, ld1, ld2, ld3, ld4, ld5, ld6, ld7;
wire      [7:0]     leds;

// RS232:
wire			rx, tx;


s6base_top s6base_top_1( 
				 //------------------------------------------------------------------
                 // main clock source:
                .clock100M(clk100M),	// master clock input (external oscillator 100MHz)
                .reset_n(reset_n),     // external reset, active low (red button on the ATLYS board)
				//------------------------------------------------------------------
                // push buttons: button down = logic 1 (no debouncing hw)
				.btnu( btnu ),			// button up
				.btnr( btnr ),
				.btnd( btnd ),
				.btnl( btnl ),			// button left
				.btnc( btnc ),          // button center

				//------------------------------------------------------------------
                // Slide switches:
				.sw0( sw0 ),
				.sw1( sw1 ),
				.sw2( sw2 ),
				.sw3( sw3 ),
				.sw4( sw4 ),
				.sw5( sw5 ),
				.sw6( sw6 ),
				.sw7( sw7 ),

				//------------------------------------------------------------------
				// LEDs: logic 1 lights the LED
				.ld7( ld7 ),			// LED 7 (leftmost)
				.ld6( ld6 ),
				.ld5( ld5 ),
				.ld4( ld4 ),
				.ld3( ld3 ),
				.ld2( ld2 ),
				.ld1( ld1 ),
				.ld0( ld0 ),			// LED 0 (rightmost)


				//------------------------------------------------------------------
				// Serial interface (RS232 port)
               .tx( tx ),			// tx data (output from the user circuit)
               .rx( rx )			// rx data (input to the user circuit)

				);


// define bit vectors for the buttons, switches and leds:
assign {btnu, btnr, btnd, btnl, btnc} = btns;
assign { sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0} = sws;
assign leds = { ld7, ld6, ld5, ld4, ld3, ld2, ld1, ld0};

// Local signals for UART connection:
reg             uart_txen;
wire            uart_rxready, uart_txready;
reg  [7:0]      uart_din;
wire [7:0]      uart_dout;



// Simulation model of the UART,
// fixed baudrate: 115200 baud, 8bit, 1 stop bit, no parity
uart_sim  uart_sim_1  
                ( 
				  .clock(clk100M),	    // master clock (100MHz)
                  .reset(~reset_n),		// master reset, assynchronous, active high
                  .tx(rx),				// tx data, connected to rx input
                  .rx(tx),				// rx data, connected to tx output
                  .txen(uart_txen),			// load data into transmit buffer and initiate a transmission
                  .txready(uart_txready),	// ready to receive a new byte to tx
                  .rxready(uart_rxready),	// data is ready at dout port
                  .dout(uart_dout),			// data out (received data)
                  .din(uart_din)				// data in (data to transmit)
                );

				
// Initialize inputs, generate the 100 MHz clock signal:
initial
begin
  clk100M = 0;
  reset_n = 1;
  btns = 5'b0000_0;
  sws  = 8'b0000_0000;
  uart_txen = 1'b0;
  uart_din = 8'd0;
  #1
  // Generate the 100 MHz clock:
  forever #(CLOCK_PERIOD/2) clk100M = ~clk100M;
end		

// generate the reset signal (note this is active low)
// Activate reset_n for more than 50 clock cycles
// our master clock is 2 MHz (50X slower than 100 MHz) and we need
// the reset active for a positive clock transition.
// Keep the reset active for 200 clock cycles of the 100 MHz clock
// or 4 clock cycles of our 2 MHz clock
initial
begin
  # 2
  reset_n = 0;
  # 2000        // Wait 200 clock cycles of 100 MHz
  reset_n = 1;
end		


// Registers to hold the values read from the wind sensor:
reg signed [31:0] wspeed, wangle, spdX, spdY;
// Real variable to transform the values read to fracional values:
real rwspeed, rwangle, rspdX, rspdY;
real r7b = (1 << 7);
real r10b = (1 << 10);


// Main simulation thread:
initial
begin
  # 10
  
  // Wait the release of master reset:
  @(posedge reset_n);

  $display("----------------------------------------\n***START OF SIMULATION ***\n");
  // Wait some time, this is "only" 20 periods of the 2 MHz clock
  // or 1 sampling period
  repeat (1000)
    @(posedge clk100M);
	 
  // Write some data to ports 2, 3, 4 and 5 that are now loopback to the 
  // inputs ports 2, 3, 4 and 5, where the final results will be connected:
  WritePort(  14, 2 ); // Write to port address 2, the wind modulus 
  WritePort( -79, 3 ); // Write to port address 3, the wind angle
  WritePort(   5, 4 ); // Write to port address 4, the X wind speed 
  WritePort(  13, 5 ); // Write to port address 5, the Y wind speed
  
	 
  // Enable generation of	sine waves:
  WritePort( 1, 0 ); // Write 1 to port address 0 

  // Set the length of the speed averaging filter to 2^6 = 64
  WritePort( 6, 1 ); // Write 6 to port address 1  
	 
	 
  // Set the "wind" generator by sending the phase differences to be applyed
  // to the sine wave generators  
  // Use the Matlab scripts or the PC app to calculate 
  // the phase differences for a certain wind speed and directions
  // Some examples are:
  
  // ---- A "set wind - read results" cycle should repeat from here ...
  SetWind( 0, 32.0802 );  // Set wind to 5 m/s, angle 0 dgr
  
  // Wait 256 sampling periods. Each sampling period is 1000 clock cycles 
  // of the external clock (100 MHz). For a filter length of 64 this is enough
  // time to reach the steady state in the wind speed and direction results
  repeat ( 256 * 1000 )
    @(posedge clk100M);
	
  // Read results through the serial port:	
  ReadPort( wspeed, 1 );  // wind speed
  ReadPort( wangle, 2 );  // wind angle
  ReadPort( spdX, 3 );    // wind speed X component
  ReadPort( spdY, 4 );    // wind speed Y component
  
  // Convert to real number, only for visualization:
  rwspeed = wspeed / r7b;
  rwangle = wangle / r7b;
  rspdX   = spdX / r10b;
  rspdY   = spdY / r10b;
  
  $display(" Values read: Wspd: %f  Wangl: %f  SpdX: %f  SpdY: %f", 
                                      rwspeed, rwangle, rspdX, rspdY );

  // Wait some more time just to help observing the waveform results.
  repeat ( 100 * 1000 )
    @(posedge clk100M);

  // ---- ... to here

  SetWind( -16.3430,  18.0874 );  // Set wind to  3.8 m/s, angle 42.1 dgr
  
  // Wait 256 sampling periods. Each sampling period is 1000 clock cycles 
  // of the external clock (100 MHz). For a filter length of 64 this is enough
  // time to reach the steady state in the wind speed and direction results
  repeat ( 256 * 1000 )
    @(posedge clk100M);
	
  // Read results through the serial port:	
  ReadPort( wspeed, 1 );  // wind speed
  ReadPort( wangle, 2 );  // wind angle
  ReadPort( spdX, 3 );    // wind speed X component
  ReadPort( spdY, 4 );    // wind speed Y component
  
  // Convert to real number, only for visualization:
  rwspeed = wspeed / r7b;
  rwangle = wangle / r7b;
  rspdX   = spdX / r10b;
  rspdY   = spdY / r10b;
  
  $display(" Values read: Wspd: %f  Wangl: %f  SpdX: %f  SpdY: %f", 
                                      rwspeed, rwangle, rspdX, rspdY );

  // Wait some more time just to help observing the waveform results.
  repeat ( 100 * 1000 )
    @(posedge clk100M);


  $display("----------------------------------------\n***END OF SIMULATION ***\n");
  // Other examples:
  // SetWind( -35.7219,  73.3025 );  // Set wind to 12.7 m/s, angle 154.0 dgr
  // SetWind(  42.8892, -45.9957 );  // Set wind to 9.8 m/s, angle -137.0 dgr  
  // SetWind(  75.7013,  22.5433 );  // Set wind to 12.3 m/s, angle 73.4 dgr
  


  $stop;
end




task SetWind;
input real phasediff42, phasediff13;

reg signed [31:0] iphase1, iphase2, iphase3, iphase4;

begin
  
  // Phase 2 is set to 0, phase 4 is set to phasediff42
  iphase2 = 0;
  iphase4 = 11930465 * phasediff42;
  
  // Phase 3 is set to 0, phase 1 is set to phasediff13
  iphase3 = 0;
  iphase1 = 11930465 * phasediff13;

  // Send to hardware:
  WritePort( iphase1, 06 );
  WritePort( iphase2, 07 );
  WritePort( iphase3, 08 );
  WritePort( iphase4, 09 );

end
endtask

//------------------------------------------------------------------
// Interface to module IO ports:
// Write 32bit data to a port:
task WritePort;
input [31:0] data;
input [3:0]  port;
begin
  // send command WRITE:
  SendData( { 4'b0010, port } );
  // send data:
  SendData( data[31:24] );
  SendData( data[23:16] );
  SendData( data[15:8] );
  SendData( data[7:0] );
end
endtask


//------------------------------------------------------------------
// read 32 bit data from a port:
task ReadPort;
output [31:0] data;
input  [3:0]  port;
reg [7:0] b3, b2, b1, b0;
begin
  // send command READ:
  SendData( { 4'b0011, port } );
  GetData( b3 );
  GetData( b2 );
  GetData( b1 );
  GetData( b0 );
  data = { b3, b2, b1, b0};
end
endtask


//------------------------------------------------------------------
// Interface to UART
// Send one byte to the sim UART, wait for the end of transmission:
task SendData;
input [7:0] data;
begin
 #50
 uart_din = data; // set value at the UART input databus
 @(negedge clk100M);
 uart_txen = 1; // start transmission
 #20
 uart_txen = 0;
 @( posedge uart_txready ) // wait for the end of transmission
 #50; // wait more...
end
endtask

//------------------------------------------------------------------
// Interface to UART
// Read one byte from the sim UART, wait for the end of transmission:
task GetData;
output [7:0] data;
begin
  # 50
  @(negedge clk100M);
  // wait for a new byte received:
  while( uart_rxready == 1'b0 )
    @(negedge clk100M);
  data = uart_dout;
  #50;
end
endtask



endmodule

