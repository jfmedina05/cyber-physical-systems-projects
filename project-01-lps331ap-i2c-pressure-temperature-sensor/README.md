# Project 01 — LPS331AP I2C Pressure & Temperature Sensor

## Overview
This project implements a Python driver for the **LPS331AP pressure and temperature sensor** using the I2C communication protocol on a Raspberry Pi.

---

## Objective
- Interface with the LPS331AP sensor over I2C
- Validate communication using the WHOAMI register
- Enable the sensor and trigger measurements
- Convert raw register data into meaningful physical units

---

## Implementation

### I2C Communication
The Raspberry Pi communicates with the sensor using the `smbus` library over I2C bus 1. The sensor is identified by reading the WHOAMI register (`0x0F`), which returns a fixed value (`0xBB`).

### Sensor Initialization
- Control Register 1 is configured to enable the sensor
- Control Register 2 is used to trigger sampling

### Data Acquisition
- Pressure is read from registers `0x28–0x2A`
- Temperature is read from registers `0x2B–0x2C`
- Raw values are combined and converted into:
  - Degrees Celsius
  - Inches of Mercury (inHg)

---

## Skills Developed
- I2C protocol implementation
- Low-level register manipulation
- Sensor driver development
- Data conversion from raw binary values

---

## Tools & Technologies
- Python
- smbus (I2C)
- Raspberry Pi
- LPS331AP Sensor

---

## Notes
This project introduces direct hardware interaction and lays the groundwork for integrating multiple sensors into a cyber-physical system.
