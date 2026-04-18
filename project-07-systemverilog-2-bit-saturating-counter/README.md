# Project 07 — SystemVerilog 2-Bit Saturating Counter

## Overview
This project implements a **2-bit saturating counter** in SystemVerilog and verifies its behavior using a testbench.

---

## Objective
- Design a synchronous saturating counter
- Implement increment/decrement logic with bounds
- Handle enable and reset signals
- Develop a testbench for verification

---

## System Description

### Inputs
- `clk` — clock signal
- `rst` — reset (forces counter to 0)
- `enable` — enables counting
- `up_down` — direction control (1 = increment, 0 = decrement)

### Output
- `count[1:0]` — 2-bit counter value

### Behavior
- Counts from 0 to 3
- Saturates at limits:
  - stays at 3 if incremented
  - stays at 0 if decremented

---

## Implementation

### RTL Design
- Sequential logic implemented using `always_ff`
- State transitions controlled by input signals
- Saturation enforced via conditional logic

### Testbench
- Verifies:
  - reset behavior
  - increment/decrement
  - saturation limits
- Uses assertions and `$fatal` for correctness
- Includes final pass condition:
$display("@@@Passed");


---

## Skills Developed
- SystemVerilog RTL design
- Sequential logic implementation
- Testbench creation and verification
- FPGA-oriented design practices

---

## Tools & Technologies
- SystemVerilog
- FPGA (Basys3)
- Simulation tools

---

## Notes
This project transitions from embedded systems to digital hardware design, demonstrating full-stack cyber-physical engineering capability.
