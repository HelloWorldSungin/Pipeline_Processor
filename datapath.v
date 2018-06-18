
module datapath (
	clk, reset,
	pcsrc_d, seze_d, outputbranch_d,
	regwrite_d, regdst_d,
	memtoreg_d, memwrite_d, memread_d,
	aluctrl_d, alusrc_d, outselect_d,
	op, func,
	eq_ne
);
//--Input Ports-----------------------------
input clk, reset;
input [1:0] pcsrc_d;
input regwrite_d;
input memtoreg_d, memwrite_d, memread_d;
input [1:0] regdst_d;
input [1:0] outselect_d;
input [3:0] aluctrl_d;
input alusrc_d;
input seze_d, outputbranch_d;
//--Output Ports---------------------------
output [5:0] op, func;
output eq_ne;
//--Internal Wires---------------------------
//------(IF) Instruction Fetch signals
wire stall_f;
wire [31:0] pcnext;
wire [31:0] pc_f;
wire [31:0] pcplus4_f;
wire [31:0] instr_f;
//------(ID) Instruction Decode signals-----------
wire stall_d, flush_d;
wire forwarda_d, forwardb_d;
wire [31:0] instr_d;
wire [4:0] rs_d, rt_d, rd_d;
wire [31:0] pcplus4_d;
wire [31:0] branchoffset_d;
wire [31:0] pcbranch_d, pcjump_d;
wire [31:0] rfread1_d, rfread2_d;
wire [31:0] rfout1_d, rfout2_d;
wire [31:0] signimm_d, zeroimm_d;
wire [31:0] imm_d;
wire [31:0] upperimm_d;
//------(EXE) Execute Stage signals
wire flush_e, stall_e;
wire [1:0] forwarda_e, forwardb_e;
wire regwrite_e;
wire memtoreg_e;
wire memread_e, memwrite_e;
wire [1:0] regdst_e;
wire [1:0] outselect_e;
wire [3:0] aluctrl_e;
wire alusrc_e;
wire [4:0] rs_e, rt_e, rd_e;
wire [31:0] upperimm_e;
wire [31:0] imm_e;
wire [31:0] rfout1_e, rfout2_e;
wire [31:0] srca_e, srcb_e;
wire [31:0] aluout_e;
wire [31:0] execout_e;
wire [31:0] writedata_e;
wire [4:0] writereg_e;
//------(MEM) Memory Stage signals
wire stall_m;
wire regwrite_m;
wire memtoreg_m;
wire memread_m;
wire memwrite_m;
wire memready_m;
wire [31:0] execout_m;
wire [31:0] writedata_m;
wire [31:0] readdata_m;
wire [4:0] writereg_m;
//------(WB) WriteBack stage signals-------------------------------------
wire flush_w;
wire regwrite_w;
wire memtoreg_w;
wire [31:0] execout_w;
wire [31:0] readdata_w;
wire [31:0] result_w;
wire [4:0] writereg_w;
//--Wire Assignements----------------------------------------------------
assign rs_d = instr_d[25:21];
assign rt_d = instr_d[20:16];
assign rd_d = instr_d[15:11];
assign op = instr_d[31:26];
assign func = instr_d[5:0];
// jump target address (jta)
assign pcjump_d = {pcplus4_d[31:28], instr_d[25:0], 2'b00};

/*----------------------------------------------------------------------
* HAZARD DETECTION UNIT
*/
hazard_detector hazard_detector(
	.clk(clk),
	.reset(reset),
	.rs_d(rs_d),
	.rt_d(rt_d),
	.rt_e(rt_e),
	.memread_d(memread_d),
	.writereg_e(writereg_e),
	.writereg_m(writereg_m),
	.regwrite_e(regwrite_e),
	.memtoreg_e(memtoreg_e),
//	.branch_d(pcsrc_d[0]),
	.branch_d(outputbranch_d),
	.jump_d(pcsrc_d[1]),
	.memwrite_d(memwrite_d),
	.memread_e(memread_e),
	.memwrite_e(memwrite_e),
	.memready_m(memready_m),
	.memtoreg_m(memtoreg_m),
	.memread_m(memread_m),
	.memwrite_m(memwrite_m),
	.stall_f(stall_f),
	.stall_d(stall_d),
	.stall_e(stall_e),
	.stall_m(stall_m),
	.flush_d(flush_d),
	.flush_e(flush_e),
	.flush_w(flush_w)
);
/*
* data forwarding
*/
data_forward data_forward(
	.regwrite_m(regwrite_m),
	.regwrite_w(regwrite_w),
	.rs_d(rs_d),
	.rt_d(rt_d),
	.rs_e(rs_e),
	.rt_e(rt_e),
	.writereg_m(writereg_m),
	.writereg_w(writereg_w),
	.forwardA_d(forwarda_d),
	.forwardB_d(forwardb_d),
	.forwardA_e(forwarda_e),
	.forwardB_e(forwardb_e)
);

/*-----------------------------------------------------------------------
* FETCH (IF) Stage:
* - instruction memory block
*/
mux3 #(32) pc_mux (
	.select(pcsrc_d),
	.d0(pcplus4_f),
	.d1(pcbranch_d),
	.d2(pcjump_d),
	.out(pcnext)
);
flopenr #(32) if_pc_register (
	.clk(clk),
	.reset(reset),
	.enable(~stall_f),
	.d(pcnext),
	.q(pc_f)
);
inst_memory instr_memory_unit (
	.address(pc_f),
	.read_data(instr_f)
);
adder pc_plus4_adder (
	.a(pc_f),
	.b(4),
	.y(pcplus4_f)
);

