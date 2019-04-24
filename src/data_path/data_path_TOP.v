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
  input wire [31:0]   instr_d,
  input wire [31:0]   readdata_m,
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

endmodule // data_path_TOP

`default_nettype wire
