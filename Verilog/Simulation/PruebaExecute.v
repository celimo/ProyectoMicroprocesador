`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:41:02 01/22/2021
// Design Name:   Execute
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaExecute.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Execute
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaExecute;

	//Objetivo de la prueba
	// Se verifica que las señales de control junto con la ALU funcionen de manera de correcta

	// Inputs
	reg [31:0] inR1;
	reg [31:0] inR2;
	reg [31:0] inPC;
	reg [31:0] inExtend;
	reg selALU_JAL;
	reg selALU_src;
	reg [2:0] contALU;

	// Outputs
	wire [31:0] resALU;
	wire Znegado;

	// Instantiate the Unit Under Test (UUT)
	Execute uut (
		.inR1(inR1), 
		.inR2(inR2), 
		.inPC(inPC), 
		.inExtend(inExtend), 
		.selALU_JAL(selALU_JAL), 
		.selALU_src(selALU_src), 
		.contALU(contALU), 
		.resALU(resALU), 
		.Znegado(Znegado)
	);

	initial begin
		// Initialize Inputs
		inR1 = 0;
		inR2 = 0;
		inPC = 0;
		inExtend = 0;
		selALU_JAL = 0;
		selALU_src = 0;
		contALU = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		inR1 = 2;
		inR2 = 3;
		inPC = 8;
		inExtend = 40;
		selALU_JAL = 0;
		selALU_src = 0;
		contALU = 0;
		
		// Se espera que el resultado sea la suma 2 + 3
		
		#10;
		
		selALU_JAL = 1; // Señal de control para sumar el PC
		selALU_src = 1; // Señal de control para seleccinoar inmediato 
		
		// El resultado se espera que sea 40 + 8
		
		#10;
		selALU_JAL = 0;
		
		// El resultado se espera que sea 2 + 40
		
		#10;
		
		$stop;
        
		// Add stimulus here

	end
      
endmodule

