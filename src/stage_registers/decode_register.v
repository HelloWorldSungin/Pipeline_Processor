/*
  decode_register.v
*/

`default_nettype none

module decode_register (
  input wire          clk,
  input wire          reset,
  input wire          enable,
  input wire          clr,
  input wire  [31:0]  instr_f,
  input wire  [31:0]  pc_plus4_f,
  output wire [31:0]  instr_d,
  output wire [31:0]  pc_plus4_d
  );

  // Declare local regs and wires
  reg [31:0] instr_d_reg;
  reg [31:0] pc_plus4_d_reg;

  // Assign outputs;
  assign instr_d = instr_d_reg;
  assign pc_plus4_d = pc_plus4_d_reg;

  always @ (posedge clk or posedge reset) begin
    if (reset == 1'b1 || clr == 1'b1) begin
      instr_d_reg <= 32'd0;
      pc_plus4_d_reg <= 32'd0;
    end else begin
      if (enable == 1'b1) begin
        instr_d_reg <= instr_f;
        pc_plus4_d_reg <= pc_plus4_f;
      end
    end
  end

endmodule // decode_register

`default_nettype wire
