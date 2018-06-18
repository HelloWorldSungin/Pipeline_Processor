/*
 * file: mips_pipe.v
 */

module mips_cpu (
	clk, reset,
	pc_IF,
	instr_ID,
	execout_EXE,
	writedata_MEM,
	readdata_MEM,
	result_WB
);
//--Input Ports-----------------
input clk, reset;
//--Output Ports------------------
output [31:0] pc_IF;
output [31:0] instr_ID;
output [31:0] execout_EXE;
output [31:0] writedata_MEM;
output [31:0] readdata_MEM;
output [31:0] result_WB;
//--Internal Wires------------------
wire [5:0] op, func;
wire eq_ne, se_ze;
wire [1:0] pcsrc;
wire outputbranch;
wire regwrite, memtoreg;
wire memread, memwrite;
wire [1:0] regdst;
wire [1:0] outselect;
wire [3:0] aluop;
wire alusrc;


/* Controller */
controller mips_controller (
	.op(op),
	.func(func),
	.eq_ne(eq_ne),
	.pcsrc(pcsrc),
	.regwrite(regwrite),
	.memtoreg(memtoreg),
	.memwrite(memwrite),
	.memread(memread),
	.regdst(regdst),
	.outselect(outselect),
	.aluctrl(aluop),
	.alusrc(alusrc),
	.se_ze(se_ze),
	.outputbranch(outputbranch)
);

/* Datapath */
datapath dp (
	.clk(clk),
	.reset(reset),
	.pcsrc_d(pcsrc),
	.regwrite_d(regwrite),
	.memtoreg_d(memtoreg),
	.memwrite_d(memwrite),
	.memread_d(memread),
	.regdst_d(regdst),
	.outselect_d(outselect),
	.aluctrl_d(aluop),
	.alusrc_d(alusrc),
	.seze_d(se_ze),
	.outputbranch_d(outputbranch),
	.op(op),
	.func(func),
	.eq_ne(eq_ne)
);


endmodule
