#!/usr/bin/bash

rm -f run_units_msim_transcript
rm -f vsim.wlf

vsim -c -do "do run_all_units_auto.do $1"
