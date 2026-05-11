`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 04:22:54 PM
// Design Name: 
// Module Name: ElevCtrl_tb
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


module ElevCtrl_tb;

logic clk, rst;
logic [3:0] floorBtn;
logic [1:0] floorSel;
logic door;

ElevCtrl ec(
    .clk,
    .rst,
    .floorBtn,
    .floorSel,
    .door

    );
    
task ElevCtrl_test;
input [1:0]floorSelT;
input doorT;

#1

assert(floorSel == floorSelT)
else $fatal(1, "Bad Floor %b (floor select = %b)", floorSel, floorSelT);
assert(door == doorT)
else $fatal(1, "Bad Floor %b (value = %b)", door, doorT);
endtask

always #5 clk =~clk;

initial begin
    clk = 0;
    rst = 1;
    
$monitor ("clk:%b rst:%b floorBtn:%b floorSel:%b,door:%b", clk, rst, floorBtn, floorSel, door);
    for (int i = 0; i < 8; ++i)
        @(negedge clk);
        
    $display(" Go From Floor 0 to floor 1");
    rst = 0;    
    floorBtn = 4'b0010;
    //ElevCtrl_test ('b00, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b00, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b1);
    
    $display(" Go From Floor 1 to floor 2");
    rst = 0;    
    floorBtn = 4'b0100;
    ElevCtrl_test (2'b01, 'b1);    
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b1);
    
    $display(" Go From Floor 2 to floor 3");
    rst = 0;    
    floorBtn = 4'b1000;
    ElevCtrl_test (2'b10, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b11, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b11, 'b1);
    
    $display(" Go From Floor 3 to floor 2");
    rst = 0;    
    floorBtn = 4'b0100;
    ElevCtrl_test (2'b11, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b11, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b1);
    
    $display(" Go From Floor 2 to floor 1");
    rst = 0;    
    floorBtn = 4'b0010;
    ElevCtrl_test (2'b10, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b10, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b1);
    
    $display(" Go From Floor 1 to floor 0");
    rst = 0;    
    floorBtn = 4'b0001;
    ElevCtrl_test (2'b01, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b00, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b00, 'b1);
    
    $display(" Go From Floor 0 to floor 1");
    rst = 0;    
    floorBtn = 4'b0010;
    ElevCtrl_test (2'b00, 'b1);
    @(negedge clk);
    ElevCtrl_test (2'b00, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b0);
    @(negedge clk);
    ElevCtrl_test (2'b01, 'b1);
    
    $display(" Reset to floor 0");
    rst = 1;
    @(negedge clk);
    ElevCtrl_test (2'b00, 'b1);
    
    $display("@@@Passed\n");
    $finish;

    
    end  
    
endmodule
