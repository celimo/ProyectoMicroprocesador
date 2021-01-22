`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:33 01/15/2021 
// Design Name: 
// Module Name:    memoria_datos 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//Objetivo del modulo
//Este es el modulo de memoria de datos encargado de almacenar la información que
//deba ser movida a este nivel de memoria, permite guardar tanto una palabra completa
//como un byte, además de la lectura de toda una palabra

module memoriaDatos (
		input [31:0] A,  								//direccion de memoria sobre la que se trabaja
		input [31:0] WD, 								//datos a escribir en memoria
		input MW,		  								//activar escritura en memoria
		input SB,		  								//activar escritura de 1 byte
		input clock,
		input loadByte,
		output reg [31:0] RD     						//salida de datos de memoria
	);

	reg [31:0] memoria[255:0];  				//memoria de 32 bits y 256 filas
	wire [7:0] direccion = A[9:2];				//dado que cada fila es de 4 bytes
															//la direccion para buscar dentro de la memoria
															//se registra hasta el bit A[2]
	
	integer i;										//contadores para inicializar la memoria
	
	initial begin										//inicialización de la memoria
		for (i=0; i<250; i=i+1) begin
			memoria[i] = 0;
		end
		for (i=250;i<256; i=i+1)
		begin
			memoria[i] = 0;
		end
	end
	
	reg [31:0] copia;									//registro auxiliar para realizar store byte
	
	always @(posedge clock) begin
		if (MW) begin									//cuando se desea escribir a memoria...
			if (SB) begin								//***un solo byte a memoria
				copia = memoria[direccion];		//copiar la palabra en la direccion de memoria al registro auxiliar
				copia[7:0] = WD[7:0];				//escribe sobre el byte 0 de la copia
				memoria[direccion] = copia;		//escribir los datos de la copia sobre la misma palabra en la memoria
			end
			else begin									//***toda la palabra a memoria
				memoria[direccion] = WD;			//escribir los datos de WD en la direccion de memoria
			end
		end
	end
	
	reg [31:0] copiaLoad = 0;
	
	always @(negedge clock) begin
		if (loadByte) begin
			copiaLoad = memoria[direccion];
			RD = {24'b0, copiaLoad[7:0]};
		end
		else
		begin
			RD = memoria[direccion];				   //colocar a la salida la palabra en la direccion de memoria
		end
	end
endmodule 