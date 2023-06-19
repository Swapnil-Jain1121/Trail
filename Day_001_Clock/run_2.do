#compilation
vlog clock_2.v

#elaboration
vsim -novopt -suppress 12110 tb +freq=30

#adding signals to the wave
add wave -position insertpoint sim:/tb/*

#simulation
run -all