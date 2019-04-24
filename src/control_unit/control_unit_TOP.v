/*
	controller TOP module is the brain of the Pipeline MIPS processor that decode op_code and control_unit_funct
	instructions to functional control signal to each modules in the Pipeline
	Inputs:
		1. op_code (6 bits)
		2. control_unit_funct (6 bits)
		3. eq_ne
	Outputs:
	 	1. pc_source (2 bits)
		2. out_select (2 bits) output from main_decoder
		3. mem_write (1 bit) output from main_decoder
		4. mem_read (1 bit) output from main_decoder
		5. reg_write (1 bit) output from main_decoder
		6. output_branch (1 bit)
		7. ALUSrc_A (1 bit) output from main_decoder
		8. ALU_Func (4 bits) output from ALU_decoder
		9. se_ze (1 bit) output from main_decoder
		10. reg_dst (1 bit) output from main_decoder
		11. start_mult (1 bit) output from main_decoder
		12. mult_sign (1 bit) output from main_decoder
		13. mem_to_reg (1 bit) output from main_decoder
*/
`default_nettype none

module control_unit_TOP(
		input wire [5:0] 	op_code,
		input wire [5:0] 	control_unit_funct,
		input wire 			 	eq_ne,
		output wire [1:0] pc_source,
		output wire [1:0] out_select,
		output wire mem_write,
		output wire mem_read,
		output wire reg_write,
		output wire output_branch,
		output wire ALUSrc_A,
		output wire [3:0] ALU_Func,
		output wire se_ze,
		output wire reg_dst,
		output wire start_mult,
		output wire mult_sign,
		output wire mem_to_reg
	);

// Declare Wires used in this Module
wire jump;
wire bne;
wire beq;
wire [2:0] ALU_mid;

// Assign some of the output wires
assign output_branch = (beq & eq_ne) ^ (~eq_ne & bne);
assign pc_source = {jump, output_branch};

// initialize main_decoder module

main_decoder control_unit_main_decoder (
	.op_code						(op_code),
	.control_unit_funct	(control_unit_funct),
	.reg_write					(reg_write),
	.reg_dst						(reg_dst),
	.ALUSrc_A						(ALUSrc_A),
	.mem_write					(mem_write),
	.mem_read 					(mem_read),
	.mem_to_reg					(mem_to_reg),
	.beq 								(beq),
  .bne 								(bne),
	.jump 							(jump),
	.se_ze 							(se_ze),
	.start_mult 				(start_mult),
	.mult_sign					(mult_sign),
	.out_select					(out_select),
	.ALU_mid 						(ALU_mid)
	);

// initialize ALU_decoder module

ALU_decoder control_unit_ALU_decoder (
	.control_unit_funct		(control_unit_funct),
	.ALU_mid 							(ALU_mid),
	.ALU_Func							(ALU_Func)
	);
endmodule

`default_nettype wire
