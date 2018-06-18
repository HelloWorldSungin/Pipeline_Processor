
/*
* ID/EXE Pipeline Register:
*/
module id_exe_reg (
	clk, reset, enable, clr,
	regwrite_d,
	memtoreg_d,
	memwrite_d, memread_d,
	regdst_d,
	outselect_d,
	aluctrl_d,
	alusrc_d,
	rfout1_d, rfout2_d,
	rs_d, rt_d, rd_d,
	imm_d,
	upperimm_d,
	regwrite_e,
	memtoreg_e,
	memwrite_e, memread_e,
	regdst_e,
	outselect_e,
	aluctrl_e,
	alusrc_e,
	rfout1_e, rfout2_e,
	rs_e, rt_e, rd_e,
	imm_e,
	upperimm_e
);
//--Inputs--------------------------
input clk, enable, reset, clr;
input regwrite_d;
input memtoreg_d;
input memwrite_d, memread_d;
input [1:0] regdst_d;
input [1:0] outselect_d;
input [3:0] aluctrl_d;
input alusrc_d;
input [31:0] rfout1_d, rfout2_d;
input [4:0] rs_d, rt_d, rd_d;
input [31:0] imm_d;
input [31:0] upperimm_d;
//--Outputs--------------------------
output reg regwrite_e;
output reg memtoreg_e;
output reg memwrite_e, memread_e;
output reg [1:0] regdst_e;
output reg [1:0] outselect_e;
output reg [3:0] aluctrl_e;
output reg alusrc_e;
output reg [31:0] rfout1_e, rfout2_e;
output reg [4:0] rs_e, rt_e, rd_e;
output reg [31:0] imm_e;
output reg [31:0] upperimm_e;


//--Synchronous (w/ Asynchronous reset)----------------
always @ (posedge clk or posedge reset) begin
	if (reset) begin
		regwrite_e <= 0;
		memtoreg_e <= 0;
		memwrite_e <= 0;
		memread_e <= 0;
		regdst_e <= 0;
		outselect_e <= 0;
		aluctrl_e <= 0;
		alusrc_e <= 0;
		rfout1_e <= 0;
		rfout2_e <= 0;
		rs_e <= 0;
		rt_e <= 0;
		rd_e <= 0;
		imm_e <= 0;
		upperimm_e <= 0;
	end
	else begin
		if (enable) begin
			if (clr) begin
				regwrite_e <= 0;
				memtoreg_e <= 0;
				memwrite_e <= 0;
				memread_e <= 0;
				regdst_e <= 0;
				outselect_e <= 0;
				rfout1_e <= 0;
				rfout2_e <= 0;
				rs_e <= 0;
				rt_e <= 0;
				rd_e <= 0;
			end
			else begin
				regwrite_e <= regwrite_d;
				memtoreg_e <= memtoreg_d;
				memwrite_e <= memwrite_d;
				memread_e <= memread_d;
				regdst_e <= regdst_d;
				outselect_e <= outselect_d;
				aluctrl_e <= aluctrl_d;
				alusrc_e <= alusrc_d;
				rfout1_e <= rfout1_d;
				rfout2_e <= rfout2_d;
				rs_e <= rs_d;
				rt_e <= rt_d;
				rd_e <= rd_d;
				imm_e <= imm_d;
				upperimm_e <= upperimm_d;
			end
		end
	end
end//always

endmodule
