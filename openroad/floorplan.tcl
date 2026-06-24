read_lef /opt/OpenROAD/src/odb/test/data/sky130hd/sky130_fd_sc_hd.tlef

read_lef /opt/OpenROAD/src/odb/test/data/sky130hd/sky130_fd_sc_hd_merged.lef

read_liberty /opt/OpenROAD/src/sta/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog afifo_synth.v

link_design afifo

initialize_floorplan \
  -site unithd \
  -die_area "0 0 200 200" \
  -core_area "20 20 180 180"
report_design_area
