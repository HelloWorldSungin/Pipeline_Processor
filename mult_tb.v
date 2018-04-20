/*
 * file: multiplier_tb.v
 */


module multiplier_tb ();
	reg clk, reset, start, m_signed;
	reg [7:0] a, b;
	wire ready, done;
	wire [15:0] p;

	multiplier #(8) m2(clk, reset, start, m_signed, a, b, ready, done, p);

	always begin #10 clk = ~clk; end

	initial begin
		clk <= 0;
		reset <= 0;
		start <= 0;
		m_signed <= 0;
		a <= 8'b0000;
		b <= 8'b0000;
		#10
		reset <= 1;
		#10
		reset <= 0;
		start <= 1;
		a <= 8'b0101_0111;
		b <= 8'b1000_0111;
		#10
		start <= 0;
		#1000
		reset <= 1;
		#20
		reset <= 0;
		#10
		start <= 1;
		m_signed <= 1;
		a <= 8'b1010_1010;
		b <= 8'b0111_0011;
		#10
		start <= 0;
	end

endmodule
