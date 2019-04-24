`timescale 1 ns / 1 ns
`default_nettype none

module data_memory_tb ();

  //--Inputs--------------------------
  reg         clk;
  reg         write;
  reg [31:0]  address;
  reg [31:0]  write_data;

  //--Output--------------------------
  wire [31:0] read_data;

  // Declare local regs and wires
  reg donesim;
  reg [31:0] read_data_expected;

  // initialize control_unit_TOP module
  data_memory data_memroy_inst (
    .clk            (clk),
    .write          (write),
    .address        (address),
    .write_data     (write_data),
    .read_data      (read_data)
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
        $display("Error for write: %b, address: %d, write_data: %d", write, address, write_data);
        $display("read_data_expected: %d,   read_data: %d", read_data_expected, read_data);
        $stop;
      end
    end
  end

  initial begin
    clk = 1'b0;
    write = 1'b0;
    address = 32'd12;
    #10
    read_data_expected = 32'd3;
    #10
    write_data = 32'd0;
    address = 32'd20;
    write = 1'b1;
    read_data_expected = 32'd5;
    #10
    write = 1'b0;
    address = 32'd20;
    read_data_expected = 32'd0;
    #10;
    donesim = 1'b1;
  end




endmodule //data_memory_tb
