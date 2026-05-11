# Project 08 — SystemVerilog Elevator Control State Machine

This project implements a 4-floor elevator simulator using SystemVerilog. The design uses a finite state machine to control elevator movement, door behavior, floor selection, and visual output on the Basys3 FPGA 7-segment displays.

The project demonstrates sequential logic, finite state machine design, reset behavior, input handling, active-low display control, and testbench-based verification.

---

## Overview

The elevator system simulates a freight elevator moving between four floors. A user calls the elevator by pressing a floor button. The elevator remembers the requested floor, closes its door, moves toward the selected floor, and opens the door once it arrives.

The system is split into two main modules:

1. `ElevCtrl.sv` — controls the elevator state machine
2. `SevSegDisplay.sv` — maps the current elevator state to the 7-segment display output

The controller determines the current floor and door position, while the display driver visually represents the elevator on one of four 7-segment displays.

---

## Project Goals

- Design a finite state machine for a 4-floor elevator
- Track the current floor and requested destination floor
- Handle floor button inputs
- Remember the first requested floor until the elevator reaches it
- Ignore additional button presses while servicing a request
- Reset the elevator to floor 1 with the door open
- Display the elevator location using the Basys3 7-segment displays
- Represent open and closed door states visually
- Verify both the controller and display driver using testbenches

---

## System Behavior

The elevator starts on floor 1 with the door open after reset.

When a floor button is pressed:

1. The elevator stores the requested floor.
2. The door closes.
3. The elevator moves one floor at a time toward the target floor.
4. Once the elevator reaches the requested floor, the door opens.
5. The elevator waits for the next floor request.

---

## Design Architecture

```text
Floor Buttons
 btnU btnL btnR btnD
        │
        ▼
Elevator Controller FSM
        │
        ├── floorSel[1:0]
        │
        └── door
        │
        ▼
7-Segment Display Driver
        │
        ├── segments[6:0]
        └── select[3:0]
        │
        ▼
Basys3 7-Segment Displays
```

---

## Module Breakdown

### `ElevCtrl.sv`

The `ElevCtrl` module controls the elevator movement and door state.

```systemverilog
module ElevCtrl(
    input       clk,
    input       rst,
    input [3:0] floorBtn,

    output logic [1:0] floorSel,
    output logic       door
);
```

### Signal Description

| Signal | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1 bit | Clock signal for state transitions |
| `rst` | Input | 1 bit | Reset signal |
| `floorBtn` | Input | 4 bits | Floor request buttons |
| `floorSel` | Output | 2 bits | Current floor selection |
| `door` | Output | 1 bit | Elevator door state |

---

## Floor Encoding

| `floorSel` | Floor |
|---|---|
| `2'b00` | Floor 1 |
| `2'b01` | Floor 2 |
| `2'b10` | Floor 3 |
| `2'b11` | Floor 4 |

---

## Door Encoding

| `door` | Meaning |
|---|---|
| `0` | Door closed |
| `1` | Door open |

---

## Elevator State Machine

The elevator controller is based on a finite state machine.

At a high level, the FSM handles:

```text
Idle with Door Open
        │
        ▼
Store Requested Floor
        │
        ▼
Close Door
        │
        ▼
Move Up or Down
        │
        ▼
Arrive at Target Floor
        │
        ▼
Open Door
```

The controller must keep the elevator request active until the selected floor is reached. This prevents the elevator from forgetting the requested floor while it is moving.

---

## Example Elevator Sequence

Example: elevator starts on floor 3 with the door open and is called to floor 1.

```text
Floor 3, door open
        │
        ▼
Floor 3, door closed
        │
        ▼
Floor 2, door closed
        │
        ▼
Floor 1, door closed
        │
        ▼
Floor 1, door open
```

This sequence shows the elevator closing its door before moving and opening the door only after reaching the requested floor.

---

## 7-Segment Display Driver

### `SevSegDisplay.sv`

The `SevSegDisplay` module maps the elevator floor and door state to the Basys3 7-segment display.

```systemverilog
module SevSegDisplay(
    input [1:0] floorSel,
    input       door,

    output logic [6:0] segments,
    output logic [3:0] select
);
```

### Signal Description

| Signal | Direction | Width | Description |
|---|---|---|---|
| `floorSel` | Input | 2 bits | Current elevator floor |
| `door` | Input | 1 bit | Door open/closed state |
| `segments` | Output | 7 bits | Segment control signals |
| `select` | Output | 4 bits | Display selection signals |

---

## Display Behavior

The Basys3 board has four 7-segment displays. Each display represents one floor of the elevator system.

```text
select[0] → Floor 1
select[1] → Floor 2
select[2] → Floor 3
select[3] → Floor 4
```

