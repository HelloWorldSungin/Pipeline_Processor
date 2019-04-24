# Start new transcript file
transcript file compile_data_memory_msim_transcript

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
vlog -f memory_src.f

# Compile all unit testbench and simulation-only Verilog files
vlog -vlog01compat ./data_memory_tb.v
