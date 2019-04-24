#!/usr/bin/bash

rm -f run_MIPS_PIPELINE_TOP_tb_transcript
rm -f vsim.wlf

vsim -c -do "do run_MIPS_PIPELINE_TOP_tb_auto.do $1"
