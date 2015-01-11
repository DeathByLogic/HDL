`timescale 1us / 1ns

module BitCounter(CLK, WrEn, Input, Count);
	// Module Parameters
	parameter INPUT_WIDTH = 10;
	parameter COUNT_WIDTH = 4;
	parameter COUNT_TYPE = 0;

	// I/O Signal Definitions
	input CLK;
	input WrEn;
	input [INPUT_WIDTH - 1:0] Input;
	output reg [COUNT_WIDTH - 1:0] Count;
   
	// Interal Signal Definitions
	integer Count_i;
   integer i;
	
	always @(posedge CLK)
	begin
		if (WrEn) begin
			Count_i = 0;
		  
			for (i = 0; i < INPUT_WIDTH; i = i + 1)
				if (Input[i] == 1)
					Count_i = Count_i + 1;
		
			Count <= Count_i;
		
		end  
	
	end
endmodule
