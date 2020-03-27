/*

    Integrated Master in Electrical and Computer Engineering - FEUP
	
	EEC0055 - Digital Systems Design 2019/2020
	
	----------------------------------------------------------------------
	module phasecalc_all 
	
	Summary
	CORDIC vectoring mode - convert rectangular coords to polar coords
	
	----------------------------------------------------------------------	
	Date created: 1 Nov 2019
	Author: jca@fe.up.pt

	----------------------------------------------------------------------		
	This Verilog code is property of the University of Porto, Portugal
	Its utilization beyond the scope of the course Digital Systems Design
	(Projeto de Sistemas Digitais) of the Integrated Master in Electrical 
	and Computer Engineering requires explicit authorization from the author.

*/

module cordic( 
                input clock,
				input reset,
				input start,               // set to 1 for one clock to start 
				output busy,               // 1: module is busy and does not accept new inputs
				input  signed [15:0] x,    // X component, 6Q10
				input  signed [15:0] y,    // Y component, 6Q10
				output signed [15:0] angle,// Angle in degrees, 9Q7
				output signed [15:0] mod   // modulus, 6Q10
			  );
			  

// Instantiate the rec2pol module (datapath)
cordic_calc cordic_calc_1 (
		.clock(clock), 
		.reset(reset), 
		.start(start), 
		.enable(enable),
		.x(x), 
		.y(y), 
		.angle( angle ),
		.mod( mod )
	);
	
// Instantiate the controller
cordic_control cordic_control_1 (
		.clock(clock), 
		.reset(reset), 
		.start(start), 
		.busy(busy),
		.enable(enable)
		);
		
endmodule