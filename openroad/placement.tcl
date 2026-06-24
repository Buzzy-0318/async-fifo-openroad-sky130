read_lef /opt/OpenROAD/src/odb/test/data/sky130hd/sky130_fd_sc_hd.tlef

read_lef /opt/OpenROAD/src/odb/test/data/sky130hd/sky130_fd_sc_hd_merged.lef

read_liberty /opt/OpenROAD/src/sta/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog afifo_synth.v

link_design afifo

initialize_floorplan \
    -site unithd \
    -die_area "0 0 200 200" \
    -core_area "20 20 180 180"
make_tracks met2 \
    -x_pitch 0.46 \
    -y_pitch 0.46 \
    -x_offset 0.23 \
    -y_offset 0.23

make_tracks met3 \
    -x_pitch 0.68 \
    -y_pitch 0.68 \
    -x_offset 0.34 \
    -y_offset 0.34

place_pins \
    -hor_layers met2 \
    -ver_layers met3

global_placement

report_design_area
