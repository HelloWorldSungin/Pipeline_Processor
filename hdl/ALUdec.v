/*
*
*/
module ALUdec (
	Func,
	ALU_Mid,
	ALU_Op
);

input [5:0] Func;
input [2:0] ALU_Mid;
output reg [3:0] ALU_Op;

//--Asynchronous---------------------------
always @ (*)
	case (ALU_Mid) //Itype
		3'b000: ALU_Op <= 4'b0100; //addi, addiu
		3'b001: ALU_Op <= 4'b1100; //subi
		3'b010: ALU_Op <= 4'b0000; //andi
		3'b011: ALU_Op <= 4'b0001; //ori
		3'b100: ALU_Op <= 4'b0010; //xori
		3'b101: ALU_Op <= 4'b1101; //sliti
		//lui?
		default: case(Func) //Rtype
			6'b100000: ALU_Op <= 4'b0100; //add
			6'b100001: ALU_Op <= 4'b0100; //addu
			6'b100010: ALU_Op <= 4'b1100; //sub
			6'b100011: ALU_Op <= 4'b1100; //subu
			6'b100100: ALU_Op <= 4'b0000; //and
			6'b100101: ALU_Op <= 4'b0001; //or
			6'b100110: ALU_Op <= 4'b0010; //xor
			6'b001100: ALU_Op <= 4'b0011; //xnor //001100 is originally systemcall, but we use it for xnor here
			6'b101010: ALU_Op <= 4'b1101; //slt
			6'b101011: ALU_Op <= 4'b1101; //sltu
			default: ALU_Op <= 4'bxxxx; //???
		endcase
	endcase
endmodule
