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

/*
Objetivo del módulo
Se crea para selecciona entre el valor de cero y el valor de los bits 19:15 de las instrucciones
y ya que solo son 5 bits se debe crear otro módulo aparte del otro mux de 2 a 1

-Entradas
A: Primera entrada del mux 1'b0
B: Segunda entrada del mux 1'b1
sel: Señal de control para seleccionar entre las entradas

-Salida
O: Contiene el dato de alguna de las entradas, dependiendo de la señal de control

*/

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
