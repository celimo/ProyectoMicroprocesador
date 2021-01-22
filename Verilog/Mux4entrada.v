`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:10 01/11/2021 
// Design Name: 
// Module Name:    Mux4entradas 
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
Este bloque es muy similar a un mux de 4 entradas con la diferencia de la dirección 2'b11
en este caso le asigna cero a la salida al bit menos significativo de la entrada D, esto considerando la operación
del JALR

-Entradas
A: Primer entrada del mux 2'b00
B: Segundo entrada del mux 2'b01
C: Tercer entrada del mux 2'b10
D: Cuarta entrada del mux 2'b11
sel: Seleccionar cual salida poner en el mux

-Salidas
O: Salida con el valor de alguna de las entradas

*/

module Mux4entradas(A, B, C, D, O, sel
    );
	// Este Mux se encarga de eligir la direccion del PC
	//Definicion de entradas y salidas 
	input[1:0] sel;
	input[31:0] A, B, C, D;
	output reg[31:0] O;

	//Descripcion del MUX
	always @(*)
	begin
		case(sel)
		'b00: O = A;
		'b01: O = B;
		'b10: O = C;
		'b11: O = {D[31:1], 1'b0}; //para el caso de JALR
		endcase
	end
endmodule
