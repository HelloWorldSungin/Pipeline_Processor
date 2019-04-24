# Log the simulation results into the transcript
transcript file run_data_path_TOP_tb_transcript

vsim data_path_TOP_tb

radix hex

# Setting when running on Modelsim GUI
if {$argc == 1} {
  # Setup cloumn widths, etc. for wave window
  #Layout suppresstype list
  #view - undock objects
  configure wave -namecolwidth 250
  configure wave -valuecolwidth 75

  # Open saved waveform view
  #do control_unit_TOP_tb.do
}

# Ouput vsim.wlf file
# To view waveform, open modelsim, go to this test directory, and run:
#    vsim -view vsim.wlf -do wave.do
#log -r /*

run -all
