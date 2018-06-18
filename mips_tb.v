/*
*
*/
module a_pipelined_mips_tb();

reg clk;
reg reset;
wire [31:0] pc, instr, execout, writedata, readdata, result;

reg [31:0] cycle_num;

// instantiate device to be tested
mips_cpu pipelined_mips_pu (
	.clk(clk),
	.reset(reset),
	.pc_IF(pc),
	.instr_ID(instr),
	.execout_EXE(execout),
	.writedata_MEM(writedata),
	.readdata_MEM(readdata),
	.result_WB(result)
);

// pulse the `reset` signal to start processor in a known state
initial begin
	cycle_num <= 0;
	reset <= 1; #22; reset <= 0;
end

// generate clock to sequence tests
always begin clk <=1; #10; clk <= 0; # 10; end

	always @ (posedge clk) begin
		if (~reset) cycle_num <= cycle_num + 1;
	end

endmodule
