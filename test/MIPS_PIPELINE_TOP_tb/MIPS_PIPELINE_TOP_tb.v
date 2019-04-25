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
  .reset    (reset)
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
    #40
    result_w_expected <= 32'd11;
    #10
    result_w_expected <= 32'd12;
    #10
    result_w_expected <= 32'd13;
    #10
    result_w_expected <= 32'd14;
    #10
    result_w_expected <= 32'd15;
    #10
    result_w_expected <= 32'd16;
    #10
    result_w_expected <= 32'd7;
    #10
    result_w_expected <= 32'd28;
    #10
    result_w_expected <= 32'd9;
    #10
    result_w_expected <= 32'hFFFFFFF4;    // -12
    #10
    result_w_expected <= 32'd21;
    #10
    result_w_expected <= 32'd22;
    #10
    result_w_expected <= 32'd23;
    #10
    result_w_expected <= 32'd1;
    #10
    result_w_expected <= 32'd1;
    #10
    result_w_expected <= 32'd1;
    #10
    result_w_expected <= 32'd1;
    #10
    result_w_expected <= 32'd28;
    #10
    result_w_expected <= 32'hXXXXXXXX;
    #10
    result_w_expected <= 32'd65536;
    #10
    result_w_expected <= 32'hXXXXXXXX;
    #10
    result_w_expected <= 32'd0;
    #10
    result_w_expected <= 32'hXXXXXXXX;
    #10
    result_w_expected <= 32'd3;
    #10
    donesim = 1'b1;
  end


endmodule // MIPS_PIPELINE_TOP_tb

`default_nettype wire
