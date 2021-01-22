`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:54:28 01/15/2021 
// Design Name: 
// Module Name:    Sumador 
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

/*
Bloque para sumar dos entradas y dar el valor resultante, se utiliza para dar el valor de PC+4 y en 
instrucciones como BNE

-Entradas
A: Primer operando a sumar
B: Segundo operando a sumar

-Salidas
O: Resultado de la suma
*/

module Sumador(A, B, O
	);
	
	input [31:0] A, B;
	output reg [31:0] O = 0;
	
	always @(*)
	begin
		O = A + B;
	end


endmodule
