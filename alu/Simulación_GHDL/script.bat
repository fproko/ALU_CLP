ghdl -a --std=08 ../Fuentes/alu.vhd ../Fuentes/alu_tb.vhd
ghdl -s --std=08 ../Fuentes/alu.vhd ../Fuentes/alu_tb.vhd
ghdl -e --std=08 alu_tb
ghdl -r --std=08 alu_tb --vcd=alu_tb.vcd --stop-time=100ns
gtkwave alu_tb.vcd --rcvar 'scale_to_time_dimension n'