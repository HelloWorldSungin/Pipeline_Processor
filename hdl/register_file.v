
/*
*
*/
module register_file (
	clk, reset, wr_en,
	rd_reg_addr1, rd_reg_addr2, wr_reg_addr,
	wr_data,
	rd_data1, rd_data2
);
//--Input Ports-------
input clk, reset, wr_en;
input [4:0] rd_reg_addr1, rd_reg_addr2, wr_reg_addr;
input [31:0] wr_data;
//--Output Ports------
output reg [31:0] rd_data1, rd_data2;
//--Internal Registers-----------------------------------
reg [31:0] rf [0:31];
//reg [31:0] i;

integer i;


//assign rd_data1 = (rd_reg_addr1 == 0) ? 0 : registers[rd_reg_addr1];
//assign rd_data2 = (rd_reg_addr2 == 0) ? 0 : registers[rd_reg_addr2];

/*
* register writeback on posedge clk; do NOT write to $zero
*/
always @ (posedge clk or posedge reset) begin
	if(reset) begin
		for (i = 0; i < 32; i = i + 1) rf[i] <= i;
		rd_data1 <= 0;
		rd_data2 <= 0;
	end
	else if (wr_reg_addr!=0 && wr_en==1) begin
		rf[wr_reg_addr] <= wr_data;
	end
end


/*
* Forwarding between (MEM) / (WB) stages is handles within the register_file
*  by checking the state of the "write_enable" signal and if the register to
*  to be read has just been written. If so, the requested register can be
*  returned right away using the "write_data" value.
*/
always @ (negedge clk) begin
	if (rd_reg_addr1 == 0)
		rd_data1 <= 0;
	else if (wr_en==1 && rd_reg_addr1==wr_reg_addr)
		rd_data1 <= wr_data;
	else	rd_data1 <= rf[rd_reg_addr1];
	if (rd_reg_addr2 == 0)
		rd_data2 <= 0;
	else if (wr_en==1 && rd_reg_addr2==wr_reg_addr)
		rd_data2 <= wr_data;
	else	rd_data2 <= rf[rd_reg_addr2];
end

endmodule

