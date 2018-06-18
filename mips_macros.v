`ifndef MIPS_MACROS_V
`define MIPS_MACROS_V


//--OPCODES-------
`define RTYPE 0
`define JUMP  2
`define BEQ   4
`define BNE   5
`define ADDI  8
`define ADDIU 9
`define SLTI   10
`define SLTIU   11
`define ANDI   12
`define ORI   13
`define XORI   14
`define LUI   15
`define MUL   28
`define LW   35
`define SW   43

//--FUNCT (RTYPE)-----
`define SLL 0
`define SRL 2
`define MFHI   16
`define MFLO   18
`define MULT   24
`define MULTU   25
`define ADD 32
`define ADDU 33
`define SUB 34
`define SUBU 35
`define AND 36
`define OR 37
`define XOR 38
`define NOR 39
`define SLT 42
`define SLTU 43

`endif