/*-----------------------------------------------------------------------
* DECODE (ID) Stage:
* - control unit
* - register file block
*/
if_id_reg IF_ID_register (
	.clk(clk),
	.reset(reset),
	.enable(~stall_d),
	.clr(pcsrc_d[0]|pcsrc_d[1]),
//	.clr(flush_d),
	.instr_f(instr_f),
	.pcplus4_f(pcplus4_f),
	.instr_d(instr_d),
	.pcplus4_d(pcplus4_d)
);

register_file rf_ID (
	.clk(clk),
	.reset(reset),
	.wr_en(regwrite_w),
	.rd_reg_addr1(rs_d),
	.rd_reg_addr2(rt_d),
	.wr_reg_addr(writereg_w),
	.wr_data(result_w),
	.rd_data1(rfread1_d),
	.rd_data2(rfread2_d)
);

// data forwarding mux2's from MEM stage (of 2 instructions before)

mux2 #(32) rfread1_mux_ID (
	.select(forwarda_d),
	.d0(rfread1_d),
	.d1(execout_m),
	.out(rfout1_d)
);
mux2 #(32) rfread2_mux_ID (
	.select(forwardb_d),
	.d0(rfread2_d),
	.d1(execout_m),
	.out(rfout2_d)
);
// generate eq_ne sent to controller
equals branch_eq_ID (
	.srcA(rfout1_d),
	.srcB(rfout2_d),
	.eq(eq_ne)
);

// branch target address
signext_16_32 signextend_ID (
	instr_d[15:0],
	signimm_d
);
sll_2 sll2_word_allign_ID (
	signimm_d,
	branchoffset_d
);
adder branch_adder_ID (
	branchoffset_d,
	pcplus4_d,
	pcbranch_d
);
// upper-immediate value (lui)
sll_16 sll16_upperimm_ID (
	instr_d[15:0],
	upperimm_d
);
// zero-extended immediate value for logical instructions
zeroext_16_32 zeroextend_ID (
	instr_d[15:0],
	zeroimm_d
);
mux2 #(32) sign_zero_immediate_mux_ID (
	.select(seze_d),
	.d0(zeroimm_d),
	.d1(signimm_d),
	.out(imm_d)
);


/*---------------------------------------------------------------------
* EXECUTE (EXE) Stage:
* - 32-bit alu
* - 32-bit serial multiplier()
*/
id_exe_reg ID_EXE_register (
	.clk(clk),
	.reset(reset),
	.enable(~stall_e),
	.clr(flush_e),
	.regwrite_d(regwrite_d),
	.memtoreg_d(memtoreg_d),
	.memwrite_d(memwrite_d),
	.memread_d(memread_d),
	.regdst_d(regdst_d),
	.outselect_d(outselect_d),
	.aluctrl_d(aluctrl_d),
	.alusrc_d(alusrc_d),
	.rfout1_d(rfout1_d),
	.rfout2_d(rfout2_d),
	.rs_d(rs_d),
	.rt_d(rt_d),
	.rd_d(rd_d),
	.imm_d(imm_d),
	.upperimm_d(upperimm_d),
	.regwrite_e(regwrite_e),
	.memtoreg_e(memtoreg_e),
	.memwrite_e(memwrite_e),
	.memread_e(memread_e),
	.regdst_e(regdst_e),
	.outselect_e(outselect_e),
	.aluctrl_e(aluctrl_e),
	.alusrc_e(alusrc_e),
	.rfout1_e(rfout1_e),
	.rfout2_e(rfout2_e),
	.rs_e(rs_e),
	.rt_e(rt_e),
	.rd_e(rd_e),
	.imm_e(imm_e),
	.upperimm_e(upperimm_e)
);

