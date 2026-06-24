read_liberty /opt/OpenROAD/src/sta/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog afifo_synth.v

link_design afifo

read_sdc afifo.sdc

report_checks
