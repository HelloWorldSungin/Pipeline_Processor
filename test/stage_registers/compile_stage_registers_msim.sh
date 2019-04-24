#!/usr/bin/bash

rm -f compile_stage_registers_msim_transcript

vsim -c -do compile_stage_registers_auto.do
