module inst_memory_tb();
  reg [31:0] address;
  reg Clk;
  wire [31:0] Read_data;
  inst_memory DUT(address, Read_data);
  // we are using memfile_1st as the test for
  //instruction_memory
  always begin
    #5 Clk = ~Clk;
  end
  
  initial begin
    Clk = 0;
    address = 0;  //00A60820
    #10
    address = 4;  //02852822   
    #10
    address = 8;  //02384826
    #10
    address = 12; //3A6D0004
    #10
    address = 16; //2A310020
    #10
    address = 20; //3C140001
    #10
    $stop;
  end
  
endmodule
