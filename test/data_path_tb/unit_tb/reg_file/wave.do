onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /reg_file_tb/donesim
add wave -noupdate /reg_file_tb/clk
add wave -noupdate /reg_file_tb/reset
add wave -noupdate /reg_file_tb/write
add wave -noupdate -radix decimal /reg_file_tb/PR1
add wave -noupdate -radix decimal /reg_file_tb/PR2
add wave -noupdate -radix decimal /reg_file_tb/WR
add wave -noupdate -radix decimal /reg_file_tb/WD
add wave -noupdate -radix decimal /reg_file_tb/RD1
add wave -noupdate -radix decimal /reg_file_tb/RD1_expected
add wave -noupdate -radix decimal /reg_file_tb/RD2
add wave -noupdate -radix decimal /reg_file_tb/RD2_expected
add wave -noupdate -radix decimal {/reg_file_tb/reg_file_inst/rf_mem[4]}
add wave -noupdate -radix decimal {/reg_file_tb/reg_file_inst/rf_mem[1]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ns} 0}
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
WaveRestoreZoom {0 ns} {116 ns}
