`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:09:14 01/22/2021
// Design Name:   Flip_flop_GPIO
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaGPIO.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Flip_flop_GPIO
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaGPIO;
	// Objetivo de la simulación
	// Comprobar que el módulo copía el archivo solo cuando las entradas A y B son iguales y en caso contrario
	// mantiene el dato actual
	
	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [31:0] D;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] Q;

	// Instantiate the Unit Under Test (UUT)
	Flip_flop_GPIO uut (
		.A(A), 
		.B(B), 
		.D(D), 
		.Q(Q), 
		.clock(clock), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		D = 0;
		clock = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		reset = 0;
		A = 5;
		B = 3;
		D = 32'hADF;
		
		// El dato de salida esperado es de cero
		
		#20;
		
		B = 5;
		
		// En este caso las entradas son iguales y se copia el dato de D
		
		#20;
		
		A = 10;
		D = 32'hABCD;
		
		// El dato de salida debe ser de 0xADF y mantenerlo
		
		$stop;
        
		// Add stimulus here

	end
	
	initial forever #5 clock = ~clock;
      
endmodule

