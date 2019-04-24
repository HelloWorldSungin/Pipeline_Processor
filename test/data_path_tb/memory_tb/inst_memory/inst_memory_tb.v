`default_nettype none

module inst_memory_tb ();

//--Inputs--------------------------
reg [31:0] address;
reg reset;
//--Output--------------------------
wire [31:0] read_data;

// Declare local regs and wires
reg clk;
reg donesim;
reg [31:0] read_data_expected;

// initialize control_unit_TOP module
inst_memory inst_memory_inst (
    .reset      (reset),
    .address    (address),
    .read_data  (read_data)
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

  // Checking read_data against read_data_expected
  initial begin
    read_data_expected = read_data;
    while(donesim !== 1'b1) begin
      @(negedge clk);
      if (read_data != read_data_expected) begin
        $display("Error for address: %d", address);
        $display("read_data_expected: %h,   read_data: %h", read_data_expected, read_data);
        $stop;
      end
    end
  end

  initial begin
    donesim = 1'b0;
    clk = 1'b0;
    reset = 1'b1;
    #10
    address = 32'd0;
    read_data_expected = 32'h00A60820;
    #10
    address = 32'd4;
    read_data_expected = 32'h21420002;
    #10
    address = 32'd8;
    read_data_expected = 32'h21830001;
    #10
    address = 32'd12;
    read_data_expected = 32'h008A2020;
    #10
    address = 32'd16;
    read_data_expected = 32'h02852822;
    #10
    address = 32'd20;
    read_data_expected = 32'h03083023;
    #10;
    donesim = 1'b1;
  end

endmodule //inst_memory_tb

`default_nettype wire
