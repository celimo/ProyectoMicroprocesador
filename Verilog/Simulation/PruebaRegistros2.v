`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:27 01/17/2021
// Design Name:   Registro2
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaRegistros2.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Registro2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaRegistros2;

	// Inputs
	reg [4:0] A1;
	reg [4:0] A2;
	reg [4:0] A3;
	reg [31:0] WR3;
	reg writeRegister;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] R1;
	wire [31:0] R2;

	// Instantiate the Unit Under Test (UUT)
	Registro2 uut (
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.WR3(WR3), 
		.writeRegister(writeRegister), 
		.R1(R1), 
		.R2(R2),
		.clock(clock),
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		A1 = 0;
		A2 = 0;
		A3 = 0;
		WR3 = 0;
		writeRegister = 0;
		clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		writeRegister = 1;
		A3 = 5;
		WR3 = 874;
		
		#100
		A1 = 5;
		A3 = 20;
		WR3 = 83948;
		#100
		
		writeRegister = 0;
		A2 = 20;
		A3 = 20;
		WR3 = 8;
		#100;
        
		// Add stimulus here
		
		// Se espera que el bloque registro ponga las salidas R1 y R2 dependiendo de la dirección seleccionada
		// Además que el bloque guarde correctamente el valor de WR3 en la dirección de A3

	end
	
	initial forever #25 clock = ~clock;
      
endmodule

