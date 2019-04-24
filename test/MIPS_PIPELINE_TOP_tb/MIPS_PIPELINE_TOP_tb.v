`timescale 1 ns / 1 ns
`default_nettype none

module MIPS_PIPELINE_TOP_tb ();

//--Inputs--------------------------
reg clk;
reg reset;

// Declare local regs and wires
reg donesim;

// initialize MIPS_PIPELINE_TOP module
MIPS_PIPELINE_TOP MIPS_PIPELINE_TOP_init (
  .clk      (clk),
  .reset    (reset)
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

  initial begin
    donesim = 1'b0;
    #400;
    donesim = 1'b1;
  end


endmodule // MIPS_PIPELINE_TOP_tb

`default_nettype wire
