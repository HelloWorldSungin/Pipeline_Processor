/*
 * file: controller.v
 */


/*
 * ALU_Op: Control signal to select ALU operation
 */
module controller(	input [5:0]		OP, Func,
					input			Eq_ne,
					output [1:0]	PC_source, Out_select,
					output			MemWrite, MemRead, RegWrite, Output_branch, ALUSrcA,
					output [3:0]	ALU_Op,
					output			Se_ze, RegDst, Start_mult, Mult_sign, MemtoReg);

wire jump;
wire Reset;
wire beq, bne;
wire [2:0] ALU_Mid;


maindec md(OP, Func, Eq_ne, RegWrite, RegDst, ALUSrcA, MemWrite, MemRead, MemtoReg, beq, bne,
             jump, Se_ze, Start_mult, Mult_sign, Out_select, ALU_Mid);

ALUdec ad(Func, ALU_Mid, ALU_Op);

assign Output_branch = (beq & Eq_ne)^ (~Eq_ne & bne);
assign PC_source = {jump, Output_branch};

endmodule
