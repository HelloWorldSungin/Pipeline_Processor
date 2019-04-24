`timescale 1 ns / 1 ns
`default_nettype none

module control_unit_TOP_tb();

//--Inputs--------------------------
reg [5:0]  op_code;
reg [5:0]  control_unit_funct;
reg        eq_ne;

//--Output--------------------------
wire [1:0]  pc_source;
wire [1:0]  out_select;
wire        mem_write;
wire        mem_read;
wire        reg_write;
wire        output_branch;
wire        ALUSrc_A;
wire [3:0]  ALU_Func;
wire        se_ze;
wire        reg_dst;
wire        start_mult;
wire        mult_sign;
wire        mem_to_reg;

// Declare local regs and wires
reg clk;
reg donesim;

wire [17:0] controller_output;
reg  [17:0] controller_output_expected;

assign controller_output = {
                            reg_write,          // 17
                            reg_dst,            // 16
                            ALUSrc_A,           // 15
                            ALU_Func,           // 11:14
                            mem_write,          // 10
                            mem_to_reg,         // 9
                            se_ze,              // 8
                            out_select,         // 6:7
                            start_mult,         // 5
                            mult_sign,          // 4
                            output_branch,      // 3
                            pc_source,          // 1:2
                            mem_read            // 0
                            };

// initialize control_unit_TOP module
control_unit_TOP control_unit_TOP_inst (
  .op_code              (op_code),
  .control_unit_funct   (control_unit_funct),
  .eq_ne                (eq_ne),
  .pc_source            (pc_source),
  .out_select           (out_select),
  .mem_write            (mem_write),
  .mem_read             (mem_read),
  .reg_write            (reg_write),
  .output_branch        (output_branch),
  .ALUSrc_A             (ALUSrc_A),
  .ALU_Func             (ALU_Func),
  .se_ze                (se_ze),
  .reg_dst              (reg_dst),
  .start_mult           (start_mult),
  .mult_sign            (mult_sign),
  .mem_to_reg           (mem_to_reg)
  );

