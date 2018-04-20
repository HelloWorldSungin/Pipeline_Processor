/*
 * file: datapath.v
 */

module old_datapath_tb ();

	reg clk, reset;

	reg seze, regwrite, regdst, memwrite, memtoreg, alusrc;
	reg [1:0] pcsrc, outselect;
	reg [3:0] aluctrl;
	wire eq_ne;

	datapath dut (
		clk, reset, pcsrc, seze, regwrite, regdst, alusrc,
		aluctrl, outselect, memwrite, memtoreg, eq_ne
	);

	always #10 clk <= ~clk;
	
	initial begin
		clk=0; reset=1;
		#10; reset=0;
	end

endmodule
