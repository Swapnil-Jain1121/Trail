vlog clock_1.v
vsim -novopt -suppress 12110 tb
add wave -position insertpoint sim:/tb/*
run -all