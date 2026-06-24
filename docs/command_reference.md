# OpenROAD Command Reference Used in This Project

## Synthesis

### Run Yosys

```bash
yosys -s synth.ys
```

Purpose:
Generate gate-level netlist from RTL.

---

## Load Design

```tcl
read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog afifo_synth.v
link_design afifo
```

Purpose:
Load synthesized design into OpenROAD.

---

## Floorplanning

```tcl
initialize_floorplan
```

Purpose:
Create die area and core area.

---

## Pin Placement

```tcl
place_pins \
    -hor_layers met3 \
    -ver_layers met2
```

Purpose:
Assign IO pins around the core boundary.

---

## Global Placement

```tcl
global_placement
```

Purpose:
Place standard cells.

---

## Detailed Placement

```tcl
detailed_placement
```

Purpose:
Legalize placement.

---

## Timing Constraints

```tcl
create_clock -name wclk -period 10 [get_ports wclk]

create_clock -name rclk -period 14 [get_ports rclk]

set_clock_groups -asynchronous \
    -group {wclk} \
    -group {rclk}
```

Purpose:
Define clock domains and CDC relationship.

---

## Static Timing Analysis

```tcl
report_checks
```

Purpose:
Analyze setup timing paths.

---

## Clock Tree Synthesis

```tcl
clock_tree_synthesis \
    -buf_list sky130_fd_sc_hd__clkbuf_1
```

Purpose:
Generate balanced clock distribution.

---

## Global Routing

```tcl
global_route
```

Purpose:
Generate routing guides.

---

## Detailed Routing

```tcl
detailed_route
```

Purpose:
Create final metal routes.

---

## Save Design

### Save DEF

```tcl
write_def afifo_final.def
```

### Save ODB

```tcl
write_db afifo_final.odb
```

Purpose:
Store final physical implementation.

---

## Useful Inspection Commands

### Design Area

```tcl
report_design_area
```

### Cell Count

```tcl
llength [get_cells *]
```

### Port List

```tcl
get_ports *
```

### Library Cells

```tcl
get_lib_cells *
```

### Fit Layout View

```tcl
gui::fit
```

These commands were used during the implementation and debugging of the AFIFO design using OpenROAD and Sky130HD.
