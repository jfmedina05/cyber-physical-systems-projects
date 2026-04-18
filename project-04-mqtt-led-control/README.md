# Project 04 — MQTT LED Control with PWM

## Overview
This project extends the MQTT sensor node by adding **remote LED control** using GPIO and PWM.

---

## Objective
- Implement a PWM-based LED driver
- Control LED duty cycle and frequency via MQTT
- Subscribe to control topics
- Publish LED state along with sensor data

---

## Implementation

### LED Driver
A custom `Led_Driver` class was developed to:
- Control PWM duty cycle
- Adjust frequency dynamically
- Interface with GPIO pin 18

### MQTT Subscriptions
- `sensors/<id>/led/duty`
- `sensors/<id>/led/frequency`

Incoming messages dynamically update LED behavior.

### MQTT Publishing
- LED state is published:
