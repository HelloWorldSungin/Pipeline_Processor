#!/usr/bin/bash

rm -f compile_MIPS_PIPELINE_TOP_msim_transcript

vsim -c -do compile_MIPS_PIPELINE_TOP_auto.do