// data forwarding mux3's from MEM or WB
mux3 #(32) srca_mux_EXE (
	.select(forwarda_e),
	.d0(rfout1_e),
	.d1(result_w),
	.d2(execout_m),
	.out(srca_e)
);
mux3 #(32) wde_mux_EXE (
	.select(forwardb_e),
	.d0(rfout2_e),
	.d1(result_w),
	.d2(execout_m),
	.out(writedata_e)
);
// alu's srcb mux2 for register(R-TYPE) or immediate(I-TYPE) value
mux2 #(32) srcb_mux_EXE (
	.select(alusrc_e),
	.d0(writedata_e),
	.d1(imm_e),
	.out(srcb_e)
);

ALU alu_EXE (
	.In1(srca_e),
	.In2(srcb_e),
	.Func(aluctrl_e),
	.ALUout(aluout_e)
);
mux4 #(32) execout_mux (
	.select(outselect_e),
	.d0(aluout_e),
	.d1(upperimm_e),
	.d2(32'bx),
	.d3(32'bx),
	.out(execout_e)
);
mux2 #(5) writereg_instr_mux (
	.select(regdst_e[0]),
	.d0(rt_e),
	.d1(rd_e),
	.out(writereg_e)
);

/*-----------------------------------------------------------------------------
* MEMORY (MEM) Stage:
*  - data memory unit: where the CPU interacts with main memory through
*    load instructions to read from memory and store instruction to
*    write and udpate main memory.
*/
exe_mem_reg exe_mem_register (
	.clk(clk),
	.reset(reset),
	.enable(~stall_m),
	.regwrite_e(regwrite_e),
	.memtoreg_e(memtoreg_e),
	.memwrite_e(memwrite_e),
	.memread_e(memread_e),
	.execout_e(execout_e),
	.writedata_e(writedata_e),
	.writereg_e(writereg_e),
	.regwrite_m(regwrite_m),
	.memtoreg_m(memtoreg_m),
	.memwrite_m(memwrite_m),
	.memread_m(memread_m),
	.execout_m(execout_m),
	.writedata_m(writedata_m),
	.writereg_m(writereg_m)
);

/*
data_memory #(
.DATA_WIDTH(32),
.ADDR_WIDTH(32),
.RAM_DEPTH(256)
) new_data_memory_unit(
.clk(clk),
.reset(reset),
.wr_en(memwrite_m),
.rd_en(memread_m),
.address(execout_m),
.wr_data(writedata_m),
.rd_data(readdata_dmem),
.ready(memready_m),
.done(memdone_m)
);
*/
/*
data_memory_basic data_memory_unit (
	.clk(clk), .reset(reset),
	.write_enable(memwrite_m),
	.read_enable(memread_m),
	.address(execout_m),
	.write_data(writedata_m),
	.read_data(readdata_m),
	.ready(memready_m)
);
*/


data_memory_basic data_memory_unit (
	.clk(clk),
	.reset(reset),
//	.ready(memready_m),
	.wr_en(memwrite_m),
	.rd_en(memread_m),
	.addr(execout_m),
	.wr_data(writedata_m),
	.rd_data(readdata_m)
);

/*-----------------------------------------------------------------------
* WRITEBACK (WB) Stage:
*/
mem_wb_reg mem_wb_register (
	.clk(clk),
	.reset(reset),
	.clr(flush_w),
	.regwrite_m(regwrite_m),
	.memtoreg_m(memtoreg_m),
	.readdata_m(readdata_m),
	.execout_m(execout_m),
	.writereg_m(writereg_m),
	.regwrite_w(regwrite_w),
	.memtoreg_w(memtoreg_w),
	.readdata_w(readdata_w),
	.execout_w(execout_w),
	.writereg_w(writereg_w)
);

mux2 #(32) fin_mux (
	.select(memtoreg_w),
	.d0(execout_w),
	.d1(readdata_w),
	.out(result_w)
);

endmodule
