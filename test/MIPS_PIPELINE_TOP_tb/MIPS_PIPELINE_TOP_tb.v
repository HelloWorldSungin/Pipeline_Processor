`timescale 1 ns / 1 ns
`default_nettype none

module MIPS_PIPELINE_TOP_tb ();

//--Inputs--------------------------
reg clk;
reg reset;

//--Output--------------------------
wire [31:0] result_w;

// Declare local regs and wires
reg donesim;
reg [31:0] result_w_expected;

// initialize MIPS_PIPELINE_TOP module
MIPS_PIPELINE_TOP MIPS_PIPELINE_TOP_init (
  .clk      (clk),
  .reset    (reset),
  .result_w (result_w)
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

  // Checking result_w against result_w_expected
  initial begin
    result_w_expected = result_w;
    while(donesim !== 1'b1) begin
      @(negedge clk);
      if (result_w != result_w_expected) begin
        $display("result_w unmatch error :: time is %0t",$time);
        $stop;
      end
    end
  end


  initial begin
    donesim <= 1'b0;
    reset <= 1'b1;
    #15;
    reset <= 1'b0;
    // wait for 4 cycles to get to write back stage
    #40
    result_w_expected <= 32'd11;    // Add , instr_d = 00A60820
    #10
    result_w_expected <= 32'd12;    // Addi, instr_d = 21420002
    #10
    result_w_expected <= 32'd13;    // Addiu, instr_d = 21830001
    #10
    result_w_expected <= 32'd14;    // Addu,  instr_d = 008A2020
    #10
    result_w_expected <= 32'd15;    // Sub,   instr_d = 02852822
    #10
    result_w_expected <= 32'd16;    // Subu,  instr_d = 03083023
    #10
    result_w_expected <= 32'd7;     // And,   instr_d = 02E73824
    #10
    result_w_expected <= 32'd28;    // Or,    instr_d = 02024025
    #10
    result_w_expected <= 32'd9;     // XOR,   instr_d = 02384826
    #10
    result_w_expected <= 32'hFFFFFFF4;  //Xnor, instr_d = 0313500C
    #10
    result_w_expected <= 32'd21;    // Andi,  instr_d = 32AB001F
    #10
    result_w_expected <= 32'd22;    // Ori,   instr_d = 268C0002
    #10
    result_w_expected <= 32'd23;    // Xori,  instr_d = 3A6D0004
    #10
    result_w_expected <= 32'd1;     // SLT,   instr_d = 0014702A
    #10
    result_w_expected <= 32'd1;     // SLTI,  instr_d = 2A100020
    #10
    result_w_expected <= 32'd1;     // STLIU, instr_d = 2A310020
    #10
    result_w_expected <= 32'd1;     // LW,    instr_d = 8E920008
    #10
    result_w_expected <= 32'd28;    // SW,    instr_d = AE930009
    #10
    result_w_expected <= 32'hXXXXXXXX;  // stall
    #10
    result_w_expected <= 32'd65536;   // LUI, instr_d = 3C140001
    #10
    result_w_expected <= 32'hXXXXXXXX;//LW Stall
    #10
    result_w_expected <= 32'd0;       // Skipped due to jump instruction
    #10
    result_w_expected <= 32'hXXXXXXXX;// stall
    #10
    result_w_expected <= 32'd3;       // Addi, instr_d = 22170002
    #10
    donesim = 1'b1;
  end


endmodule // MIPS_PIPELINE_TOP_tb

`default_nettype wire
