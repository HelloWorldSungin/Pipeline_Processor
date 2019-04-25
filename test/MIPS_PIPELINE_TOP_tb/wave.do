onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_PIPELINE_TOP_tb/donesim
add wave -noupdate /MIPS_PIPELINE_TOP_tb/clk
add wave -noupdate /MIPS_PIPELINE_TOP_tb/reset
add wave -noupdate -divider hazard_unit
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rs_d
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rt_d
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rs_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rt_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writereg_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writereg_m
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writereg_w
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memtoreg_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memtoreg_m
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/regwrite_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/regwrite_m
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/regwrite_w
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/output_branch
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_done
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwarda_d
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwardb_d
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwarda_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwardb_e
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/stall_f
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/stall_d
add wave -noupdate -group hazard_unit /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/flush_e
add wave -noupdate -divider multiplier
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/clk
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/reset
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/start_mult
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_sign
add wave -noupdate -expand -group multiplier -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srca_e
add wave -noupdate -expand -group multiplier -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srcb_e
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_ready
add wave -noupdate -expand -group multiplier /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_done
add wave -noupdate -expand -group multiplier -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/product
add wave -noupdate -divider {Pre-Fetch Stage}
add wave -noupdate -expand -group pcnext_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcsrc
add wave -noupdate -expand -group pcnext_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcjump_d
add wave -noupdate -expand -group pcnext_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcnext
add wave -noupdate -expand -group pcnext_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcbranch_d
add wave -noupdate -expand -group pcnext_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcplus4_f
add wave -noupdate -group fetch_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/fetch_register/enable
add wave -noupdate -group fetch_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/fetch_register/pc_d
add wave -noupdate -group fetch_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/fetch_register/pc_next_f
add wave -noupdate -divider {Fetch Stage}
add wave -noupdate -expand -group init_memory /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/reset
add wave -noupdate -expand -group init_memory /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pc
add wave -noupdate -expand -group init_memory /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/readdata_f
add wave -noupdate -expand -group plus4_addr -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pc
add wave -noupdate -expand -group plus4_addr -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcplus4_f
add wave -noupdate -expand -group decode_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/clr
add wave -noupdate -expand -group decode_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/enable
add wave -noupdate -expand -group decode_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/instr_f
add wave -noupdate -expand -group decode_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/instr_d
add wave -noupdate -expand -group decode_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/pc_plus4_f
add wave -noupdate -expand -group decode_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/decode_register/pc_plus4_d
add wave -noupdate -divider {Decode Stage}
add wave -noupdate -expand -group reg_file /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/clk
add wave -noupdate -expand -group reg_file /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/reset
add wave -noupdate -expand -group reg_file /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/regwrite_w
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rs_d
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rt_d
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writereg_w
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/result_w
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rf_read1
add wave -noupdate -expand -group reg_file -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rf_read2
add wave -noupdate -expand -group rd1_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwarda_d
add wave -noupdate -expand -group rd1_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_m
add wave -noupdate -expand -group rd1_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rf_read1
add wave -noupdate -expand -group rd1_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd1out_d
add wave -noupdate -expand -group rd2_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwardb_d
add wave -noupdate -expand -group rd2_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_m
add wave -noupdate -expand -group rd2_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rf_read2
add wave -noupdate -expand -group rd2_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd2out_d
add wave -noupdate -expand -group equal_comparator -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd1out_d
add wave -noupdate -expand -group equal_comparator -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd2out_d
add wave -noupdate -expand -group equal_comparator /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/eq_ne
add wave -noupdate -expand -group signnext_16_32 /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/instr_d
add wave -noupdate -expand -group signnext_16_32 /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/signimm_d
add wave -noupdate -expand -group brach_target_addr(bta) -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/branch_offset
add wave -noupdate -expand -group brach_target_addr(bta) -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcplus4_d
add wave -noupdate -expand -group brach_target_addr(bta) -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcbranch_d
add wave -noupdate -expand -group jump_offset_calculate /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/instr_d
add wave -noupdate -expand -group jump_offset_calculate -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/jump_offset
add wave -noupdate -expand -group jump_targe_addr(jta) /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/instr_d
add wave -noupdate -expand -group jump_targe_addr(jta) -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/jump_offset
add wave -noupdate -expand -group jump_targe_addr(jta) -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/pcjump_d
add wave -noupdate -expand -group upper_immediate(lui) /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/instr_d
add wave -noupdate -expand -group upper_immediate(lui) /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/upperimm_d
add wave -noupdate -expand -group zero_extended /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/instr_d
add wave -noupdate -expand -group zero_extended /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/zeroimm_d
add wave -noupdate -expand -group {immediate mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/se_ze
add wave -noupdate -expand -group {immediate mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/signimm_d
add wave -noupdate -expand -group {immediate mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/zeroimm_d
add wave -noupdate -expand -group {immediate mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/imm_d
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/clr
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/ctrls_d
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/ctrls_e
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/imm_d
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/imm_e
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd1out_d
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd1out_e
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd2out_d
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd2out_e
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd_d
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rd_e
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rs_d
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rs_e
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rt_d
add wave -noupdate -expand -group execute_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/rt_e
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/upperimm_d
add wave -noupdate -expand -group execute_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/execute_register/upperimm_e
add wave -noupdate -divider {Execute Stage}
add wave -noupdate -expand -group {srca mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwarda_e
add wave -noupdate -expand -group {srca mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_m
add wave -noupdate -expand -group {srca mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/result_w
add wave -noupdate -expand -group {srca mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd1out_e
add wave -noupdate -expand -group {srca mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srca_e
add wave -noupdate -expand -group {wde mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/forwardb_e
add wave -noupdate -expand -group {wde mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_m
add wave -noupdate -expand -group {wde mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/result_w
add wave -noupdate -expand -group {wde mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd2out_e
add wave -noupdate -expand -group {wde mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writedata_e
add wave -noupdate -expand -group {srcb mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/alusrc_e
add wave -noupdate -expand -group {srcb mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/imm_e
add wave -noupdate -expand -group {srcb mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writedata_e
add wave -noupdate -expand -group {srcb mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srcb_e
add wave -noupdate -expand -group ALU -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srca_e
add wave -noupdate -expand -group ALU -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/srcb_e
add wave -noupdate -expand -group ALU /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluctrl_e
add wave -noupdate -expand -group ALU -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout
add wave -noupdate -expand -group mainout_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/outselect_e
add wave -noupdate -expand -group mainout_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout
add wave -noupdate -expand -group mainout_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/upperimm_e
add wave -noupdate -expand -group mainout_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_lo
add wave -noupdate -expand -group mainout_mux /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/mult_hi
add wave -noupdate -expand -group mainout_mux -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_e
add wave -noupdate -expand -group {write_register mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/regdst_e
add wave -noupdate -expand -group {write_register mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rd_e
add wave -noupdate -expand -group {write_register mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/rt_e
add wave -noupdate -expand -group {write_register mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writereg_e
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/aluout_m
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/aluout_w
add wave -noupdate -expand -group writeback_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/ctrls_m
add wave -noupdate -expand -group writeback_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/ctrls_w
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/readdata_m
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/readdata_w
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/writereg_m
add wave -noupdate -expand -group writeback_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writeback_register/writereg_w
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/aluout_e
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/aluout_m
add wave -noupdate -expand -group memory_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/ctrls_e
add wave -noupdate -expand -group memory_register /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/ctrls_m
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/writedata_e
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/writedata_m
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/writereg_e
add wave -noupdate -expand -group memory_register -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memory_register/writereg_m
add wave -noupdate -divider {Memory Stage}
add wave -noupdate -expand -group data_memory /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/clk
add wave -noupdate -expand -group data_memory /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memwrite_m
add wave -noupdate -expand -group data_memory -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_m
add wave -noupdate -expand -group data_memory -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/writedata_m
add wave -noupdate -expand -group data_memory -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/readdata_m
add wave -noupdate -divider {Writeback Stage}
add wave -noupdate -expand -group {final_result mux} /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/memtoreg_w
add wave -noupdate -expand -group {final_result mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/readdata_w
add wave -noupdate -expand -group {final_result mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/aluout_w
add wave -noupdate -expand -group {final_result mux} -radix decimal /MIPS_PIPELINE_TOP_tb/MIPS_PIPELINE_TOP_init/data_path_TOP/result_w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {29 ns}
