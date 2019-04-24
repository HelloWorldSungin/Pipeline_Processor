`timescale 1 ns / 1 ns
`default_nettype none

module reg_file_tb();

//--Inputs--------------------------
reg         clk;
reg         reset;
reg         write;
reg [4:0]   PR1;
reg [4:0]   PR2;
reg [4:0]   WR;
reg [31:0]  WD;

//--Output--------------------------
wire [31:0] RD1;
wire [31:0] RD2;

// Declare local regs and wires
reg donesim;
reg [31:0]  RD1_expected;
reg [31:0]  RD2_expected;

// initialize control_unit_TOP module
reg_file reg_file_inst (
    .clk       (clk),
    .reset     (reset),
    .write     (write),
    .PR1       (PR1),
    .PR2       (PR2),
    .WR        (WR),
    .WD        (WD),
    .RD1       (RD1),
    .RD2       (RD2)
  );
// Simulate clk
initial begin
  clk = 0;
  while(donesim !== 1'b1) begin   // == compare bits (0 or 1), === compare 4 states (0,1,x,z)
    #5
    clk = ~clk;
  end
  $display("done");
end

// Checking ALUout against ALUout_expected
initial begin
  RD1_expected = RD1;
  RD2_expected = RD2;
  while(donesim !== 1'b1) begin
    @(negedge clk);
    if (RD1 != RD1_expected) begin
      $display("Error for write: %d, PR1: %d, PR2: %d, WR: %d, WD: %d", write, PR1, PR2, WR, WD);
      $display("RD1_expected: %d, but RD1: %d", RD1_expected, RD1);
      $stop;
    end
    if (RD2 != RD2_expected) begin
      $display("Error for write: %d, PR1: %d, PR2: %d, WR: %d, WD: %d", write, PR1, PR2, WR, WD);
      $display("RD2_expected: %d, but RD2: %d", RD2_expected, RD2);
      $stop;
    end
  end
end

initial begin
  donesim <= 1'b0;
  clk <= 1'b0;
  reset <= 1'b1;
  RD1_expected <= 32'd0;
  RD2_expected <= 32'd0;
  #10
  reset <= 1'b0;
  write <= 1'b0;
  PR1 <= 5'd6;
  PR2 <= 5'd8;
  #10
  RD1_expected <= 32'd6;
  RD2_expected <= 32'd8;
  #10
  write <= 1'b1;
  WR <= 5'd4;     // Write data to the rf_mem[4]
  WD <= 32'd31;   // The new data is 31 at rf_mem[4]
  #10
  write <= 1'b0;
  PR1 <= 5'd4;    // Read data from rf_mem[4]
  #10
  RD1_expected <= 32'd31; // check to see if the new data 32 is written at rf_mem[4]
  #20
  reset <= 1'b1;     // reset the RD1, and RD2 to 0
  RD1_expected <= 32'd0;
  RD2_expected <= 32'd0;
  #7.5
  //On the same clock cycle, it reads rf_mem[10] data, which is 10 and rf_mem[12], which is 12 on falling edge
  reset <= 1'b0;
  write <= 1'b0;
  PR1 <= 5'd10;
  PR2 <= 5'd12;
  @(negedge clk)
  RD1_expected <= 32'd10;
  RD2_expected <= 32'd12;
  #2.5
  //On the same clock cycle as above comment (Write <= 0), it writes rf_mem[20] to 1 on the raising edge
  write <= 1'b1;
  WD <= 32'd20;
  WR <= 5'd1;
  #5
  // Read the rf_mem[5] we just wrote
  write <= 1'b0;
  WR <= 5'd0;
  PR1 <= 5'd1;
  @(negedge clk)
  RD1_expected <= 32'd20;
  #10;
  donesim <= 1'b1;
end

endmodule

`default_nettype wire
