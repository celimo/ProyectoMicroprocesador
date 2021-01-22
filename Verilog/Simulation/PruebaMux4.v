`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:27:18 01/11/2021
// Design Name:   Mux4entradas
// Module Name:   Z:/semestres TEC/Semestres/IV Semestre/digital/TAREA2/TAREA2SANABRIAJORGE/PruebaMux.v
// Project Name:  TAREA2SANABRIAJORGE
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Mux4entradas
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaMux4;
//Objetibo de la prueba
//Verificar el correcto funncionamiento del MUX de 4 entradas
//Para ver todas las convinaciones colocar en el tiempo 0.40
	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] C;
	reg [31:0] D;
	reg [1:0] sel;

	// Outputs
	wire [31:0] O;

	// Instantiate the Unit Under Test (UUT)
	Mux4entradas uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.O(O), 
		.sel(sel)
	);
integer i=0;
	initial begin
		// Initialize Inputs
		// commo el mux lo que va a hacer es elejir una de las 4
		//entradas sse les colocara un valor distinto a todas
		//recordar que cuando el sel=3 a D se le agrega un 0 en el bit menos significativo
		A = 3;
		B = 5;
		C = 7;
		D = 11;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// con el for lo que cambia es el valor del sel, para visualizar todas las obciones
      for (i=0;i<=2;i=i+1)
      begin
			sel = sel + 1;
			#100;
      end;
		// Add stimulus here
		
		// Lo que se espera es que cada vez que cambie el selector tambien cambie el 
		//valor de la salida, segun la entrada que se seleccione con el mux

	end
endmodule

