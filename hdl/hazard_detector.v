
module hazard_detector (
	clk, reset,
	rs_d,
	rt_d,
	branch_d,
	jump_d,
	memread_d,
	memwrite_d,
	rt_e,
	regwrite_e,
	writereg_e,
	memtoreg_e,
	memread_e,
	memwrite_e,
	writereg_m,
	memtoreg_m,
	memread_m,
	memwrite_m,
	memready_m,
	stall_f, stall_d, flush_d, flush_e,
	stall_e, stall_m, flush_w
);
//--Input Ports-----------------------------------------------
input clk, reset;
input [4:0] rs_d, rt_d;
input [4:0] rt_e, writereg_e;
input [4:0] writereg_m;
input regwrite_e;
input branch_d, jump_d, memread_d, memwrite_d; // possible timing error
input memtoreg_e, memread_e, memwrite_e;
input memtoreg_m, memread_m, memwrite_m, memready_m;
//--Output Ports-----------------------------------
output reg stall_f, stall_d, stall_e, stall_m;
output reg flush_d, flush_e, flush_w;
//--Internal Wires---------------------------------
wire jump_flush;
wire branch_not_taken;
wire flush_no_stall;
wire branch_haz_e;
wire branch_haz_m;
wire lw_use_haz;
wire lw_stall;
wire branch_stall;
wire data_stall;
wire mem_stall;
//--Registers------------------------------------------
/*reg sf, sd, se, sm, fd, fe, fw;
assign stall_f = sf;
assign stall_d = sd;
assign stall_e = se;
assign stall_m = sm;
assign flush_d = fd;
assign flush_e = fe;
assign flush_w = fw;
*/
reg branch_both;

//assign branch_not_taken = branch_d & ~branch_stall;
//assign branch_not_taken = (~branch_d) ? 1 : 0;
//assign jump_flush = jump_d;
//assign flush_no_stall = jump_flush;

/*--Branch Control Hazard-----------------------------------------------------
* In our pipline the branch condition is resolved in the ID stage which
*   creates the possibility of a hazard where the branch condition is data-
*   dependent on the destination register of the previous instruction loaded
*   from memory. As a result, when a branch is being "decoded" in ID,
*   its operand may not be ready.
*   If the dependedent data is being computed by 
*/
assign branch_haz_e = branch_d & regwrite_e & (writereg_e == rs_d | writereg_e == rt_d);
assign branch_haz_m = branch_d & memtoreg_m & (writereg_m == rs_d | writereg_m == rt_d);
assign branch_stall = branch_haz_e | branch_haz_m;

/*--LOAD-USE Data Hazard----------------------
* Stall uder the this condition by setting the following signals:
*  - stall_f, stall_d, flush_e all equal tp 1'b1.
*/
assign lw_use_haz = (memtoreg_e & ((rs_d == rt_e) | (rt_d == rt_e)));
assign lw_stall = lw_use_haz;

assign data_stall = branch_stall | lw_stall;
//assign {stall_f, stall_d, stall_e, stall_m,
//		flush_e, flush_d, flush_w} = (data_stall) ? 7'b111_0000 : 7'b000_0000;


/*--MEMORY Data Hazard---------------------------------
* With the addition of a new abstraction model for the main data memory
*  unit, a new type of data hazard was introduced into our pipeline:
*    - Now that it takes 20 clock cycles to read(load) or write(store)
*      anything from memory, the balance in the execution time amongst
*      stages is no longer ideal.
*    - To accomodate this reality while maintaining the integrity of our
*      pipeline, we must set handle the hazards it creates.
*/
// set stall_f, stall_d, stall_e, stall_m, and flush_w all to 1'b1
// this will create a "bubble" or "noop"

assign mem_stall = (memread_m | memwrite_m) & ~memready_m;
//assign mem_stall = (memread_m | memwrite_m);

/*
reg pcsrc_reg;
initial pcsrc_reg <= 0;
always @ (posedge clk) begin
	if (pcsrc_reg) begin
		flush_d <= 1;
		pcsrc_reg <= 0;
	end
end
*/

//reg branch_flush;
//initial branch_flush = 0;


always @ (*) begin
	{stall_f, stall_d, flush_d, flush_e, stall_e, stall_m, flush_w} = 7'b0000000;

/*	else if (mem_stall) begin
		stall_m = 1;
		stall_e = stall_m;
		flush_w = stall_m;
		stall_d = stall_e;
		stall_f = stall_d;
	end
*/	//else

	if (data_stall) begin
		stall_d = 1;
		stall_f = stall_d;
		flush_e = stall_d;
	end

end


//assign {stall_f,stall_d,stall_e,stall_m,flush_w} = (mem_haz & ~(stall_f & stall_d))? 5'b11111:5'b00000;



endmodule

