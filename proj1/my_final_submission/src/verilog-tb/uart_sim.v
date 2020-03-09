//-------------------------------------------------------------------------------
//  Simple usart with fixed configuration (1 start bit, 8 data bits, 1 stop bit, no parity)
//  baudrate is user defined (see configuration section below)
//  
//  jca@fe.up.pt,  Dec 2007-2014
//
//-------------------------------------------------------------------------------

`timescale 1ns/1ps

module uart_sim ( 
                clock,  // master clock
                reset,  // master reset, assynchronous, active high
                tx,     // output: tx data
                rx,     // input: rx data
                txen,   // input, active high: load data into transmit buffer and initiate a transmission, active high
                txready,// output, active high: ready to receive a new byte to tx
                rxready,// output, active high: data is ready at dout port
                dout,   // data out (received data)
                din     // data in (data to transmit)
              );
input        clock, reset, txen;
input        rx;
output       tx;
output       txready, rxready;

input  [7:0] din;
output [7:0] dout;

//---------------------------------------------------------------------------------
// Configure the USART
parameter INPUT_CLOCK_FREQUENCY = 100_000_000, // master clock frequency, Hz
          TX_BAUD_RATE          = 115_200,     // transmit baudrate
		  RX_BAUD_RATE          = 115_200,     // receive baudrate
		  BAUD_TX_COUNT         = (INPUT_CLOCK_FREQUENCY / TX_BAUD_RATE ) - 1,
		  BAUD_RX_COUNT         = (INPUT_CLOCK_FREQUENCY / RX_BAUD_RATE ) - 1,
		  NBITS_TX_COUNT        = 14,  // Number of bits required for BAUD_TX_COUNT
		  NBITS_RX_COUNT        = 14;  // The same for RX count
//---------------------------------------------------------------------------------

// output registers:
reg           txready, rxready;
reg     [7:0] dout;
reg           tx;

// state register for clock generator FSM:
reg           staterxbc, 
              statetxbc;
              
reg    [NBITS_RX_COUNT-1:0] baudrxcount, baudrxcount2;
reg    [ 3:0] bitrxcount;
reg    [NBITS_TX_COUNT-1:0] baudtxcount;
reg    [ 3:0] bittxcount;
reg           rx1, rx2, rx3;

// TX / RX shift registers:
reg    [8:0]  rxdata, txdata;

// State register for TX/RX serializer/deserializer
reg           staterx,
              statetx;
			  
// baud clock enable pulses:
wire          baudrxclock;
wire          baudtxclock;
wire          startrxbit;
reg           starttxbit;

// Auxiliary flipflop to hold the stopbit:
reg           r_stopbit;



// State encoding for clock divider FSM:
parameter IDLE       = 1'b0,
          CNT10P     = 1'b1;


// State encoding for receive FSM
parameter IDLERX     = 1'b0,
          RXDATA     = 1'b1;

// State encoding for transmit FSM
parameter IDLETX     = 1'b0,
          TXDATA     = 1'b1;


// these are the baudrate clock enable that synchronize the sampling of rx and tx data
assign baudrxclock = (baudrxcount == BAUD_RX_COUNT);
assign baudtxclock = (baudtxcount == BAUD_TX_COUNT);



// clock generator for rx baudrate, freerun
always @(posedge clock)
begin
  if ( reset )
  begin
    baudrxcount2 <= 0;
  end
  else
  begin
    if ( baudrxcount2 == ( BAUD_RX_COUNT / 2 ) )
	  baudrxcount2 <= 0;
	else
	  baudrxcount2 <= baudrxcount2 + 1;
  end
end


// clock generator for rx baudrate
// when startrxbit is asserted, initiate a baudrate clock 
always @(posedge clock)
begin
  if ( reset )
  begin
    baudrxcount <= 0;
    bitrxcount <= 0;
    staterxbc <= IDLE;
  end
  else
  begin
    case ( staterxbc )
      IDLE :        begin
                      bitrxcount <= 0;
                      if ( startrxbit )
                      begin
                        baudrxcount <= BAUD_RX_COUNT / 2; // half bit period
                        staterxbc <= CNT10P;
                      end
                      else
                      begin
                        staterxbc <= IDLE; // wait for startbit
                      end
                    end
                    
      CNT10P:       begin
                      if ( baudrxclock )
                      begin
                        if ( bitrxcount == 9 )
                        begin
                          staterxbc <= IDLE; // counts the 10th bit and stops
                        end
                        else
                        begin
                          staterxbc <= CNT10P;
                        end
                        
                        bitrxcount <= bitrxcount + 1; // counts bits up to 10
                        baudrxcount <= 0;
                      end
                      else
                        baudrxcount <= baudrxcount + 1; // increment baudrate counter
                    end
    endcase
  end
end


// clock generator for tx baudrate
// when starttxbit is asserted, initiate a baudrate clock 
always @(posedge clock)
begin
  if ( reset )
  begin
    baudtxcount <= 0;
    bittxcount <= 0;
    statetxbc <= IDLE;
  end
  else
  begin
    case ( statetxbc )
      IDLE :        begin
                      bittxcount <= 0;
                      if ( starttxbit )
                      begin
                        baudtxcount <= BAUD_TX_COUNT / 2; // half period for 115200 baud
                        statetxbc <= CNT10P;
                      end
                      else
                      begin
                        statetxbc <= IDLE; // wait for startbit
                      end
                    end
                    
      CNT10P:       begin
                      if ( baudtxclock )
                      begin
                        if ( bittxcount == 10 )
                        begin
                          statetxbc <= IDLE; // counts the 10th bit and stops
                        end
                        else
                        begin
                          statetxbc <= CNT10P;
                        end
                        
                        bittxcount <= bittxcount + 1; // counts bits up to 10
                        baudtxcount <= 0;
                      end
                      else
                        baudtxcount <= baudtxcount + 1; // increment baudrate counter
                    end
    endcase
  end
end



// three stage synchonizer for rx input signal
always @(posedge clock)
begin
  if ( reset )
  begin
    rx1 <= 0;
    rx2 <= 0;
    rx3 <= 0;
  end
  else
  begin
    rx1 <= rx;
    rx2 <= rx1;
    rx3 <= rx2;
  end
end


// generate the startbit signal (one clock period pulse) when the rx input changes from 1 to 0:
assign startrxbit = ( rx3 & ~rx2 ) & (bitrxcount == 0);


// input data shift-register (deserializer)
always @(posedge clock)
begin
  if ( reset )
  begin
    rxdata <= 0;
    staterx <= IDLERX;
    dout <= 0;
  end
  else
  begin
    case ( staterx )
      IDLERX:	begin // wait here for the start bit
                  rxready <= 0;
                  if ( startrxbit )
                    staterx <= RXDATA;
                  else
                    staterx <= IDLERX;
                end
                
      RXDATA:	begin
                  if ( baudrxclock ) // for each sampling point at baud clock
                  begin
                    if ( ( bitrxcount == 0 ) & (rx3 == 1'b1) ) // this was a false start bit, rx line is still high!
					begin
					  $display("Error: false start bit detected");
                      staterx <= IDLERX; // abort reception
					end
                    else
                    begin                       
                      rxdata <= {rx3, rxdata[8:1]}; // shift data in
                      if ( bitrxcount == 9 )  // this is the last bit, next bit should be the stop bit (logic one)
                      begin
                        if ( rx3 == 1'b0 ) // stop bit not detected, abort reception
						begin
						  $display("Error: Stop bit not detected");
                          staterx <= IDLERX;
						end
                        else
                        begin
                          dout <= rxdata[8:1];
                          rxready <= 1;
                          staterx <= IDLERX;
                        end
                      end
                    end
                  end
                end                
    endcase
  end
end


initial
begin
    txready <= 1;
    tx <= 1'b1;
	r_stopbit <= 1'b1;
end

// output data shift-register (serializer)
always @(posedge clock)
begin
  if ( reset )
  begin
    txdata <= 0;
    statetx <= IDLETX;
    starttxbit <= 0;
    txready <= 1;
    tx <= 1'b1;
	r_stopbit <= 1'b1;
  end
  else
  begin
    case ( statetx )
      IDLETX:	begin // wait here for entx
                  tx <= 1'b1;
                  if ( txen )
                  begin
                    statetx <= TXDATA;
                    txdata <= {r_stopbit,din}; // concatenate 1 stop bit
                    txready <= 0;
                    starttxbit <= 1;
                  end
                  else
                    statetx <= IDLETX;
                end
                
      TXDATA:	begin
                  starttxbit <= 0;
                  if ( baudtxclock ) // for each sampling point at baud clock
                  begin
                    if ( bittxcount == 0 )
                      tx <= 1'b0; // startbit
                    else
                    begin                       
                      if ( bittxcount == 10 ) 
                      begin
                        tx <= 1'b1; // transmission complete, set tx line to high
                        txready <= 1;
                        statetx <= IDLETX;
                      end
                      else
                      begin
                        tx <= txdata[0]; // databits, starting with LSB
                        txdata <= {1'b1, txdata[8:1]}; // shift right, enter 1 at left
                      end
                    end
                  end
                end                
    endcase
  end
end


endmodule

