#compilation
vlog tb_half_adder.v

#elaboration
vsim -novopt -suppress 12110 tb_half_adder

#adding signals to the wave
add wave -position insertpoint sim:/tb_half_adder/*

#simulation
run -all