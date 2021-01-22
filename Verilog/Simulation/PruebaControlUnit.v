`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:10 01/13/2021
// Design Name:   ControlUnit
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/Simulation.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlUnit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaControlUnit;

	/*
	Objetivo
	Comprobar que las salidas de la unidad de control correspondan con la tabla de verdad realizada
	*/

	// Inputs
	reg [6:0] opcode;
	reg [2:0] funct3;
	reg [6:0] funct7;

	// Outputs
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

	// Instantiate the Unit Under Test (UUT)
	ControlUnit uut (
		.opcode(opcode), 
		.funct3(funct3), 
		.funct7(funct7), 
		.branch(branch), 
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

	initial begin
		// Initialize Inputs
		opcode = 0;
		funct3 = 0;
		funct7 = 0;
		
		// Wait 100 ns for global reset to finish
		#20;
        
		// Add stimulus here
		
		// LUI
		opcode = 7'b0110111;
		funct3 = 3'b010;
		funct7 = 47;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 1;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b101;
		contALU = 3'b000;
		*/
		
		#20; // Espera 20ns
		
		// JAL
		opcode = 7'b1101111;
		funct3 = 3'b011;
		funct7 = 100;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 1;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = x;
		contJAL = 1;
		contJALR = 1;
		contExt = 3'b010;
		contALU = 3'b000;
		*/
		
		#20;
		
		// JALR
		opcode = 7'b1100111;
		funct3 = 3'b111;
		funct7 = 97;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 1;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 1;
		contExt = 3'b000;
		contALU = 3'b000;
		*/
		
		#20;
		
		// BNE
		opcode = 7'b1100011;
		funct3 = 3'b000;
		funct7 = 3;
		
		// Resultados esperados 
		/*
		branch = 1;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = x;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b011;
		contALU = 3'b001;
		*/
		
		#20;
		
		// LW
		opcode = 7'b0000011;
		funct3 = 3'b010;
		funct7 = 7'b0000000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = 0;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 1;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b101;
		contALU = 3'b000;
		*/
		
		#20;
		
		// LBU
		opcode = 7'b0000011;
		funct3 = 3'b100;
		funct7 = 7'b0011000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = 1;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 1;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b101;
		contALU = 3'b000;
		*/
		
		#20;
		
		// SB
		opcode = 7'b0100011;
		funct3 = 3'b000;
		funct7 = 7'b0100100;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 1;
		PC_Source = 0;
		loadByte = x;
		writeReg = 0;
		ALU_src = 1;
		writeMem = 1;
		memReg = x;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b100;
		contALU = 3'b000;
		*/
		
		#20;
		
		// SW
		opcode = 7'b1100011;
		funct3 = 3'b010;
		funct7 = 7'b1000101;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = 0;
		writeReg = 0;
		ALU_src = 1;
		writeMem = 1;
		memReg = x;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b100;
		contALU = 3'b000;
		*/
		
		#20;
		
		// ADDI
		opcode = 7'b0010011;
		funct3 = 3'b000;
		funct7 = 7'b0110000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b000;
		contALU = 3'b000;
		*/
		
		#20;
		
		// XORI
		opcode = 7'b0010011;
		funct3 = 3'b100;
		funct7 = 7'b0101000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b000;
		contALU = 3'b010;
		*/
		
		#20;
		
		// ANDI
		opcode = 7'b0010011;
		funct3 = 3'b111;
		funct7 = 7'b0000111;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b000;
		contALU = 3'b011;
		*/
		
		#20;
		
		// SLLI
		opcode = 7'b0010011;
		funct3 = 3'b001;
		funct7 = 7'b0000000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b001;
		contALU = 3'b100;
		*/
		
		#20;
		
		// SRLI
		opcode = 7'b0010011;
		funct3 = 3'b101;
		funct7 = 7'b0000000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b001;
		contALU = 3'b101;
		*/
		
		#20;
		
		// SRAI
		opcode = 7'b0010011;
		funct3 = 3'b101;
		funct7 = 7'b0100000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 1;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b001;
		contALU = 3'b110;
		*/
		
		#20;
		
		// ADD
		opcode = 7'b0110011;
		funct3 = 3'b000;
		funct7 = 7'b0000000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 0;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = x;
		contALU = 3'b000;
		*/
		
		#20;
		
		// SUB
		opcode = 7'b0110011;
		funct3 = 3'b000;
		funct7 = 7'b0100000;
		
		// Resultados esperados 
		/*
		branch = 0;
		storeByte = 0;
		PC_Source = 0;
		loadByte = x;
		writeReg = 1;
		ALU_src = 0;
		writeMem = 0;
		memReg = 0;
		contA1 = 0;
		contJAL = 0;
		contJALR = 0;
		contExt = 3'b000;
		contALU = 3'b001;
		*/
		
	end
      
endmodule

