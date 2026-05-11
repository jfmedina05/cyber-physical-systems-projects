# Cyber-Physical Systems Projects

A collection of embedded systems and digital design projects focused on Raspberry Pi hardware interfacing, sensor communication, MQTT-based networking, GPIO/PWM control, FPGA-based digital logic, and SystemVerilog hardware design.

This repository demonstrates practical cyber-physical systems development across the full stack: physical sensors, embedded software, communication protocols, networked data publishing, remote device control, digital logic, state machines, and FPGA-to-Raspberry Pi hardware communication.

---

## Overview

Cyber-physical systems connect computation, sensing, communication, and physical-world behavior. This repository documents a series of projects built around that idea using Raspberry Pi, Python, I2C, SPI, MQTT, GPIO/PWM, SystemVerilog, Vivado, and the Basys3 FPGA.

The projects begin with Raspberry Pi setup and remote development, then move into sensor driver development, real-time sensor publishing, remote LED control, combinational logic, arithmetic logic design, finite state machines, and FPGA-to-Raspberry Pi SPI communication.

This repository was cleaned and reorganized from private coursework into a public portfolio project to better show embedded systems, hardware-software integration, and digital design skills.

---

## Project Goals

- Build reliable embedded systems using Raspberry Pi and external hardware
- Interface with sensors using I2C and SPI communication protocols
- Convert raw sensor register data into usable physical measurements
- Publish live sensor data over MQTT for remote monitoring
- Control physical outputs using GPIO and PWM
- Design and verify digital hardware using SystemVerilog
- Implement combinational and sequential logic circuits
- Build finite state machines for real-world control systems
- Connect FPGA logic with external embedded devices
- Practice structured embedded development using Git and GitHub

---

## Technical Areas

| Area | Description |
|---|---|
| Embedded Linux | Raspberry Pi setup, SSH access, command-line development, and Git workflow |
| Sensor Interfacing | Low-level communication with pressure, temperature, and accelerometer sensors |
| I2C Communication | Register-level driver development for the LPS331AP pressure/temperature sensor |
| SPI Communication | Register-level accelerometer communication and FPGA-to-Raspberry Pi SPI transfer |
| MQTT Networking | Publishing sensor data and subscribing to remote control messages |
| GPIO / PWM Control | LED control using duty cycle and frequency updates |
| Digital Logic | Decoder, demultiplexer, ALU, counter, and combinational logic design |
| Sequential Logic | Flip-flops, registers, state retention, and clocked hardware behavior |
| Finite State Machines | Elevator controller design using state-based control logic |
| FPGA Integration | Basys3 hardware demonstrations, switches, LEDs, buttons, and 7-segment displays |

---

## Repository Structure

```text
cyber-physical-systems-projects/
│
├── project-00-raspberry-pi-setup-and-git/
│   └── Raspberry Pi setup, SSH workflow, and GitHub development workflow
│
├── project-01-lps331ap-i2c-pressure-temperature-sensor/
│   └── I2C driver for pressure and temperature measurements
│
├── project-02-adxl343-spi-accelerometer/
│   └── SPI driver for 3-axis acceleration data acquisition
│
├── project-03-mqtt-sensor-network-node/
│   └── MQTT-connected sensor node for publishing live sensor data
│
├── project-04-mqtt-led-control/
│   └── Remote LED control using MQTT, GPIO, and PWM
│
├── project-05-systemverilog-3-to-8-demultiplexer/
│   └── Decoder-based 3-to-8 demultiplexer with SystemVerilog testbenches
│
├── project-06-systemverilog-8-bit-arithmetic-logic-unit/
│   └── 8-bit ALU supporting arithmetic, logic, carry, and overflow behavior
│
├── project-07-systemverilog-2-bit-saturating-counter/
│   └── SystemVerilog RTL design and verification of a 2-bit saturating counter
│
├── project-08-systemverilog-elevator-control-state-machine/
│   └── 4-floor elevator controller using FSM logic and 7-segment display output
│
├── project-09-basys3-raspberry-pi-spi-interface/
│   └── SPI communication link between a Basys3 FPGA and Raspberry Pi
│
└── README.md
```

---

## Projects

