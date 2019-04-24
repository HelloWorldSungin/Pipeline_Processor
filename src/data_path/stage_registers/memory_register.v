/*
  memory_register.v
*/

`default_nettype none

module memory_register(
  input wire          clk,
  input wire          reset,
  input wire  [2:0]   ctrls_e,
  input wire  [31:0]  aluout_e,
  input wire  [31:0]  writedata_e,
  input wire  [4:0]   writereg_e,
  output wire [2:0]   ctrls_m,
  output wire [31:0]  aluout_m,
  output wire [31:0]  writedata_m,
  output wire [4:0]   writereg_m
  );

  // Declare local regs and wires
  reg [2:0]   ctrls_m_reg;
  reg [31:0]  aluout_m_reg;
  reg [31:0]  writedata_m_reg;
  reg [4:0]   writereg_m_reg;

  // Assign outputs;
  assign ctrls_m = ctrls_m_reg;
  assign aluout_m = aluout_m_reg;
  assign writedata_m = writedata_m_reg;
  assign writereg_m = writereg_m_reg;

  always @ (posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
      ctrls_m_reg <= 3'd0;
      aluout_m_reg <= 32'd0;
      writedata_m_reg <= 32'd0;
      writereg_m_reg <= 5'd0;
    end else begin
      ctrls_m_reg <= ctrls_e;
      aluout_m_reg <= aluout_e;
      writedata_m_reg <= writedata_e;
      writereg_m_reg <= writereg_e;
    end
  end

endmodule // memory_register

`default_nettype wire
