# Project 02 — ADXL343 SPI Accelerometer

## Overview
This project develops a Python-based driver for the **ADXL343 accelerometer** using the SPI communication protocol.

---

## Objective
- Interface with the ADXL343 using SPI
- Verify device identity using the DEVID register
- Enable measurement mode
- Read and convert acceleration data from X, Y, and Z axes

---

## Implementation

### SPI Communication
The Raspberry Pi communicates with the accelerometer using the `spidev` library. SPI mode 3 is configured to match device requirements.

### Device Validation
- The DEVID register is read to confirm the device (`0xE5`)

### Data Acquisition
- Each axis is read from two registers (low + high byte)
- Data is combined and converted to a signed value
- A scaling factor is applied to convert readings into units of **g**

---

## Skills Developed
- SPI protocol implementation
- Binary data handling and conversion
- Sensor interfacing and calibration
- Embedded Python programming

---

## Tools & Technologies
- Python
- spidev (SPI)
- Raspberry Pi
- ADXL343 Accelerometer

---

## Notes
This project extends sensor integration capabilities by introducing SPI communication and multi-axis data acquisition.
