
/*
* file: data_forward.v
*/

module data_forward (
	rs_d, rt_d,
	rs_e, rt_e,
	writereg_m, regwrite_m,
	writereg_w, regwrite_w,
	forwardA_d, forwardB_d,
	forwardA_e, forwardB_e
);
//--Inputs--------------------------------------------------------------------
input [4:0] rs_d, rt_d;
input [4:0] rs_e, rt_e;
input [4:0] writereg_m, writereg_w;
input regwrite_m, regwrite_w;
//--Output Ports------------------------------------------------------------
output reg forwardA_d, forwardB_d;
output reg [1:0] forwardA_e, forwardB_e;
//--Registers----------------------------------------------------------
/*reg fwd_exe2id_a, fwd_exe2id_b;
reg fwd_branch_a, fwd_branch_b;
reg [1:0] fwd_alusrc_a, fwd_alusrc_b;

assign forwardA_d = (fwd_exe2id_a | fwd_branch_a);
assign forwardB_d = (fwd_exe2id_b | fwd_branch_b);
assign forwardA_e = fwd_alusrc_a;
assign forwardB_e = fwd_alusrc_b;
*/
//--Forward-to-(ID)-Decode-Stage----------------------------------------------
always @ (*) begin
	forwardA_d <= 1'b0;
	forwardB_d <= 1'b0;
	// src_A
	if (rs_d != 0) begin
		if ((rs_d == writereg_m) && (regwrite_m==1))
			forwardA_d <= 1'b1;
	end
	// src_B
	if (rt_d != 0) begin
		if ((rt_d == writereg_m) && (regwrite_m==1))
			forwardB_d <= 1'b1;
	end
/*	
	//-Forward data to DECODE stage for branch conditions
	fwd_branch_a <= 0; fwd_branch_b <= 0;
	if (branch_d == 1) begin
		if (writereg_m != 0) begin
			if (writereg_m == rs_d)
				fwd_branch_a <= 1'b1;
			else if (writereg_m == rt_d)
				fwd_branch_b <= 1'b1;
		end
	end
*/
end


//assign forwardA_d = ((rs_d!=0) & (rs_d==writereg_m) & regwrite_m);
//assign forwardB_d = ((rt_d!=0) & (rt_d==writereg_m) & regwrite_m);


//--Forward to (EXE) Execute Stage--------------------------------------------
always @ (*) begin
	forwardA_e <= 2'b00; forwardB_e <= 2'b00;
//	fwd_alusrc_a = 2'b00; fwd_alusrc_b = 2'b00;
	// src_A
	if (rs_e != 0) begin
		if ((rs_e == writereg_m) && (regwrite_m==1))
			forwardA_e <= 2'b10;
		if ((rs_e == writereg_w) && (regwrite_w==1))
			forwardA_e <= 2'b01;
	end
	// src_B
	if (rt_e != 0) begin
		if ((rt_e == writereg_m) && (regwrite_m==1))
			forwardB_e <= 2'b10;
		else if ((rt_e == writereg_w) && (regwrite_w==1))
			forwardB_e <= 2'b01;
	end
/*	if (regwrite_w) begin
		if (writereg_w != 0) begin
			if (writereg_m == rs_e)
				fwd_alusrc_a <= 2'b10;
			if (writereg_m == rt_e)
				fwd_alusrc_b <= 2'b10;
		end
		if (writereg_w != 0) begin
			if ((writereg_m != rs_e) && (writereg_w == rs_e))
				fwd_alusrc_a <= 2'b01;
			if ((writereg_m != rt_e) && (writereg_w == rt_e))
				fwd_alusrc_b <= 2'b01;
		end
	end
*/
end


endmodule



/*
//always @ (rs_e or rt_e or rs_d or rt_d or writereg_m or writereg_w or regwrite_m or regwrite_w) begin
//always @ (*) begin
always @ (posedge clk) begin
	// Execute stage
	//forwardA_d = 1'b0;
	//forwardB_d = 1'b0;
	forwardA_e = 2'b00;
	forwardB_e = 2'b00;
	
	// srcA
	if (rs_e != 0) begin
		if ((rs_e == writereg_m) && (regwrite_m==1))
			forwardA_e <= 2'b10;
		else if ((rs_e == writereg_w) && (regwrite_w==1))
			forwardA_e <= 2'b01;
	end
	// srcB
	if (rt_e != 0) begin
		if ((rt_e == writereg_m) && (regwrite_m==1))
			forwardB_e <= 2'b10;
		else if ((rt_e == writereg_w) && (regwrite_w==1))
			forwardB_e <= 2'b01;
	end

	// Decode stage
	// srcA
	if ((rs_d != 0) && (rs_d == writereg_m) && (regwrite_m==1))
		forwardA_d <= 1;
	//else
	//	forwardA_d <= 0;
	// srcB
	if ((rt_d != 0) && (rt_d == writereg_m) && (regwrite_m==1))
		forwardB_d <= 1;
	//else
	//	forwardB_d <= 0;

end//always
*/
