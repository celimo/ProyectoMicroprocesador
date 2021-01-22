`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:56:15 01/21/2021 
// Design Name: 
// Module Name:    Flip_flop_GPIO 
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
Objetivo del módulo:
Se agrega este módulo con el fin de cumplir con el rol de registro en el cual guarda el valor de la memoria 0xABCD
en la salida GPIO, en el caso que A y B sean iguales el dato D de entrada se guarda en el registro

-Entradas
A: Primer valor a comparar
B: Segundo valor a comparar
D: Dato a guardar 
clock: Señal de reloj
reset: Reinicia el valo en creo

-Salidas
Q: Dato actual del módulo

*/

module Flip_flop_GPIO(A, B, D, Q, clock, reset
   );

	input [31:0] A, B, D;
	input clock, reset;
	output reg [31:0] Q = 0;
	
	always@(posedge clock)
	begin
		if(reset) // Reiniciar los valores
		begin
			Q <= 0;
		end
		else
		begin
			if(A == B) // Guardar o no el valos
			begin
				Q <= D;
			end
		end
	end

endmodule
