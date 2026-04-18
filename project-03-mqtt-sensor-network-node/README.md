# Project 03 — MQTT Sensor Network Node

## Overview
This project integrates multiple sensors into a **network-connected MQTT node** that publishes real-time data to a remote broker.

---

## Objective
- Combine pressure, temperature, and accelerometer data
- Publish sensor data using MQTT
- Transmit data at fixed time intervals
- Enable remote monitoring of a physical system

---

## Implementation

### MQTT Communication
- Implemented using the `paho-mqtt` library
- Connected to broker: `pivot.iuiot.org`
- Data published every 5 seconds

### Published Topics
- `sensors/<id>/temperature`
- `sensors/<id>/pressure`
- `sensors/<id>/accel/x`
- `sensors/<id>/accel/y`
- `sensors/<id>/accel/z`

### Sensor Integration
- LPS331AP → temperature and pressure
- ADXL343 → acceleration (X, Y, Z)

---

## Skills Developed
- MQTT publish/subscribe architecture
- Sensor fusion
- Networked embedded systems
- Real-time data streaming

---

## Tools & Technologies
- Python
- MQTT (paho-mqtt)
- Raspberry Pi
- LPS331AP
- ADXL343

---

## Notes
This project demonstrates a full cyber-physical pipeline from sensing to network transmission.
