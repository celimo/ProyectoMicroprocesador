`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:08:29 01/16/2021
// Design Name:   Fetch
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaFetch.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaFetch;

	// Objetivo de la simulación
	// Comprobar que los saltos del PC se realizan de manera correcta y la salida coincida con la dirección
	// especificada
	
	// Inputs
	reg [31:0] intExtend;
	reg [31:0] intJAL;
	reg [1:0] contMux4;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] outINPUT;
	wire [31:0] dataPC;
	wire [31:0] dataPC4;

	// Instantiate the Unit Under Test (UUT)
	Fetch uut (
		.intExtend(intExtend), 
		.intJAL(intJAL),
		.contMux4(contMux4), 
		.clock(clock), 
		.reset(reset), 
		.outINPUT(outINPUT),
		.dataPC4(dataPC4),
		.dataPC(dataPC)
	);

	initial begin
		// Initialize Inputs
		intExtend = 10;
		intJAL = 12;
		contMux4 = 0;
		clock = 0;
		reset = 1;

		// Wait 10 ns for global reset to finish
		#10;
		
		reset = 0;
		// Es espera que el siguiente valor de PC sea el de PC + 4
		
		#10;
		
		contMux4 = 1;
		// Se espera que el valor de PC sea el de intJAL
		
		#10;
		
		contMux4 = 2;
		// Se espera que el valor de PC sea el de la suma del PC actual con la entrada del Extend (intExtend)
		
		#10;
		
		contMux4 = 3;
		// El valor de PC debe ser de intJALR
		
		$stop;

	end
	
	initial forever #5 clock = ~clock;
      
endmodule

