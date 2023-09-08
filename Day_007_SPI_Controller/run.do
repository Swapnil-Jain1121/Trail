#compilation
vlog tb_SPI_ctrl.v

#elaboration
vsim -novopt -suppress 12110 tb_SPI_ctrl

#adding signals to the wave
add wave -position insertpoint sim:/tb_SPI_ctrl/dut/*

#simulation
run -all