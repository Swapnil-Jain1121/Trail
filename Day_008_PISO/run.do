#compilation
vlog tb_PISO.v

#elaboration
vsim -novopt -suppress 12110 tb_PISO 

#adding signals to the wave
add wave -position insertpoint sim:/tb_PISO/dut/*

#simulation
run -all