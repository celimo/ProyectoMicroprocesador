`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:21 01/13/2021 
// Design Name: 
// Module Name:    ControlUnit 
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
Modulo encargado de la unidad de control 

Este m�dulo se encarga de indicar cual operaci�n de la ALU se debe realizar, cual es el valor siguiente del PC
asi mismo, indica si se debe realizar la escritura de los registros y de la memoria de datos y tiene la se�al de
control de los muxes del circuito.

- Entradas
opcode: Son los primeros 7 bits de la instrucci�n
funct3: Son los bits 12 y 14 de la instrucci�n
funct7: Son los bits 25 y 31, se utiliza en las instrucciones tipo R
reset: Es la entrada general del circuito y esta entrada pone las salidas en un estado de cero

- Salidas
branch: Se�al de control para la instrucci�n BNE que controla la salida del mux de 4
storeByte: Le indica a la memoria cuando debe guardar un byte en la posici�n menos significativo
PC_Source: Se�al que controla la salida del mux de 4
loadByte: Le indica a la memoria de datos cuando debe cargar el byte menos significativo
writeReg: Indica al registro cuando debe guardar un valor
ALU_src: Controla la salida de un mux entre el valor de salida del bloque extend y el valor de registros
writeMem: Le indica a la memoria de datos cuando debe guardar un valor
memReg: Controla la salida del mux de 2 entradas, entre el valor de memoria o el resultado de la ALU
contA1: Cambia la entrada A1 al bloque de registros, entre el valor de cero o el que venga en la instrucci�n
contJAL: Se�al de control de un mux, para seleccionar entre el valor del PC o el valor del bloque de registro 
contJALR: Indica cuando se debe guardar en los registos el valor de PC+4 y tambi�n sirve para la salida del mux de 4
contExt: Indica la operaci�n que debe hacer el bloque extend, salida de 3 bits
contALU: Se�al de 3 bits e indica la operaci�n aritm�tica que debe realizar la ALU

*/

module ControlUnit(reset, opcode, funct3, funct7, branch, storeByte, PC_Source, loadByte, writeReg, ALU_src, writeMem, 
	memReg, contA1, contJAL, contJALR, contExt, contALU
	);

	// Entradas de la unidad de control
	input [6:0] opcode;
	input [2:0] funct3;
	input [6:0] funct7;
	input reset;

	// Se definen las salidas de control con sus valores iniciales
	output reg branch = 0, storeByte = 0, PC_Source = 0, loadByte = 0, writeReg = 0;
	output reg ALU_src = 0, writeMem = 0, memReg = 0, contA1 = 0, contJAL = 0, contJALR = 0;
	output reg [2:0] contExt = 2'b00, contALU = 2'b00;

	always@(opcode, funct3, funct7, reset)
	begin
		if (reset)  // Condici�n del reset
		begin
			branch = 0;
			storeByte = 0;
			PC_Source = 0;
			loadByte = 0;
			writeReg = 0;
			ALU_src = 0;
			writeMem = 0;
			memReg = 0;
			contA1 = 0;
			contJAL = 0;
			contJALR = 0;
			contExt = 3'b000;
			contALU = 3'b000;
		end
		else
		begin
			if (opcode == 7'b0110111) begin // Condici�n para LUI
				branch = 0;
				storeByte = 0;
				PC_Source = 0;
				writeReg = 1;
				ALU_src = 1;
				writeMem = 0;
				memReg = 0;
				contA1 = 1;
				contJAL = 0;
				contJALR = 0;
				contExt = 3'b101;
				contALU = 3'b000;
			end else if (opcode == 7'b1101111) begin // Condici�n para JAL
				branch = 0;
				storeByte = 0;
				PC_Source = 1;
				writeReg = 1;
				ALU_src = 1;
				writeMem = 0;
				memReg = 0;
				contJAL = 1;
				contJALR = 1;
				contExt = 3'b010;
				contALU = 3'b000;
			end else if (opcode == 7'b1100111) begin // Condici�n para JALR
				branch = 0;
				storeByte = 0;
				PC_Source = 1;
				writeReg = 1;
				ALU_src = 1;
				writeMem = 0;
				memReg = 0;
				contA1 = 0;
				contJAL = 0;
				contJALR = 1;
				contExt = 3'b000;
				contALU = 3'b000;
			end else if (opcode == 7'b1100011) begin // Condici�n para BNE
				branch = 1;
				storeByte = 0;
				PC_Source = 0;
				writeReg = 0;
				ALU_src = 0;
				writeMem = 0;
				contA1 = 0;
				contJAL = 0;
				contJALR = 0;
				contExt = 3'b011;
				contALU = 3'b001;
			end else if (opcode == 7'b0000011) begin //Condici�n para LW - LBU
				case (funct3)
					3'b010: // Caso para LW
					begin
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
						contExt = 3'b000;
						contALU = 3'b000;
					end
					3'b100: // Caso para LBU
					begin
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
						contExt = 3'b000;
						contALU = 3'b000;
					end
				endcase
			end else if (opcode == 7'b0100011) begin // Condici�n para SB - SW
				case (funct3)
					3'b000: // Caso para SB
						begin
							branch = 0;
							storeByte = 1;
							PC_Source = 0;
							writeReg = 0;
							ALU_src = 1;
							writeMem = 1;
							contA1 = 0;
							contJAL = 0;
							contJALR = 0;
							contExt = 3'b100;
							contALU = 3'b000;
						end
					3'b010: // Caso para SW
						begin
							branch = 0;
							storeByte = 0;
							PC_Source = 0;
							writeReg = 0;
							ALU_src = 1;
							writeMem = 1;
							contA1 = 0;
							contJAL = 0;
							contJALR = 0;
							contExt = 3'b100;
							contALU = 3'b000;
						end
				endcase
			end else if (opcode == 7'b0010011) begin // Condici�n para ADDI - XORI - ANDI - SLLI - SRLI - SRAI
				case (funct3)
					3'b000: // ADDI
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 1;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contExt = 3'b000;
						contALU = 3'b000;
					end
					3'b100: // XORI
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 1;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contExt = 3'b000;
						contALU = 3'b010;
					end
					3'b111: // ANDI
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 1;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contExt = 3'b000;
						contALU = 3'b011;
					end
					3'b001: // SLLI
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 1;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contExt = 3'b001;
						contALU = 3'b100;
					end
					3'b101: // SRLI - SRAI
					begin
						case (funct7)
							7'b0000000: // SRLI
								begin
									branch = 0;
									storeByte = 0;
									PC_Source = 0;
									writeReg = 1;
									ALU_src = 1;
									writeMem = 0;
									memReg = 0;
									contA1 = 0;
									contJAL = 0;
									contJALR = 0;
									contExt = 3'b001;
									contALU = 3'b101;
								end
							7'b0100000: // SRAI
								begin
									branch = 0;
									storeByte = 0;
									PC_Source = 0;
									writeReg = 1;
									ALU_src = 1;
									writeMem = 0;
									memReg = 0;
									contA1 = 0;
									contJAL = 0;
									contJALR = 0;
									contExt = 3'b001;
									contALU = 3'b110;
								end
						endcase
					end
				endcase
			end else if (opcode == 7'b0110011) begin // Condici�n para ADD - SUB
				case (funct7)
					7'b0000000: // ADD
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 0;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contALU = 3'b000;
					end
					7'b0100000: // SUB
					begin
						branch = 0;
						storeByte = 0;
						PC_Source = 0;
						writeReg = 1;
						ALU_src = 0;
						writeMem = 0;
						memReg = 0;
						contA1 = 0;
						contJAL = 0;
						contJALR = 0;
						contALU = 3'b001;
					end
				endcase
			end else begin // Algo falla :'c
				branch = 0;
				storeByte = 0;
				PC_Source = 0;
				loadByte = 0;
				writeReg = 0;
				ALU_src = 0;
				writeMem = 0;
				memReg = 0;
				contA1 = 0;
				contJAL = 0;
				contJALR = 0;
				contExt = 3'b000;
				contALU = 3'b000;
			end
		end // Fin de la condic�n del reset
	end // Fin del always
	 
endmodule
