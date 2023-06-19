#compilation
vlog 4_tb_FA_4bit.v

#elaboration
vsim -novopt -suppress 12110 tb_FA_4bit

#adding signals to the wave
add wave -position insertpoint sim:/tb_FA_4bit/*

#simulation
run -all