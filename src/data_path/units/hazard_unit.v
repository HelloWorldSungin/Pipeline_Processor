/*
 * file: hazard_unit.v
 */

`default_nettype none
`timescale 1 ns / 1 ns
module hazard_unit (
  input wire [4:0]    rs_d,
  input wire [4:0]    rt_d,
  input wire [4:0]    rs_e,
  input wire [4:0]    rt_e,
  input wire [4:0]    writereg_e,
  input wire [4:0]    writereg_m,
  input wire [4:0]    writereg_w,
  input wire          memtoreg_e,
  input wire          memtoreg_m,
  input wire          regwrite_e,
  input wire          regwrite_m,
  input wire          regwrite_w,
  input wire          branch_d,
  input wire          mult_done,
  output wire         forwarda_d,
  output wire         forwardb_d,
  output wire [1:0]   forwarda_e,
  output wire [1:0]   forwardb_e,
  output wire         stall_f,
  output wire         stall_d,
  output wire         flush_e
  );

  // Declare Wires used in this Module
  wire lwstall_d;
  wire branchstall_d;
  wire multstall;

  // Assign outputs
  assign forwarda_d = (rs_d != 5'd0 & rs_d == writereg_m & regwrite_m);
  assign forwardb_d = (rt_d != 5'd0 & rt_d == writereg_m & regwrite_m);

  assign forwarda_e = ((rs_e != 5'd0) && (rs_e == writereg_m) && (regwrite_m == 1'b1)) ? 2'b10 :
                      ((rs_e != 5'd0) && (rs_e == writereg_w) && (regwrite_w == 1'b1)) ? 2'b01 : 2'b00;

  assign forwardb_e = ((rt_e != 5'd0) && (rt_e == writereg_m) && (regwrite_m == 1'b1)) ? 2'b10 :
                      ((rt_e != 5'd0) && (rt_e == writereg_w) && (regwrite_w == 1'b1)) ? 2'b01 : 2'b00;
  assign multstall = ~mult_done;

  assign lwstall_d = memtoreg_e & (rt_e == rs_d | rt_e == rt_d);
	assign branchstall_d = branch_d &
		(regwrite_e &
		(writereg_e == rs_d | writereg_e == rt_d) |
		memtoreg_m &
		(writereg_m == rs_d | writereg_m == rt_d));

	assign stall_d = lwstall_d | branchstall_d; //| multstall;
	assign stall_f = stall_d;
	assign flush_e = stall_f;

endmodule // hazard_unit

`default_nettype wire
