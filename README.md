# Cyber-Physical Systems Projects

## Overview
This repository contains a collection of Cyber-Physical Systems projects completed using Raspberry Pi, sensor interfacing, MQTT-based communication, GPIO/PWM control, and SystemVerilog digital design.

The work spans embedded hardware-software integration across multiple communication protocols, including I2C, SPI, and network-based messaging. Projects include pressure and temperature sensing with the LPS331AP, acceleration sensing with the ADXL343, MQTT sensor publishing, LED control through MQTT, and FPGA-based implementation of a 2-bit saturating counter.

This repository is a cleaned and reorganized version of coursework originally developed in a private class repository and adapted here for public portfolio presentation.

---

## Topics Covered
- Raspberry Pi setup and remote development
- Git and GitHub workflow for embedded systems projects
- I2C communication with the **LPS331AP** pressure/temperature sensor
- SPI communication with the **ADXL343** accelerometer
- MQTT-based sensor publishing and remote interaction
- GPIO and PWM-based LED control
- SystemVerilog design of a **2-bit saturating counter**
- Basic FPGA top-level integration and testbench development

---

## Project Structure

### Project 00 — Raspberry Pi Setup and Git
Initial Raspberry Pi setup using SSH, repository cloning, and environment preparation for later cyber-physical systems development.

### Project 01 — LPS331AP I2C Pressure/Temperature Sensor
Python-based sensor driver development for the ST LPS331AP pressure and temperature sensor using the I2C interface.

### Project 02 — ADXL343 SPI Accelerometer
SPI-based accelerometer interfacing and data acquisition using the ADXL343, including reading and converting X, Y, and Z axis measurements.

### Project 03 — MQTT Sensor Network Node
Integration of sensor data into an MQTT-connected node that publishes live pressure, temperature, and accelerometer data to a broker.

### Project 04 — MQTT LED Control
Extension of the MQTT sensor node to include GPIO/PWM LED control, allowing remote updates to LED duty cycle and frequency over MQTT.

### Project 07 — SystemVerilog 2-Bit Saturating Counter
Implementation and verification of a 2-bit saturating counter in SystemVerilog, including a testbench and FPGA top-level integration.

---

## Skills Demonstrated
- Embedded Python development
- Raspberry Pi hardware interfacing
- I2C and SPI protocol implementation
- Sensor driver design
- MQTT publish/subscribe systems
- PWM and GPIO control
- Hardware-software co-design
- SystemVerilog RTL design
- Testbench development and digital verification

---

## Tools and Technologies
- Python
- SystemVerilog
- Raspberry Pi
- MQTT
- I2C
- SPI
- GPIO / PWM
- LPS331AP
- ADXL343
- Basys3 FPGA

---

## Author
**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  
[GitHub Profile](https://github.com/jfmedina05)