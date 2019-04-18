/*
 * file: mips_pipe.v
 */

module mips_pipeline(
	input clk, reset,
	input [31:0] instr_d, read_data,
	output memwrite,
	output [31:0] pc, 
	output [31:0] exec_out, 
	output [31:0] write_data);

wire eq_ne, outputbranch, jump;
wire memread, alusrc, regwrite, memtoreg, regdst, se_ze;
wire [1:0] pcsrc, outselect;
wire [3:0] aluop;

wire start_mult, mult_sign;

wire [5:0] op, func;
assign op = instr_d[31:26];
assign func = instr_d[5:0];

/* Controller */
controller c (op, func, eq_ne, pcsrc, outselect,
	memwrite, memread, regwrite, outputbranch, alusrc, aluop, se_ze,
	regdst, start_mult, mult_sign, memtoreg
);

/* Datapath */
datapath dp (
	clk, reset, pc, instr_d, read_data, start_mult, mult_sign,
	pcsrc, se_ze, regwrite, regdst, alusrc, aluop, outselect, memwrite, memtoreg,
	outputbranch, eq_ne, op, func
);


endmodule
