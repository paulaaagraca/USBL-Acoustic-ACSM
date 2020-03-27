/*

    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------	
	Date created: 1 Nov 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.

*/

module cordic_control( 
                input clock,
				input reset,
				input start,   // set to 1 for one clock to start 
				output enable,
				output busy
			  );
			  
reg [4:0] counter;
reg       state;

// FSM states:
parameter ST_IDLE = 1'b0,
          ST_RUN  = 1'b1;

// The controller:
always @(posedge clock)
begin
  if ( reset )
  begin
    counter <= 5'd0;
    state <= ST_IDLE;
  end
  else
    case ( state )
	  ST_IDLE: if (start)
	           begin
	             state <= ST_RUN;
			   end
	  ST_RUN:  if ( counter == 15 )
	           begin
			     counter <= 5'd0;
				 state <= ST_IDLE;
			   end
			   else
			     counter <= counter + 5'd1; 
	endcase

end

// set enable for 17 clock cycles:
assign enable = ( start | ( state == ST_RUN ) );
// enable is the same as NOT(busy)...
assign busy = ~enable;
		
endmodule
