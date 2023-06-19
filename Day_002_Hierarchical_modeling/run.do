#compilation
vlog tb_FA_Using_HA.v

#elaboration
vsim -novopt -suppress 12110 tb_full_adder

#adding signals to the wave
add wave -position insertpoint sim:/tb_full_adder/*

#simulation
run -all