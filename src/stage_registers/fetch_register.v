/*
  fetch_register.v
*/

`default_nettype none

module fetch_register (
  input wire          clk,
  input wire          reset,
  input wire          enable,
  input wire  [31:0]  pc_next_f,
  output wire [31:0]  pc_d
  );

  // Declare local regs and wires
  reg [31:0] pc_d_reg;

  // Assign output;
  assign pc_d = pc_d_reg;

  always @ (posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
      pc_d_reg <= 32'd0;
    end else begin
      if (enable == 1'b1) begin
        pc_d_reg <= pc_next_f;
      end else begin
        pc_d_reg <= pc_d_reg;
      end
    end
  end

endmodule // fetch_register

`default_nettype wire
