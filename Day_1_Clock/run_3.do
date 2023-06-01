#compilation
vlog Clock_3.v

#elaboration
vsim -novopt -suppress 12110 tb +freq=30 +duty=90

#adding signals to the wave
add wave -position insertpoint sim:/tb/*

#simulation
run -all