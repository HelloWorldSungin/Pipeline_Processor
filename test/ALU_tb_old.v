module ALU_tb();
reg [31:0] In1 = 31'b0101;
reg [31:0] In2 = 31'b1010;
reg clk;
reg [3:0] Func;
wire [31:0] ALUout;
ALU DUT(In1, In2, Func, ALUout);


always begin
  #5 clk = ~clk;
end

initial begin
  clk <= 0;
  In1 = 31'b0101; //5
  In2 = 31'b1010; //10
  Func = 4'b0000; //AND   ALUout = 0000 = 0
  #20
  Func = 4'b0001; //OR    ALUout = 1111 = 15
  #20
  In2 = 31'b1011; //11
  Func = 4'b0010; //XOR   ALUout = 1110 = 14
  #20
  Func = 4'b0011; //XNOR  ALUout = 1111 1111 1111 1111 1111 1111 1111 0001 = -15
  #20
  Func = 4'b0100; //ADD   ALUout = 1000 = 8
  #20
  Func = 4'b1100; //SUB   ALUout = 1111 1111 1111 1111 1111 1111 1111 1010 = -6
  #20
  Func = 4'b0101; //SLT   ALUout = 0000 = 0
  #20
  $stop;
end

endmodule
