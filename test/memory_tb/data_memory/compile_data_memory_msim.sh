#!/usr/bin/bash

rm -f compile_data_memory_msim_transcript

vsim -c -do compile_data_memory_auto.do
