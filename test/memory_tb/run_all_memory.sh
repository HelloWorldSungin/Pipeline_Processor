#!/usr/bin/bash

cd data_memory
source compile_data_memory_msim.sh

source run_data_memory_tb_msim.sh $1

cd ../inst_memory
source compile_inst_memory_msim.sh

source run_inst_memory_tb_msim.sh $1

cd ..
