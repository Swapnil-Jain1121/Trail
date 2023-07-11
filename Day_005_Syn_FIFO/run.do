#compilation
vlog 1_tb_fifo_3.v

#elaboration
vsim -novopt -suppress 12110 tb_fifo +testname=test_full_error

#adding signals to the wave
add wave -position insertpoint sim:/tb_fifo/dut/*

#simulation
run -all