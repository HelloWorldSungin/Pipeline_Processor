# Start new transcript file
transcript file compile_MIPS_PIPELINE_TOP_msim_transcript

# Kill off any exisiting simulation window
quit -sim -sim

# Nuke any exisiting contents of Verilog work/ subdir.
if {[file exists rtl_work]} {
  vdel -lib rtl_work -all
}

# Re-create Verilog work/ subdir and associated library
vlib rtl_work
vmap work rtl_work

# Compile all controller files
vlog -f control_unit_src.f

# Compile all data_path files
vlog -f data_path_src.f

# Compile MIPS_PIPELINE_TOP vile
vlog ../../src/MIPS_PIPELINE_TOP.v

# Compile all unit testbench and simulation-only Verilog files
vlog -vlog01compat MIPS_PIPELINE_TOP_tb.v
