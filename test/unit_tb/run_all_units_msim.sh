#!/usr/bin/bash

rm -f run_units_msim_ALU_tb_transcript
rm -f vsim.wlf

vsim -c -do "do run_unit_ALU_tb_auto.do $1"
