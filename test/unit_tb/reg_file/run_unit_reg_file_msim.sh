#!/usr/bin/bash

rm -f run_unit_reg_file_tb_msim_transcript
rm -f vsim.wlf

vsim -c -do "do run_unit_reg_file_tb_auto.do $1"
