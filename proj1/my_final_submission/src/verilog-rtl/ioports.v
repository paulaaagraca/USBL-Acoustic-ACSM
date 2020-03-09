/*
 General purpose I/O ports (32 bits)
 Output port "outf" has automatic return to zero after 4 clock cycles

Generic top level module for the Atlys Board
 
jca@fe.up.pt, Nov 2015 - Nov 2016 - Nov 2017 -  Nov 2018

	This Verilog code is property of University of Porto
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.
 
*/

`timescale 1ns/100ps

module ioports( clk,    // master clock 
                reset,  // master reset, synchronous, active high
                load,   // load enable for din bus
                ready,  // ready to consume dout data
                enout,  // enable loading of dout data
                datain, // data in bus (8 bits)
                dataout,// data out bus (8 bits)
                in0,    // 8 32-bit input ports
                in1,    
                in2,    
                in3,    
                in4,    
                in5,     
                in6,    
                in7,    
                out0,   // 16 32-bit output ports
                out1, 
                out2, 
                out3, 
  			    out4, 
				out5,   
				out6,
				out7,
				out8,   
				out9,   
				outa,
				outb,
				outc,   
				outd,   
				oute,
				outf    // port f has automatic return to zero after 4 clock cycles
                );

input        clk, reset, load, ready;
output       enout;
input  [7:0] datain;
output [7:0] dataout;

input  [31:0] in0, in1, in2, in3, 
              in4, in5, in6, in7;
output [31:0] out0, out1, out2, out3,
              out4, out5, out6, out7,
              out8, out9, outa, outb,
              outc, outd, oute, outf;



// Registers:
reg    [4:0]  state;
reg    [31:0] out0, out1, out2, out3,
              out4, out5, out6, out7,
              out8, out9, outa, outb,
              outc, outd, oute, outf;
reg    [7:0]  dataout;
reg    [7:0]  byte3, byte2, byte1;
reg           enout;
reg    [3:0]  address;
reg    [31:0] datatoout;
reg    [31:0] from_inports;

// This code identified the design implemented. Do not touch
parameter ATLYS_HWID = 32'h2019_2020;

// State encoding:
parameter IDLE       = 5'b0,
          WRITECMD   = 5'd1,
          WRITECMD2  = 5'd2,
          WRITECMD3  = 5'd3,
          WRITECMD4  = 5'd4,
          READCMD    = 5'd5,
          READCMD2   = 5'd6,
          READCMD3   = 5'd7,
          READCMD4   = 5'd8,
          READCMD5   = 5'd9,
          READCMD6   = 5'd10,
          READCMD7   = 5'd11,
          READCMD8   = 5'd12,
		  DELAY0     = 5'd13,
		  DELAY1     = 5'd14,
		  DELAY2     = 5'd15,
		  DELAY3     = 5'd16;

// Commands:
parameter RESET      = 3'b001,
          WRITE      = 3'b010,
          READ       = 3'b011;


always @(posedge clk)
begin
  if ( reset )
  begin
    out0 <= 0;
    out1 <= 0;
    out2 <= 0;
    out3 <= 0;
    out4 <= 0;
    out5 <= 0;
    out6 <= 0;
    out7 <= 0;
    out8 <= 0;
    out9 <= 0;
    outa <= 0;
    outb <= 0;
    outc <= 0;
    outd <= 0;
    oute <= 0;
    outf <= 0;
    enout <= 0;
	byte3 <= 0;
	byte2 <= 0;
	byte1 <= 0;
	state <= 0;  
  end
  else
  begin
    case ( state )
      IDLE :        begin
                      if ( load )
                        case ( datain[6:4] ) // command
                          RESET : begin
                                    out0 <= 0;
                                    out1 <= 0;
                                    out2 <= 0;
                                    out3 <= 0;
                                    out4 <= 0;
                                    out5 <= 0;
                                    out6 <= 0;
                                    out7 <= 0;
                                    out8 <= 0;
                                    out9 <= 0;
                                    outa <= 0;
                                    outb <= 0;
                                    outc <= 0;
                                    outd <= 0;
                                    oute <= 0;
                                    outf <= 0;
                                    enout <= 0;
                                    state <= IDLE;
                                  end
                          WRITE : begin
                                    address <= datain[3:0]; // address of port
                                    state <= WRITECMD;
                                  end
                          READ  : begin
						            datatoout <= from_inports;
                                    state <= READCMD;
                                  end
  						  default : state <= IDLE;
                        endcase
                      else
                        state <= IDLE;
                    end
                    
      WRITECMD:     begin
                     if ( load )           // byte 3 arrived
                     begin
                       byte3 <= datain;       // load byte
                       state <= WRITECMD2;
                     end
                     else
                     begin
                       state <= WRITECMD;  // keep waiting for MS byte
                     end
                    end
					
     WRITECMD2:    begin
                     if ( load )           // byte 2 arrived
                     begin
                       byte2 <= datain;       // load byte 
                       state <= WRITECMD3;
                     end
                     else
                     begin
                       state <= WRITECMD2;  // keep waiting
                     end
                    end

	WRITECMD3:    begin
                     if ( load )           // byte 1 arrived
                     begin
                       byte1 <= datain;       // load byte 
                       state <= WRITECMD4;
                     end
                     else
                     begin
                       state <= WRITECMD3;  // keep waiting 
                     end
                    end
                    
                    
    WRITECMD4   : begin
                     if ( load )           // LSbyte arrived
                     begin
                       case ( address )
                         0 : out0 <= {byte3, byte2, byte1, datain};
                         1 : out1 <= {byte3, byte2, byte1, datain};
                         2 : out2 <= {byte3, byte2, byte1, datain};
                         3 : out3 <= {byte3, byte2, byte1, datain};
                         4 : out4 <= {byte3, byte2, byte1, datain};
                         5 : out5 <= {byte3, byte2, byte1, datain};
                         6 : out6 <= {byte3, byte2, byte1, datain};
                         7 : out7 <= {byte3, byte2, byte1, datain};
                         8 : out8 <= {byte3, byte2, byte1, datain};
                         9 : out9 <= {byte3, byte2, byte1, datain};
                         10: outa <= {byte3, byte2, byte1, datain};
                         11: outb <= {byte3, byte2, byte1, datain};
                         12: outc <= {byte3, byte2, byte1, datain};
                         13: outd <= {byte3, byte2, byte1, datain};
                         14: oute <= {byte3, byte2, byte1, datain};
                         15: outf <= {byte3, byte2, byte1, datain};
                       endcase
					   if ( address == 15 )
					     state <= DELAY3;  // wait 1 clock cycle
					   else
                         state <= IDLE;
                     end
                     else
                       state <= WRITECMD4;  // keep waiting for LS byte
                    end
					
      DELAY0      : state <= DELAY3;					
                    
      DELAY1      : state <= DELAY2;					
                    
      DELAY2      : state <= DELAY3;					
                    
      DELAY3      : begin
	                  outf <= 0;
	                  state <= IDLE;					
					end
                    
      READCMD     : begin
                      if ( ready )
                      begin
                        dataout <= datatoout[31:24]; // output byte 3
                        enout <= 1;
                        state <= READCMD2;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD;  // wait for ready
                      end
                    end
                    
      READCMD2    : begin              // wait for ready low
                      if ( ready )
                      begin
                        enout <= 1;    // keep enout active until ready is deasserted
                        state <= READCMD2;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD3;
                      end
                    end
                      
      READCMD3    : begin
                      if ( ready )
                      begin
                        dataout <= datatoout[23:16]; // output byte 2
                        enout <= 1;
                        state <= READCMD4;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD3;  // wait for ready
                      end
                    end
                    
      READCMD4    : begin              // wait for ready low
                      if ( ready )
                      begin
                        enout <= 1;    // keep enout active until ready is deasserted
                        state <= READCMD4;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD5;
                      end
                    end
                      
      READCMD5    : begin
                      if ( ready )
                      begin
                        dataout <= datatoout[15:8]; // output byte 1
                        enout <= 1;
                        state <= READCMD6;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD5;  // wait for ready
                      end
                    end
                    
      READCMD6    : begin              // wait for ready low
                      if ( ready )
                      begin
                        enout <= 1;    // keep enout active until ready is deasserted
                        state <= READCMD6;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD7;
                      end
                    end
                      
      READCMD7    : begin
                      if ( ready )
                      begin
                        dataout <= datatoout[7:0]; // output byte 0
                        enout <= 1;
                        state <= READCMD8;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= READCMD7;  // wait for ready
                      end
                    end
                    
      READCMD8    : begin              // wait for ready low
                      if ( ready )
                      begin
                        enout <= 1;    // keep enout active until ready is deasserted
                        state <= READCMD8;
                      end
                      else
                      begin
                        enout <= 0;
                        state <= IDLE;
                      end
                    end		
					
      default     : begin
                      state <= IDLE;
                    end
    endcase
  end
end

// Select data to read
always @*
begin
if ( datain[3:0] == 15 )
  from_inports = ATLYS_HWID;
else
   case ( datain[3:0] )
     0: from_inports = in0;
     1: from_inports = in1;
     2: from_inports = in2;
     3: from_inports = in3;
     4: from_inports = in4;
     5: from_inports = in5;
     6: from_inports = in6;
     7: from_inports = in7;
   endcase
end


endmodule
