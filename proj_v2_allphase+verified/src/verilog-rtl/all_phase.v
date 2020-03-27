`timescale 1ns / 1ps

/* -------------------------------------------------------------------------------------
	Module all_phase - receives 4 signals and outputs the phase difference between them
	
	This module receives 4 signals which have phase differences and calculates their
	phase difference

	
	----------------------------------------------------------------------------------
	Date of creation: 16/03/2020
	Author: Paula Graa (paula.graca@fe.up.pt)
*/

module all_phase(
		input clock,
		input reset,
		input enable,
		input [9:0] K,
		input [15:0] rx1, 
		input [15:0] rx2, 
		input [15:0] rx3, 
		input [15:0] rx4,
		output signed [15:0] diff_phase_1,
		output signed [15:0] diff_phase_2,
		output signed [15:0] diff_phase_3,
		output signed [15:0] diff_phase_4,
		output signed [15:0] diff_phase_5,
		output signed [15:0] diff_phase_6
    );
	
//hilbert_uut
wire signed [15:0] re1, re2, re3, re4,
				   im1, im2, im3, im4;

//cordic_uut
wire signed [15:0] phase1, phase2, phase3, phase4;

//phasediff_uut
wire signed [15:0] angle1, angle2, angle3, angle4, angle5, angle6;

hilbert hilbert_uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),	//enables new input
			.xin1(rx1),	 		// input sample
			.xin2(rx2),	 		// input sample
			.xin3(rx3),	 		// input sample
			.xin4(rx4),	 		// input sample
			.re1(re1), 			// real 
			.im1(im1),	 		// imaginary
			.re2(re2), 			// real 
			.im2(im2),	 		// imaginary
			.re3(re3), 			// real 
			.im3(im3),	 		// imaginary
			.re4(re4), 			// real 
			.im4(im4)			 // imaginary
);

top_cordic cordic_uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),	//enables new input
			.re1(re1), 			// real 
			.im1(im1),	 		// imaginary
			.re2(re2), 			// real 
			.im2(im2),	 		// imaginary
			.re3(re3), 			// real 
			.im3(im3),	 		// imaginary
			.re4(re4), 			// real 
			.im4(im4),	 		// imaginary
			.phase1(phase1),
			.phase2(phase2),
			.phase3(phase3),
			.phase4(phase4)
);

phasediff phasediff_uut (
			.clock(clock),
			.reset(reset),
			.enable(enable),		//enables new input
			.phase1(phase1),
			.phase2(phase2),
			.phase3(phase3),
			.phase4(phase4),
			.angle1(angle1),		// output angle 1
			.angle2(angle2),		// output angle 2
			.angle3(angle3),		// output angle 3
			.angle4(angle4),		// output angle 4
			.angle5(angle5),		// output angle 5
			.angle6(angle6)			// output angle 6
);

phasemean phasemean_uut(
		.clock(clock),				// global clock
		.reset(reset),				// global reset
		.enable(enable),			// enables new input
		.K(K), 						// 2^K = N is the number of accumulated samples
		.in_sampl_1(angle1),		// input sample 1
		.in_sampl_2(angle2),		// input sample 2
		.in_sampl_3(angle3),		// input sample 3
		.in_sampl_4(angle4),		// input sample 4
		.in_sampl_5(angle5),		// input sample 5
		.in_sampl_6(angle6),		// input sample 6
		.phaseout_1(diff_phase_1),	// output of phase mean for input 1
		.phaseout_2(diff_phase_2),	// output of phase mean for input 2
		.phaseout_3(diff_phase_3),	// output of phase mean for input 3
		.phaseout_4(diff_phase_4),	// output of phase mean for input 4
		.phaseout_5(diff_phase_5),	// output of phase mean for input 5
		.phaseout_6(diff_phase_6)	// output of phase mean for input 6
);

endmodule
