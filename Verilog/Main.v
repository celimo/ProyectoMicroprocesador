`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:42 01/15/2021 
// Design Name: 
// Module Name:    Main 
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
Modulo principal con todos los bloques de la arqitectura

-Entradas
reset: Reinicia el valor de los registros y del PC
clock: Señal de reloj

-Salidas
GPIO: Señal que contiene el valor de memoria de la dirección 0xABCD

*/

module Main(reset, clock, GPIO
   );
	// Versión 1.2 del Main
	// Incluye el decode y el execute
	
	input clock, reset;
	output [31:0] GPIO;
	wire [31:0] INPUT;
	
	// Entradas de la unidad de control
	wire [6:0] opcode = INPUT[6:0];
	wire [2:0] funct3 = INPUT[14:12];
	wire [6:0] funct7 = INPUT[31:25];
	
	// Salidas de la unidad de control
	wire branch;
	wire storeByte;
	wire PC_Source;
	wire loadByte;
	wire writeReg;
	wire ALU_src;
	wire writeMem;
	wire memReg;
	wire contA1;
	wire contJAL;
	wire contJALR;
	wire [2:0] contExt;
	wire [2:0] contALU;
	
	// Unidad de control
	ControlUnit control (
		.opcode(opcode), 
		.funct3(funct3), 
		.funct7(funct7), 
		.branch(branch),
		.reset(reset),
		.storeByte(storeByte), 
		.PC_Source(PC_Source), 
		.loadByte(loadByte), 
		.writeReg(writeReg), 
		.ALU_src(ALU_src), 
		.writeMem(writeMem), 
		.memReg(memReg), 
		.contA1(contA1), 
		.contJAL(contJAL), 
		.contJALR(contJALR), 
		.contExt(contExt), 
		.contALU(contALU)
	);
	
	wire [31:0] PC4; // Cable que contiene el resultado de PC + 4
	wire [31:0] PC;  // Cablo que contiene el dato de PC
	wire MSB_Mux4;
	wire [1:0] contMux4;
	
	wire [31:0] outR1, outR2, outExtend;
	wire [31:0] resALU;
	wire zNegado;
	
	wire [31:0] writeW3;
	
	assign MSB_Mux4 = (branch & zNegado) | contJALR; // Logica combinacional para el MSB del control del Mux-selPC
	
	assign contMux4 = {MSB_Mux4, PC_Source}; // Se concatenan los bits para la señal de contol del Mux-selPC
	
	Fetch fetch(
		.intExtend(outExtend), 
		.intJAL(writeW3), 
		.contMux4(contMux4), 
		.clock(clock), 
		.reset(reset), 
		.outINPUT(INPUT), // Se utiliza cuando esté la memoria
		.dataPC4(PC4),
		.dataPC(PC)
   );
	
	Decode decode (
		.INPUT(INPUT), 
		.PC4(PC4),
		.clock(clock),
		.WriteData(writeW3), // Dato a ser guardado en el registro
		.R1(outR1), // Salida R1
		.R2(outR2), // Salida R2
		.outExtend(outExtend), 
		.contA1(contA1), 
		.contJALR(contJALR), 
		.WriteReg(writeReg),
		.reset(reset),
		.contExtend(contExt)
	);
	
	Execute execute(
		.inR1(outR1), 
		.inR2(outR2), 
		.inPC(PC), 
		.inExtend(outExtend),
		.selALU_JAL(contJAL), 
		.selALU_src(ALU_src),
		.contALU(contALU),
		.resALU(resALU), 
		.Znegado(zNegado)
   );
	
	Memory memory(
		.inALU(resALU), 
		.inDataMemory(outR2), 
		.writeMemory(writeMem), 
		.storeByte(storeByte), 
		.loadByte(loadByte), 
		.memReg(memReg), 
		.writeData(writeW3),
		.dataGPIO(GPIO),
		.clock(clock),
		.reset(reset)
   );

endmodule