### [Project 00 — Raspberry Pi Setup and Git Workflow](./project-00-raspberry-pi-setup-and-git)

This project establishes the development foundation for the rest of the repository. It focuses on setting up a Raspberry Pi, enabling SSH-based remote access, configuring wireless networking, and using Git/GitHub for version control.

#### Key Work

- Connected to a Raspberry Pi using SSH
- Configured a remote embedded development workflow
- Practiced repository cloning, commits, pushes, and pulls
- Established a repeatable workflow for later hardware projects

#### Skills Demonstrated

- Raspberry Pi setup
- Linux command-line usage
- SSH remote development
- Git and GitHub workflow

---

### [Project 01 — LPS331AP I2C Pressure and Temperature Sensor](./project-01-lps331ap-i2c-pressure-temperature-sensor)

This project implements a Python driver for the LPS331AP pressure and temperature sensor using I2C communication on a Raspberry Pi.

#### Key Work

- Communicated with the sensor using the `smbus` library
- Verified the device using the `WHOAMI` register
- Configured sensor control registers
- Read raw pressure and temperature values from sensor registers
- Converted raw binary data into physical units

#### Skills Demonstrated

- I2C communication
- Register-level sensor configuration
- Embedded Python development
- Raw data conversion
- Hardware-software integration

---

### [Project 02 — ADXL343 SPI Accelerometer](./project-02-adxl343-spi-accelerometer)

This project develops a Python-based SPI driver for the ADXL343 accelerometer. The system reads X, Y, and Z acceleration values from the sensor and converts the raw register data into usable acceleration measurements.

#### Key Work

- Communicated with the accelerometer using the `spidev` library
- Configured SPI mode for device communication
- Verified the sensor using the `DEVID` register
- Enabled measurement mode
- Read and converted X, Y, and Z acceleration data

#### Skills Demonstrated

- SPI communication
- Binary data handling
- Sensor driver development
- Multi-axis data acquisition
- Embedded Python programming

---

### [Project 03 — MQTT Sensor Network Node](./project-03-mqtt-sensor-network-node)

This project combines pressure, temperature, and acceleration sensing into a network-connected MQTT sensor node. The Raspberry Pi publishes live sensor data to a broker at fixed time intervals.

#### Key Work

- Integrated LPS331AP pressure/temperature data
- Integrated ADXL343 accelerometer data
- Published sensor readings using MQTT
- Sent data to structured MQTT topics
- Built a simple remote monitoring pipeline

#### Example MQTT Topics

```text
sensors/<id>/temperature
sensors/<id>/pressure
sensors/<id>/accel/x
sensors/<id>/accel/y
sensors/<id>/accel/z
```

#### Skills Demonstrated

- MQTT publish/subscribe architecture
- Networked embedded systems
- Real-time sensor data streaming
- Sensor integration
- Cyber-physical system communication

---

### [Project 04 — MQTT LED Control with PWM](./project-04-mqtt-led-control)

This project extends the MQTT sensor node by adding remote LED control through GPIO and PWM. The Raspberry Pi subscribes to MQTT control topics and updates LED behavior based on incoming messages.

#### Key Work

- Developed a custom LED driver
- Controlled LED duty cycle using PWM
- Updated LED frequency dynamically
- Subscribed to MQTT control topics
- Combined sensing, publishing, and actuation in one system

#### Example MQTT Control Topics

```text
sensors/<id>/led/duty
sensors/<id>/led/frequency
```

#### Skills Demonstrated

- GPIO control
- PWM signal generation
- MQTT subscriptions
- Remote actuator control
- Embedded systems integration

---

### [Project 05 — SystemVerilog 3-to-8 Demultiplexer](./project-05-systemverilog-3-to-8-demultiplexer)

This project implements a 3-to-8 decoder and uses it as a submodule to build a 3-to-8 demultiplexer in SystemVerilog. The design demonstrates combinational logic, one-hot decoding, module instantiation, enable-controlled output routing, and testbench-based verification.

#### Key Work

- Designed a 3-to-8 decoder using Boolean logic
- Built a 3-to-8 demultiplexer using the decoder as a submodule
- Used internal wires to connect decoder outputs to demultiplexer logic
- Gated demultiplexer outputs using an enable signal
- Verified all decoder and demultiplexer input combinations with testbenches

