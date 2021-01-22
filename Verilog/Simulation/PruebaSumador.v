`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:56:18 01/15/2021
// Design Name:   Sumador
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaSumador.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sumador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaSumador;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] O;

	// Instantiate the Unit Under Test (UUT)
	Sumador uut (
		.A(A), 
		.B(B), 
		.O(O)
	);

	initial begin
	
		// Objetivo de la prueba
		// Validar el comportamiento del módulo sumador
		// Initialize Inputs
		
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		A = 1000;
		B = 1305;
		
		#10;
		
		A = 387;
		B = -100;
		
		#10;
		
		A = 996;
		B = 4;
		
		#10;
		
		A = 45;
		B = -50;
        
		// Add stimulus here
		// Los resultados esperados son que la salida corresponda con la suma de las entradas A y B
	end
      
endmodule

