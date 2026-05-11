`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Indiana University
// Engineer: Jaiden Medina
// 
// Create Date: 04/02/2025 04:39:16 PM
// Design Name: 
// Module Name: ElevCtrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ElevCtrl(
    input       clk, //clock
    input       rst, //reset
    input [3:0] floorBtn,

    output logic [1:0] floorSel,
    output logic       door
    
);

enum{f0_ON, f0_CL, f1_ON, f1_CL, f2_ON, f2_CL, f3_ON, f3_CL} state, nextState;

logic [3:0] destination = 4'b0000;
logic [3:0] next_dest = 4'b0000;

always_ff @(posedge clk) begin
if (rst) begin
    state <= f0_ON;
    destination <= 4'b0000;
    end
else
    state <= nextState;
    destination <= next_dest;
end 

always_comb begin

nextState = state;
next_dest = destination;

case(state)
// Floor 0 open door to floor 0 closed door
    f0_ON: begin
    door = 1'b1;
    floorSel = 2'b00;
    if (floorBtn != 4'b0000 && floorBtn != 4'b0001) begin
        next_dest = floorBtn;
        nextState = f0_CL;
        end 
    end
// Floor 0 Closed door to open Floor 0 door or go to Floor 1
    f0_CL: begin
    door = 1'b0;
    floorSel = 2'b00;
    if (destination == 4'b0001) 
    begin 
        nextState = f0_ON;
        end
    else begin
        nextState = f1_CL;
        end
    end
// Floor 1 open door to floor 1 closed door
    f1_ON: begin
    door = 1'b1;
    floorSel = 2'b01;
    if (floorBtn != 4'b0000 && floorBtn != 4'b0010) begin
        next_dest = floorBtn;
        nextState = f1_CL;
        end 
    end
// Floor 1 Closed door to open Floor 1 door or go to Floor 2
    f1_CL: begin
    door = 1'b0;
    floorSel = 2'b01;
    if (destination == 4'b0010) 
    begin 
        nextState = f1_ON;
        end
    else if (destination == 4'b0001)
        nextState = f0_CL;
    else begin
        nextState = f2_CL;
        end
    end
// Floor 2 open door to floor 2 closed door
    f2_ON: begin
    door = 1'b1;
    floorSel = 2'b10;
    if (floorBtn != 4'b0000 && floorBtn != 4'b0100) 
    begin
        next_dest = floorBtn;
        nextState = f2_CL;
        end
    end
// Floor 2 Closed Door to Floor 3 or Floor 1
    f2_CL: begin
    door = 1'b0;
    floorSel = 2'b10;
    if (destination == 4'b0100)
    begin
        nextState = f2_ON;
    end
    else if (destination == 4'b1000)
        nextState = f3_CL;   
    else begin
        nextState = f1_CL;
        end
    end
// Floor 3 open door to floor 3 closed door
    f3_ON: begin
    door = 1'b1;
    floorSel = 2'b11;
    if (floorBtn != 4'b0000 && floorBtn != 4'b1000)
    begin
        next_dest = floorBtn;
        nextState = f3_CL;
        end
    end
    f3_CL: begin
    door = 1'b0;
    floorSel = 2'b11;
    if (destination == 4'b1000)
    begin
        nextState = f3_ON;
        end
    else begin
        nextState = f2_CL;
        end
    end
    
    default: begin
        nextState = state;
        floorSel = 2'b00;
        end

endcase
end 

endmodule
