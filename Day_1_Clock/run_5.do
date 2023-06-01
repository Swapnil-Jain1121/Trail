#compilation
vlog Clock_5.v

#elaboration
vsim -novopt -suppress 12110 tb +freq=100 +duty=50 +jitter=5

#adding signals to the wave
add wave -position insertpoint sim:/tb/*

#simulation
run -all