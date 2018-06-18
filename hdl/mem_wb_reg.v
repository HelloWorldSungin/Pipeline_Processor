
module mem_wb_reg (
	clk, reset, clr,
	regwrite_m,
	memtoreg_m,
	readdata_m,
	execout_m,
	writereg_m,
	regwrite_w,
	memtoreg_w,
	readdata_w,
	execout_w,
	writereg_w
);
//--Input Ports-------------------------------------
input clk, reset, clr;
input regwrite_m;
input memtoreg_m;
input [31:0] readdata_m;
input [31:0] execout_m;
input [4:0] writereg_m;
//--Output Ports------------------------------------
output reg regwrite_w;
output reg memtoreg_w;
output reg [31:0] readdata_w;
output reg [31:0] execout_w;
output reg [4:0] writereg_w;

//--Synchronous-----------
always @ (posedge clk or posedge reset) begin
	if (reset) begin
		regwrite_w <= 0;
		memtoreg_w <= 0;
		readdata_w <= 0;
		execout_w <= 0;
		writereg_w <= 0;
	end else begin
		if (clr) begin
			regwrite_w <= 0;
			memtoreg_w <= 0;
			readdata_w <= 0;
			execout_w <= 0;
			writereg_w <= 0;
		end else begin
			regwrite_w <= regwrite_m;
			memtoreg_w <= memtoreg_m;
			readdata_w <= readdata_m;
			execout_w <= execout_m;
			writereg_w <= writereg_m;
		end
	end
end//always
endmodule
