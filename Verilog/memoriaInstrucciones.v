`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:58 01/14/2021 
// Design Name: 
// Module Name:    memoria_instrucciones 
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

//Objetivo del modulo
//En este modulo se almacenan las instrucciones en hexadecimal necesarias
//para implementar un determinado codigo c

/*
- Entradas 
A: Dirección a acceder en la memoria

- Salidas
RD: Valor con la instrucción a realizar

*/

module memoriaInstrucciones(
	input [31:0] A, 			//direccion pc de la instruccion a ejecutar
	output reg [31:0] RD 			//instruccion a ejecutar
);
	
	reg [31:0] memoria[63:0]; //una memoria de 32 bits con 64 filas
	wire [5:0] direccion = A[7:2]; //como cada instrucción tiene 4 bytes de informacion
											  //el salto entre una instrucción a la siguiente inmediata
											  //se hace ignorando A[1:0], porque pc+4 se registra como tal
											  //hasta en el A[2]
											  //como la memoria tiene 64 filas solo se ocupan 6 bits, 
											  //en el caso que fueran más se debe de agregar más bits al wire direccion
	integer i;
	
	initial begin
		for (i = 0; i < 64; i = i + 1)
		begin
			memoria[i] = 0;
		end
		$readmemh("Compilados/funct.txt", memoria, 0); //carga del archivo hexadecimal de instrucciones
	end
	
	always@(*)
	begin
		RD = memoria[direccion]; 	//colocar a la salida la respectiva instruccion 
	end
	
endmodule
