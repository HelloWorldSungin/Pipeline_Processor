/*
  This is the main decoder inside of the Control unit
  Inputs:
    1. 6 bits op_code
    2. 6 bits control_unit_funct
  Outputs:
    1. reg_write (1 bit)
    2. reg_dst (1 bit)
    3. ALUSrc_A (1 bit)
    4. mem_write (1 bit)
    5. mem_read (1 bit)
    6. mem_to_reg (1 bit)
    7. beq (1 bit)
    8. bne (1 bit)
    9. jump (1 bit)
    10. se_ze (1 bit)
    11. start_mult (1 bit)
    12. mult_sign (1 bit)
    13. out_select (2 bits)
    14. ALU_mid (3 bits)
*/

`default_nettype none

module main_decoder (
    input wire [5:0] op_code,
    input wire [5:0] control_unit_funct,
    output wire reg_write,
    output wire reg_dst,
    output wire ALUSrc_A,
    output wire mem_write,
    output wire mem_read,
    output wire mem_to_reg,
    output wire beq,
    output wire bne,
    output wire jump,
    output wire se_ze,
    output wire start_mult,
    output wire mult_sign,
    output wire [1:0] out_select,
    output wire [2:0] ALU_mid
  );

// Declare Wires used in this Module
wire [15:0] controls;

assign mem_read = ~mem_write;

assign {reg_write,    // 15
        reg_dst,      // 14
        ALUSrc_A,     // 13
        ALU_mid,      // 10:12
        mem_write,    // 9
        mem_to_reg,   // 8
        beq,          // 7
        bne,          // 6
        jump,         // 5
        se_ze,        // 4
        out_select,   // 2:3
        start_mult,   // 1
        mult_sign     // 0
        } = controls

assign controls = (op_code == 6'b000000) ? ((control_unit_funct == 6'b000000) ? 16'b00xxxx0x0000xx00 :        // NOOP
                                            (control_unit_funct == 6'b010000) ? 16'b11xxxx0000001100 :        // MFHI
                                            (control_unit_funct == 6'b010010) ? 16'b11xxxx0000001000 :        // MFLO
                                            (control_unit_funct == 6'b011000) ? 16'b000xxx00000x1011 :        // MULT
                                            (control_unit_funct == 6'b011001) ? 16'b110xxx00000x1010 :        // MULTU
                                                                                16'b1101110000000000) :       // RType without MULT and MULTU
                  (op_code == 6'b000010) ? 16'b000xxx01001xxx00 :                          // JUMP
                  (op_code == 6'b000100) ? 16'b000xxx01100xxx00 :                          // BEQ
                  (op_code == 6'b000101) ? 16'b000xxx01010xxx00 :                          // BNE
                  (op_code == 6'b001000) ? 16'b1010000000010000 :                          // ADDI
                  (op_code == 6'b001001) ? 16'b1010000000010000 :                          // ADDIU
                  (op_code == 6'b001010) ? 16'b1011010000010000 :                          // SLTI
                  (op_code == 6'b001011) ? 16'b1011010000010000 :                          // SLTIU
                  (op_code == 6'b001100) ? 16'b1010100000000000 :                          // ANDI
                  (op_code == 6'b001101) ? 16'b1010110000000000 :                          // ORI
                  (op_code == 6'b001110) ? 16'b1011000000000000 :                          // XORI
                  (op_code == 6'b001111) ? 16'b10xxxx00000x0100 :                          // LUI
                  (op_code == 6'b100011) ? 16'b1010000000010000 :                          // LW
                  (op_code == 6'b101011) ? 16'b0x10001x00010000 : 16'bxxxxxxxxxxxxxxxx;    // SW





endmodule

`default_nettype wire
