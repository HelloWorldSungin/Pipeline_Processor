/*
  This is the data memory module in M_state
  Inputs:
    1. clk (1 bit)
    2. reset (1 bit)
    3. wirte (1 bit)
    4. address (32 bits)
    5. write_data (32 bits)
  Output:
    1. read_data (32 bits)
*/

`default_nettype none

module data_memory (
  input wire          clk,
  input wire          write,
  input wire [31:0]   address,
  input wire [31:0]   write_data,
  output wire [31:0]  read_data
  );

  // Declare Wires used in this Module
  reg [31:0] data_mem_RAM[63:0];      // declare 2-d data_mem_RAM array
  reg [31:0] i;

  assign read_data = data_mem_RAM[address[31:2]];   // Reading the data with word aligned

  initial begin
    for (i = 0; i < 64; i = i + 1)
      data_mem_RAM[i] = i;
  end

  always @ (posedge clk) begin
    if (write == 1'b1) begin
      data_mem_RAM[address[31:2]] <= write_data;
    end
  end

endmodule // data_memory

`default_nettype wire
