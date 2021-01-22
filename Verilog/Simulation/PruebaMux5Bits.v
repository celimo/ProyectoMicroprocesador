`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:16:35 01/22/2021
// Design Name:   Mux5Bits
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaMux5Bits.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mux5Bits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaMux5Bits;
	//Objetibo de la prueba
	//Verificar el correcto funncionamiento del MUX de 2 entradas con 5 bits
	
	// Inputs
	reg [4:0] A;
	reg [4:0] B;
	reg sel;

	// Outputs
	wire [4:0] O;

	// Instantiate the Unit Under Test (UUT)
	Mux5Bits uut (
		.A(A), 
		.B(B), 
		.O(O), 
		.sel(sel)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		A = 3;
		B = 5;
		
		// La salida debe ser A
		
		#20; sel = 1;
		
		// La salida debe ser B

	end
      
endmodule

