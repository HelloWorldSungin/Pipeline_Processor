#!/usr/bin/bash

rm -f compile_data_path_TOP_msim_transcript
rm -f vsim.wlf

vsim -c -do "do run_data_path_TOP_tb_auto.do $1"