#### Skills Demonstrated

- SystemVerilog combinational logic
- Boolean expression design
- Decoder implementation
- Demultiplexer implementation
- Module instantiation
- Testbench tasks
- Assertion-based verification
- FPGA-oriented digital design

---

### [Project 06 — SystemVerilog 8-Bit Arithmetic Logic Unit](./project-06-systemverilog-8-bit-arithmetic-logic-unit)

This project implements an 8-bit Arithmetic Logic Unit (ALU) in SystemVerilog. The ALU performs arithmetic and logical operations on two 8-bit operands and produces an 8-bit result, an unsigned carry flag, and a signed overflow flag.

#### Key Work

- Designed an 8-bit ALU using SystemVerilog
- Implemented arithmetic operations including addition and subtraction
- Implemented logical operations including AND, OR, NOT, and XOR
- Added transfer and zero-test operations
- Used a 4-bit select signal to control ALU behavior
- Detected unsigned carry for arithmetic operations
- Detected signed overflow for addition and subtraction
- Verified ALU behavior using a dedicated testbench

#### Supported Operations

| Select `s` | Operation | Result |
|---|---|---|
| `1110` | AND | `r = a & b` |
| `1101` | OR | `r = a | b` |
| `1100` | NOT | `r = ~a` |
| `1011` | XOR | `r = a ^ b` |
| `1010` | Addition | `r = a + b` |
| `1001` | Subtraction | `r = a - b` |
| `1000` | Transfer | `r = a` |
| `0111` | Test | `r = (a == 0)` |

#### Skills Demonstrated

- ALU design
- Arithmetic logic implementation
- Bitwise logic operations
- Carry detection
- Signed overflow detection
- `always_comb` design
- `case` statement operation selection
- Testbench development
- Digital hardware verification

---

### [Project 07 — SystemVerilog 2-Bit Saturating Counter](./project-07-systemverilog-2-bit-saturating-counter)

This project transitions from embedded software into digital hardware design. It implements a 2-bit saturating counter in SystemVerilog and verifies its behavior using a testbench.

The counter increments and decrements based on an input signal but saturates at its limits instead of overflowing or underflowing.

#### Key Behavior

- Counts from `0` to `3`
- Saturates at `3` when incremented past the maximum value
- Saturates at `0` when decremented past the minimum value
- Supports reset, enable, and direction control signals

#### Skills Demonstrated

- SystemVerilog RTL design
- Sequential logic design
- `always_ff` implementation
- Testbench development
- Assertion-based verification
- FPGA-oriented design practices

---

### [Project 08 — SystemVerilog Elevator Control State Machine](./project-08-systemverilog-elevator-control-state-machine)

This project implements a 4-floor elevator simulator using SystemVerilog. The design uses a finite state machine to control elevator movement, door behavior, floor selection, and visual output on the Basys3 FPGA 7-segment displays.

#### Key Work

- Designed a finite state machine for a 4-floor elevator system
- Handled floor request button inputs
- Stored the first requested floor until the elevator reached it
- Ignored additional requests while servicing the current request
- Reset the elevator to floor 1 with the door open
- Created a 7-segment display driver for floor and door visualization
- Used active-low display logic for the Basys3 board
- Verified the elevator controller and display driver using testbenches

#### System Behavior

```text
Floor Request
      │
      ▼
Store Destination
      │
      ▼
Close Door
      │
      ▼
Move Up or Down
      │
      ▼
Arrive at Requested Floor
      │
      ▼
Open Door
```

#### Skills Demonstrated

- Finite state machine design
- Sequential logic implementation
- State-based output control
- Reset handling
- Input request handling
- 7-segment display driving
- Active-low logic design
- SystemVerilog `always_ff` and `always_comb`
- FPGA-oriented control system design
- Simulation-based verification

---

### [Project 09 — Basys3 to Raspberry Pi SPI Interface](./project-09-basys3-raspberry-pi-spi-interface)

This project implements a Serial Peripheral Interface (SPI) communication link between a Basys3 FPGA and a Raspberry Pi. The Raspberry Pi acts as the SPI master, while the Basys3 FPGA acts as the SPI slave.

