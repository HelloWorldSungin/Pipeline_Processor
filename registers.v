/*
 * file: registers.v
 */

module flopenr #(parameter WIDTH = 4) (
	input clk, reset, enable,
	input [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q
);
	always @ (posedge clk or posedge reset) begin
		if (reset) q <= 0;
		else if (enable) q <=d;
		//else q <= d;
	end//always
endmodule


module decode_register (
	input clk, reset, enable, clr,
	input [31:0] instr_f, pcplus4_f,
	output reg [31:0] instr_d, pcplus4_d
);
	always @ (posedge clk or posedge reset) begin
		if (reset | clr) begin
			instr_d <= 0;
			pcplus4_d <= 0;
		end
		else if (enable) begin
			instr_d <= instr_f;
			pcplus4_d <= pcplus4_f;
		end
		//else begin instr_d<=instr_f; pcplus4_d<=pcplus4_f; end
	end//always
endmodule

module execute_register (
	input clk, reset, clr,
	input [10:0] dec_ctrls,
	input [31:0] rd1out_d, rd2out_d, imm_d, upperimm_d,
	input [4:0] rs_d, rt_d, rd_d,
	output reg [10:0] exec_ctrls,
	output reg [31:0] rd1out_e, rd2out_e, imm_e, upperimm_e,
	output reg [4:0] rs_e, rt_e, rd_e
);
	always @ (posedge clk or posedge reset) begin
		if (reset | clr) begin
			exec_ctrls <= 0;
			rd1out_e <= 0;
			rd2out_e <= 0;
			imm_e <= 0;
			upperimm_e <= 0;
			rs_e <= 0;
			rt_e <= 0;
			rd_e <= 0;
		end
		else begin
			exec_ctrls <= dec_ctrls;
			rd1out_e <= rd1out_d;
			rd2out_e <= rd2out_d;
			imm_e <= imm_d;
			upperimm_e <= upperimm_d;
			rs_e <= rs_d;
			rt_e <= rt_d;
			rd_e <= rd_d;
		end
	end//always
endmodule


module memory_register (
	input clk, reset,
	input [2:0] exec_ctrls,
	input [31:0] aluout_e, writedata_e,
	input [4:0] writereg_e,
	output reg [2:0] mem_ctrls,
	output reg [31:0] aluout_m, writedata_m,
	output reg [4:0] writereg_m
);
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			mem_ctrls <= 0;
			aluout_m <= 0;
			writedata_m <= 0;
			writereg_m <= 0;
		end
		else begin
			mem_ctrls <= exec_ctrls;
			aluout_m <= aluout_e;
			writedata_m <= writedata_e;
			writereg_m <= writereg_e;
		end
	end
endmodule


module writeback_register (
	input clk, reset,
	input [1:0] mem_ctrls,
	input [31:0] readdata_m, aluout_m,
	input [4:0] writereg_m,
	output reg [1:0] wb_ctrls,
	output reg [31:0] readdata_w, aluout_w,
	output reg [4:0] writereg_w
);
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			wb_ctrls <= 0;
			readdata_w <= 0;
			aluout_w <= 0;
			writereg_w <= 0;
		end
		else begin
			wb_ctrls <= mem_ctrls;
			readdata_w <= readdata_m;
			aluout_w <= aluout_m;
			writereg_w <= writereg_m;
		end
	end
endmodule


