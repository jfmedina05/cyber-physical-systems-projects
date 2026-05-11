# Project 06 — SystemVerilog 8-Bit Arithmetic Logic Unit

This project implements an 8-bit Arithmetic Logic Unit (ALU) in SystemVerilog. The ALU performs arithmetic and logical operations on two 8-bit inputs and produces an 8-bit result, an unsigned carry flag, and a signed overflow flag.

The project demonstrates combinational logic design, operation selection using a 4-bit control signal, bitwise logic, arithmetic computation, carry detection, overflow detection, and testbench-based verification.

---

## Overview

An Arithmetic Logic Unit is a core digital circuit used in processors and embedded hardware systems. It performs mathematical and logical operations such as addition, subtraction, AND, OR, NOT, and XOR.

In this project, the ALU receives two 8-bit operands, `a` and `b`, and uses a 4-bit select input, `s`, to determine which operation should be performed.

The ALU outputs:

```text
r  →  8-bit result
c  →  unsigned carry flag
v  →  signed overflow flag
```

This project also introduces important SystemVerilog design concepts such as arrays, case statements, `always_comb` blocks, and verification through a dedicated ALU testbench.

---

## Project Goals

- Design an 8-bit ALU using SystemVerilog
- Support both arithmetic and logical operations
- Use a 4-bit operation select signal to control ALU behavior
- Implement addition and subtraction
- Detect unsigned carry for arithmetic operations
- Detect signed overflow for addition and subtraction
- Set carry and overflow to `0` for non-arithmetic operations
- Verify ALU behavior using a SystemVerilog testbench
- Prepare the design for FPGA implementation on the Basys3 board

---

## ALU Interface

The ALU module uses the following interface:

```systemverilog
module alu(
    input        [7:0] a,
    input        [7:0] b,
    input        [3:0] s,

    output logic [7:0] r,
    output logic       c,
    output logic       v
);
```

---

## Signal Description

| Signal | Direction | Width | Description |
|---|---|---|---|
| `a` | Input | 8 bits | First operand |
| `b` | Input | 8 bits | Second operand |
| `s` | Input | 4 bits | Operation select signal |
| `r` | Output | 8 bits | Result of selected operation |
| `c` | Output | 1 bit | Unsigned carry flag |
| `v` | Output | 1 bit | Signed overflow flag |

---

## Supported Operations

The ALU supports eight operations: four logical operations and four arithmetic/data operations.

| Select `s` | Operation | Result |
|---|---|---|
| `1110` | AND | `r = a & b` |
| `1101` | OR | `r = a \| b` |
| `1100` | NOT | `r = ~a` |
| `1011` | XOR | `r = a ^ b` |
| `1010` | Addition | `r = a + b` |
| `1001` | Subtraction | `r = a - b` |
| `1000` | Transfer | `r = a` |
| `0111` | Test | `r = (a == 0)` |

---

## Design Architecture

```text
        a[7:0]        b[7:0]
          │             │
          └──────┬──────┘
                 │
                 ▼
        Operation Select Logic
              s[3:0]
                 │
                 ▼
      Arithmetic / Logic Datapath
                 │
      ┌──────────┼──────────┐
      ▼          ▼          ▼
   Result r   Carry c   Overflow v
```

The ALU uses the select signal `s` to choose which operation is assigned to the result output. Arithmetic operations also update the carry and overflow flags.

---

## Arithmetic Operations

### Addition

For addition, the ALU computes:

```systemverilog
r = a + b;
```

Since adding two 8-bit unsigned values can produce a 9-bit result, the ALU uses an extended intermediate value to preserve the carry-out bit.

Example:

```text
a = 11111111
b = 00000001

a + b = 1_00000000
r     =   00000000
c     = 1
```

The lower 8 bits become `r`, while the ninth bit becomes the carry flag `c`.

---

### Subtraction

For subtraction, the ALU computes:

```systemverilog
r = a - b;
```

Subtraction is related to two's complement arithmetic:

```text
a - b = a + (~b) + 1
```

The ALU also checks signed overflow for subtraction. Overflow occurs when the signed result cannot be represented correctly in 8 bits.

---

## Carry and Overflow

### Carry Flag

The carry flag `c` is used for unsigned arithmetic.

For addition, `c` is set when the result requires a ninth bit.

For non-arithmetic operations, `c` is set to `0`.

```text
Logic operations  → c = 0
Transfer/Test     → c = 0
Addition          → c = carry-out
Subtraction       → c = arithmetic carry/borrow behavior
```

### Overflow Flag

The overflow flag `v` is used for signed arithmetic.

Signed overflow can occur when:

```text
positive + positive = negative
negative + negative = positive
```

For subtraction, overflow can occur when subtracting values with different signs produces a result with an invalid signed interpretation.

For all non-arithmetic operations, `v` is set to `0`.

---

## Logical Operations

The logical operations are applied bit-by-bit across the 8-bit operands.

### AND

```systemverilog
r = a & b;
```

Each bit of `a` is ANDed with the corresponding bit of `b`.

