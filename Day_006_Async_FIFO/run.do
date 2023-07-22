#compilation
vlog tb_Async_FIFO.v

#elaboration
vsim -novopt -suppress 12110 tb_Async_FIFO +test_name=test_concurrent_wr_rd 

#adding signals to the wave
add wave -position insertpoint sim:/tb_Async_FIFO/dut/*

#simulation
run -all