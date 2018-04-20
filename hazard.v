/*
 * file: hazard.v
 */

module hazard_detector(
	input [4:0] rs_d, rt_d, rt_e,
	input [4:0] writereg_e, writereg_m,
	input memtoreg_e, memtoreg_m,
	input regwrite_e,
	input branch_d,
	input mult_done,
	output stall_f, stall_d, flush_e
);

	wire lwstall_d, branchstall_d, multstall;

	assign #1 lwstall_d = memtoreg_e & (rt_e == rs_d | rt_e == rt_d);
	assign #1 branchstall_d =
		branch_d
		& (regwrite_e & (writereg_e == rs_d | writereg_e == rt_d)
		| memtoreg_m & (writereg_m == rs_d | writereg_m == rt_d));

	assign multstall = ~mult_done;

	assign #1 stall_d = lwstall_d | branchstall_d;// | multstall;
	assign #1 stall_f = stall_d;
	assign #1 flush_e = stall_d;


endmodule
