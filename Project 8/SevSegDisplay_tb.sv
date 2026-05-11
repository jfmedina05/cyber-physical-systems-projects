`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 04:20:56 PM
// Design Name: 
// Module Name: SevSegDisplay_tb
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


module SevSegDisplay_tb;

logic [1:0] floorSel;
logic door;
logic [6:0] segments;
logic [3:0] select;

SevSegDisplay ec(
    .floorSel,
    .door,
    .segments,
    .select
    
    );
    
    task test_logic;
    input [6:0] segmentsT;
    input [3:0] selectT;
        #1
        assert ( segments == segmentsT) else $fatal(1, "segments = %b and segments should be %b", segments, segmentsT);
        assert ( select == selectT) else $fatal(1, "select = %b and select should be %b", select, selectT);
    endtask
    
    initial begin
    
    $monitor ("floorSel:%b door:%b segments:%b select:%b", floorSel, door, segments, select);
    
    $display("F1O");
    floorSel = 2'b00;
    door = 'b1;
    test_logic (7'b1000011, 4'b1110);
    $display("F1C");
    floorSel = 2'b00;
    door = 'b0;
    test_logic (7'b0100011, 4'b1110);
    $display("F2O");
    floorSel = 2'b01;
    door = 'b1;
    test_logic (7'b1000011, 4'b1101);
    $display("F2C");
    floorSel = 2'b01;
    door = 'b0;
    test_logic (7'b0100011, 4'b1101);
    $display("F3O");
    floorSel = 2'b10;
    door = 'b1;
    test_logic (7'b1000011, 4'b1011);
    $display("F3C");
    floorSel = 2'b10;
    door = 'b0;
    test_logic (7'b0100011, 4'b1011);
    $display("F4O");
    floorSel = 2'b11;
    door = 'b1;
    test_logic (7'b1000011, 4'b0111);
    $display("F4C");
    floorSel = 2'b11;
    door = 'b0;
    test_logic (7'b0100011, 4'b0111);
    
    $display("@@@Passed\n");
    $finish;

    end
endmodule