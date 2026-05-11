# Cyber-Physical Systems Projects

A collection of embedded systems and digital design projects focused on Raspberry Pi hardware interfacing, sensor communication, MQTT-based networking, GPIO/PWM control, and SystemVerilog digital logic design.

This repository demonstrates practical cyber-physical systems development across the full stack: physical sensors, embedded software, communication protocols, networked data publishing, remote device control, and FPGA-oriented digital design.

---

## Overview

Cyber-physical systems connect computation, sensing, communication, and physical-world behavior. This repository documents a series of projects built around that idea using Raspberry Pi, Python, I2C, SPI, MQTT, GPIO/PWM, and SystemVerilog.

The projects begin with Raspberry Pi setup and remote development, then move into low-level sensor driver development, real-time sensor data publishing, remote actuator control, and digital hardware design using SystemVerilog.

This repository was cleaned and reorganized from private coursework into a public portfolio project to better show embedded systems, hardware-software integration, and digital design skills.

---

## Project Goals

- Build reliable embedded systems using Raspberry Pi and external hardware
- Interface with sensors using I2C and SPI communication protocols
- Convert raw sensor register data into usable physical measurements
- Publish live sensor data over MQTT for remote monitoring
- Control physical outputs using GPIO and PWM
- Design and verify basic digital hardware using SystemVerilog
- Practice structured embedded development using Git and GitHub

---

## Technical Areas

| Area | Description |
|---|---|
| Embedded Linux | Raspberry Pi setup, SSH access, command-line development, and Git workflow |
| Sensor Interfacing | Low-level communication with pressure, temperature, and accelerometer sensors |
| I2C Communication | Register-level driver development for the LPS331AP pressure/temperature sensor |
| SPI Communication | Register-level data acquisition from the ADXL343 accelerometer |
| MQTT Networking | Publishing sensor data and subscribing to remote control messages |
| GPIO / PWM Control | LED control using duty cycle and frequency updates |
| Digital Design | SystemVerilog RTL design, testbench development, and FPGA-oriented logic |

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
├── project-07-systemverilog-2-bit-saturating-counter/
│   └── SystemVerilog RTL design and verification of a 2-bit saturating counter
│
└── README.md
```

---

## Projects

### Project 00 — Raspberry Pi Setup and Git Workflow

This project establishes the development foundation for the rest of the repository. It focuses on setting up a Raspberry Pi, enabling SSH-based remote access, configuring wireless networking, and using Git/GitHub for version control.

#### Key Work

- Connected to a Raspberry Pi using SSH
- Configured remote embedded development workflow
- Practiced repository cloning, commits, pushes, and pulls
- Established a repeatable workflow for later hardware projects

#### Skills Demonstrated

- Raspberry Pi setup
- Linux command-line usage
- SSH remote development
- Git and GitHub workflow

---

### Project 01 — LPS331AP I2C Pressure and Temperature Sensor

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

### Project 02 — ADXL343 SPI Accelerometer

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

### Project 03 — MQTT Sensor Network Node

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

### Project 04 — MQTT LED Control with PWM

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

### Project 07 — SystemVerilog 2-Bit Saturating Counter

This project transitions from embedded software into digital hardware design. It implements a 2-bit saturating counter in SystemVerilog and verifies its behavior using a testbench.

The counter increments and decrements based on an input signal but saturates at its limits instead of overflowing or underflowing.

#### Key Behavior

- Counts from 0 to 3
- Saturates at 3 when incremented past the maximum value
- Saturates at 0 when decremented past the minimum value
- Supports reset, enable, and direction control signals

#### Skills Demonstrated

- SystemVerilog RTL design
- Sequential logic design
- `always_ff` implementation
- Testbench development
- Assertion-based verification
- FPGA-oriented design practices

---

## System-Level Flow

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

For the digital design portion:

```text
SystemVerilog RTL
        │
        ▼
Testbench Verification
        │
        ▼
FPGA-Oriented Hardware Design
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
- Testbench development and digital verification
- Cyber-physical systems architecture

---

## Why This Project Matters

This repository shows the foundation of cyber-physical systems engineering: connecting software to real hardware, reading physical data from sensors, transmitting that data over a network, and controlling outputs remotely.

The work also connects embedded systems with digital hardware design, showing both software-driven physical interaction and hardware-level logic design. Together, these projects demonstrate practical experience with the kinds of systems used in robotics, IoT, edge computing, automation, and intelligent embedded platforms.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
