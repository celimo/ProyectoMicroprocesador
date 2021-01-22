`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:38:03 01/17/2021 
// Design Name: 
// Module Name:    Mux5Bits 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mux5Bits(A, B, O, sel
    );
	//Definicion de entradas y salidas 
	input sel;
	input[4:0] A, B;
	output reg[4:0] O;

	//Descripcion del MUX
	always @(A, B, sel)
		begin
			case(sel)
			0: O = A;
			1: O = B;
			endcase
		end
	endmodule
