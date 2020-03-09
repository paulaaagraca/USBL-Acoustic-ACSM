`timescale 1ns/1ps

/*
	Module hilbert - Sequential hilbert filter with parameterized order

	This module receives 4 multiplexed inputs that are received from 4
	hilbert_chain modules. One chain is selected at a time to compute 
	the multiplication and addition/subtraction of the Hilbert filter. 
	In this system, since there are spare clock cycles, only one 
	multiplier and one adder are used in each cycle.
	__________________________________________________________________
	Note: 
	By changing the order of the filter, the control logic behind the
	calculations is altered as well. Therefore, this system only accepts 
	filter orders that are multiple of 4, which results in:
		- # HFcoefficients (!= 0) = order_hf/4
		- # changes = (#HFcoefficients - 1) * 2  -> (nº of times that the 
		coefficient for the multiplication is changed)
		
	E.g.	order = 8;  #changes=2;  2 HFcoeff
			order = 12; #changes=4;  3 HFcoeff
			order = 16; #changes=6;  4 HFcoeff
			order = 20; #changes=8;  5 HFcoeff
			order = 24; #changes=10; 6 HFcoeff
			order = 28; #changes=12; 7 HFcoeff

*/

module hilbert (
		input clock,					 // global clock
		input reset,					 // global reset
		input enable,					 // enables new input
		input [15:0] xin1,	 			 // input sample
		input [15:0] xin2,	 			 // input sample
		input [15:0] xin3,	 			 // input sample
		input [15:0] xin4,	 		 	 // input sample
		output signed [27:0] re1, 		 // real hilbert_chain 1
		output reg signed [27:0] im1,	 // imaginary
		output signed [27:0] re2, 		 // real hilbert_chain 2
		output reg signed [27:0] im2,	 // imaginary
		output signed [27:0] re3, 		 // real hilbert_chain 3
		output reg signed [27:0] im3,	 // imaginary
		output signed [27:0] re4, 		 // real hilbert_chain 4
		output reg signed [27:0] im4	 // imaginary
);


//------------------------------- signals and registers ----------------------------------------
// Hilbert Filter coefficients: 1Q10	
parameter ha = 11'd245, //0.2392578125
		  hb = 11'd641; //0.6259765625

// Hilbert Filter (8 order): 9 register chain 
parameter order_hf = 8;		  // hilbert filter order
wire signed [27:0] im;		// selected im output 

// auxiliar signals
wire addsub_sel; 			 			// selector for type of operation: addition or subtraction
wire signed [10:0] mult_coef; 			// coefficient used in the multiplication
wire signed [15:0] xf1, xf2, xf3, xf4;  // holds value of last register of each chain
wire [3:0] aux_xf;

//control signals
wire cnt_stop;	// active when counter is finished (=0)
reg en_calc0;	// enables accumulator for filter coefficients != 0
wire en_calc;	// auxiliar signal which retifies en_calc0, leaving only steps equivalent to coefficients != 0
//reg [2:0] cnt_chain;		  // number of chains already computed
reg [4:0] cnt_in; 			// counter for register chain 

// calculation signals
wire signed [26:0] mult;	// output of the multiplication
wire signed [27:0] addsub;	// output of the addition/subtraction
wire signed [15:0] xf; 		// selected reg for hilbert filter

//FSM states
reg [3:0] state;
parameter IDLE = 4'd0,
          RUN1 = 4'd1,
		  RUN2 = 4'd2,
		  RUN3 = 4'd3,
		  RUN4 = 4'd4;

//------------------------------- instantiate 4 HF chains ----------------------------------------
hilbert_chain hfchain_1 (
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.cnt_stop(cnt_stop),
		.in(xin1),
		.re(re1),
		.out(xf1)
);
hilbert_chain hfchain_2 (
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.cnt_stop(cnt_stop),
		.in(xin2),
		.re(re2),
		.out(xf2)
);
hilbert_chain hfchain_3 (
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.cnt_stop(cnt_stop),
		.in(xin3),
		.re(re3),
		.out(xf3)
);
hilbert_chain hfchain_4 (
		.clock(clock),
		.reset(reset),
		.enable(enable),
		.cnt_stop(cnt_stop),
		.in(xin4),
		.re(re4),
		.out(xf4)
);

//------------------------------ calculations -----------------------------------------------------

// select sample to be used for the multiplication
assign aux_xf = (state == IDLE || state == RUN1)? 4'd1 : ((state == RUN2) ? 4'd2 : ((state == RUN3) ? 4'd3 : 4'd4));
assign xf = (state == IDLE || state == RUN1)? xf1 : ((state == RUN2) ? xf2 : ((state == RUN3) ? xf3 : xf4));

//select imaginary output to hold the result of the calculation
assign im = (state == IDLE || state == RUN1)? im1 : ((state == RUN2) ? im2 : ((state == RUN3) ? im3 : im4));


// ** ATENTION **  only works for filter order 8  ** ATENTION **
// __________________________________________________________________________________________
// selects HF coefficient to be used
assign mult_coef = (cnt_in < order_hf-1 && cnt_in > 2 )? hb : ha;
// output of multiplication between last register in chain and the selected coefficient
assign mult = $signed(xf)* $signed(mult_coef); 

// selector for add/sub calculation
assign addsub_sel = (cnt_in > 5 );	
// if multiplication != 0, then add/sub
assign addsub = addsub_sel ?  $signed(im + mult) : $signed(im - mult); 
// __________________________________________________________________________________________


// -------------------------------- control signals ------------------------------------------------

// en_calc can only be active during circular shift 
assign en_calc = en_calc0 & ~cnt_stop;

// holds counter state while waiting for new input
assign cnt_stop = (cnt_in == 5'd0);


// Generates enable signal for accumulator register:
always @(posedge clock)
begin
	if (reset) begin
		en_calc0 <= 1'd0;
	end
	else begin
		// initiates enable when new input is uploaded
		if (enable) begin
			en_calc0 <= 1'd0;
		end
		// enable is alternated during circular shift
		else if (!cnt_stop) begin 
			en_calc0 <= ~en_calc0;
		end
		// enable is not active after full circular shift
		else if (cnt_stop)
			en_calc0 <= 1'd0;
	end
end

/*  -----------------------------------------------------------------------------
	FSM controller:

	Uses 5 states in total: 
	- IDLE : system is steady and waits to receive new sample so that is can 
	prepare for the processing states;
	- RUNx : system selects register chain x and performs calculations 
	with those samples. After shifting the entire chain (i.e. returning to the 
	initial position), the x+1 chain is selected and the described process is 
	repeated. In the end of last state, RUN4, all chains were already rotated 
	and the system will return to IDLE state to wait for new input.

*/
always @(posedge clock)
begin
  if (reset)
  begin
    cnt_in <= order_hf + 5'd1;	// decreasing counter 
    state <= IDLE;				// start state is IDLE
	im1  <= 28'd0;
	im2  <= 28'd0;
	im3  <= 28'd0;
	im4  <= 28'd0;
  end
  else
    case (state)
		// IDLE : when waiting for new sample
		IDLE: if (enable) begin //|| (cnt_chain != 3'd0)
					 state <= RUN1;
					 cnt_in <= order_hf + 5'd1;
					 im1 <= 28'd0;
					 im2 <= 28'd0;
					 im3 <= 28'd0;
					 im4 <= 28'd0;
				   end
		// RUN1 : computation of hilbert filter for first chain		   
		RUN1: begin 
				if (cnt_in == 5'd0) begin		// after rotating first register chain:
					cnt_in <= order_hf + 5'd1;	// reset counter
					state <= RUN2; 				// select second chain
				end
				else begin						// if register chain is not fully rotated:
					cnt_in <= cnt_in - 5'd1;	// decrease the counter
				end
				if (en_calc) begin 				// if current HF coefficient is != 0:
					im1 <= addsub;				// update imaginary output
				end 
				end 

		// RUN2 : computation of hilbert filter for second chain				   
		RUN2: begin
				if (cnt_in == 5'd0) begin		// after rotating second register chain:
					state <= RUN3; 				// reset counter
					cnt_in <= order_hf + 5'd1;	// select third chain
				end
				else begin						// if register chain is not fully rotated:
					cnt_in <= cnt_in - 5'd1;	// decrease the counter
				end	
				if (en_calc) begin 				// if current HF coefficient is != 0:			
					im2 <= addsub;				// update imaginary output
				end 
				end 
		// RUN3 : computation of hilbert filter for third chain				
		RUN3: begin
				if (cnt_in == 5'd0) begin		// after rotating third register chain:
					state <= RUN4; 				// reset counter
					cnt_in <= order_hf + 5'd1; 	// select fourth chain
				end
				else begin						// if register chain is not fully rotated:
					cnt_in <= cnt_in - 5'd1;	// decrease the counter
				end	
				if (en_calc) begin 				// if current HF coefficient is != 0:
					im3 <= addsub;				// update imaginary output
				end 
				end 
		// RUN4 : computation of hilbert filter for fourth chain				
		RUN4: begin
				if (cnt_in == 5'd0) begin		// after rotating fourth register chain:
					state <= IDLE; 				// go to IDLE state and wait for new sample
				end
				else begin						// if register chain is not fully rotated:
					cnt_in <= cnt_in - 5'd1;	// decrease the counter
				end
				if (en_calc) begin 				// if current HF coefficient is != 0:
					im4 <= addsub;				// update imaginary output
				end 
				end 
				
		default: state <= IDLE; // if any other state is detected, go to IDLE
	endcase
end


/* always @(posedge clock)
begin
	if (reset) begin
		cnt_chain <= 3'd0;
	end
	else begin
		if (cnt_in == 5'd0) begin
			cnt_chain <= cnt_chain + 3'd1;
		end
		else if (cnt_chain == 3'd3) begin
			cnt_chain <= 3'd0;
		end
	end	

end */


/* // upload result of addition/subtraction to imaginary output 
always @(posedge clock)
begin
	if (reset) begin
		im1  <= 28'd0;
		im2  <= 28'd0;
		im3  <= 28'd0;
		im4  <= 28'd0;
	end
	// if calculation is enabled -> saves addsub output
	else if (en_calc) begin 
		im1 <= addsub;
	end
	// if receives new sample -> reset register
	else if (enable) begin
		im1 <= 28'd0;
	end
end */

// counter equivalent to HF order
/* always @(posedge clock)
begin
	if (reset) begin
		cnt_in <= order_hf + 5'd1;
	end
	else begin
		if (enable) begin
			cnt_in <= order_hf + 1'd1;
		end
		else if (cnt_in != 5'd0) begin
			cnt_in <= cnt_in - 5'd1;
		end
	end
end */

endmodule
