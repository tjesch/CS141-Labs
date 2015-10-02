`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    SLL 
// Author(s): 
// Description: shift left logical (shift X left by Y places)
//
//
//////////////////////////////////////////////////////////////////////////////////
module SLL(X,Y,Z);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] Z;

	// 16 bit shift
	wire [31:0] out_16;
	wire [31:0] out_8;
	wire [31:0] out_4;
	wire [31:0] out_2;
	wire [31:0] out_1;
	
	
	assign out_16 = {X[15:0],16'b0000000000000000};
	
	
	// intermediary wires
	wire [31:0] shift4out;
	wire [31:0] shift3out;
	wire [31:0] shift2out;
	wire [31:0] shift1out;
	wire [31:0] shift0out;

	//choose between 16 bit shift or skip
	param_2_to_1_mux #(.N(32)) MUX_0 (.X(X) , .Y(out_16) , .S(Y[4]) , .Z(shift4out));
	
	//8 bit shift
	//assign wire [31:0] out_8 = {0,0,0,0,0,0,0,0,shift4out[31:8]};
	assign out_8 = {shift4out[23:0],8'b00000000};
	
	//choose between 8 bit shift or skip
	param_2_to_1_mux #(.N(32)) MUX_1 (.X(shift4out) , .Y(out_8) , .S(Y[3]) , .Z(shift3out));
	
	//4 bit shift
	//assign wire [31:0] 4out = [0,0,0,0,shift3out[31:4]];
	assign out_4 = {shift3out[27:0],4'b0000};
	
	//choose between 4 bit shift or skip
	param_2_to_1_mux #(.N(32)) MUX_2 (.X(shift3out) , .Y(out_4) , .S(Y[2]) , .Z(shift2out));
	
	//2 bit shift
	//assign wire [31:0] 2out = [0,0,shift3out[31:2]];
	assign out_2 = {shift2out[29:0],2'b00};
	
	//choose between 2 bit shift or skip
	param_2_to_1_mux #(.N(32)) MUX_3 (.X(shift2out) , .Y(out_2) , .S(Y[1]) , .Z(shift1out));
	
	//1 bit shift
	//assign wire [31:0] 1out = [0,shift3out[31:1]];
	assign out_1 = {shift1out[30:0],1'b0};
	
	//choose between 1 bit shift or skip
	param_2_to_1_mux #(.N(32)) MUX_4 (.X(shift1out) , .Y(out_1) , .S(Y[0]) , .Z(shift0out));

	assign Z = shift0out;
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
