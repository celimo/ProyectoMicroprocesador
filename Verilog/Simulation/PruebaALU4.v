`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:04:55 01/13/2021
// Design Name:   alu
// Module Name:   Z:/semestres TEC/Semestres/IV Semestre/digital/TAREA2/TAREA2SANABRIAJORGE/PruebaALU4.v
// Project Name:  TAREA2SANABRIAJORGE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaALU;
//Objetivo:
//Revisar que se realice adecuadamente las operaciones de la alu
//Realizar la simulacion con un tiempo de 0.70
	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] sel;

	// Outputs
	wire [31:0] O;
	wire Z;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.O(O), 
		.sel(sel), 
		.Z(Z)
	);
integer i=0;
	initial begin
		// Initialize Inputs
		//Para la prueba se colocan cualesquiera 2 valores de entrada
		// en decimal, los cuales no deben superar los 32bit
		A = 20;
		B = 5;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		//Por medio del For se correran todas las operaciones de la alu
		for (i=0;i<=5;i=i+1)
      begin
			sel = sel + 1;
			if (sel == 3'b101) begin
				B = 3;
			end else if (sel == 3'b110) begin
				A = -1;
				B = 5;
			end else begin
				A = 20;
				B = 5;
			end
			#100;
      end; 
		// Add stimulus here
		//En donde para la operacion add y sub puede ser mas facil de revisar en decimal
		// ya que seria mas sencillo revisar dichas operaciones en esta notacion
		//Para las demas operaciones se aconseja revisarlo en binario, ya que para el caso de la xor
		// su salida es 1  cuando los operandos son distintos, para la and su salida sera 1
		// cuando sus dos entradas son 1, y para los corrimientos queda mas sencillo contarlos
		// todas las operaciones se realizan de manera correcta
		
		
		// se debe tomar en cuenta que los corrimientos pueden probocar desvordamientos, sin embargo 
		//en el caso de corrimiento a la derecha genere que la salida sea 0, nos sirve para revisar
		//la bandera Z

	end
      
endmodule

