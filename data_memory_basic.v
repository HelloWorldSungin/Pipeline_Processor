
/*
* Data Memory (Main Memory, DRAM):
*/
module data_memory_basic (
	clk,
	reset,
	wr_en,
	rd_en,
	addr,
	wr_data,
	rd_data
//	ready
);
//--Input Ports--------------
input clk, reset;
input wr_en, rd_en;
input [31:0] addr;
input [31:0] wr_data;
//--Output Ports----------
output [31:0] rd_data;
//output reg [31:0] rd_data;
//output reg ready;

//--Registers-------------
reg [31:0] RAM[0:127];
reg [31:0] i;

initial begin
	for (i = 0; i < 128; i=i+1) RAM[i] = i;
	RAM[0] = 8; RAM[1] = 7; RAM[2] = 15; RAM[3] = 25; RAM[4] = 1;
	RAM[5] = 29; RAM[6] = 107; RAM[7] = 5; RAM[8] = 33; RAM[9] = 101;
end

//assign rd_data = RAM[addr[31:2]]; // word aligned
assign rd_data = RAM[addr];

//--Synchronous----------------------
always @ (posedge clk or posedge reset) begin
	if (reset) begin end
	else begin
		if (wr_en) RAM[addr] <= wr_data;
	end
end//always
endmodule
