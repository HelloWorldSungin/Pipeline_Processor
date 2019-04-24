/*
  execute_register.v
*/

`default_nettype none

module execute_register (
  input wire clk,
  input wire reset,
  input wire clr,
  input wire [10:0] ctrls_d,
  input wire [31:0] rd1out_d,
  input wire [31:0] rd2out_d,
  input wire [31:0] imm_d,
  input wire [31:0] upperimm_d,
  input wire [4:0]  rs_d,
  input wire [4:0]  rt_d,
  input wire [4:0]  rd_d,
  output wire [10:0]  ctrls_e,
  output wire [31:0]  rd1out_e,
  output wire [31:0]  rd2out_e,
  output wire [31:0]  imm_e,
  output wire [31:0]  upperimm_e,
  output wire [4:0] rs_e,
  output wire [4:0] rt_e,
  output wire [4:0] rd_e
  );

  // Declare local regs and wires
  reg [10:0]  ctrls_e_reg;
  reg [31:0]  rd1out_e_reg;
  reg [31:0]  rd2out_e_reg;
  reg [31:0]  imm_e_reg;
  reg [31:0]  upperimm_e_reg;
  reg [4:0]   rs_e_reg;
  reg [4:0]   rt_e_reg;
  reg [4:0]   rd_e_reg;

  // Assign output;
  assign ctrls_e = ctrls_e_reg;
  assign rd1out_e = rd1out_e_reg;
  assign rd2out_e = rd2out_e_reg;
  assign imm_e = imm_e_reg;
  assign upperimm_e = upperimm_e_reg;
  assign rs_e = rs_e_reg;
  assign rt_e = rt_e_reg;
  assign rd_e = rd_e_reg;

  always @ (posedge clk or posedge reset) begin
    if (clk == 1'b1) begin
      ctrls_e_reg <= 11'd0;
    end else begin
      if (reset == 1'b1) begin
        ctrls_e_reg <= 11'd0;
        rd1out_e_reg <= 32'd0;
        rd2out_e_reg <= 32'd0;
        imm_e_reg <= 32'd0;
        upperimm_e_reg <= 32'd0;
        rs_e_reg <= 5'd0;
        rt_e_reg <= 5'd0;
        rd_e_reg <= 5'd0;
      end else begin
        ctrls_e_reg <= ctrls_d;
        rd1out_e_reg <= rd1out_d;
        rd2out_e_reg <= rd2out_d;
        imm_e_reg <= imm_d;
        upperimm_e_reg <= upperimm_d;
        rs_e_reg <= rs_d;
        rt_e_reg <= rt_d;
        rd_e_reg <= rd_d; 
      end
    end
  end

endmodule // execute_register

`default_nettype wire
