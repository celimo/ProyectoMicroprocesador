`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:08 01/13/2021 
// Design Name: 
// Module Name:    alu 
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
- Objetivo del módulo
Realizar operaciones aritmético lógicas

- Entradas
A: Primer operando
B: Segundo operando
sel: Indica que operación realizar

- Salidas
O: Contiene el resultado de la operación
Z: Es 1 si la salida es diferente a cero sino el valor de z es cero
*/

module ALU(A,B,O,sel, Z
    );
	// Es la encargada de realizar las operaciones aritmeticas
	//Definicion de entradas y salidas 
	input[2:0] sel;//  selector
	input[31:0] A, B;//entradas de la alu 
	output reg[31:0] O;//Salida de la alu
	output reg Z;// Bandera Z negada
	//Descripcion del MUX
	always @(*)
	begin
			case(sel)
				3'b000: O = A + B;//Operacion ADD
				3'b001: O = A - B;//Operacion SUB
				3'b010: O = A ^ B;//Operacion XOR
				3'b011: O = A & B;//Operacion AND
				3'b100: O = A << B[4:0];//Operacion SLLI
				3'b101: O = A >> B[4:0];//Operacion SRLI
				3'b110: O = ($signed(A) >>> B[4:0]);//Operacion SRAI
				default: O = 0;
			endcase
			
			if (O != 32'b0)
				Z = 1'b1;
			else
				Z = 1'b0;
	end	
endmodule