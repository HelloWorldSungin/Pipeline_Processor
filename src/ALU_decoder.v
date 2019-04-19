/*
  ALU_decoder convert control_unit_funct and ALU_mid input and decode the Itype and Rtype
  instructions to correct Func selector for the ALU
  Inputs:
    control_unit_funct: 6 bits funct selector Rtype for ALU operation
    ALU_mid: 6 bits funct select Itype for ALU operation
*/

`default nettype none
module ALU_decoder(
  input wire [5:0] control_unit_funct,
  input wire [2:0] ALU_mid,
  output wire [3:0] Func
  );

  assign Func = (ALU_mid == 3'b000) ? 4'b0100 :                   // Itype:   addi, addiu
                (ALU_mid == 3'b001) ? 4'b1100 :                   //          subi
                (ALU_mid == 3'b010) ? 4'b0000 :                   //          andi
                (ALU_mid == 3'b011) ? 4'b0001 :                   //          ori
                (ALU_mid == 3'b100) ? 4'b0010 :                   //          xori
                (ALU_mid == 3'b101) ? 4'b1101 :                   //          sliti
                (control_unit_funct == 6'b100000) ? 4'b0100 :           // Rtype:   add
                (control_unit_funct == 6'b100001) ? 4'b0100 :           //          addu
                (control_unit_funct == 6'b100010) ? 4'b1100 :           //          sub
                (control_unit_funct == 6'b100011) ? 4'b1100 :           //          subu
                (control_unit_funct == 6'b100100) ? 4'b0000 :           //          and
                (control_unit_funct == 6'b100101) ? 4'b0001 :           //          or
                (control_unit_funct == 6'b100110) ? 4'b0010 :           //          xor
                (control_unit_funct == 6'b001100) ? 4'b0011 :           //          xnor, 001100 is originally systemcall, but we use it for xnor here
                (control_unit_funct == 6'b101010) ? 4'b1101 :           //          slt
                (control_unit_funct == 6'b101011) ? 4'b1101 : 4'bXXXX;  //          sltu

endmodule
`default_nettype wire
