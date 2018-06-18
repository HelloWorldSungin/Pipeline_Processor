
// Some notes for the control signals:
// **beq, bne, jump** `MemtoReg` must be set to `0` not `x`, otherwise hazard
// unit causes the fetch and decode pipeline registers to be disabled!
// `RegDst` possibly similar sitution because it causes `WriteReg` to be `x`
// and then it cannot be used by hazard detector! (RegDst is a maybe)
module maindec (
	op,
	func,
	eq_ne,
	regwrite,
	memtoreg,
	memwrite,
	memread,
	regdst,
	outselect,
	alu_src,
	alu_mid,
	se_ze,
	beq,
	bne,
	jump
);
//--Input Ports-------------------
input [5:0] op, func;
input eq_ne;
//--Output Ports------------------
output regwrite;
output memtoreg;
output memwrite;
output memread;
output [1:0] regdst;
output [1:0] outselect;
output alu_src;
output [2:0] alu_mid;
output se_ze;
output beq;
output bne;
output jump;
//--Instruction OPCODES-------
parameter RTYPE = 0;
parameter JUMP = 2;
parameter BEQ = 4;
parameter BNE = 5;
parameter ADDI = 8;
parameter ADDIU = 9;
parameter SLTI = 10;
parameter SLTIU = 11;
parameter ANDI = 12;
parameter ORI = 13;
parameter XORI = 14;
parameter LUI = 15;
parameter MUL = 28;
parameter LW = 35;
parameter SW = 43;
//--
parameter MFHI = 6'b010000;
parameter MFLO = 18;
parameter MULT = 24;
parameter MULTU = 25;

reg [15:0] controls;
assign {
	regwrite, memtoreg, memwrite, memread,
	regdst/*2b*/, outselect/*2b*/,
	alu_src, alu_mid/*3b*/,
	se_ze, beq, bne, jump
} = controls;

//--Asynchronous----------------
always @ (*) begin
	casex (op)
		RTYPE:	controls <= 16'b1000_0100_0111_x000;
/*		begin
			casex (func)
				MFHI:    controls <= 20'b1000_0111_xxxx_0010_x000;
				MFLO:    controls <= 20'b1000_0110_xxxx_0001_x000;
				MULT:    controls <= 20'b1000_1010_0xxx_1100_x000;
				MULTU:   controls <= 20'b1000_1010_0xxx_1000_x000;
				default: controls <= 16'b1000_0100_0111_x000;
			endcase
		end
*/		JUMP:    controls <= 16'b0000_xxxx_xxxx_x001;
		BEQ:     controls <= 16'b0000_0000_0000_0100;
//		BNE:     controls <= 16'b0000_xxxx_0xxx_x010;
		BNE:     controls <= 16'b0000_0000_0000_0010;
		ADDI:    controls <= 16'b1000_0000_1000_1000;
		ADDIU:   controls <= 16'b1000_0000_1000_1000;
		SLTI:    controls <= 16'b1000_0000_1101_1000;
		SLTIU:   controls <= 16'b1000_0000_1101_1000;
		ANDI:    controls <= 16'b1000_0000_1010_0000;
		ORI:     controls <= 16'b1000_0000_1011_0000;
		XORI:    controls <= 16'b1000_0000_1100_0000;
		LUI:     controls <= 16'b1000_0001_xxxx_x000;
//		MUL:     controls <= 20'b1000_0110_0xxx_1100_x000;
		LW:      controls <= 16'b1101_0000_1000_1000;
		SW:      controls <= 16'b0010_xx00_1000_1000;
		default: controls <= 16'b0000_0000_0000_0000;
	endcase
end

endmodule

