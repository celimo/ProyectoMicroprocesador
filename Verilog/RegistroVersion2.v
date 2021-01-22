`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:12 01/17/2021 
// Design Name: 
// Module Name:    RegistroVersion2 
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

/*
- Objetivo del módulo
El módulo contiene los 32 bits de la arquitectura de RISCV

- Entradas
A1: Contiene la dirección a acceder del registro 1
A2: Contiene la dirección a acceder del registro 2
A3: Contiene la dirección a acceder del registro a escribir
WR3: Contiene el valor a escribir en A3
writeRegister: Indica si se debe escribir en A3
clock: Señal de clock
reset: Reiniciar los registros 

- Salidas
R1: Valor del registro en la dirección de A1
R2: Valor del registro en la dirección de A2

*/

module Registro2(A1, A2, A3, WR3, writeRegister, R1, R2, clock, reset
	);

	input [4:0] A1, A2, A3;
	input [31:0] WR3;
	input writeRegister, clock, reset;
	output [31:0] R1, R2;

	reg [31:0] registros [31:0];
	 
	integer i;
	initial begin										//inicialización de la memoria
		for (i=0; i <= 31; i=i+1) begin				//debido al límite de 250 loops del software ISE
			registros[i] = 0;
		end
		i = 0;
	end
	
	always@(posedge clock)
	begin
		if (reset) // Reset
		begin
			for (i = 0; i<32; i =i+1) // Reinicia el valor de los registros
			begin
				registros[i] = 0;
			end
		end
		else
		begin
			if (writeRegister) // Escribir en un registro
			begin
				if(A3 != 0) // El registro cero no se escribe
				begin
					registros[A3] = WR3;
				end
			end // Fin del if de escritura
		end // Fin if del reset
	end
	
	assign R1 = registros[A1];
	assign R2 = registros[A2];

endmodule
