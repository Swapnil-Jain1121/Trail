#compilation
vlog Seed_1.v

#elaboration
vsim -novopt -suppress 12110 tb +seed=5

#adding signals to the wave
#add wave -position insertpoint sim:/tb/*

#simulation
run -all