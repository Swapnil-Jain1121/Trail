#compilation
vlog 2_tb_Memory_task_args_1.v

#elaboration
vsim -novopt -suppress 12110 tb_memory

#adding signals to the wave
add wave -position insertpoint sim:/tb_memory/*

#simulation
run -all