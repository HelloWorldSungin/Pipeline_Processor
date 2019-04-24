/*
 * file: MIPS_PIPELINE_TOP.v
*/

`default_nettype none

module MIPS_PIPELINE_TOP (
  input wire clk,
  input wire reset
  );

  // Declare Wires used in this Module
  // wire outputs from control_unit_TOP
  wire output_branch_ctrl;
  wire mem_read_ctrl, ALUSrc_A_ctrl, reg_write_ctrl, mem_to_reg_ctrl, reg_dst_ctrl, se_ze_ctrl, mem_write_ctrl;
  wire [1:0]  pc_source_ctrl, out_select_ctrl;
  wire [3:0]  ALU_Func_ctrl;
  wire start_mult_ctrl, mult_sign_ctrl;

  // wire outputs from data_path_TOP
  wire eq_ne_dp;
  wire [5:0] op_code_dp, control_unit_funct_dp;

  // initialize control_unit_TOP module
  control_unit_TOP control_unit_TOP (
    .op_code              (op_code_dp),
    .control_unit_funct   (control_unit_funct_dp),
    .eq_ne                (eq_ne_dp),
    .pc_source            (pc_source_ctrl),
    .out_select           (out_select_ctrl),
    .mem_write            (mem_write_ctrl),
    .mem_read             (mem_read_ctrl),
    .reg_write            (reg_write_ctrl),
    .output_branch        (output_branch_ctrl),
    .ALUSrc_A             (ALUSrc_A_ctrl),
    .ALU_Func             (ALU_Func_ctrl),
    .se_ze                (se_ze_ctrl),
    .reg_dst              (reg_dst_ctrl),
    .start_mult           (start_mult_ctrl),
    .mult_sign            (mult_sign_ctrl),
    .mem_to_reg           (mem_to_reg_ctrl)
    );

    // initialize data_path_TOP_tb module
    data_path_TOP data_path_TOP (
      .clk                 (clk),
      .reset               (reset),
      .start_mult          (start_mult_ctrl),
      .mult_sign           (mult_sign_ctrl),
      .pcsrc               (pc_source_ctrl),
      .se_ze               (se_ze_ctrl),
      .regwrite_d          (reg_write_ctrl),
      .regdst_d            (reg_dst_ctrl),
      .alusrc_d            (ALUSrc_A_ctrl),
      .aluctrl_d           (ALU_Func_ctrl),
      .outselect_d         (out_select_ctrl),
      .memwrite_d          (mem_write_ctrl),
      .memtoreg_d          (mem_to_reg_ctrl),
      .output_branch       (output_branch_ctrl),
      .eq_ne               (eq_ne_dp),
      .op_code             (op_code_dp),
      .control_unit_funct  (control_unit_funct_dp)
      );

endmodule // MIPS_PIPELINE_TOP

`default_nettype wire
