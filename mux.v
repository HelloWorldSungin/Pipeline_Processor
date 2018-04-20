module mux2 #(parameter WIDTH = 8) (
	input s,
	input [WIDTH-1:0] d0, d1,
	output [WIDTH-1:0] y
);
	assign y = s ? d1 : d0;
endmodule


module mux3 #(parameter WIDTH = 8) (
	input [1:0] s,
	input [WIDTH-1:0] d0, d1, d2,
	output [WIDTH-1:0] y
);
	assign y = s[1] ? d2 : (s[0] ? d1 : d0);
endmodule


module mux4 #(parameter WIDTH = 8) (
	input  [1:0] s,
	input  [WIDTH-1:0] d0, d1, d2, d3,
	output reg [WIDTH-1:0] y
);
always @ (*)
  begin
    case(s)
      2'b00 : y <= d0;
      2'b01 : y <= d1;
      2'b10 : y <= d2;
      2'b11 : y <= d3;
    endcase
  end
endmodule
