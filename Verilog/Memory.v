`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:06 01/16/2021 
// Design Name: 
// Module Name:    Memory 
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
Organizar los módulos que tienen relación con las operaciones de memoria, en este caso se incluye los bloques
que pertenecerían a writeBack

- Entradas
inALU: Valor del resultado de la ALU
inDataMemory: Valor a guardar en memoria 
clock: Señal de clock
writeMemory: Indica si se debe escribir en memoria
storeByte: Indica si se debe guardar el byte menos significativo de la memoria
loadByte: Indica si se debe cargar el byte menos significativo de la memoria
memReg: Señal de control para el mux que selecciona entre el valor de la memoria y el del resultado de la ALU

- Salidas
writeData: Dato que se utiliza para rescribir en los registros o en los saltos del PC
dataGPIO: Dato del GPIO

*/

module Memory(inALU, inDataMemory, writeMemory, storeByte, loadByte, memReg, writeData, clock, dataGPIO, reset
	);

	input [31:0] inALU, inDataMemory;  // Datos de la ALU y los datos que se desean escribir en la memoria
	input clock, reset;
	output [31:0] writeData;  // Salida final de la derecha
	output [31:0] dataGPIO;
	
	input writeMemory, storeByte, loadByte, memReg; // Seniales de control

	wire [31:0] datMemory; // Se usa cuando se tengan las memorias
	
	wire [1:0] selByte = inALU[1:0]; // Si se hace un load byte se selecciona cual byte se desea

	Mux2entradas MuxMemoryALU ( // Mux que elije entre la memoria y el resultado de la ALU
		.A(inALU), 
		.B(datMemory),
		.O(writeData), 
		.sel(memReg)
	);

	memoriaDatos Memoria ( // Memoria de datos
		.A(inALU),
		.WD(inDataMemory),
		.MW(writeMemory),
		.SB(storeByte),
		.RD(datMemory),
		.loadByte(loadByte),
		.clock(clock)
	);
	
	Flip_flop_GPIO GPIO( // Salida del GPIO
		.A(32'habcd), 
		.B(inALU),
		.D(inDataMemory), 
		.Q(dataGPIO), 
		.clock(clock),
		.reset(reset)
	);
	
endmodule
