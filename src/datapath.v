/*
 * file: datapath.v
 */

module datapath (
	input clk, reset,
	input [31:0] pc, instr_d, readdata_m,
	input start_mult, mult_sign,
	input [1:0] pcsrc,
	input se_ze, regwrite_d,
	input regdst_d, alusrc_d,
	input [3:0] aluctrl_d,
	input [1:0] outselect_d,
	input memwrite_d,
	input memtoreg_d,
	input output_branch,
	output eq_ne,
	output [5:0] op, func
);

	wire regwrite_e, regwrite_m, regwrite_w;
	wire memtoreg_e, memtoreg_m, memtoreg_w;
	wire memwrite_e, memwrite_m;
	wire mult_ready, mult_done;
	wire [31:0] mult_hi, mult_lo;
	wire alusrc_e, regdst_e;
	wire [3:0] aluctrl_e;
	wire [1:0] outselect_e;
	wire [31:0] pcplus4_f, pcbranch_d, pcjump_d, pcnext, readdata;
	wire [31:0] pcplus4_d;
	wire [31:0] signimm_d, zeroimm_d, upperimm_d, imm_d;
	wire [31:0] branch_offset, jump_offset;
	wire [31:0] rf_read1, rf_read2, rd1out_d, rd2out_d;
	wire [31:0] rd1out_e, rd2out_e, imm_e, upperimm_e;
	wire [4:0] rs_e, rt_e, rd_e;
	wire [31:0] srca_e, srcb_e;
	wire [31:0] writedata_e, writedata_m;
	wire [31:0] aluout, aluout_e, aluout_m, aluout_w;
	wire [31:0] result_w;
	wire [4:0] writereg_e, writereg_m, writereg_w;
	wire [31:0] readdata_w;
	wire forward_ad, forward_bd;
	wire [1:0] forward_ae, forward_be;
	wire stall_f, stall_d, flush_e;

	wire [63:0] product;

	assign op = instr_d[31:26];
	assign func = instr_d[5:0];

	
	assign mult_hi = product[63:32];
	assign mult_lo = product[31:0];


//hazard_unit
	hazard_unit haz (
		instr_d[25:21], instr_d[20:16], rs_e, rt_e,
		writereg_e, writereg_m, writereg_w,
		memtoreg_e, memtoreg_m,
		regwrite_e, regwrite_m, regwrite_w,
		output_branch, mult_done, mult_ready,
		forward_ad, forward_bd, forward_ae, forward_be,
		stall_f, stall_d, flush_e
	);
	
//Multiplier
	multiplier #(32) mult (
		clk, reset, start_mult, mult_sign, srca_e, srcb_e,
		mult_ready, mult_done, product
	);

//pc_mux that determines what is the next PC.
  mux3 #(32) pc_mux(pcsrc, pcplus4_f, pcbranch_d, pcjump_d, pcnext);

//Fetch Register
	flopenr #(32) fetch_reg(clk, reset, {~stall_f}, pcnext, pc);

//
	inst_memory imem(pc, readdata);
	//adder plus4(pc_f, 4, pcplus4_f);
	adder plus4(pc, 4, pcplus4_f);

//Decode
	decode_register dec_reg(
		clk, reset, {~stall_d}, {pcsrc[1] | pcsrc[0]},
		readdata, pcplus4_f,
		instr_d, pcplus4_d
	);

	// register file
	reg_file reg_file (
		clk, reset, regwrite_w,
		instr_d[25:21], instr_d[20:16], writereg_w, result_w,
		rf_read1, rf_read2
	);
	mux2 #(32) rd1_mux(forward_ad, rf_read1, aluout_m, rd1out_d);
	mux2 #(32) rd2_mux(forward_bd, rf_read2, aluout_m, rd2out_d);

	// generate eq_ne sent to controller
	equals branch_eq(rd1out_d, rd2out_d, eq_ne);

	// branch target address
	signext_16_32 signext(instr_d[15:0], signimm_d);
	sll_2 sll2(signimm_d, branch_offset);
	adder branch_adder(branch_offset, pcplus4_d, pcbranch_d);
	
	// jump target address (jta)
	sll_2 sll2_jump({6'b00_0000, instr_d[25:0]}, jump_offset);
	assign pcjump_d = {instr_d[31:28], jump_offset};

	// upper-immediate value (lui)
	sll_16 lui_sll(instr_d[15:0], upperimm_d);

	// zero-extended immediate value for logical instructions
	zeroext_16_32 zeroext(instr_d[15:0], zeroimm_d);

	mux2 #(32) imm_mux(se_ze, zeroimm_d, signimm_d, imm_d);

//Execute
/*	assign dec_ctrls = {regwrite_d, memtoreg_d, memwrite_d,
		aluctrl_d, alusrc_d, regdst_d, outselect_d};
	assign exec_ctrls = {regwrite_e, memtoreg_e, memwrite_e,
		aluctrl_e, alusrc_e, regdst_e, outselect_e};
*/
	execute_register exec_reg (
		clk, reset, flush_e,
		{regwrite_d, memtoreg_d, memwrite_d, aluctrl_d, alusrc_d, regdst_d, outselect_d},
		rd1out_d, rd2out_d, imm_d, upperimm_d,
		instr_d[25:21], instr_d[20:16], instr_d[15:11],
		{regwrite_e, memtoreg_e, memwrite_e, aluctrl_e, alusrc_e, regdst_e, outselect_e},
		rd1out_e, rd2out_e, imm_e, upperimm_e, rs_e, rt_e, rd_e
	);

	mux3 #(32) srca_mux(forward_ae, rd1out_e, result_w, aluout_m, srca_e);
	mux3 #(32) wde_mux(forward_be, rd2out_e, result_w, aluout_m, writedata_e);

	mux2 #(32) srcb_mux(alusrc_e, writedata_e, imm_e, srcb_e);

	ALU alu(srca_e, srcb_e, aluctrl_e, aluout);

	mux4 #(32) mainout_e(
		outselect_e, aluout, upperimm_e, mult_lo, mult_hi,
		aluout_e
	);

	mux2 #(5) wr_mux(regdst_e, rt_e, rd_e, writereg_e);

//Memory
	memory_register mem_reg (
		clk, reset, {regwrite_e, memtoreg_e, memwrite_e},
		aluout_e, writedata_e, writereg_e,
		{regwrite_m, memtoreg_m, memwrite_m}, aluout_m, writedata_m, writereg_m
	);

	data_memory dmem (clk, memwrite_m, aluout_m, writedata_m, readdata_m);

//Writeback

	writeback_register wb_reg (
		clk, reset, {regwrite_m, memtoreg_m}, readdata_m, aluout_m, writereg_m,
		{regwrite_w, memtoreg_w}, readdata_w, aluout_w, writereg_w
	);
	
	

	mux2 #(32) fin_mux(memtoreg_w, aluout_w, readdata_w, result_w);

endmodule
