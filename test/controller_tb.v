module controller_tb();
  reg [5:0] OP, Func;
  reg Eq_ne;
  wire [1:0] PC_source, Out_select;
  wire			MemWrite, MemRead, RegWrite, Output_branch, ALUSrcA;
  wire [3:0]	ALU_Op;
  wire Se_ze, RegDst, Start_mult, Mult_sign, MemtoReg;
  wire Jump, bne, ALU_Mid;
  
  reg clk;
  reg [17:0] con;
  reg [17:0] testing;

  
  controller DUT(OP, Func, Eq_ne, PC_source, Out_select, MemWrite, MemRead, RegWrite, Output_branch,
              ALUSrcA, ALU_Op, Se_ze, RegDst, Start_mult, Mult_sign, MemtoReg);
              
  always@(*)   
  con = {RegWrite, RegDst, ALUSrcA, ALU_Op, MemWrite, MemtoReg, 
        Se_ze, Out_select, Start_mult,Mult_sign, Output_branch,PC_source, MemRead};  
  
  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 0;
    Eq_ne = 0;
    OP = 6'b000000; //R-Type
    Func = 6'b000000;  //NOOP
    testing = (con && 18'b00xxxxx0x0xx000001);
    #10
    Func = 6'b100000;  //ADD
    testing = (con && 18'b110010000000000001);
    #10
    Func = 6'b100001;  //ADDU
    testing = (con && 18'b110010000000000001);
    #10
    Func = 6'b100010;  //SUB
    testing = (con && 18'b110100000000000001);
    #10
    Func = 6'b100011;  //SUBU
    testing = (con && 18'b110100000000000001);
    #10
    Func = 6'b100100;  //AND
    testing = (con && 18'b110000000000000001);
    #10
    Func = 6'b100011;  //OR
    testing = (con && 18'b110110000000000001);
    #10
    Func = 6'b100100;  //XOR
    testing = (con && 18'b110000000000000001);
    #10
    Func = 6'b001100;  //XNOR
    testing = (con && 18'b110001100000000001);  
    #10
    Func = 6'b101010;  //SLT
    testing = (con && 18'b110110100000000001); 
    #10
    Func = 6'b101011;  //SLTU
    testing = (con && 18'b110110100000000001);
    #10
    Func = 6'b010000;  //MFHI
    testing = (con && 18'b11xxxxx00011000001);
    #10
    Func = 6'b010010;  //MFLO
    testing = (con && 18'b11XXXXX00011000001);
    #10
    Func = 6'b011000;  //MULT
    testing = (con && 18'b110xxxx00x10110001);
    #10
    Func = 6'b011001;  //MULTU
    testing = (con && 18'b110xxxx00x10100001);
    #10
    //I-Type
    OP = 6'b000010;    //JUMP
    testing = (con && 18'b000xxxx01xxx000101);
    #20
    Eq_ne <= 1;
    OP <= 6'b000100;    //BEQ
    testing = (con && 18'b000xxxx01xxx001011);
    #20
    Eq_ne <= 0;         //BEQ
    testing = (con && 18'b000xxxx01xxx000001);
    #20
    Eq_ne <= 1;         
    OP <= 6'b000101;    //BNE
    testing = (con && 18'b000xxxx01xxx000001);
    #20
    testing = (con && 18'b000xxxx01xxx001011);
    #20
    OP <= 6'b001000;    //ADDI
    testing = (con && 18'b101010000100000001);
    #10
    OP <= 6'b001001;    //ADDIU
    testing = (con && 18'b101010000100000001);
    #10
    OP <= 6'b001010;    //SLTI
    testing = (con && 18'b101110100100000001);
    #10
    OP <= 6'b001011;    //SLTIU
    testing = (con && 18'b101110100100000001);
    #10
    OP <= 6'b001100;    //ANDI
    testing = (con && 18'b101000000000000001);
    #10
    OP <= 6'b001101;    //ORI
    testing = (con && 18'b101000100000000001);
    #10
    OP <= 6'b001110;    //XORI
    testing = (con && 18'b101001000000000001);
    #10
    OP <= 6'b001111;    //LUI
    testing = (con && 18'b10xxxxx00x01000001);
    #10
    OP <= 6'b100011;    //LW
    testing = (con && 18'b101010000100000001);
    #10
    OP <= 6'b101011;    //SW
    testing = (con && 18'b0x101001x100000001);
    #10;
    $stop;
  end      
  
  
endmodule