`timescale 1 ns / 1 ns
`default_nettype none

module data_path_TOP_tb();

//--Inputs--------------------------
reg          clk;
reg          reset;
// reg [31:0]   pc;
//reg [31:0]   instr_d;
//reg [31:0]   readdata_m;
reg          start_mult;
reg          mult_sign;
reg [1:0]    pcsrc;
reg          se_ze;
reg          regwrite_d;
reg          regdst_d;
reg          alusrc_d;
reg [3:0]    aluctrl_d;
reg [1:0]    outselect_d;
reg          memwrite_d;
reg          memtoreg_d;
reg          output_branch;

//--Output--------------------------
wire         eq_ne;
wire [5:0]   op_code;
wire [5:0]   control_unit_funct;


// Declare local regs and wires
reg donesim;
// {regwrite_d, regdst_d, alusrc_d, aluctrl_d, memwrite_d, memtoreg_d, se_ze, outselect_d, start_mult, mult_sign, output_branch, pcsrc}
reg [16:0]   controller_simulator;

reg          eq_ne_expected;
reg [5:0]    op_code_expected;
reg [5:0]    control_unit_funct_expected;

// initialize data_path_TOP_tb module
data_path_TOP data_path_TOP_init (
  .clk                 (clk),
  .reset               (reset),
  // .pc                  (pc),
  //.instr_d             (instr_d),
  //.readdata_m          (readdata_m),
  .start_mult          (start_mult),
  .mult_sign           (mult_sign),
  .pcsrc               (pcsrc),
  .se_ze               (se_ze),
  .regwrite_d          (regwrite_d),
  .regdst_d            (regdst_d),
  .alusrc_d            (alusrc_d),
  .aluctrl_d           (aluctrl_d),
  .outselect_d         (outselect_d),
  .memwrite_d          (memwrite_d),
  .memtoreg_d          (memtoreg_d),
  .output_branch       (output_branch),
  .eq_ne               (eq_ne),
  .op_code             (op_code),
  .control_unit_funct  (control_unit_funct)
  );

  // Simulate clk
  initial begin
    clk = 1'b0;
    while(donesim !== 1'b1) begin   // == compare bits (0 or 1), === compare 4 states (0,1,x,z)
      #5
      clk = ~clk;
    end
    $display("done");
  end

  // Checking outputs against the expected outputs
  initial begin
    eq_ne_expected = eq_ne;
    op_code_expected = op_code;
    control_unit_funct_expected = control_unit_funct;
    while (donesim !== 1'b1) begin
      @(negedge clk)
      if (eq_ne != eq_ne_expected) begin
        $display("Error eq_ne_expected: %b, but eq_ne: %b", eq_ne_expected, eq_ne);
        $display("Error for following inputs:");
        //$display("instr_d: %h", instr_d);
        //$display("readdata_m: %d", readdata_m);
        // $display("pc: %d", pc);
        $display("start_mult: %b", start_mult);
        $display("mult_sign: %b", mult_sign);
        $display("pcsrc: %b", pcsrc);
        $display("se_ze: %b", se_ze);
        $display("regwrite_d: %b", regwrite_d);
        $display("regdst_d: %b", regdst_d);
        $display("alusrc_d: %b", alusrc_d);
        $display("aluctrl_d: %b", aluctrl_d);
        $display("outselect_d: %b", outselect_d);
        $display("memwrite_d: %b", memwrite_d);
        $display("memtoreg_d: %b", memtoreg_d);
        $display("output_branch: %b", output_branch);
        $display("eq_ne unmatch error :: time is %0t",$time);
        #50;
        $stop;
      end
      if (op_code != op_code_expected) begin
        $display("Error op_code_expected: %b, but op_code: %b", op_code_expected, op_code);
        $display("Error for following inputs:");
        //$display("instr_d: %h", instr_d);
        //$display("readdata_m: %d", readdata_m);
        // $display("pc: %d", pc);
        $display("start_mult: %b", start_mult);
        $display("mult_sign: %b", mult_sign);
        $display("pcsrc: %b", pcsrc);
        $display("se_ze: %b", se_ze);
        $display("regwrite_d: %b", regwrite_d);
        $display("regdst_d: %b", regdst_d);
        $display("alusrc_d: %b", alusrc_d);
        $display("aluctrl_d: %b", aluctrl_d);
        $display("outselect_d: %b", outselect_d);
        $display("memwrite_d: %b", memwrite_d);
        $display("memtoreg_d: %b", memtoreg_d);
        $display("output_branch: %b", output_branch);
        $display("op_code unmatch error :: time is %0t",$time);
        #50;
        $stop;
      end
      if (control_unit_funct != control_unit_funct_expected) begin
        $display("Error control_unit_funct_expected: %b, but control_unit_funct: %b", control_unit_funct_expected, control_unit_funct);
        $display("Error for following inputs:");
        //$display("instr_d: %h", instr_d);
        //$display("readdata_m: %d", readdata_m);
        // $display("pc: %d", pc);
        $display("start_mult: %b", start_mult);
        $display("mult_sign: %b", mult_sign);
        $display("pcsrc: %b", pcsrc);
        $display("se_ze: %b", se_ze);
        $display("regwrite_d: %b", regwrite_d);
        $display("regdst_d: %b", regdst_d);
        $display("alusrc_d: %b", alusrc_d);
        $display("aluctrl_d: %b", aluctrl_d);
        $display("outselect_d: %b", outselect_d);
        $display("memwrite_d: %b", memwrite_d);
        $display("memtoreg_d: %b", memtoreg_d);
        $display("output_branch: %b", output_branch);
        $display("control_unit_funct unmatch error :: time is %0t",$time);
        #50;
        $stop;
      end
    end
  end

  initial begin
    donesim <= 1'b0;
    reset   <= 1'b1;
    #10;
    reset   <= 1'b0;
    #5;
    controller_simulator <= 17'b11001000000000000; // ADD
    {regwrite_d, regdst_d, alusrc_d, aluctrl_d, memwrite_d, memtoreg_d, se_ze, outselect_d, start_mult, mult_sign, output_branch, pcsrc} <= controller_simulator;
    #30;
    donesim <= 1'b1;
  end
endmodule

`default_nettype wire
