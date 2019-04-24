
module reg_file (
	input Clk, Reset, Write,
	input [4:0] PR1, PR2, WR,
	input [31:0] WD,
	output reg [31:0] RD1, RD2
	//output [31:0] RD1, RD2
);
	reg [31:0] rf[31:0];
	reg [31:0] i;
	initial begin             //set values to rf just for testbench
	for( i = 0; i < 32; i = i + 1)
		rf[i] = i;
	end

	always @ (posedge Clk, posedge Reset) begin
		if(Reset) begin         //setting synchronnous reset at positive clk edge
			RD1 <= 0;
			RD2 <= 0;
		end
		else if(Write)  //write to the memory if write = 1, Reset = 0, and on a raising edge of the clock
			rf[WR] <= WD;
		end

	always @ (negedge Clk) begin //Read the memory if write = 0 and on a falling edge of the clock
		if(Write == 0 && WR == 0) begin
			RD1 <= (PR1 != 0) ? rf[PR1] : 0;
			RD2 <= (PR2 != 0) ? rf[PR2] : 0;
		end
	end

endmodule
