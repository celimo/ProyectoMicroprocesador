`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:46:10 01/16/2021
// Design Name:   FlipFlopD
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaFlipFlopD.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FlipFlopD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaFlipFlopD;

	// Inputs
	reg [31:0] D;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] Q;

	// Instantiate the Unit Under Test (UUT)
	FlipFlopD uut (
		.D(D), 
		.Q(Q), 
		.clock(clock), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		// Objetivo de la simulación
		// Comprobar le funcionamiento del Flip-Flop tipo D
		
		D = 0;
		clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#50;
		
		D = 83745;
		// Se espera que el dato 83745 se guarde
		
		#50;
		
		D = 123;
		// Se espera que este dato no se guarde ya que está en el flanco negativo
		
		#50;
		
		D = 12035;
		// Se espera que este dato se guarde en el registro
		
		#50;
		
		reset = 1; 
		// Se espera que se reinicie el flip-flop y la salida sea cero
		
		#50;
		
		reset = 0;
		D = 1927;
		// Se espera que se guarde el dato 1927 en el flip-flop
		
		#50;
		
      
		$finish;
		// Add stimulus here

	end
	
	initial forever #50 clock = ~clock;
      
endmodule

