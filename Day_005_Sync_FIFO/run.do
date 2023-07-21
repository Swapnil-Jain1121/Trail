#compilation
vlog tb_Syn_FIFO_3.v

#elaboration
vsim -novopt -suppress 12110 tb_Syn_FIFO +testname=test_empty_error

#adding signals to the wave
add wave -position insertpoint sim:/tb_Syn_FIFO/dut/*

#simulation
run -all