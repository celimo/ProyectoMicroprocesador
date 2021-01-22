`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:01:21 01/15/2021 
// Design Name: 
// Module Name:    Decode 
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
Tener más orden para cablear los diferentes módulos, en este caso se agregan los bloques registro, extend y dos muxes

-Entradas
INPUT: Contiene la instrucción a realizar
PC4: Contiene el valor del PC + 4
WriteData: Dato que proviene del mux de 2 entradas que conecta la ALU con la memoria de datos
clock: Señal de clock
reset: Señal de reset
contExtend: Señal de control para el bloque extend

-Salidas
R1: Valor del registro de la dirección en A1
R2: Valor del registro en la dirección de A2
outExtend: Valor con las operaciones realizadas en el bloque extend

*/

module Decode(INPUT, PC4, WriteData, R1, R2, outExtend, contA1, contJALR, WriteReg, contExtend, clock, reset
	);
	
	// Se definen las entradas y salidas del módulo
	input [31:0] INPUT, PC4, WriteData;
	output [31:0] R1, R2, outExtend;
	input clock, reset;
	
	// Entradas de control
	input contA1, contJALR, WriteReg;  // Para los registros y decir si se escribe en memoria
	input [2:0] contExtend; // Controla que hace el extend
	
	// Conexiones entre bloques
	wire [4:0] inAA1, inA1, inA2, inA3; // Bloque de registros
	wire [31:0] inWR3;
	wire [25:0] inExtend; // Bloque de extend
	
	// Se asignan los datos de la entrada a su respectivo cable
	
	// Configuración para los registros
	assign inAA1 = INPUT[19:15];
	assign inA2 = INPUT[24:20];
	assign inA3 = INPUT[11:7];
	
	assign inExtend = INPUT[31:6];
	
	Mux2entradas Mux2In1 ( // Mux que va conectado a la entrada WR3 de los registros
		.A(WriteData), 
		.B(PC4),
		.O(inWR3), 
		.sel(contJALR)
	);
	
	Mux5Bits Mux2In2 (  // Mux que va conectado a la entrada A1 de los registros
		.A(inAA1), 
		.B(5'd0),
		.O(inA1), 
		.sel(contA1)
	);
	
	Extend bloqueExtend (  // Bloque que hace el extend de los inmediatos
		.A(inExtend), 
		.O(outExtend), 
		.sel(contExtend)
	);
	
	Registro2 bloqueRegistros(
		.A1(inA1), 
		.A2(inA2), 
		.A3(inA3), 
		.WR3(inWR3), 
		.writeRegister(WriteReg), 
		.clock(clock),
		.reset(reset),
		.R1(R1), 
		.R2(R2)
	);
	
	

endmodule
