

module mux2 #(parameter WIDTH = 8) (
	input select,
	input [WIDTH-1:0] d0, d1,
	output [WIDTH-1:0] out
);
	assign out = select ? d1 : d0;
endmodule


module mux3 #(parameter WIDTH = 8) (
	input [1:0] select,
	input [WIDTH-1:0] d0, d1, d2,
	output [WIDTH-1:0] out
);
	assign out = select[1] ? d2 : (select[0] ? d1 : d0);
endmodule


module mux4 #(parameter WIDTH = 8) (
	input  [1:0] select,
	input  [WIDTH-1:0] d0, d1, d2, d3,
	output reg [WIDTH-1:0] out
);
always @ (*)
  begin
    case(select)
      2'b00 : out <= d0;
      2'b01 : out <= d1;
      2'b10 : out <= d2;
      2'b11 : out <= d3;
    endcase
  end
endmodule