The design allows the Raspberry Pi to read switch values from the Basys3 and write LED values back to the FPGA using a simple SPI-based register interface.

#### Key Work

- Implemented an SPI slave interface in SystemVerilog
- Captured incoming `MOSI` data on the rising edge of `SCLK`
- Updated outgoing `MISO` data on the falling edge of `SCLK`
- Converted serial SPI data into 8-bit parallel data
- Built a controller interface for reading switches and writing LEDs
- Implemented a register-mapped read/write interface
- Connected Raspberry Pi SPI communication to Basys3 FPGA hardware

#### Register Address Map

| Address | Mapping | Access Type |
|---|---|---|
| `7'h00` | `chip_id` | Read-only |
| `7'h01` | `switches[7:0]` | Read-only |
| `7'h02` | `switches[15:8]` | Read-only |
| `7'h03` | `leds[7:0]` | Read/write |
| `7'h04` | `leds[15:8]` | Read/write |

#### Skills Demonstrated

- SPI slave interface design
- Serial-to-parallel data conversion
- Parallel-to-serial data transmission
- Edge-sensitive signal handling
- FPGA register interface design
- Address decoding
- Read/write transaction handling
- Raspberry Pi to FPGA communication
- Basys3 switch and LED integration
- Hardware/software co-design

---

## System-Level Flow

### Embedded Sensor and MQTT Projects

```text
Physical Sensors / Outputs
        │
        ▼
Raspberry Pi GPIO / I2C / SPI Interfaces
        │
        ▼
Python Sensor Drivers and Control Logic
        │
        ▼
MQTT Publish / Subscribe Communication
        │
        ▼
Remote Monitoring and Remote Device Control
```

### Digital Design and FPGA Projects

```text
SystemVerilog RTL
        │
        ▼
Simulation and Testbench Verification
        │
        ▼
Vivado Synthesis / FPGA Implementation
        │
        ▼
Basys3 Hardware Demonstration
```

### FPGA-to-Raspberry Pi SPI Project

```text
Raspberry Pi SPI Master
        │
        ▼
SPI Signals: SCLK, MOSI, MISO, SS
        │
        ▼
Basys3 SPI Slave Interface
        │
        ▼
Controller Register Interface
        │
        ├── Read Switches
        ├── Write LEDs
        └── Return Chip ID
```

---

## Tools and Technologies

### Languages

- Python
- SystemVerilog

### Hardware

- Raspberry Pi 3B
- LPS331AP pressure/temperature sensor
- ADXL343 accelerometer
- LED circuit
- Basys3 FPGA
- 7-segment displays
- Switches and pushbuttons

### Protocols and Interfaces

- I2C
- SPI
- MQTT
- GPIO
- PWM

### Libraries and Tools

- `smbus`
- `spidev`
- `paho-mqtt`
- Vivado
- Git / GitHub
- Linux command line
- FPGA simulation tools

---

## Skills Demonstrated

- Embedded Python development
- Raspberry Pi hardware interfacing
- Sensor driver design
- I2C and SPI protocol implementation
- Low-level register manipulation
- MQTT-based network communication
- Real-time sensor data publishing
- GPIO and PWM control
- Remote actuator control
- Hardware-software integration
- SystemVerilog RTL design
- Combinational logic design
- Sequential logic design
- Finite state machine design
- ALU design
- SPI slave interface design
- Testbench development
- Assertion-based verification
- FPGA-oriented system design
- Cyber-physical systems architecture

---

## Why This Project Matters

This repository shows the foundation of cyber-physical systems engineering: connecting software to real hardware, reading physical data from sensors, transmitting that data over a network, and controlling outputs remotely.

It also connects embedded systems with digital hardware design. The Raspberry Pi projects demonstrate software-driven interaction with physical sensors and actuators, while the SystemVerilog projects demonstrate hardware-level logic design, state machines, FPGA communication, and digital verification.

Together, these projects demonstrate practical experience with the kinds of systems used in robotics, IoT, automation, embedded platforms, intelligent devices, and FPGA-based hardware systems.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io/)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
