`timescale 1ns/1ps

/////////////
//
/////////////

module hilbert (
		input clock,
		input reset,
		input enable,			// enables new input
		input [15:0] xin,	 	// input sample
		output reg signed [27:0] re,	// real 
		output reg signed [27:0] im	// imaginary
);

// Hilbert Filter coefficients: 1Q10	
parameter ha = 11'b0_0011_1101_01,  //0.2392578125
		  hb = 11'b0_1010_0000_01; //0.6259765625

// Hilbert Filter (8 order): 9 register chain 
reg signed [15:0] x0,x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8;

parameter order_hf = 8;
reg signed [15:0] xa[0:order_hf];


// auxiliar signals
wire cnt_stop;
reg en_calc0;
wire en_calc;

reg [4:0] cnt_in;	  
wire signed [26:0] mult;
wire signed [27:0] addsub;
wire signed [10:0] aux_param;
wire aux_addsub;
reg aux;

integer i;


always @(posedge clock)
begin
	if (reset) begin
		re  <= 15'd0;
/* 		x0  <= 15'd0;
		x_1 <= 15'd0;
		x_2 <= 15'd0;
		x_3 <= 15'd0;
		x_4 <= 15'd0;
		x_5 <= 15'd0;
		x_6 <= 15'd0;
		x_7 <= 15'd0;
		x_8 <= 15'd0; */
		
		for(i=0;i<=8;i=i+1)
			xa[i] <= 16'd0;
		
		en_calc0 <= 1'd0;
	end
	// multiplexer chooses between 'uploading new input' or 'computing circular shift'
	else begin
		// upload input
		if (enable) begin
/* 			x0 <= xin;
			x_1 <= x0;
			x_2 <= x_1;
			x_3 <= x_2;
			x_4 <= x_3;
			x_5 <= x_4;
			x_6 <= x_5;
			x_7 <= x_6;
			x_8 <= x_7; */
			
			re <= xa[4]; 	// ERRADOO
			
			
			xa[0] <= xin;
			for(i=1;i<=8;i=i+1)
				xa[i] <= xa[i-1];
			
			
			en_calc0 <= 1'd0;
		end
		// circular shift
		else if (!cnt_stop) begin 
			/* x0 <= x_8;
			x_1 <= x0;
			x_2 <= x_1;
			x_3 <= x_2;
			x_4 <= x_3;
			x_5 <= x_4;
			x_6 <= x_5;
			x_7 <= x_6;
			x_8 <= x_7;	 */
			
			xa[0] <= xa[8];
			for(i=1;i<=8;i=i+1)
				xa[i] <= xa[i-1];
			
			en_calc0 <= ~en_calc0;
		end
		else if (cnt_stop)
			en_calc0 <= 1'd0;
	end
end

assign en_calc = en_calc0 & ~cnt_stop;

assign aux_param = (cnt_in < 7 && cnt_in > 2 )? hb : ha;
assign mult = $signed(xa[8])* $signed(((cnt_in < 7 && cnt_in > 2 )? hb : ha)); 

assign aux_addsub = (cnt_in > 5 ) ? 1'd1 : 1'd0;
// assign addsub = en_calc ? addsub : ((cnt_in > 4 ) ?  $signed(im + mult) : $signed(im - mult)); // if multiplication != 0, then add/sub
assign addsub = (cnt_in > 5 ) ?  $signed(im + mult) : $signed(im - mult); // if multiplication != 0, then add/sub

//calculus
always @(posedge clock)
begin
	if (reset) begin
		im  <= 16'd0;
		aux <= 1'd0;
	end
	else if (en_calc) begin 
		//aux <= ~aux;
		im <= addsub;
	end
	else if (enable) begin
		im <= 28'd0;
	end
end

// holds counter state while waiting for new input
assign cnt_stop = (cnt_in == 5'd0);

always @(posedge clock)
begin
	if (reset) begin
		cnt_in <= 5'd9;
	end
	else begin
		if (enable) begin
			cnt_in <= 5'd9;
		end
		else if (cnt_in != 5'd0) begin
			cnt_in <= cnt_in - 5'd1;
		end
	end
end

endmodule
