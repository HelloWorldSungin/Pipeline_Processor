#!/usr/bin/bash

rm -f run_memory_tb_transcript
rm -f vsim.wlf

vsim -c -do "do run_memory_tb_auto.do $1"
