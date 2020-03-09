`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module real2cpx(
    input clk,
    input reset,
	 input data_rdy,		  // enable
    input [11:0] x_rx,	  // integer
    output reg [12:0] re, // integer
    output reg [12:0] im  // integer
    );

// Hilbert Filter Coefficients
parameter h1 = 26'b0_0000_0000_0000_0_0111_1010_0000, // 0.23828125
			 h3 = 26'b0_0000_0000_0000_1_0100_0000_0000, // 0.62500000
			 N = 26;	// multiplication buffer size
			 
reg signed[N+1-1:0] y1, y01, y3, y03, y5, y05;
reg signed[11:0] x1, x2, x3, x4;

wire signed [2*N-1:0] y1_t, y3_t;
wire signed [N-1:0] y1_t_26, y3_t_26, im_t;

assign y1_t = $signed({{x1[11],x1},13'd0}) * $signed(h1); // present input * coeff h1
assign y3_t = $signed({{x1[11],x1},13'd0}) * $signed(h3); // present input * coeff h3
assign y1_t_26 = $signed(y1_t[38:13]); // 26b after multiplication
assign y3_t_26 = $signed(y3_t[38:13]); // 26b after multiplication

assign im_t = y05 - y1_t_26; // cummulative contribution of -h1   

reg [3:0] init_count; // counter for first 8 samples

always @(posedge clk)
begin
	if(reset) begin
		//init_count <= 4'b1001;	// initialize counter with 9
		re <= 0;
		im <= 0;
		y1 <= 0;
		y3 <= 0;
		y5 <= 0;
		y01 <= 0;
		y03 <= 0;
		y05 <= 0;
		x1 <= 0;
		x2 <= 0;
		x3 <= 0;
		x4 <= 0;
	end
	else begin
		if(data_rdy ) begin //&& init_count==4'd0
			// imaginary part: 7 register chain
			im <= $signed(im_t[25:13]); // last truncation and rounding [25:13]
			y05 <= y5; 						 // pure delay  
			y5 <= y03 - y3_t_26;			 // cummulative contribution of -h3
			y03 <= y3;				 		 // pure delay
			y3 <= y01 + y3_t_26;			 // cummulative contribution of h1 
			y01 <= y1;						 // pure delay
			y1 <= y1_t_26;					 // cummulative contribution of h3 
			
			// real part: 4 register chain
			re <= $signed({x4[11],x4});
			x4 <= x3;
			x3 <= x2;
			x2 <= x1;
			x1 <= x_rx;
		end
	else if (data_rdy  ) begin // && init_count != 4'd0
//			init_count <= init_count - 1'd1; 
		end
		else
			 re<=re;
		end	
end

//assign enable_next = (init_count==4'd0);
 
endmodule