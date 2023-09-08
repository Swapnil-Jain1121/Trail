#compilation
vlog practice_2.v

#elaboration
vsim -novopt -suppress 12110 practice

#adding signals to the wave
#add wave -position insertpoint sim:/practice/*

#simulation
run -all