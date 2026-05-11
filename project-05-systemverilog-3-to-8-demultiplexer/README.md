# Project 05 — SystemVerilog 3-to-8 Demultiplexer

This project implements a 3-to-8 decoder and uses it as a submodule to build a 3-to-8 demultiplexer in SystemVerilog. The design demonstrates combinational logic, one-hot decoding, module instantiation, enable-controlled output routing, and testbench-based verification.

The decoder converts a 3-bit input combination into one active output. The demultiplexer extends this behavior by adding an enable signal, allowing the selected output to receive the input value only when the enable signal is active.

---

## Overview

A demultiplexer is a combinational circuit that routes one input signal to one of several outputs based on select inputs. In this project, the select inputs are `a`, `b`, and `c`, and the enable input is `e`.

The project is built in two stages:

1. Design a 3-to-8 decoder.
2. Use the decoder as a submodule inside a 3-to-8 demultiplexer.

The decoder creates a one-hot output based on the select inputs, while the demultiplexer gates each decoder output with the enable signal.

---

## Project Goals

- Implement a 3-to-8 decoder using Boolean logic expressions
- Build a 3-to-8 demultiplexer using the decoder as a submodule
- Practice hierarchical SystemVerilog design
- Verify decoder behavior for all input combinations
- Verify demultiplexer behavior for all select and enable combinations
- Use testbench tasks and assertions to automate simulation checks

---

## System Behavior

### Decoder

The decoder has three inputs and eight outputs:

```text
Inputs:  a, b, c
Outputs: d0, d1, d2, d3, d4, d5, d6, d7
```

For each input combination, exactly one output is active. This is known as one-hot encoding.

Example:

```text
a b c = 000  →  d0 = 1
a b c = 001  →  d1 = 1
a b c = 010  →  d2 = 1
a b c = 111  →  d7 = 1
```

### Demultiplexer

The demultiplexer adds an enable signal `e`.

```text
Inputs:  a, b, c, e
Outputs: d0, d1, d2, d3, d4, d5, d6, d7
```

When `e = 0`, all outputs are `0`.

When `e = 1`, the demultiplexer behaves like the decoder and activates the selected output.

Example:

```text
a b c e = 0001  →  d0 = 1
a b c e = 0011  →  d1 = 1
a b c e = 0101  →  d2 = 1
a b c e = 1111  →  d7 = 1
```

---

## Design Architecture

```text
Select Inputs
 a, b, c
    │
    ▼
3-to-8 Decoder
    │
    ▼
One-Hot Decoder Outputs
    │
    ▼
Enable Gating with e
    │
    ▼
Demultiplexer Outputs
d0 d1 d2 d3 d4 d5 d6 d7
```

The demultiplexer reuses the decoder module instead of rewriting the full Boolean logic. This makes the design more modular and easier to test.

---

## Module Breakdown

### `decoder.sv`

The `decoder` module implements the 3-to-8 decoder.

```systemverilog
module decoder(
    input a, b, c,
    output d0, d1, d2, d3, d4, d5, d6, d7
);
```

Each output is assigned using a Boolean expression based on the values of `a`, `b`, and `c`.

Example:

```systemverilog
assign d0 = ~a & ~b & ~c;
assign d1 = ~a & ~b & c;
assign d7 = a & b & c;
```

### `demux.sv`

The `demux` module implements the 3-to-8 demultiplexer.

```systemverilog
module demux(
    input a, b, c,
    input e,
    output d0, d1, d2, d3, d4, d5, d6, d7
);
```

The demultiplexer instantiates the decoder as a submodule. Internal wires store the decoder outputs, and each output is gated with the enable signal `e`.

Example:

```systemverilog
assign d0 = wire0 & e;
assign d1 = wire1 & e;
assign d7 = wire7 & e;
```

This means the selected output only becomes active when `e = 1`.

---

## Verification

This project includes two testbenches:

- `decoder_tb.sv`
- `demux_tb.sv`

### Decoder Testbench

The decoder testbench checks all 8 possible input combinations for `a`, `b`, and `c`.

Each test confirms that only the correct output is active.

Example:

```text
Input:  a = 0, b = 0, c = 0
Output: d0 = 1, all other outputs = 0
```

### Demultiplexer Testbench

The demultiplexer testbench checks all 16 possible input combinations:

- 8 select input combinations when `e = 0`
- 8 select input combinations when `e = 1`

When `e = 0`, every output should remain `0`.

When `e = 1`, exactly one output should be active based on the select inputs.

---

## Testbench Strategy

The testbenches use tasks to make the simulation cleaner and more repeatable.

Example structure:

```systemverilog
task demux_test;
    input aT, bT, cT;
    input eT;
    input d0T, d1T, d2T, d3T, d4T;
    input d5T, d6T, d7T;

    #5
    a = aT; b = bT; c = cT; e = eT;

    #5
    assert(
        (d0 == d0T) && (d1 == d1T) &&
        (d2 == d2T) && (d3 == d3T) &&
        (d4 == d4T) && (d5 == d5T) &&
        (d6 == d6T) && (d7 == d7T)
    )
    else $fatal(1, "demux failed");
endtask
```

This approach avoids repeated assertion code and makes the simulation easier to debug.

---

## Repository Files

```text
project-05-systemverilog-3-to-8-demultiplexer/
│
├── decoder.sv
│   └── 3-to-8 decoder implementation
│
├── decoder_tb.sv
│   └── Decoder testbench covering all 8 input combinations
│
├── demux.sv
│   └── 3-to-8 demultiplexer using the decoder as a submodule
│
└── demux_tb.sv
    └── Demultiplexer testbench covering all 16 input and enable combinations
```

---

## Truth Table Summary

### Decoder Behavior

| `a` | `b` | `c` | Active Output |
|---|---|---|---|
| 0 | 0 | 0 | `d0` |
| 0 | 0 | 1 | `d1` |
| 0 | 1 | 0 | `d2` |
| 0 | 1 | 1 | `d3` |
| 1 | 0 | 0 | `d4` |
| 1 | 0 | 1 | `d5` |
| 1 | 1 | 0 | `d6` |
| 1 | 1 | 1 | `d7` |

### Demultiplexer Behavior

| Enable `e` | Behavior |
|---|---|
| 0 | All outputs are `0` |
| 1 | Selected decoder output is passed through |

---

## Tools and Technologies

- SystemVerilog
- Vivado
- Basys3 FPGA
- Digital logic design
- Combinational logic
- Testbench simulation
- Assertion-based verification

---

## Skills Demonstrated

- Boolean logic design
- One-hot encoding
- Decoder implementation
- Demultiplexer implementation
- Hierarchical module design
- SystemVerilog module instantiation
- Internal wire usage
- Testbench task creation
- Exhaustive simulation testing
- FPGA-oriented digital design

---

## Key Takeaways

This project demonstrates how small combinational logic blocks can be used as reusable submodules in larger digital systems. The decoder handles the one-hot selection logic, while the demultiplexer adds enable-controlled routing.

The project also reinforces the importance of exhaustive testing. By checking every input combination for both the decoder and demultiplexer, the design can be verified before being synthesized for FPGA hardware.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
