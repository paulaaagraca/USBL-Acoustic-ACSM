`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineers:   Goncalo Pereira & Paula A A Graca
// Institution: FEUP University of Porto
//////////////////////////////////////////////////////////////////////////////////

module phase2speed(
    input clk,
    input reset,
	 input data_rdy,	// external enable may be used
	 input [3:0] N, 			// between 64(6b) and 2048(12b)
    input signed [18:0] in_phasediff,	// 9Q10
    output reg signed [15:0] out_speed,	// 6Q10
	 output reg speeden
    );
	 
parameter signed const = 20450; //15kHz ------ 16 bits
//parameter const = 18026; //17kHz
//parameter const = 16139; //19kHz

wire [12:0] Nmean;
assign Nmean = (1<<N); //256 

reg [11:0] sample_count; // 0 to 255
reg signed [19+11-1:0] avg;	// 19 bit number + N-1 more additions | addition of words with x bits, need x+1 bits
wire signed [19+11-1:0] avg_div;
wire signed [19+11+16-1:0] speed;

//input averaging logic
always @(posedge clk)
begin
	if (reset) begin
		out_speed <= 0;
		sample_count <= Nmean-1;
		avg <= 0;
		speeden <= 0;
	end
	else if(data_rdy) begin
		if (sample_count == 0) begin	//after receiving N samples
			out_speed <= $signed(speed[33:17]+speed[16]);	// 6Q10
			sample_count <= Nmean-1; //reset counter
			avg <= in_phasediff; //reset average
			speeden <= 1'd1;
		end
		else begin
			sample_count <= sample_count - 1; //for every received sample, decrement counter
			avg <= avg + in_phasediff;			 //accumulate input values
			speeden <= 0;
		end
	end
end

assign avg_div = (avg >>> N)+avg[N-1];	// divide average by N
assign speed = $signed(avg_div) * $signed(const);	// (19+N-1)+16bits+1 -> Q17 // $signed({const,10'd0})
//assign out_speed = $signed(speed[33:17]+speed[16]);	// 6Q10

endmodule
