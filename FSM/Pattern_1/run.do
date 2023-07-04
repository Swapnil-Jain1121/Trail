#compilation
vlog 1_tb_pattern_det_moore.v

#elaboration
vsim -novopt -suppress 12110 tb

#adding signals to the wave
add wave -position insertpoint sim:/tb/dut/*

#simulation
run -all

