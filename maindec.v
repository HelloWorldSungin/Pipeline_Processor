
/*
module maindec( input [5:0] OP, Func,
                input  Eq_ne,
                output RegWrite, RegDst, ALUSrcA, MemWrite, MemRead, MemtoReg, beq, bne, jump, Se_ze, Start_mult, Mult_sign,
                output [1:0] Out_select,
                output [2:0] ALU_Mid);
 reg [15:0] controls;
 assign {RegWrite, RegDst, ALUSrcA, ALU_Mid, MemWrite, MemtoReg, 
        beq, bne, jump, Se_ze, Out_select, Start_mult,Mult_sign} = controls;

 
  always@(*) begin
    case(OP)
      6'b000000: case(Func)
        6'b010000: controls   <=  16'b1100000000001100; //MFHI
        6'b010010: controls   <=  16'b1100000000001000; //MFLO                         
        6'b011000: controls   <=  16'b1100000000001011; //MULT
        6'b011001: controls   <=  16'b1100000000001010; //MULTU
        default: controls     <=  16'b1101110000000000; //RType without MULT and MULTU
              endcase
      6'b000010: controls     <=  16'b0000000000100000; //JUMP
      6'b000100: controls     <=  16'b0000000010000000; //BEQ
      6'b000101: controls     <=  16'b0000000001000000; //BNE 
      6'b001000: controls     <=  16'b1010000000010000; //ADDI
      6'b001001: controls     <=  16'b1010000000010000; //ADDIU
      6'b001010: controls     <=  16'b1011010000010000; //SLTI
      6'b001011: controls     <=  16'b1011010000010000; //SLTIU
      6'b001100: controls     <=  16'b1010100000000000; //ANDI
      6'b001101: controls     <=  16'b1010110000000000; //ORI
      6'b001110: controls     <=  16'b1011000000000000; //0ORI
      6'b001111: controls     <=  16'b1000000000000100; //LUI
      6'b100011: controls     <=  16'b1010000100010000; //LW
      6'b101011: controls     <=  16'b0010001000010000; //SW
      default:   controls     <=  16'bxxxxxxxxxxxxxxxx; 
    endcase 
  end
   assign MemRead = ~MemWrite;
  
endmodule
*/


module maindec( input [5:0] OP, Func,
                input  Eq_ne,
                output RegWrite, RegDst, ALUSrcA, MemWrite, MemRead, MemtoReg, beq, bne, jump, Se_ze, Start_mult, Mult_sign,
                output [1:0] Out_select,
                output [2:0] ALU_Mid);
 reg [15:0] controls;
 assign {RegWrite, RegDst, ALUSrcA, ALU_Mid, MemWrite, MemtoReg, 
        beq, bne, jump, Se_ze, Out_select, Start_mult,Mult_sign} = controls;

 
  always@(*) begin
    casex(OP)
      6'b000000: casex(Func)
        6'b010000: controls   <=  16'b11xxxx0000001100; //MFHI
        6'b010010: controls   <=  16'b11xxxx0000001000; //MFLO                         
        6'b011000: controls   <=  16'b110xxx00000x1011; //MULT
        6'b011001: controls   <=  16'b110xxx00000x1010; //MULTU
        default: controls     <=  16'b1101110000000000; //RType without MULT and MULTU
              endcase
      6'b000010: controls     <=  16'b0xxxxx0x001xxx00; //JUMP
      6'b000100: controls     <=  16'b0x0xxx01100xxx00; //BEQ
      6'b000101: controls     <=  16'b0x0xxx01010xxx00; //BNE 
      6'b001000: controls     <=  16'b1010000000010000; //ADDI
      6'b001001: controls     <=  16'b1010000000010000; //ADDIU
      6'b001010: controls     <=  16'b1011010000010000; //SLTI
      6'b001011: controls     <=  16'b1011010000010000; //SLTIU
      6'b001100: controls     <=  16'b1010100000000000; //ANDI
      6'b001101: controls     <=  16'b1010110000000000; //ORI
      6'b001110: controls     <=  16'b1011000000000000; //XORI
      6'b001111: controls     <=  16'b10xxxx00000x0100; //LUI
      6'b100011: controls     <=  16'b1010000000010000; //LW
      6'b101011: controls     <=  16'b0x10001x00010000; //SW
      default:   controls     <=  16'bxxxxxxxxxxxxxxxx; 
    endcase 
  end
   assign MemRead = ~MemWrite;
  
endmodule

