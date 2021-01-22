`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:09 01/16/2021 
// Design Name: 
// Module Name:    Execute 
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
Se encarga de hacer las operaciones aritmético lógicas y se encarga de cual valor poner en las entradas de la ALU

- Entradas
inR1: Valor del registro R1
inR2: Valor del registro R2
inPC: Valor del PC
inExtend: Valor proveniente de la salida del bloque entend
selALU_JAL: Señal de control para el mux que selecciona enre el PC y el valor de R1
selALU_src: Señal de control para el mux que selecciona entre el valor de R2 y el inmediato
contALU: Señal de control que indica la operación de la ALU a realizar

- Salidas
resALU: Resultado de la ALU
Znegado: Flag que se activa cuando el resultado es diferente de cero

*/

module Execute(inR1, inR2, inPC, inExtend, selALU_JAL, selALU_src, contALU, resALU, Znegado
   );
	
	input [31:0] inR1, inR2, inPC, inExtend; // Entradas para las operaciones de la ALU
	input selALU_JAL, selALU_src;  // Senial de control de los muxes
	input [2:0] contALU;  // Controla las operaciones de la ALU
	output [31:0] resALU; // Resultados de la ALU
	output Znegado; //

	wire [31:0] inA, inB;  // Entradas que van conectadas al mux2 y a la ALU

	Mux2entradas muxJAL ( // Mux que selecciona entre PC y el valor de R2
		.A(inR1), 
		.B(inPC),
		.O(inA), 
		.sel(selALU_JAL)
	);
	
	Mux2entradas muxInmediato ( // Mux que selecciona entre el valor de R2 y el inmediato
		.A(inR2), 
		.B(inExtend),
		.O(inB), 
		.sel(selALU_src)
	);
	
	ALU alu ( // ALU
		.A(inA), 
		.B(inB), 
		.O(resALU),
		.sel(contALU),
		.Z(Znegado)
	);

endmodule
