/*
 * file: controller.v
 */


/*
 * ALU_Op: Control signal to select ALU operation
 */

/*
* Not including `output_branch` but its the same as pcsrc[0]
*/
module controller (
	op, func, eq_ne,
	pcsrc, se_ze, outputbranch,
	regwrite, regdst,
	aluctrl, alusrc, outselect,	
	memtoreg, memread, memwrite
);
//--Input Ports---------------------------------------------------------------
input [5:0] op, func;
input eq_ne;
//--Output Ports----------
output [1:0] pcsrc;
output regwrite;
output memtoreg, memread, memwrite;
//output regdst;
output [1:0] regdst;
output [1:0] outselect;
output [3:0] aluctrl;
output alusrc;
output se_ze;
output outputbranch;
//--Internal Wires---------
wire branch_taken, beq, bne, jump;
wire [2:0] ALU_Mid;

//--Wire Assignments---------
assign outputbranch = beq | bne;
assign branch_taken = (beq & eq_ne) ^ (~eq_ne & bne);
assign pcsrc = {jump, branch_taken};
//--Submodules--------------

maindec main_decoder (
	.op(op),
	.func(func),
	.eq_ne(eq_ne),
	.regwrite(regwrite),
	.memtoreg(memtoreg),
	.memwrite(memwrite),
	.memread(memread),
	.regdst(regdst),
	.outselect(outselect),
	.alu_src(alusrc),
	.alu_mid(ALU_Mid),
	.se_ze(se_ze),
	.beq(beq),
	.bne(bne),
	.jump(jump)
);

ALUdec alu_decoder (
	.Func(func),
	.ALU_Mid(ALU_Mid),
	.ALU_Op(aluctrl)
);


endmodule

