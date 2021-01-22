`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:34 01/16/2021 
// Design Name: 
// Module Name:    FlipFlopD 
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
Flip-flop D que contiene el valor del PC para seleccionar la instrucción de la memoria de instucciones

Entradas
D: Dato a guardar
clock: Señal de clock
reset: Señal de reset

Salidas
Q: Valor actual en el flip-flop

*/

module FlipFlopD(D, Q, clock, reset
    );
	 
	 input [31:0] D;
	 input clock, reset;
	 
	 output reg [31:0] Q = 0;
	 
	 always @(posedge clock)
	 begin
		if (reset)
			Q <= 0;
		else
			Q <= D;
	 end


endmodule
