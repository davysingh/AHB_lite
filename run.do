
vlib work
vmap work work
 
# Compile all SystemVerilog files in current folder
vlog -sv +incdir+. AHB_top.sv DUT.sv
 
# Run simulation
vsim -voptargs=+acc work.top  +UVM_VERBOSITY=UVM_LOW +UVM_CONFIG_DB_TRACE
add wave top.vif/*
add wave top.dut/mem
run -all
#quit