### OR

```systemverilog
r = a | b;
```

Each bit of `a` is ORed with the corresponding bit of `b`.

### NOT

```systemverilog
r = ~a;
```

Each bit of `a` is inverted.

### XOR

```systemverilog
r = a ^ b;
```

Each bit of `a` is XORed with the corresponding bit of `b`.

---

## Transfer and Test Operations

### Transfer

The transfer operation passes input `a` directly to the result.

```systemverilog
r = a;
```

This is useful for checking that the ALU can forward data without modification.

### Test

The test operation checks whether `a` is equal to zero.

```systemverilog
r = (a == 0);
```

If `a` is zero, the result is `1`. Otherwise, the result is `0`.

---

## Implementation Strategy

The ALU can be implemented using an `always_comb` block and a `case` statement.

Example structure:

```systemverilog
always_comb begin
    r = 8'h00;
    c = 1'b0;
    v = 1'b0;

    case (s)
        4'b1110: r = a & b;
        4'b1101: r = a | b;
        4'b1100: r = ~a;
        4'b1011: r = a ^ b;

        4'b1010: begin
            // addition
        end

        4'b1001: begin
            // subtraction
        end

        4'b1000: r = a;
        4'b0111: r = (a == 8'h00);

        default: begin
            r = 8'h00;
            c = 1'b0;
            v = 1'b0;
        end
    endcase
end
```

A default value is assigned at the beginning of the block to avoid unintended latch behavior.

---

## FPGA Top-Level Behavior

The top-level FPGA design stores the first operand `a` using flip-flops. The Basys3 switches are used to provide input values and operation selection.

General behavior:

1. Set `sw[7:0]` to the desired value of `a`.
2. Press `btnC` to store `a`.
3. Set `sw[7:0]` to the desired value of `b`.
4. Set `sw[11:8]` to the operation select value.
5. View the ALU result and flags on the LEDs.

Output mapping:

```text
LED[7:0]  → ALU result r
LED[8]    → carry flag c
LED[9]    → overflow flag v
```

This allows the ALU to be demonstrated directly on the Basys3 FPGA board.

---

## Verification

This project includes one testbench:

- `alu_tb.sv`

The testbench verifies the behavior of the `alu.sv` module across arithmetic, logical, transfer, and test operations.

### Testbench Goals

- Confirm that each operation select code produces the correct result
- Check addition behavior
- Check subtraction behavior
- Verify carry flag behavior
- Verify signed overflow behavior
- Confirm that logical operations set carry and overflow to `0`
- Confirm default or unused operation behavior
- Use assertions to catch incorrect outputs during simulation

---

## Example Test Cases

| Test | Input `a` | Input `b` | Select `s` | Expected Behavior |
|---|---|---|---|---|
| AND | `8'b10101010` | `8'b11001100` | `1110` | Bitwise AND |
| OR | `8'b10101010` | `8'b11001100` | `1101` | Bitwise OR |
| NOT | `8'b00001111` | ignored | `1100` | Invert `a` |
| XOR | `8'b10101010` | `8'b11001100` | `1011` | Bitwise XOR |
| Addition | `8'h01` | `8'h01` | `1010` | `r = 8'h02` |
| Addition Carry | `8'hFF` | `8'h01` | `1010` | `r = 8'h00`, `c = 1` |
| Subtraction | `8'h05` | `8'h03` | `1001` | `r = 8'h02` |
| Transfer | `8'hA5` | ignored | `1000` | `r = 8'hA5` |
| Test Zero | `8'h00` | ignored | `0111` | `r = 8'h01` |
| Test Nonzero | `8'h04` | ignored | `0111` | `r = 8'h00` |

---

## Repository Files

```text
project-06-systemverilog-8-bit-arithmetic-logic-unit/
│
├── alu.sv
│   └── 8-bit ALU implementation
│
└── alu_tb.sv
    └── ALU testbench for arithmetic, logic, carry, overflow, transfer, and test behavior
```

---

## Tools and Technologies

- SystemVerilog
- Vivado
- Basys3 FPGA
- Digital logic design
- Combinational logic
- Arithmetic circuits
- Testbench simulation
- Assertion-based verification

---

## Skills Demonstrated

- 8-bit ALU design
- Arithmetic circuit implementation
- Bitwise logic operations
- Two's complement subtraction
- Carry detection
- Signed overflow detection
- `always_comb` block usage
- `case` statement operation selection
- SystemVerilog array and bit slicing
- Testbench development
- FPGA-oriented digital design
- Hardware debugging and simulation

---

## Key Takeaways

This project demonstrates how arithmetic and logical operations can be combined into a single reusable digital hardware module. The ALU acts as a simplified version of the computational hardware found inside processors and embedded systems.

The project also reinforces the difference between unsigned carry and signed overflow. Carry is important for unsigned arithmetic, while overflow is important for signed arithmetic. Correctly handling both flags is an important part of digital system design.

By verifying the ALU with a dedicated testbench before FPGA implementation, the design can be tested more reliably before being demonstrated on physical hardware.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
