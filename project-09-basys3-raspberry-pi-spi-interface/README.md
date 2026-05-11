# Project 09 — Basys3 to Raspberry Pi SPI Interface

This project implements a Serial Peripheral Interface (SPI) communication link between a Basys3 FPGA and a Raspberry Pi. The Raspberry Pi acts as the SPI master, while the Basys3 FPGA acts as the SPI slave.

The design allows the Raspberry Pi to read switch values from the Basys3 and write LED values back to the FPGA using a simple SPI-based register interface. This project demonstrates serial communication, FPGA peripheral design, shift-register behavior, hardware/software interfacing, and controller-based register mapping.

---

## Overview

SPI is a synchronous serial communication protocol commonly used to transfer data between microcontrollers, sensors, displays, memory devices, and embedded hardware systems.

In this project, the Raspberry Pi communicates with the Basys3 FPGA over SPI using four main signals:

```text
SCLK  → Serial clock from Raspberry Pi
MOSI  → Master Out, Slave In
MISO  → Master In, Slave Out
SS    → Slave Select
```

The Basys3 receives data from the Raspberry Pi through `MOSI` and sends data back through `MISO`. The FPGA-side logic is divided into two main modules:

1. `spi.sv` — handles low-level SPI serial communication
2. `ctrlr.sv` — handles the command/register interface for switches and LEDs

---

## Project Goals

- Implement an SPI slave interface in SystemVerilog
- Receive serial data from a Raspberry Pi over `MOSI`
- Transmit serial data back to the Raspberry Pi over `MISO`
- Capture incoming bits on the rising edge of `SCLK`
- Update outgoing bits on the falling edge of `SCLK`
- Convert between serial SPI data and 8-bit parallel data
- Build a controller interface for reading switches and writing LEDs
- Implement a simple memory-mapped register interface
- Demonstrate hardware communication between an FPGA and Raspberry Pi

---

## System Architecture

```text
Raspberry Pi
SPI Master
    │
    │  SCLK, SS, MOSI, MISO
    ▼
Basys3 FPGA
SPI Slave Interface
    │
    ▼
Controller Register Interface
    │
    ├── Read Basys3 switches
    ├── Write Basys3 LEDs
    └── Return chip ID
```

At a high level, the Raspberry Pi sends SPI transactions to the Basys3. The SPI module receives the serial data and converts it into an 8-bit value. The controller interprets that value as either a read or write command and responds with the appropriate data.

---

## Module Breakdown

### `spi.sv`

The `spi` module implements the low-level SPI slave interface.

```systemverilog
module spi(
    input               clk,
    input               rst,

    input               sck,
    input               ss,
    input               mosi,
    output              miso,

    input        [7:0]  din,
    output logic [7:0]  dout,
    output logic        busy
);
```

### SPI Signal Description

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | Basys3 system clock |
| `rst` | Input | Reset signal |
| `sck` | Input | SPI serial clock from Raspberry Pi |
| `ss` | Input | SPI slave select |
| `mosi` | Input | Serial data from Raspberry Pi to Basys3 |
| `miso` | Output | Serial data from Basys3 to Raspberry Pi |
| `din` | Input | Parallel byte to transmit over SPI |
| `dout` | Output | Parallel byte received from SPI |
| `busy` | Output | Indicates an active SPI transaction |

---

## SPI Timing Behavior

The SPI interface follows the timing behavior required for this project:

- `MOSI` is sampled on the rising edge of `SCLK`.
- `MISO` is updated on the falling edge of `SCLK`.
- Data is transferred from MSB to LSB.

This means the incoming bit from the Raspberry Pi is captured when `sck` rises, while the outgoing bit from the Basys3 is prepared when `sck` falls.

---

## SPI Data Flow

```text
Raspberry Pi sends serial byte over MOSI
        │
        ▼
spi.sv shifts incoming bits into register
        │
        ▼
Received byte becomes dout[7:0]
        │
        ▼
Controller reads dout as command/data
        │
        ▼
Controller prepares response byte
        │
        ▼
spi.sv shifts response out over MISO
```

The SPI module acts like a shift register between the Raspberry Pi and FPGA logic.

---

## `ctrlr.sv`

The `ctrlr` module implements the command and register interface for the Basys3.

```systemverilog
module ctrlr(
    input                   clk,
    input                   rst,

    input           [15:0]  switches,
    output logic    [15:0]  leds,

    input                   dvalid,
    input           [7:0]   din,
    output logic    [7:0]   dout
);
```

### Controller Signal Description

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | Basys3 system clock |
| `rst` | Input | Reset signal |
| `switches` | Input | 16 Basys3 switch inputs |
| `leds` | Output | 16 Basys3 LED outputs |
| `dvalid` | Input | Indicates valid SPI data |
| `din` | Input | Byte received from Raspberry Pi |
| `dout` | Output | Byte sent back to Raspberry Pi |

The controller interprets SPI data as a two-byte command sequence. The first byte contains the address and read/write control bit. The second byte contains either write data or dummy data used during a read.

---

## Register Address Map

The controller exposes a small register map to the Raspberry Pi.

