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
  input wire          reset,
  input wire          write,
  input wire [31:0]   address,
  input wire [31:0]   write_data,
  output wire [31:0]  read_data
  );

// Declare Wires used in this Module
reg [31:0] RAM [63:0];      // declare 2-d RAM array

genvar i;
generate
  if (reset == 1'b1) begin
    for (i = 0; i < 64; i = i + 1) begin
      RAM[i] = i;
    end
  end
endgenerate

assign read_data = RAM[address[31:2]]   // Reading the data with word aligned

always @ (posedge clk) begin
  if (write == 1'b1) begin
    RAM[address[31:2]] <= write_data;
  end
end

endmodule // data_memory

`default_nettype wire