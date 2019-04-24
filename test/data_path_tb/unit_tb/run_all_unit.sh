#!/usr/bin/bash

cd ALU

source compile_unit_ALU_msim.sh

source run_unit_ALU_msim.sh

cd ../reg_file

source compile_unit_reg_file_msim.sh

source run_unit_reg_file_msim.sh

cd ..
