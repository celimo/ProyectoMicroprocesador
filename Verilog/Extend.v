`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:21 01/09/2021 
// Design Name: 
// Module Name:    extend 
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
- Objetivo del modulo
Este módulo se crea para resolver las operaciones con inmediatos de las instrucciones de la RISCV

- Entradas
A: Contiene los bits 31:6 de la instruccion
sel: Le indica que hacer con los bits de entrada, dependiendo de la instrucción a realizar

- Salidas
O: Resultado con el inmediato a trabajar en las instrucciones


*/

module Extend(A, O, sel
    );
	 //es el encargado de extender los inmediatos ya que estos no son de 32bit
	//Definicion de entradas y salidas 
	input[2:0] sel;
	input[31:6] A;
	output reg[31:0] O;

	//Descripcion del MUX
	always @(*)
	begin
		case(sel)
			3'b000: // Para ANDI, XORI, ADDI, LW, LBU, JALR
				begin
				if (A[31]==1'b0)
					O={20'b0,A[31:20] };//inmediato positivo
				else if (A[31]==1'b1)
					O={20'hFFFFF ,A[31:20] };//inmediato negativo
				end
			3'b001:
				O={26'b0, A[25:20]}; //Para corrimientos SLLI, SRLI, SRAI
			3'b010://Para JAL multiplica por 2 y extend con signo
				begin
				if (A[31]==1'b0)
					O={11'b0,A[31],A[19:12],A[20],A[30:21],1'b0};//inmediato positivo
				else if (A[31]==1'b1)
					O={11'd2047,A[31],A[19:12],A[20],A[30:21],1'b0};//inmediato negativo
				end
			3'b011: //Para BNE
				begin
				if (A[31]==1'b0)
					O={19'b0,A[31],A[7],A[30:25],A[11:8],1'b0};//inmediato positivo
				else if (A[31]==1'b1)
					O={19'd524287,A[31],A[7],A[30:25],A[11:8],1'b0};//inmediato negativo
				end
			3'b100: //Para SW
				begin
				if (A[31]==1'b0)
					O={20'b0,A[31:25],A[11:7]};//inmediato positivo
				else if (A[31]==1'b1)
					O={20'd1048575,A[31:25],A[11:7]};//inmediato negativo
				end
			3'b101:
				O={A[31:12], 12'b0};//Para LUI	
			default:
				O=0;
		endcase
	end
endmodule
