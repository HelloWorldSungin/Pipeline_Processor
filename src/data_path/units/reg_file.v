/*
  reg_file will manage reading and writing register values
  Inputs:
    1. clk (1 bit)
    2. reset (1 bit)
    3. write (1 bit)
    4. PR1 (5 bits)
    5. PR2 (5 bits)
    6. WR (5 bits)
    7. WD (32 bits)
  Outputs:
    1. RD1 (32 bits)
    2. RD2 (32 bits)
*/

`default_nettype none

module reg_file(
  input wire          clk,
  input wire          reset,
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
  reg [31:0] RD1_r;
  reg [31:0] RD2_r;

  // Assign outputs
  assign RD1 = RD1_r;
  assign RD2 = RD2_r;

  // set values to rf_mem just for the testbench
  initial begin
    for (i = 0; i < 32; i = i + 1)
      rf_mem[i] = i;
  end

  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      // setting synchronnous reset at positive clk edge
      RD1_r <= 32'd0;
      RD2_r <= 32'd0;
    end
    else if (write) begin
      //write to the memory if write = 1, Reset = 0, and on a raising edge of the clock
      rf_mem[WR] <= WD;
    end
  end

  always @ (negedge clk) begin
    if (write == 1'b0) begin    // original code if (write == 1'b0 && WR == 5'd0) begin
      RD1_r <= (PR1 != 5'd0) ? rf_mem[PR1] : 32'd0;
      RD2_r <= (PR2 != 5'd0) ? rf_mem[PR2] : 32'd0;
    end
  end

endmodule

`default_nettype wire
