# AFIFO RTL-to-Layout Flow Documentation

## Project Objective

The objective of this project is to implement an Asynchronous FIFO (AFIFO) using Verilog HDL and perform a complete ASIC implementation flow using open-source EDA tools.

The project demonstrates:

* RTL Design
* Logic Synthesis
* Floorplanning
* Placement
* Clock Tree Synthesis
* Static Timing Analysis
* Global Routing
* Detailed Routing
* DRC Verification

using the Sky130HD technology library.

---

# Design Description

An Asynchronous FIFO allows data transfer between two independent clock domains.

The design contains:

* Write Clock Domain (wclk)
* Read Clock Domain (rclk)
* Memory Array
* Gray Code Synchronizers
* Full Detection Logic
* Empty Detection Logic

Gray coding is used because only one bit changes between adjacent states, reducing metastability risks during clock-domain crossing.

---

# Synthesis Flow

The RTL design was synthesized using Yosys.

Generated output:

```text
afifo_synth.v
```

Statistics:

* Standard Cells: 287
* D Flip-Flops: 128

---

# Floorplanning

The synthesized netlist was imported into OpenROAD.

Main tasks:

* Core area generation
* Die area definition
* Pin placement

Utilization target:

```text
25%
```

---

# Placement

OpenROAD global placement and detailed placement were performed.

Objectives:

* Minimize wirelength
* Reduce congestion
* Improve timing

---

# Clock Tree Synthesis

Clock trees were generated using:

```text
sky130_fd_sc_hd__clkbuf_1
```

CTS Results:

* 20 clock buffers inserted
* Balanced clock distribution
* Reduced clock skew

---

# Static Timing Analysis

Clock Constraints:

```text
wclk = 10 ns
rclk = 14 ns
```

Timing Results:

```text
wclk slack = +8.07 ns
rclk slack = +11.62 ns
```

Both clock domains meet timing requirements.

---

# Routing

Routing was performed in two stages:

1. Global Routing
2. Detailed Routing

Outputs:

```text
route.guide
afifo_final.def
afifo_final.odb
```

Routing completed successfully with no reported congestion issues.

---

# DRC Verification

Generated report:

```text
drc_report.txt
```

Result:

```text
No routing DRC violations reported.
```

---

# Conclusion

This project demonstrates a complete RTL-to-Physical Design flow using open-source tools.

The AFIFO design was successfully:

* Synthesized
* Floorplanned
* Placed
* Clocked
* Routed
* Verified

using the Sky130HD technology stack and OpenROAD toolchain.
