do run_unit_reg_file_tb.do
exit

if {$argc == 2} {
  do run_unit_reg_file_tb.do 1 1
} else if {$argc == 1} {
  do run_unit_reg_file_tb.do 1
} else {
  do run_unit_reg_file_tb.do
}

exit
