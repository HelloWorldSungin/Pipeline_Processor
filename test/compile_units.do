# Start new transcript file
transcript file compile_units_msim_transcript

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
vlog -f unit_src.f

# Compile all unit testbench and simulation-only Verilog files
vlog -f unit_src_tb.f