| Address | Mapping | Access Type |
|---|---|---|
| `7'h00` | `chip_id` | Read-only |
| `7'h01` | `switches[7:0]` | Read-only |
| `7'h02` | `switches[15:8]` | Read-only |
| `7'h03` | `leds[7:0]` | Read/write |
| `7'h04` | `leds[15:8]` | Read/write |

The `chip_id` register returns a fixed identifier value. The switch registers allow the Raspberry Pi to read physical FPGA switch values. The LED registers allow the Raspberry Pi to control the FPGA LEDs.

---

## Read Transaction

A read transaction allows the Raspberry Pi to request data from the Basys3.

General read sequence:

1. Byte 1: Raspberry Pi sends address with `R/W = 1`
2. Byte 2: Basys3 sends requested data back over `MISO`

Example:

```text
Read address 7'h01
        │
        ▼
Controller selects switches[7:0]
        │
        ▼
Basys3 returns lower 8 switch bits to Raspberry Pi
```

---

## Write Transaction

A write transaction allows the Raspberry Pi to update writable registers on the Basys3.

General write sequence:

1. Byte 1: Raspberry Pi sends address with `R/W = 0`
2. Byte 2: Raspberry Pi sends data to write

Example:

```text
Write address 7'h03
Write data 8'b10101010
        │
        ▼
Controller updates leds[7:0]
```

Writes to read-only registers should be ignored.

---

## Hardware Connections

The Raspberry Pi connects to the Basys3 FPGA using the SPI pins on the JC Pmod header.

| SPI Signal | Basys3 Signal | Basys3 Pin | Raspberry Pi Pin |
|---|---|---|---|
| `SCLK` | `JC[6]` | `JC9` | 23 |
| `MOSI` | `JC[5]` | `JC8` | 19 |
| `MISO` | `JC[4]` | `JC7` | 21 |
| `SS / CE0_N` | `JC[7]` | `JC10` | 24 |
| `GND` | Ground | `JC11` | 25 |

These connections allow the Raspberry Pi to send SPI clock, select, and transmit signals to the FPGA while receiving data back over `MISO`.

---

## Design Architecture

```text
             Raspberry Pi
          Python SPI Script
                  │
                  ▼
        SPI Master Transaction
                  │
      ┌───────────┼───────────┐
      │           │           │
     SCLK        MOSI        SS
      │           │           │
      ▼           ▼           ▼
              Basys3 FPGA
                  │
                  ▼
              spi.sv
      Serial-to-Parallel Interface
                  │
                  ▼
              ctrlr.sv
       Register Read/Write Interface
                  │
      ┌───────────┴───────────┐
      ▼                       ▼
  Switch Reads             LED Writes
```

---

## Repository Files

```text
project-09-basys3-raspberry-pi-spi-interface/
│
├── spi.sv
│   └── SPI slave interface for serial communication with the Raspberry Pi
│
└── ctrlr.sv
    └── Controller module for switch reads, LED writes, chip ID, and address decoding
```

---

## Verification

The original course project provides simulations for the SPI module, controller module, and top-level integrated design.

### Verification Areas

- SPI receives incoming data correctly over `MOSI`
- SPI shifts outgoing data correctly over `MISO`
- Incoming data is captured on the rising edge of `SCLK`
- Outgoing data is updated on the falling edge of `SCLK`
- `busy` reflects transaction activity
- Controller correctly decodes read and write commands
- Read-only registers ignore write attempts
- Switch values are returned correctly
- LED registers update correctly on valid writes
- Full top-level SPI/controller integration works correctly

---

## Example Use Case

A Raspberry Pi script can communicate with the Basys3 to read switch values and update LEDs.

Example system interaction:

1. User changes Basys3 switches.
2. Raspberry Pi sends a read command for switch register `7'h01`.
3. Basys3 returns `switches[7:0]`.
4. Raspberry Pi sends a write command to LED register `7'h03`.
5. Basys3 updates `leds[7:0]`.

This creates a complete hardware communication loop between the Raspberry Pi and FPGA.

---

## Tools and Technologies

- SystemVerilog
- Vivado
- Basys3 FPGA
- Raspberry Pi
- SPI communication
- Python SPI scripting
- FPGA digital logic design
- Hardware/software interfacing
- Register-mapped controller design

---

## Skills Demonstrated

- SPI slave interface design
- Serial-to-parallel data conversion
- Parallel-to-serial data transmission
- Edge-sensitive signal handling
- FPGA register interface design
- Address decoding
- Read/write transaction handling
- Raspberry Pi to FPGA communication
- Basys3 switch and LED integration
- Hardware debugging
- SystemVerilog sequential logic
- SystemVerilog combinational logic
- Hardware/software co-design

---

## Key Takeaways

This project demonstrates how an FPGA can communicate with an external embedded device using a standard serial protocol. The SPI module handles the low-level timing and bit shifting, while the controller module turns the received bytes into meaningful read and write operations.

The project also shows how hardware systems can be structured using layered design. The SPI interface is responsible for communication, while the controller is responsible for interpreting commands and interacting with physical FPGA inputs and outputs.

Together, these modules create a practical Raspberry Pi to FPGA communication system that connects embedded software with custom digital hardware.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
