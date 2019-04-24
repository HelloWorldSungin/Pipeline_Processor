#!/usr/bin/bash

rm -f run_control_unit_TOP_tb_transcript
rm -f vsim.wlf

vsim -c -do "do run_control_unit_TOP_tb_auto.do $1"
