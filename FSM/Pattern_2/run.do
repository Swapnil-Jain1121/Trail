#compilation
vlog 2_tb_pattern_det.v

#elaboration
vsim -novopt -suppress 12110 tb

#adding signals to the wave
add wave -position insertpoint sim:/tb/dut/*

#simulation
run -all