Only the display matching the current elevator floor should be active.

The display uses different segment patterns to show whether the elevator door is open or closed.

---

## Active-Low Logic

The Basys3 7-segment display uses active-low logic.

This means:

```text
0 → segment on
1 → segment off
```

Because of this, the display driver must output `0` for any segment that should be illuminated.

This is important because the logic is the opposite of normal active-high LED behavior.

---

## Open and Closed Door Representation

The elevator is represented using specific 7-segment patterns.

### Door Open

The open door state uses segments:

```text
C, D, E, F
```

### Door Closed

The closed door state uses segments:

```text
C, D, E, G
```

This creates a simple visual representation of the elevator car and door position.

---

## Verification

This project includes two testbenches:

- `ElevCtrl_tb.sv`
- `SevSegDisplay_tb.sv`

---

## Elevator Controller Testbench

The `ElevCtrl_tb.sv` testbench verifies the elevator controller state machine.

### Testbench Goals

- Confirm reset sends the elevator to floor 1
- Confirm the door is open after reset
- Test movement from one floor to another
- Verify that the elevator moves up correctly
- Verify that the elevator moves down correctly
- Confirm the door closes before movement
- Confirm the door opens after arrival
- Verify that button requests are handled correctly

### Example Controller Tests

| Test | Expected Behavior |
|---|---|
| Reset | Elevator goes to floor 1 with door open |
| Floor 1 to Floor 2 | Door closes, elevator moves up, door opens |
| Floor 2 to Floor 3 | Elevator moves up one floor |
| Floor 4 to Floor 1 | Elevator moves down until reaching floor 1 |
| Request while moving | Additional requests are ignored until current request is complete |

---

## 7-Segment Display Testbench

The `SevSegDisplay_tb.sv` testbench verifies the display output logic.

### Testbench Goals

- Confirm each floor activates the correct display
- Confirm open-door segment pattern is correct
- Confirm closed-door segment pattern is correct
- Verify active-low display behavior
- Test all floor and door combinations

### Display Test Cases

| Floor | Door State | Expected Display Behavior |
|---|---|---|
| Floor 1 | Open | Floor 1 display active, open-door pattern shown |
| Floor 1 | Closed | Floor 1 display active, closed-door pattern shown |
| Floor 2 | Open | Floor 2 display active, open-door pattern shown |
| Floor 2 | Closed | Floor 2 display active, closed-door pattern shown |
| Floor 3 | Open | Floor 3 display active, open-door pattern shown |
| Floor 3 | Closed | Floor 3 display active, closed-door pattern shown |
| Floor 4 | Open | Floor 4 display active, open-door pattern shown |
| Floor 4 | Closed | Floor 4 display active, closed-door pattern shown |

---

## Repository Files

```text
project-08-systemverilog-elevator-control-state-machine/
│
├── ElevCtrl.sv
│   └── Elevator finite state machine controller
│
├── ElevCtrl_tb.sv
│   └── Testbench for elevator movement, reset, floor requests, and door behavior
│
├── SevSegDisplay.sv
│   └── 7-segment display driver for floor and door visualization
│
└── SevSegDisplay_tb.sv
    └── Testbench for active-low 7-segment display output patterns
```

---

## Tools and Technologies

- SystemVerilog
- Vivado
- Basys3 FPGA
- 7-segment displays
- Finite state machines
- Sequential logic
- Combinational display logic
- Testbench simulation
- Assertion-based verification

---

## Skills Demonstrated

- Finite state machine design
- Sequential logic implementation
- SystemVerilog `always_ff` usage
- SystemVerilog `always_comb` usage
- Reset handling
- Input request handling
- State-based output control
- 7-segment display driving
- Active-low logic design
- FPGA-oriented hardware design
- Testbench development
- Simulation-based verification

---

## Key Takeaways

This project demonstrates how finite state machines can be used to model real-world control systems. The elevator controller must respond to input requests, remember a destination, update its state over time, and generate outputs for both movement and door behavior.

The project also reinforces the importance of separating control logic from display logic. The elevator controller handles the state of the system, while the 7-segment display driver converts that state into a visual hardware output.

Together, these modules show how digital logic can be used to design structured, testable, and hardware-ready control systems.

---

## Author

**Jaiden Medina**  
Computer Engineering @ Indiana University  
Accelerated M.S. in Intelligent Systems Engineering  

- GitHub: [jfmedina05](https://github.com/jfmedina05)
- Portfolio: [jfmedina05.github.io](https://jfmedina05.github.io)
- LinkedIn: [jaiden-medina](https://www.linkedin.com/in/jaiden-medina)
