#!/usr/bin/bash

rm -f run_data_memory_tb_transcript
rm -f vsim.wlf

vsim -c -do "do run_data_memory_tb_auto.do $1"
