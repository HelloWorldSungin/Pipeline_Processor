/*
 * file: hazard.v
 */

module hazard_unit (
	input [4:0] rs_d, rt_d, rs_e, rt_e,
	input [4:0] writereg_e, writereg_m, writereg_w,
	input memtoreg_e, memtoreg_m,
	input regwrite_e, regwrite_m, regwrite_w,
	input branch_d,
	input mult_done,
	output forwarda_d, forwardb_d,
	output reg [1:0] forwarda_e, forwardb_e,
	output stall_f, stall_d, flush_e
);

	wire lwstall_d, branchstall_d, multstall;
	
	assign forwarda_d = (rs_d != 0 & rs_d == writereg_m & regwrite_m);
	assign forwardb_d = (rt_d != 0 & rt_d == writereg_m & regwrite_m);

	always @ (*) begin

		forwarda_e = 2'b00;
		forwardb_e = 2'b00;

		if (rs_e != 0) begin
			if (rs_e == writereg_m & regwrite_m)
				forwarda_e = 2'b10;
			else if (rs_e == writereg_w & regwrite_w)
				forwarda_e = 2'b01;
		end
		if (rt_e != 0) begin
			if (rt_e == writereg_m & regwrite_m)
				forwardb_e = 2'b10;
			else if (rt_e == writereg_w & regwrite_w)
				forwardb_e = 2'b01;
		end

	end//always

	assign #1 lwstall_d = memtoreg_e & (rt_e == rs_d | rt_e == rt_d);
	assign #1 branchstall_d = branch_d & 
		(regwrite_e &
		(writereg_e == rs_d | writereg_e == rt_d) |
		memtoreg_m &
		(writereg_m == rs_d | writereg_m == rt_d));

	//assign multstall = ~mult_done;

	assign #1 stall_d = lwstall_d | branchstall_d;// | multstall;
	assign #1 stall_f = stall_d;
	assign #1 flush_e = stall_d;


endmodule
