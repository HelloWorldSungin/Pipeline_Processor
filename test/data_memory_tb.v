module data_memory_tb();
  reg [31:0] address, write_data;
  reg Clk, write;
  wire [31:0] read_data;
  
data_memory DUT(Clk, write, address, write_data, read_data);

always begin
  #5 Clk = ~Clk;
end

initial begin
  Clk <= 0;
  write <= 0;
  address <= 12; //it should read the value at at RAM[3] which is 3
  #10
  write_data <= 0; 
  address <= 20;
  write <= 1;   //it should change write 0 at RAM[5]. RAM[5] changed from 5 to 0
  #10
  
  $stop;
end

endmodule