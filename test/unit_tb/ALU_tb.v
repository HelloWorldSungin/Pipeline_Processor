`timescale 1 ns / 1 ns
`default_nettype none

module ALU_tb();

//--Inputs--------------------------
reg [31:0] In1;
reg [31:0] In2;
reg [3:0] Func;

//--Output--------------------------
wire [31:0] ALUout;

// Declare local regs and wires
reg clk;
reg donesim;
reg [31:0] ALUout_expected;

ALU ALU_inst (
  .In1    (In1),
  .In2    (In2),
  .Func   (Func),
  .ALUout (ALUout)
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
  ALUout_expected = ALUout;
  while(donesim !== 1'b1) begin
    @(negedge clk);
    if (ALUout != ALUout_expected) begin
      $display("Error for Func: %d, In1: %d, In2: %d", Func, In1, In2);
      $display("ALUout_expected: %d, but ALU_out: %d", ALUout_expected, ALUout);
      $stop;
    end
  end
end

initial begin
  donesim = 1'b0;
  In1 = 32'd0;
  In2 = 32'd0;
  Func = 4'hX;

  // AND
  #10
  Func = 4'b0000;
  In1 = 32'd5;
  In2 = 32'd10;
  ALUout_expected = 32'd0;

  // OR
  #10
  Func = 4'b0001;
  ALUout_expected = 32'd15;

  // XOR
  #10
  Func = 4'b0010;
  In2 = 32'd11;
  ALUout_expected = 32'd14;

  // XNOR
  #10
  Func = 4'b0011;
  ALUout_expected = 32'hFFFFFFF1;

  // ADD
  #10
  Func = 4'b0100;
  ALUout_expected = 32'd8;

  // SUB
  #10
  Func = 4'b1100;
  ALUout_expected = 32'hFFFFFFFA;

  // SLT
  #10
  Func = 4'b0101;
  ALUout_expected= 32'd0;

  donesim = 1'b1;
  $stop;
end

endmodule

`default_nettype wire
