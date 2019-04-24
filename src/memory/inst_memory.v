/*
  inst_memory reads MIPS instruction from a directory file path and fetch them as the output
*/

`default_nettype none

module inst_memory (
    input wire  [31:0] address,
    output wire [31:0] read_data
  );
  // Declare Wires used in this Module
  reg [31:0] inst_mem_RAM [63:0];     // declare 2-d inst_mem_RAM array

  assign read_data = inst_mem_RAM[address[31:2]];

  initial begin
    $readmemh("../test/memfile_1st.dat", inst_mem_RAM);
  end

endmodule

`default_nettype wire
