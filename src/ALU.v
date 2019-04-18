/*
  Arithmetic Logic Unit (ALU) module will perform arithmetic and logic operations
  Inputs:
    In1: First 32 bits input
    In2: Second 32 bits input
    Func: this is the selector that determines which arithmetic operation will be
          computed with In1 and In2
  Output:
    ALUout: the output from the arithmetic operation with In1 and In2
*/

`default_nettype none

module ALU (
  input wire [31:0] In1,
  input wire [31:0] In2,
  input wire [3:0] Func,
  output reg [31:0] ALUout
  );

  // Declare Wires used in this Module
  wire [31:0] update_In2;
  wire [31:0] sum;
  wire cout, cin, overflow, zero;

  // Assigning values to the local wires
  assign updated_In2 = Func[3] ? ~In2 : In2;
  assign {cout, sum} = Func[3] + In1 + updated_In2;
  assign zero = (ALUout == 0);

  // ALU arithmetic computation
  assign ALUout = (Func[2:0] == 3'b000) ? In1 & updated_In2 :               //AND
                  (Func[2:0] == 3'b001) ? In1 | updated_In2 :               //OR
                  (Func[2:0] == 3'b010) ? In1 ^ updated_In2 :               //XOR
                  (Func[2:0] == 3'b011) ? In1 ~^ updated_In2 :              //XNOR
                  (Func[2:0] == 3'b100) ? sum :                             //ADD
                  (Func[2:0] == 3'b101) ? {31'd0, sum[31]} : 32'hXXXXXXXX;  //SLT

endmodule

`default_nettype wire
