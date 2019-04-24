# Start new transcript file
transcript file compile_unit_reg_file_msim_transcript

# Kill off any exisiting simulation window
quit -sim -sim

# Nuke any exisiting contents of Verilog work/ subdir.
if {[file exists rtl_work]} {
  vdel -lib rtl_work -all
}

# Re-create Verilog work/ subdir and associated library
vlib rtl_work
vmap work rtl_work

# Compile all unit source files
vlog ../../../../src/data_path/units/reg_file.v

# Compile all unit testbench and simulation-only Verilog files
vlog -vlog01compat reg_file_tb.v
