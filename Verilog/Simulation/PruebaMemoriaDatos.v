`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:49:45 01/15/2021
// Design Name:   memoria_datos
// Module Name:   C:/Users/lenovo Core i5/Desktop/Armando/TEC/Micros/Proyecto/Microprocesador/Memoria_Datos/test_memoria_datos.v
// Project Name:  Memoria_Datos
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memoria_datos
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

//Objetivo del test
//Mostrar que se puede leer toda una palabra en una dirección de memoria y
//escribir sobre una dirección de memoria tanto una palabra como un byte

module PruebaMemoriaDatos;

	// Inputs
	reg [31:0] A;
	reg [31:0] WD;
	reg MW;
	reg SB;
	reg clock;
	reg loadByte;

	// Outputs
	wire [31:0] RD;

	// Instantiate the Unit Under Test (UUT)
	memoriaDatos uut (
		.A(A), 
		.WD(WD), 
		.MW(MW), 
		.SB(SB),
		.RD(RD),
		.loadByte(loadByte),
		.clock(clock)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		WD = 0;
		MW = 0;
		SB = 0;
		loadByte = 0;
		clock = 0;
		
		//Antes de hacer esta prueba se debe modificar la incializazión de la memoria, para indentificar los resultados

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here		
		A = 24;		//leer el dato en la posición de memoria 24 = palabra 6
		WD = 0;		//no hay dato a escribir en memoria
		MW = 0;		//aun no se escribe en memoria
		SB = 0;		//no se escribe sobre un byte especifico
		#100;
		
		A = 72;		//escribir el dato en la posición de memoria 72 = palabra 18
		MW = 1;		//activar escritura en memoria
		SB = 1;		//activar guardado de un byte especifico
		WD = 1114;	//dato a almacenar en memoria
		#100;
		
		A = 16'hABCD;		//escribir el dato en la posición de memoria ABCD = palabra 10995
		MW = 1;				//activar escritura en memoria
		SB = 0;				//apagar escritura de un byte específico
		WD = 20477356;		//dato a almacenar en memoria
		#100

		$stop;
		
	end
   
	//se obtiene el resultado esperado, se lee un dato a partir de una posición de memoria (palabra)
	//se puede escribir un byte sobre una palabra en la memoria
	//y tambien se puede sobrescribir toda una palabra completa
	
	initial forever #50 clock = ~clock;
	
endmodule

