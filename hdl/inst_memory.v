
/*
* Instruction Memory:
*/
module inst_memory (
	address,
	read_data
);
//--Input Ports-----
input [31:0] address;
//--Output Ports----
output [31:0] read_data;

/*-------------------------
*
*/
reg [31:0] RAM [255:0];

//initial $readmemh("../pipelined_mips_processor/test/inst_mem/array_sort/mini_arraysort.imem", RAM);
//initial $readmemh("branchtest.mem", RAM);
//initial $readmemh("forlooptest.mem", RAM);
//initial $readmemh("simplelw_test.mem", RAM);
//initial $readmemh("swstall_test.mem", RAM);
//initial $readmemh("hazard_test.mem", RAM);
//initial $readmemh("lwstall_test.mem", RAM);
initial $readmemh("bubble_sort.hex", RAM);
//initial $readmemh("swtest.hex", RAM);

assign read_data = RAM[address[31:2]];

endmodule

