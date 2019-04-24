/*
  writeback_register.v
*/

`default_nettype none

module writeback_register (
  input wire          clk,
  input wire          reset,
  input wire  [1:0]   ctrls_m,
  input wire  [31:0]  readdata_m,
  input wire  [31:0]  aluout_m,
  input wire  [4:0]   writereg_m,
  output wire [1:0]   ctrls_w,
  output wire [31:0]  readdata_w,
  output wire [31:0]  aluout_w,
  output wire [4:0]   writereg_w
  );

  // Declare local regs and wires
  reg [1:0]   ctrls_w_reg;
  reg [31:0]  readdata_w_reg;
  reg [31:0]  aluout_w_reg;
  reg [4:0]   writereg_w_reg;

  // Assign outputs;
  assign ctrls_w = ctrls_w_reg;
  assign readdata_w = readdata_w_reg;
  assign aluout_w = aluout_w_reg;
  assign writereg_w = writereg_w_reg;

  always @ (posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
      ctrls_w_reg <= 2'd0;
      readdata_w_reg <= 32'd0;
      aluout_w_reg <= 32'd0;
      writereg_w_reg <= 5'd0;
    end else begin
      ctrls_w_reg <= ctrls_m;
      readdata_w_reg <= readdata_m;
      aluout_w_reg <= aluout_m;
      writereg_w_reg <= writereg_m;
    end
  end

endmodule // writeback_register

`default_nettype wire
