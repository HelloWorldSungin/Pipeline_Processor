/*
 * file: multiplier_tb.v
 */


module multiplier_tb ();
	reg clk, reset, start, m_signed;
	reg [31:0] a, b;
	wire ready, done;
	wire [63:0] p;

	multiplier #(32) m2(clk, reset, start, m_signed, a, b, ready, done, p);

	always begin #10 clk = ~clk; end

	initial begin
		clk <= 1;
		reset <= 1;
		start <= 0;
		m_signed <= 1;
		#10
		reset <= 0;
		start <= 1;
		#10
		a <= 32973;
		b <= -492901;
		#660
		reset <= 1;
		#10
		reset <= 0;
		#10
		a <= -971436;
		b <= -78525;
		start <= 1;
		#10
		start <= 0;
		#660
		reset <= 1;
		#20
		reset <= 0;
		#10
		start <= 1;
		m_signed <= 0;
		a <= 45621;
		b <= 325401;
		#660
		start <= 0;
	end

endmodule
