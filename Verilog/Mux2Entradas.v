`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:40:53 01/11/2021 
// Design Name: 
// Module Name:    Mux2entradas 
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
-Objetivo del módulo
Utilizado para seleccionar entre dos condiciones

-Entradas
A: Primera entrada del mux 1'b0
B: Segunda entrada del mux 1'b1
sel: Señal de control para seleccionar entre las entradas

-Salida
O: Contiene el dato de alguna de las entradas, dependiendo de la señal de control

*/

module Mux2entradas(A, B, O, sel
    );
	//Definicion de entradas y salidas 
	input sel;
	input[31:0] A, B;
	output reg[31:0] O;

	//Descripcion del MUX
	always @(A, B, sel)
		begin
			case(sel)
			0: O = A;
			1: O = B;
			endcase
		end
	endmodule
