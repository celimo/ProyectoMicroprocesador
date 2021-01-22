`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:56:26 01/22/2021
// Design Name:   Memory
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaMemory.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PruebaMemory;

	// Inputs
	reg [31:0] inALU;
	reg [31:0] inDataMemory;
	reg writeMemory;
	reg storeByte;
	reg loadByte;
	reg memReg;
	reg clock;
	reg reset;

	// Outputs
	wire [31:0] writeData;
	wire [31:0] dataGPIO;

	// Instantiate the Unit Under Test (UUT)
	Memory uut (
		.inALU(inALU), 
		.inDataMemory(inDataMemory), 
		.writeMemory(writeMemory), 
		.storeByte(storeByte), 
		.loadByte(loadByte), 
		.memReg(memReg), 
		.writeData(writeData), 
		.clock(clock), 
		.dataGPIO(dataGPIO), 
		.reset(reset)
	);

	initial begin
		// Objetivo de la prueba
		// Con esto se pretende observar que el bloque guarde datos en la dirección de memoria, pueda seleccinoar entre
		// los datos de la memoria y los datos provenientes de la ALU
		
		// Initialize Inputs
		inALU = 0;
		inDataMemory = 0;
		writeMemory = 0;
		storeByte = 0;
		loadByte = 0;
		memReg = 0;
		clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10;
		
		inALU = 0;
		inDataMemory = 15;
		writeMemory = 1;
		
		// Con este comando se presente ver que el valor de 50 quede guardado en la dirección 0 de la memoria
		#10;
		
		inALU = 30;
		writeMemory = 0;
		memReg = 0;
		// En este caso el valor no se debe guardar en la memoria y el resultado en la salida debe ser el valor de 30
		#10;
		
		inALU = 0;
		inDataMemory = 32'hABCD;
		memReg = 1;
		// Se verifica que el valor de 30 fuera guardado en la posición 0 de la memoria
		#10;
		
		inALU = 30;
		// Se verifica que la dirección 30 de la memoria esté en cero y no se haya modificado
		// por las instrucciones anteriores
		#10;
		
		inALU = 4;
		writeMemory = 1;
		storeByte = 1;
		
      // Se guarda el byte menos significativo el valo esperado a guardar en la dirección 4 es ABCD
		#10;
		inALU = 8;
		inDataMemory = 32'hF938A;
		writeMemory = 1;
		storeByte = 0;
		
		// Se guarda el dato F938A para luego comprobar que se puede usar el loadByte
		
		#10;
		inALU = 8;
		writeMemory = 0;
		loadByte = 1;
		
		// Se verifica que solo cargue el valor de 8A como resultado final
		#10;
		$stop;
		
	end
	
	initial forever #5 clock = ~clock;
      
endmodule

