`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:53:47 01/16/2021
// Design Name:   Main
// Module Name:   D:/Documentos/TEC/II semestre - 2020/Micros/Proyecto/ProyectoMicros/PruebaMain.v
// Project Name:  ProyectoMicros
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////


module PruebaMain;

	// Inputs
	reg reset;
	reg clock;
	
	wire [31:0] GPIO;

	integer i = 0;

	// Instantiate the Unit Under Test (UUT)
	Main uut ( 
		.reset(reset), 
		.clock(clock),
		.GPIO(GPIO)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clock = 0;
		
		for (i = 0; i<250; i = i + 1) // Memoria de datos
		begin
			datos[i] = 0;
		end
		for (i = 250; i<256; i = i + 1) // Memoria de datos
		begin
			datos[i] = 0;
		end
		
		// Wait 100 ns for global reset to finish
		#10;
		
		reset = 0;
        
		// Add stimulus here

	end
	
	reg [31:0] datos [255:0];
	integer f = 0;
	
	always @(posedge clock)
	begin
		if (uut.INPUT == 32'd0)
		begin
		
			reset = 1;
			$stop;
		
			for (i = 0; i<64; i = i + 1) // Memoria de instrucciones
			begin
				force uut.fetch.memoriaPC.A = i*4;
				#5;
				datos[i] = uut.fetch.memoriaPC.RD;
				#5;
			end
			
			f = $fopen("Dumps/dumpInstrucciones.txt","w");
			$fwrite(f, "Dirección   valor(hex)\n","");
			#5;
			for (i = 0; i<64; i = i +1)
			begin
				$fwrite(f, "0x%h  0x%h\n", i, datos[i]);
				#5;
			end
			$fclose(f);
			
			$stop;
			
			for (i = 0; i<250; i = i + 1) // Memoria de datos
			begin
				force uut.memory.Memoria.A = i*4;
				#10;
				datos[i] = uut.memory.Memoria.RD;
				#10;
			end
			for (i = 250; i<256; i = i + 1) // Memoria de datos
			begin
				force uut.memory.Memoria.A = i*4;
				#10;
				datos[i] = uut.memory.Memoria.RD;
				#10;
			end
			
			f = $fopen("Dumps/dumpDatos.txt","w");
			$fwrite(f, "Dirección   valor(hex)\n","");
			#5;
			for (i = 0; i<250; i = i +1)
			begin
				$fwrite(f, "0x%h  0x%h\n", i, datos[i]);
				#5;
			end
			for (i = 250; i<256; i = i +1)
			begin
				$fwrite(f, "0x%h  0x%h\n", i, datos[i]);
				#5;
			end
			$fclose(f);
			
			$stop;
			
		end // Final del if
	end // Final del always
	
	initial forever #5 clock = ~clock;
   
endmodule

