`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:16:32 01/13/2021
// Design Name:   extend
// Module Name:   Z:/semestres TEC/Semestres/IV Semestre/digital/TAREA2/TAREA2SANABRIAJORGE/PruebEXTEND9.v
// Project Name:  TAREA2SANABRIAJORGE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: extend
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebEXTEND;

	//Objetivo de la prueba:
	// Verificar el adecuado funcionamiento del bloque extend.
	//Para observar correctamente la simulacion colocar en el tiempo 0.6


		// Inputs
		reg [31:6] A;
		reg [2:0] sel;

		// Outputs
		wire [31:0] O;

		// Instantiate the Unit Under Test (UUT)
		Extend uut (
			.A(A), 
			.O(O), 
			.sel(sel)
		);
	integer i=0;
		initial begin
			// Initialize Inputs
			
			//Se prueba con dos valores de entradas, con el fin de ver la extencion con signo
			//A = 'b00011011101100101011001010;
			A = 'b10011011101100101011001010;
			sel = 0;

			// Wait 100 ns for global reset to finish
			#100;
			
			//Por medio del for se simularan todos las posibilidades del extend
			//en el mismo orden que se colocaron en el case.
			for (i=0;i<=5;i=i+1)
			begin
				sel = sel + 1;
				#100;
			end; 
			// Add stimulus here

	// Se espera que la concatenacion se cumpla de manera correcta, ademas que la extencion 
	//del signo se logre, lo cual se logra satisfactoriamente

	end
endmodule

