/*
	Lab project 1 - V1.0
	Authors : Gonçalo Pereira up201503829, Paula Graça up201503979
	
	Additional development 4.1 
	Module that instantiates rec2pol base module, adding the correct calculations of CORDIC algorithm for the 2nd and 3rd quadrants
*/

module phasecalc( 
           	input clock,
				input reset,
				input data_rdy,               // set to 1 for one clock to start 
				input  signed [12:0] x,    // X component, 13
				input  signed [12:0] y,    // Y component, 13
			//	input prev_rdy,
				output reg signed [18:0] angle // Angle in degrees, 9Q10
			  );
wire signed [12:0] x_edit;
wire signed [18:0] angle_23;
wire signed [18:0] angle_init;
wire signed [18:0] angle_neg;
wire signed [18:0] angle_temp;
wire enable;

// invert x to always be positive in the rec2pol input
assign x_edit = x[12] ? -x : x;
// invert output angle from rec2pol and shifting the floating point
assign angle_neg = -angle_init;
// changing the modified angle to the correct quadrant -> 4th to 2nd; 1st to 3rd
assign angle_23 = (y<0)? angle_neg - $signed({9'd180, 10'd0}): angle_neg + $signed({9'd180, 10'd0});
// adaptation for outputing a 9Q23 binary number
assign angle_temp = x[12] ? angle_23 : angle_init;

//instantiation of rec2pol base module
rec2pol base_model(.clock(clock), .reset(reset), .enable(enable), .start(data_rdy), .x(x_edit), .y(y), .angle(angle_init));

always @(posedge clock)
begin
	if(reset) begin
		angle <= 0;
	end
	else if(data_rdy) begin
		angle <= angle_temp;
	end
end

endmodule
