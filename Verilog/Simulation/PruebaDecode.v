`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:41:57 01/16/2021
// Design Name:   Decode
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaDecode.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decode
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaDecode;
	// Objetivo de la prueba:
	/*
	En esta prueba se requiere ver que al unir los bloques, extend, registros y mux2,
	en otras palabras se está haciendo el decode, se realice el correcto funcionamiento 
	y a partir de la entrada INPUT corroborar el comportamiento de los registros, y la salida del extend
	*/
	
	// Recomendaciones para la simulación
	/*
	Poner un step de 50ns, la simulación tienen una duración de 400ns en total
	Este step es para ver el comportamiento de los cables internos y corroborar que todo funcione
	*/
	
	// Inputs
	reg [31:0] INPUT;
	reg [31:0] PC4;
	reg [31:0] WriteData;
	reg contA1;
	reg contJALR;
	reg WriteReg;
	reg [2:0] contExtend;

	// Outputs
	wire [31:0] R1;
	wire [31:0] R2;
	wire [31:0] outExtend;

	// Instantiate the Unit Under Test (UUT)
	Decode uut (
		.INPUT(INPUT), 
		.PC4(PC4), 
		.WriteData(WriteData), 
		.R1(R1), 
		.R2(R2), 
		.outExtend(outExtend), 
		.contA1(contA1), 
		.contJALR(contJALR), 
		.WriteReg(WriteReg), 
		.contExtend(contExtend)
	);

	initial begin
		// Initialize Inputs
		INPUT = 32'h7BC88693;  // Se asigna una entrada típica de RISC-V
		PC4 = 0;  // Para esta simulación no tiene tanta importancia
		WriteData = 15;  // Dato que será escrito en el registro 13
		contA1 = 1;  // Al inicio de la simulación, la salida del registro R1 debe ser cero
		contJALR = 0;  // Indica que la entrada a escribir a los registros es el valor de WriteData
		WriteReg = 0;  // No se debe escribir en los registros
		contExtend = 3'b000;  // Selector para las operaciones del Extend
		
		// Resultados
		/*
		Se espera que la salida de outExtend sea de 000007bc
		Ya que no se han guardado datos en los registros las salidas R1 y R2 deben ser cero
		Internamente se debe corroborar que el mux de 2 entradas seleccione el WriteData en lugar de PC4
		*/

		// Wait 100 ns for global reset to finish
		#100;
		
		INPUT = 32'h8BC88693; // Se cambia el número inmediato a uno negativo
		PC4 = 0;
		WriteData = 15;
		contA1 = 0;  // La salida de R1 debe ser el valor en el registro 17
		contJALR = 1;  // Indica que la entrada a escribir a los registros es el valor de PC4
		WriteReg = 0;
		contExtend = 3'b000;
		
		// Resultados
		/*
		La salida de outExtend debe ser FFFFF8BC
		La salida de los registros debe ser cero
		Internamente el valor que llega WR3 del bloque resgistros debe ser el valor de PC4
		*/
		
		#100;
		
		INPUT = 32'h7BC88693;
		PC4 = 0;
		WriteData = 15;
		contA1 = 0;
		contJALR = 0;  // Indica que la entrada a escribir a los registros es el valor de WriteData
		WriteReg = 1;  // Se escribe el dato 15 en el registro 13
		contExtend = 3'b000;
		
		// Ya se obtuvieron resultados similares anteriormente, solo que en este caso se guarda el dato de WriteData
		// al registro 13
		
		#100;
		
		INPUT = 32'h7BC68693;  // Se pide el dato en el registro 13
		PC4 = 0;
		WriteData = 15;
		contA1 = 0;
		contJALR = 0;
		WriteReg = 0;
		contExtend = 3'b000;
		
		// Se comprueba que el valor del registro 13 sea de 32'd15
		
		#100
		
		$stop;
        
		// Add stimulus here

	end
      
endmodule

