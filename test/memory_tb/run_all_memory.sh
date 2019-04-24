#!/usr/bin/bash

source ./data_memory/compile_data_memory_msim.sh

source ./data_memory/run_data_memory_tb_msim.sh $1

source ./inst_memory/compile_inst_memory_msim.sh

source ./inst_memory/run_inst_memory_tb_msim.sh $1
