vlib work
vlog ../ENV/interface.sv ../RTL/ram_16x8.v ../TEST/ram_pkg.sv ../TOP/ram_top.sv +incdir+../ENV +incdir+../TEST
vsim -c ram_top +RAM_write_reset
run -all