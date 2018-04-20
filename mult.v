/*
 * file: multiplier.v
 */



module multiplier #(parameter WIDTH=4)(
	input clk, reset, start, m_signed,
	input [WIDTH-1:0] src_a, src_b,
	output ready, done,
	output [2*WIDTH-1:0] product
);

	wire m0, m_is1, empty, load_words, flush, shift, add;
	//wire done;

	wire [2*WIDTH-1:0] unsigned_p;
	wire p_sign;
	wire [WIDTH-1:0] sa, sb;
	
	assign p_sign = src_a[WIDTH-1] ^ src_b[WIDTH-1];
	assign sa = (src_a[WIDTH-1]) ? (~src_a + 1'b1) : (src_a);
	assign sb = (src_b[WIDTH-1]) ? (~src_b + 1'b1) : (src_b);
	assign product = (p_sign) ? (~unsigned_p + 1'b1) : unsigned_p;

	mult_controller control2(clk, reset, start, empty, m0, m_is1,
		load_words, shift, add, flush, ready, done);

	mult_datapath #(WIDTH) data2(clk, reset, shift, add, flush, load_words, sa, sb,
		m0, m_is1, empty, unsigned_p);

endmodule


module mult_controller (
	input clk, reset, start, empty, m0, m_is1,
	output reg load_words, shift, add, flush,
	output ready, done
);

	reg [1:0] state, next_state;
	parameter IDLE=0, SHIFT=1, ADD=2, DONE=3;
	assign ready = ((state == IDLE) && !reset) || (state == DONE);
	//assign ready = ((state == IDLE) || (state == DONE));

	assign done = (state == DONE);

	always @ (posedge clk, posedge reset) begin
		//state <= (reset) ? IDLE : next_state;
		if (reset) state <= IDLE;
		else state <= next_state;
	end//always

	always @ (state, start, empty, m0, m_is1) begin
		load_words = 0; add = 0; shift = 0; flush = 0;
		case (state)
			IDLE: begin
				if (!start) next_state = IDLE;
				else if (start && !empty) begin load_words = 1; next_state = SHIFT; end
				else if (start && empty) begin flush = 1; next_state = DONE;end
			end//IDLE
			
			SHIFT: begin
				if (m_is1) begin add=1; next_state=DONE; end
				else if (m0) begin add=1; next_state=ADD; end
				else begin shift=1; next_state=SHIFT; end
			end//SHIFT

			ADD: begin
				shift=1; next_state=SHIFT;
			end//ADD

			DONE: begin
				if (start == 0) next_state=DONE;
				else if (empty) begin flush=1; next_state=DONE; end
				else begin load_words=1; next_state=SHIFT; end
			end//DONE

			default: next_state = IDLE;
		endcase
	end//always
endmodule


module mult_datapath #(parameter WIDTH=4)(
	input clk, reset, shift, add, flush, load_words,
	input [WIDTH-1:0] src_a, src_b,
	output m0, m_is1, empty,
	output reg [2*WIDTH-1:0] product
);

	reg [2*WIDTH-1:0] multiplicand;
	reg [WIDTH-1:0] multiplier;
	//assign empty = (~src_a)|(~src_b);
	assign empty = ((src_a == 0) || (src_b == 0));
	assign m_is1 = (multiplier == 1'b1);
	assign m0 = multiplier[0];


	always @ (posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			multiplier <= 0;
			multiplicand <= 0;
			product <= 0;
		end//if
		
		else if (flush) product <= 0;

		else if (load_words == 1) begin
			multiplicand <= src_a;
			multiplier <= src_b;
			product <= 0;
		end

		else if (shift) begin
			multiplicand <= multiplicand << 1;
			multiplier <= multiplier >> 1;
		end

		else if (add) begin
			product <= product + multiplicand;
		end

	end//always

endmodule