// Simulate clk
initial begin
  clk = 0;
  while(donesim !== 1'b1) begin   // == compare bits (0 or 1), === compare 4 states (0,1,x,z)
    #5
    clk = ~clk;
  end
  $display("done");
end

// Checking controller_output against controller_output_expected
initial begin
  controller_output_expected = controller_output;
  while(donesim !== 1'b1) begin
    @(negedge clk);
    if (controller_output != controller_output_expected) begin
      $display("Error for op_code: %b, control_unit_funct: %b, eq_ne: %b", op_code, control_unit_funct, eq_ne);
      $display("controller_output_expected: %b, but controller_output: %b", controller_output_expected, controller_output);
      $display("reg_write_expected: %b, reg_write: %b", controller_output_expected[17], controller_output[17]);
      $display("reg_dst_expected: %b, reg_dst: %b", controller_output_expected[16], controller_output[16]);
      $display("ALUSrc_A_expected: %b, ALUSrc_A: %b", controller_output_expected[15], controller_output[15]);
      $display("ALU_Func_expected: 0x%0b, ALU_Func: 0x%0b", controller_output_expected[11:14], controller_output[11:14]);
      $display("mem_write_expected: %b, mem_write: %b", controller_output_expected[10], controller_output[10]);
      $display("mem_to_reg_expected: %b, mem_to_reg: %b", controller_output_expected[9], controller_output[9]);
      $display("se_ze_expected: %b, se_ze: %b", controller_output_expected[8], controller_output[8]);
      $display("out_select_expected: 0x%0b, out_select: 0x%0b", controller_output_expected[6:7], controller_output[6:7]);
      $display("start_mult_expected: %b, start_mult: %b", controller_output_expected[5], controller_output[5]);
      $display("mult_sign_expected: %b, mult_sign: %b", controller_output_expected[4], controller_output[4]);
      $display("output_branch_expected: %b, output_branch: %b", controller_output_expected[3], controller_output[3]);
      $display("pc_source_expected: 0x%0b, pc_source: 0x%0b", controller_output_expected[1:2], controller_output[1:2]);
      $display("mem_read_expected: %b, mem_read: %b", controller_output_expected[0], controller_output[0]);
      $stop;
    end
  end
end

initial begin
  clk = 0;
  eq_ne = 0;
  op_code = 6'b000000; //R-Type
  control_unit_funct = 6'b000000;  //NOOP
  controller_output_expected = 18'b00xxxxx0x0xx000001;
  #10
  control_unit_funct = 6'b100000;  //ADD
  controller_output_expected = 18'b110010000000000001;
  #10
  control_unit_funct = 6'b100001;  //ADDU
  controller_output_expected = 18'b110010000000000001;
  #10
  control_unit_funct = 6'b100010;  //SUB
  controller_output_expected = 18'b110100000000000001;
  #10
  control_unit_funct = 6'b100011;  //SUBU
  controller_output_expected = 18'b110100000000000001;
  #10
  control_unit_funct = 6'b100100;  //AND
  controller_output_expected = 18'b110000000000000001;
  #10
  control_unit_funct = 6'b100011;  //OR
  controller_output_expected = 18'b110110000000000001;
  #10
  control_unit_funct = 6'b100100;  //XOR
  controller_output_expected = 18'b110000000000000001;
  #10
  control_unit_funct = 6'b001100;  //XNOR
  controller_output_expected = 18'b110001100000000001;
  #10
  control_unit_funct = 6'b101010;  //SLT
  controller_output_expected = 18'b110110100000000001;
  #10
  control_unit_funct = 6'b101011;  //SLTU
  controller_output_expected = 18'b110110100000000001;
  #10
  control_unit_funct = 6'b010000;  //MFHI
  controller_output_expected = 18'b11xxxxx00011000001;
  #10
  control_unit_funct = 6'b010010;  //MFLO
  controller_output_expected = 18'b11XXXXX00011000001;
  #10
  control_unit_funct = 6'b011000;  //MULT
  controller_output_expected = 18'b110xxxx00x10110001;
  #10
  control_unit_funct = 6'b011001;  //MULTU
  controller_output_expected = 18'b110xxxx00x10100001;
  #10
  //I-Type
  op_code = 6'b000010;    //JUMP
  controller_output_expected = 18'b000xxxx01xxx000101;
  #20
  eq_ne = 1;
  op_code = 6'b000100;    //BEQ
  controller_output_expected = 18'b000xxxx01xxx001011;
  #20
  eq_ne = 0;         //BEQ
  controller_output_expected = 18'b000xxxx01xxx000001;
  #20
  eq_ne = 1;
  op_code = 6'b000101;    //BNE
  controller_output_expected = 18'b000xxxx01xxx000001;
  #20
  controller_output_expected = 18'b000xxxx01xxx001011;
  #20
  op_code = 6'b001000;    //ADDI
  controller_output_expected = 18'b101010000100000001;
  #10
  op_code = 6'b001001;    //ADDIU
  controller_output_expected = 18'b101010000100000001;
  #10
  op_code = 6'b001010;    //SLTI
  controller_output_expected = 18'b101110100100000001;
  #10
  op_code = 6'b001011;    //SLTIU
  controller_output_expected = 18'b101110100100000001;
  #10
  op_code = 6'b001100;    //ANDI
  controller_output_expected = 18'b101000000000000001;
  #10
  op_code = 6'b001101;    //ORI
  controller_output_expected = 18'b101000100000000001;
  #10
  op_code = 6'b001110;    //XORI
  controller_output_expected = 18'b101001000000000001;
  #10
  op_code = 6'b001111;    //LUI
  controller_output_expected = 18'b10xxxxx00x01000001;
  #10
  op_code = 6'b100011;    //LW
  controller_output_expected = 18'b101010000100000001;
  #10
  op_code = 6'b101011;    //SW
  controller_output_expected = 18'b0x101001x100000001;
  #10;

  donesim = 1'b1;
end

endmodule

`default_nettype wire
