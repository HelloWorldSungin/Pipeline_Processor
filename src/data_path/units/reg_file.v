/*
  reg_file will manage reading and writing register values
  Inputs:
    1. clk (1 bit)
    2. write (1 bit)
    3. PR1 (5 bits)
    4. PR2 (5 bits)
    5. WR (5 bits)
    6. WD (32 bits)
  Outputs:
    1. RD1 (32 bits)
    2. RD2 (32 bits)
*/

`default_nettype none

module reg_file(
  input wire          clk,
  input wire          write,
  input wire [4:0]    PR1,
  input wire [4:0]    PR2,
  input wire [4:0]    WR,
  input wire [31:0]   WD,
  output wire [31:0]  RD1,
  output wire [31:0]  RD2
  );

  // Declare Wires used in this Module
  reg [31:0] rf_mem[31:0];
  reg [31:0] i;

  // Assign output
  assign RD1 = (PR1 != 5'd0) ? rf_mem[PR1] : 32'd0;
  assign RD2 = (PR2 != 5'd0) ? rf_mem[PR2] : 32'd0;

  // set values to rf_mem just for the testbench
  initial begin
    for (i = 0; i < 32; i = i + 1)
      rf_mem[i] = i;
  end

  always @ (posedge clk) begin
    if (write) begin
      //write to the memory if write = 1, Reset = 0, and on a raising edge of the clock
      rf_mem[WR] <= WD;
    end
  end


endmodule

`default_nettype wire
