`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  add_rca_32_bit
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module add_rca_32_bit(X,Y,sum,overflow);
	input wire [31:0] X, Y;
	output wire [31:0] sum;
	output wire overflow;
	wire co_1, co_2, co_3;

	add_rca_8_bit adder_1 (
		.X  (X[7:0]),
		.Y  (Y[7:0]),
		.ci (0),
		.sum(sum[7:0]),
		.co (co_1)
	);

	add_rca_8_bit adder_2 (
		.X  (X[15:8]),
		.Y  (Y[15:8]),
		.ci (co_1),
		.sum(sum[15:8]),
		.co (co_2),
	);

	add_rca_8_bit adder_3 (
		.X  (X[23:16]),
		.Y  (Y[23:16]),
		.ci (co_2),
		.sum(sum[23:16]),
		.co (co_3),
	);

	add_rca_8_bit adder_4 (
		.X  (X[31:24]),
		.Y  (Y[31:24]),
		.ci (co_3),
		.sum(sum[31:24]),
		.co (overflow),
	);
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire