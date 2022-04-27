ghdl -a --std=08 ../Fuentes/alu.vhd ../Fuentes/alu_tb.vhd # Analyze one or multiple VHDL files
ghdl -s --std=08 ../Fuentes/alu.vhd ../Fuentes/alu_tb.vhd # Check syntax of FILEs
ghdl -e --std=08 alu_tb # Elaborate design UNIT
ghdl -r --std=08 alu_tb --vcd=alu_tb.vcd --stop-time=100ns # Run design UNIT
gtkwave alu_tb.vcd --rcvar 'scale_to_time_dimension n'

