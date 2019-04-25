
module ALU (input [31:0] In1, In2, input [3:0] Func, output reg [31:0] ALUout);
  wire [31:0] BInput;
  wire [31:0] sum;
  wire cout, cin, overflow, zero;

  assign BInput = Func[3] ? ~In2 : In2; //If(Func[3])-> BInput = ~In2, else BInput = In2
  assign {cout, sum} = Func[3]+ In1 + BInput;
  
  always @ * begin
   case (Func[2:0]) 
    3'b000 : ALUout <= In1 & BInput ; //AND
    3'b001 : ALUout <= In1 | BInput ; //OR
    3'b010 : ALUout <= In1 ^ BInput;  //XOR
    3'b011 : ALUout <= In1 ~^ BInput; //XNOR
    3'b100 : ALUout <= sum;           //ADD
    3'b101 : ALUout <= {31'd0, sum[31]}; //SLT or Zero?
   endcase
  end    
  assign zero = (ALUout == 0) ;
   
 endmodule
