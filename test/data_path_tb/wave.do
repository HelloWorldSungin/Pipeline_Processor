onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_path_TOP_tb/donesim
add wave -noupdate /data_path_TOP_tb/clk
add wave -noupdate /data_path_TOP_tb/reset
add wave -noupdate /data_path_TOP_tb/controller_simulator
add wave -noupdate /data_path_TOP_tb/pc
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/inst_memory/address
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/inst_memory/read_data
add wave -noupdate /data_path_TOP_tb/eq_ne
add wave -noupdate /data_path_TOP_tb/eq_ne_expected
add wave -noupdate /data_path_TOP_tb/op_code
add wave -noupdate /data_path_TOP_tb/op_code_expected
add wave -noupdate /data_path_TOP_tb/control_unit_funct
add wave -noupdate /data_path_TOP_tb/control_unit_funct_expected
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/fetch_register/enable
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/fetch_register/pc_d
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/fetch_register/pc_d_reg
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/fetch_register/pc_next_f
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/decode_register/instr_f
add wave -noupdate /data_path_TOP_tb/data_path_TOP_init/decode_register/instr_d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
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
WaveRestoreZoom {0 ns} {114 ns}
