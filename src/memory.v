module inst_memory (
	input [31:0] address,
	output [31:0] Read_data
);

	reg [31:0] RAM[63:0];
	initial $readmemh("sungin_new/dotproduct.dat", RAM);
	
	assign Read_data = RAM[address[31:2]];
endmodule


module data_memory (
	input clk, write,
	input [31:0] address, write_data,
    output [31:0] read_data
);
	reg [31:0] RAM[63:0];
	
  reg [31:0] i;
  initial begin             //set values to rf just for testbench
  for( i = 0; i < 64; i = i + 1) 
      RAM[i] = i;
  end
	

	assign read_data = RAM[address[31:2]]; // word aligned
	//assign read_data = RAM[address]; // word aligned

	//write to the memory if write = 1 and on a raising edge of the clock
	always @ (posedge clk) begin
		if (write == 1) RAM[address[31:2]] <= write_data;
		//if (write) RAM[address] <= write_data;
	end//always
endmodule
