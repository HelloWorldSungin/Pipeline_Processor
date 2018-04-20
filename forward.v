/*
 * file: forward.v
 */

module data_forward(
	input [4:0] rs_d, rt_d, rs_e, rt_e,
	input [4:0] write_reg_m, write_reg_w,
	input reg_write_m, reg_write_w,
	output forwardAD, forwardBD,
	output reg [1:0] forwardAE, forwardBE
);

	assign forwardAD = (rs_d != 0 & rs_d == write_reg_m & reg_write_m);
	assign forwardBD = (rt_d != 0 & rt_d == write_reg_m & reg_write_m);

	always @ (*) begin

		forwardAE = 2'b00;
		forwardBE = 2'b00;

		if (rs_e != 0) begin
			if (rs_e == write_reg_m & reg_write_m)
				forwardAE = 2'b10;
			else if (rs_e == write_reg_w & reg_write_w)
				forwardAE = 2'b01;
		end
		if (rt_e != 0) begin
			if (rt_e == write_reg_m & reg_write_m)
				forwardBE = 2'b10;
			else if (rt_e == write_reg_w & reg_write_w)
				forwardBE = 2'b01;
		end

	end//always

endmodule
