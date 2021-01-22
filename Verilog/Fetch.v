`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:01:05 01/15/2021 
// Design Name: 
// Module Name:    Fetch 
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
Para tener mejor orden en el código se introdujo este bloque, que contiene el flip-flop D, la memoria de instrucciones
y tiene conectados los bloques que se encargan de asignar el siguiente valor del PC

- Entradas
intExtend: Entrada de 32 bits, entrada del bloque extend, para la operación del BNE
intJAL: Entrada conectada al bloque del mux que conecta la memoria de datos y la ALU
contMux4: Señal de control para el mux de 4 enradas
clock: Señal de clock para el flip-fop D
reset: Señal de reset

- Salidas
outINPUT: Salida de 32 bits con las instrucciones
dataPC4: Dato del PC + 4
dataPC: Dato del PC actual

*/

module Fetch(intExtend, intJAL, contMux4, clock, reset, outINPUT, dataPC4, dataPC
   );

	input [31:0] intExtend, intJAL;
	input [1:0] contMux4;
	input clock, reset;
	
	output [31:0] outINPUT; // Todavía no se asigna porque no está la memoria
	output [31:0] dataPC4, dataPC;
	
	wire [31:0] outMux4;
	wire [31:0] dataPC;
	wire [31:0] sumBNE;
	
	FlipFlopD FlipFlopPC(
		.D(outMux4), 
		.Q(dataPC), 
		.clock(clock), 
		.reset(reset)
    );
	 
	reg [31:0] sumar4 = 4; // Se usa para sumar 4 al PC
	// Se suma 4 al PC
	Sumador sumarPC(
		.A(dataPC), 
		.B(sumar4), 
		.O(dataPC4)
	);
	
	Sumador sumarBNE(
		.A(dataPC), 
		.B(intExtend), 
		.O(sumBNE)
	);
	
	Mux4entradas selPC(
		.A(dataPC4), 
		.B(intJAL), 
		.C(sumBNE), 
		.D(intJAL), 
		.O(outMux4), 
		.sel(contMux4)
   );
	
	memoriaInstrucciones memoriaPC (
		.A(dataPC), 
		.RD(outINPUT)
	);

endmodule
