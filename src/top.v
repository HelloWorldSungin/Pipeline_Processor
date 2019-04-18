/*
 * file: top.v
 */

module top (
	input clk, reset,
	output [31:0] write_data, exec_out,
	output memwrite
);
	//wire memwrite;
	wire [31:0] pc, instr_d, read_data;

	mips_pipeline mp (clk, reset, instr_d, read_data, memwrite, pc, exec_out, write_data);
	//inst_memory imem (pc, instr);
	//data_memory dmem (clk, memwrite, exec_out, write_data, read_data);

endmodule
