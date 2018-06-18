

/*
* EXE/MEM Pipeline Register:
*/
module exe_mem_reg (
	clk, reset,
	enable,
	regwrite_e,
	memtoreg_e,
	memwrite_e,
	memread_e,
	execout_e,
	writedata_e,
	writereg_e,
	regwrite_m,
	memtoreg_m,
	memwrite_m,
	memread_m,
	execout_m,
	writedata_m,
	writereg_m
);
//--Input Ports-------------------------------
input clk, reset, enable;
input regwrite_e;
input memtoreg_e;
input memwrite_e;
input memread_e;
input [31:0] execout_e;
input [31:0] writedata_e;
input [4:0] writereg_e;
//--Outputs-----------------------------------
output reg regwrite_m;
output reg memtoreg_m;
output reg memwrite_m;
output reg memread_m;
output reg [31:0] execout_m;
output reg [31:0] writedata_m;
output reg [4:0] writereg_m;

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		regwrite_m <= 0;
		memtoreg_m <= 0;
		memwrite_m <= 0;
		memread_m <= 0;
		execout_m <= 0;
		writedata_m <= 0;
		writereg_m <= 0;
	end
	else begin
		if (enable) begin
			regwrite_m <= regwrite_e;
			memtoreg_m <= memtoreg_e;
			memwrite_m <= memwrite_e;
			memread_m <= memread_e;
			execout_m <= execout_e;
			writedata_m <= writedata_e;
			writereg_m <= writereg_e;
		end
	end
end//always

endmodule
