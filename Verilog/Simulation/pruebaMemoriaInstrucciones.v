`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:01:38 01/15/2021
// Design Name:   memoria_instrucciones
// Module Name:   C:/Users/lenovo Core i5/Desktop/Armando/TEC/Micros/Proyecto/Microprocesador/Memoria_Instrucciones/test_memoria_instrucciones.v
// Project Name:  Memoria_Instrucciones
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memoria_instrucciones
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

//Objetivo del test
//Mostrar el recorrido de la memoria de instrucciones
//con todas las instrucciones necesarias para ejecutar un codigo c presentes

module pruebaMemoriaInstrucciones;

	// Inputs
	reg [31:0] A;

	// Outputs
	wire [31:0] RD;

	// Instantiate the Unit Under Test (UUT)
	memoriaInstrucciones uut (
		.A(A), 
		.RD(RD)
	);
	
	integer i = 0;
	initial begin
		// Initialize Inputs
		A = 0;
				
		// Wait 100 ns for global reset to finish
		#100; 
        
		// Add stimulus here
		for (i=1; i<64; i=i+1) begin		//se recorre la memoria de instrucciones
			A = A + 4;								//el avance es con PC+4
			#100;
		end
		
		
		
		$stop;
		
	end
endmodule 