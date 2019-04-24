/*
 * file: data_path_TOP.v
 This is the TOP module that connects all the module blocks
 in fetch, decode, execute, memory, write-back stages
 */

`default_nettype none

module data_path_TOP (
  input wire          clk,
  input wire          reset,
  input wire [31:0]   pc,
  //input wire [31:0]   instr_d,
  //input wire [31:0]   readdata_m,  input wire memread ..??
  input wire          start_mult,
  input wire          mult_sign,
  input wire [1:0]    pcsrc,
  input wire          se_ze,
  input wire          regwrite_d,
  input wire          regdst_d,
  input wire          alusrc_d,
  input wire [3:0]    aluctrl_d,
  input wire [1:0]    outselect_d,
  input wire          memwrite_d,
  input wire          memtoreg_d,
  input wire          output_branch,
  output wire         eq_ne,
  output wire [5:0]   op_code,
  output wire [5:0]   control_unit_funct
  );

  // Declare Wires used in this Module
  wire regwrite_e, regwrite_m, regwrite_w;
	wire memtoreg_e, memtoreg_m, memtoreg_w;
	wire memwrite_e, memwrite_m;
	wire mult_ready, mult_done;
	wire [31:0] mult_hi, mult_lo;
	wire alusrc_e, regdst_e;
	wire [3:0] aluctrl_e;
	wire [1:0] outselect_e;
	wire [31:0] pcplus4_f, pcbranch_d, pcjump_d, pcnext, readdata_f;
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
	wire forwarda_d, forwardb_d;
	wire [1:0] forwarda_e, forwardb_e;
	wire stall_f, stall_d, flush_e;
  wire [63:0] product;
  wire [4:0] rs_d, rt_d, rd_d;

  wire [31:0] readdata_m      // commented out input
  wire [31:0] instr_d         // commented out input


  // Assign Outputs
  assign op_code = instr_d[31:26];
  assign control_unit_funct = instr_d[5:0];

  assign rs_d = instr_d[25:21];
  assign rt_d = instr_d[20:16];
  assign rd_d = instr_d[15:11];

  assign mult_hi = product[63:32];
  assign mult_lo = product[31:0];



  // ***************************************************************************
  // * hazard_unit
  // ***************************************************************************
  hazard_unit hazard_unit (
    .rs_d           (rs_d),
    .rt_d           (rt_d),
    .rs_e           (rs_e),
    .rt_e           (rt_e),
    .writereg_e     (writereg_e),
    .writereg_m     (writereg_m),
    .writereg_w     (writereg_w),
    .memtoreg_e     (memtoreg_e),
    .memtoreg_m     (memtoreg_m),
    .regwrite_e     (regwrite_e),
    .regwrite_m     (regwrite_m),
    .regwrite_w     (regwrite_w),
    .branch_d       (output_branch),
    .mult_done      (mult_done),
    .forwarda_d     (forwarda_d),
    .forwardb_d     (forwardb_d),
    .forwarda_e     (forwarda_e),
    .forwardb_e     (forwardb_e),
    .stall_f        (stall_f),
    .stall_d        (stall_d),
    .flush_e        (flush_e)
    );

  // ***************************************************************************
  // * Multiplier
  // ***************************************************************************
  multiplier #(
    .WIDTH(32)
    ) multiplier (
      .clk        (clk),
      .reset      (reset),
      .start      (start_mult),
      .m_signed   (mult_sign),
      .src_a      (srca_e),
      .src_b      (srcb_e),
      .ready      (mult_ready),
      .done       (mult_done),
      .product    (product)
    );

 // ***************************************************************************
 // * Pre-Fetch Stage
 // ***************************************************************************

 // ---------------------------------------------------------------------------
 // - 3 input mux that determines what is the next PC
 // ---------------------------------------------------------------------------
 assign pcnext = pcsrc[1] ? pcjump_d :
                 pcsrc[0] ? pcbranch_d : pcplus4_f;

 // ---------------------------------------------------------------------------
 // - fetch_register
 // ---------------------------------------------------------------------------
 fetch_register fetch_register (
    .clk        (clk),
    .reset      (reset),
    .enable     ({~stall_f}),
    .pc_next_f  (pcnext),
    .pc_d       (pc)
   );
 // ***************************************************************************
 // * Fetch Stage
 // ***************************************************************************

 // ---------------------------------------------------------------------------
 // - inst_memory
 // ---------------------------------------------------------------------------
 inst_memory inst_memory (
    .address    (pc),
    .read_data  (readdata_f)
   );

 // ---------------------------------------------------------------------------
 // - plus4 adder
 // ---------------------------------------------------------------------------
 assign pcplus4_f = pc + 4;

 // ---------------------------------------------------------------------------
 // - decode_register
 // ---------------------------------------------------------------------------
 decode_register decode_register (
    .clk          (clk),
    .reset        (reset),
    .enable       ({~stall_d}),
    .clr          ({pcsrc[1] | pcsrc[0]}),
    .instr_f      (readdata_f),
    .pc_plus4_f   (pcplus4_f),
    .instr_d      (instr_d),
    .pc_plus4_d   (pcplus4_d)
   );

// ***************************************************************************
// * Decode Stage
// ***************************************************************************

// ---------------------------------------------------------------------------
// - register file
// ---------------------------------------------------------------------------
reg_file reg_file (
    .clk      (clk),
    .reset    (reset),
    .write    (regwrite_w),
    .PR1      (rs_d),
    .PR2      (rt_d),
    .WR       (writereg_w),
    .WD       (result_w),
    .RD1      (rf_read1),
    .RD2      (rf_read2)
  );

// ---------------------------------------------------------------------------
// - rd1_mux
// ---------------------------------------------------------------------------
assign rd1out_d = forwarda_d ? aluout_m : rf_read1;

// ---------------------------------------------------------------------------
// - rd2_mux
// ---------------------------------------------------------------------------
assign rd2out_d = forwardb_d ? aluout_m : rf_read2;

// ---------------------------------------------------------------------------
// - equal comparator: generate eq_ne sent to controller
// ---------------------------------------------------------------------------
assign eq_ne = (rd1out_d == rd2out_d) ? 1'b1 : 1'b0;

// ---------------------------------------------------------------------------
// - Calculate Branch Target address
// ---------------------------------------------------------------------------
// signext_16_32
assign signimm_d = { {16{instr_d[15]}}, instr_d[15:0]};

// jump target address (jta)
assign jump_offset = {6'b00_0000, instr_d[25:0]}, 2'b00};
assign pcjump_d = {instr_d[31:28], jump_offset};

// upper-immediate value (lui)
assign upperimm_d = {instr_d[15:0], 16'b0000_0000_0000_0000};

// zero-extended immediate value for logical instructions
assign zeroimm_d = {16'b0000_0000_0000_0000, instr_d[15:0]};

// ---------------------------------------------------------------------------
// - immediate mux
// ---------------------------------------------------------------------------
assign imm_d = se_ze ? signimm_d : zeroimm_d;

// ---------------------------------------------------------------------------
// - execute_register
// ---------------------------------------------------------------------------
execute_register execute_register (
  .clk          (clk),
  .reset        (reset),
  .clr          (flush_e),
  .ctrls_d      ({regwrite_d, memtoreg_d, memwrite_d, aluctrl_d, alusrc_d, regdst_d, outselect_d}),
  .rd1out_d     (rd1out_d),
  .rd2out_d     (rd2out_d),
  .imm_d        (imm_d),
  .upperimm_d   (upperimm_d),
  .rs_d         (rs_d),
  .rt_d         (rt_d),
  .rd_d         (rd_d),
  .ctrls_e      (regwrite_e, memtoreg_e, memwrite_e, aluctrl_e, alusrc_e, regdst_e, outselect_e),
  .rd1out_e     (rd1out_e),
  .rd2out_e     (rd2out_e),
  .imm_e        (imm_e),
  .upperimm_e   (upperimm_e),
  .rs_e         (rs_e),
  .rt_e         (rt_e),
  .rd_e         (rd_e)
  );

// ***************************************************************************
// * Execute Stage
// ***************************************************************************

// ---------------------------------------------------------------------------
// - srca mux
// ---------------------------------------------------------------------------
assign srca_e = forwarda_e[1] ? aluout_m :
                forwarda_e[0] ? result_w : rd1out_e;

// ---------------------------------------------------------------------------
// - wde mux
// ---------------------------------------------------------------------------
assign writedata_e = forwardb_e[1] ? aluout_m :
                     forwardb_e[0] ? result_w : rd2out_e;


// ---------------------------------------------------------------------------
// - srcb mux
// ---------------------------------------------------------------------------
assign srcb_e = alusrc_e ? imm_e : writedata_e;

// ---------------------------------------------------------------------------
// - ALU
// ---------------------------------------------------------------------------
ALU ALU (
  .In1        (srca_e),
  .In2        (srcb_e),
  .ALU_Func   (aluctrl_e),
  .ALUout     (aluout)
  );

// ---------------------------------------------------------------------------
// - mainout mux: this determines what the aluout_e will be
// ---------------------------------------------------------------------------
assign aluout_e = (outselect_e == 2'b00) ? aluout :
                  (outselect_e == 2'b01) ? upperimm_e :
                  (outselect_e == 2'b10) ? mult_lo : mult_hi;

// ---------------------------------------------------------------------------
// - write_register mux
// ---------------------------------------------------------------------------
assign writereg_e = (regdst_e == 1'b1) ? rd_e : rt_e;

// ---------------------------------------------------------------------------
// - memory_register
// ---------------------------------------------------------------------------
memory_register memory_register(
  .clk            (clk),
  .reset          (reset),
  .ctrls_e        ({regwrite_e, memtoreg_e, memwrite_e}),
  .aluout_e       (aluout_e),
  .writedata_e    (writedata_e),
  .writereg_e     (writereg_e),
  .ctrls_m        ({regwrite_m, memtoreg_m, memwrite_m}),
  .aluout_m       (aluout_m),
  .writedata_m    (writedata_m),
  .writereg_m     (writereg_m)
  );

// ***************************************************************************
// * Memory Stage
// ***************************************************************************

// ---------------------------------------------------------------------------
// - data memory
// ---------------------------------------------------------------------------
data_memory data_memory (
  .clk          (clk),
  .write        (memwrite_m),
  .address      (aluout_m),
  .write_data   (writedata_m),
  .read_data    (readdata_m)
  );

// ---------------------------------------------------------------------------
// - writeback_register
// ---------------------------------------------------------------------------
writeback_register writeback_register (
  .clk           (clk),
  .reset         (reset),
  .ctrls_m       ({regwrite_m, memtoreg_m}),
  .readdata_m    (readdata_m),
  .aluout_m      (aluout_m),
  .writereg_m    (writereg_m),
  .ctrls_w       ({regwrite_w, memtoreg_w}),
  .readdata_w    (readdata_w),
  .aluout_w      (aluout_w),
  .writereg_w    (writereg_w)
  );

// ***************************************************************************
// * Write-back Stage
// ***************************************************************************

// ---------------------------------------------------------------------------
// - final_result mux
// ---------------------------------------------------------------------------
assign result_w = (memtoreg_w == 1'b1) ? readdata_w : aluout_w;

endmodule // data_path_TOP

`default_nettype wire
