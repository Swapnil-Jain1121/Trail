#compilation
vlog tb_assign_2.v

#elaboration
vsim -novopt -suppress 12110 tb_mux2_1

#adding signals to the wave
add wave -position insertpoint sim:/tb_mux2_1/*

#simulation
run -all