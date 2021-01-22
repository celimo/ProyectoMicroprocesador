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

	// Inputs
	reg [31:0] intExtend;
	reg [31:0] intJAL;
	reg [31:0] intJALR;
	reg [1:0] contMux4;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] outINPUT;

	// Instantiate the Unit Under Test (UUT)
	Fetch uut (
		.intExtend(intExtend), 
		.intJAL(intJAL), 
		.intJALR(intJALR), 
		.contMux4(contMux4), 
		.clock(clock), 
		.reset(reset), 
		.outINPUT(outINPUT)
	);

	initial begin
		// Initialize Inputs
		intExtend = 10;
		intJAL = 12;
		intJALR = 14;
		contMux4 = 0;
		clock = 0;
		reset = 1;

		// Wait 10 ns for global reset to finish
		#10;
		
		reset = 0;
		
		#10;
		
		$stop;

	end
	
	initial forever #5 clock = ~clock;
      
endmodule

