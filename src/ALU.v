/*
  Arithmetic Logic Unit (ALU) module will perform arithmetic and logic operations
  Inputs:
    In1: First 32 bits input
    In2: Second 32 bits input
    ALU_Func: this is the selector that determines which arithmetic operation will be
          computed with In1 and In2
  Output:
    ALUout: the output from the arithmetic operation with In1 and In2
*/

`default_nettype none

module ALU (
  input wire [31:0] In1,
  input wire [31:0] In2,
  input wire [3:0] ALU_Func,
  output wire [31:0] ALUout
  );

  // Declare Wires used in this Module
  wire [31:0] updated_In2;
  wire [31:0] sum;
  wire cout, cin, overflow, zero;

  // Assigning values to the local wires
  assign updated_In2 = ALU_Func[3] ? ~In2 : In2;
  assign {cout, sum} = ALU_Func[3] + In1 + updated_In2;
  assign zero = (ALUout == 0);

  // ALU arithmetic computation
  assign ALUout = (ALU_Func[2:0] == 3'b000) ? In1 & updated_In2 :               //AND
                  (ALU_Func[2:0] == 3'b001) ? In1 | updated_In2 :               //OR
                  (ALU_Func[2:0] == 3'b010) ? In1 ^ updated_In2 :               //XOR
                  (ALU_Func[2:0] == 3'b011) ? In1 ~^ updated_In2 :              //XNOR
                  (ALU_Func[2:0] == 3'b100) ? sum :                             //ADD
                  (ALU_Func[2:0] == 3'b101) ? {31'd0, sum[31]} : 32'hXXXXXXXX;  //SLT

endmodule

`default_nettype wire
