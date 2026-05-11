//////////////////////////////////////////////////////////////////////////////////
// Company: Indiana university
// Engineer: Jaiden Medina & Edred Azizz
// 
// Create Date: 03/05/2025 04:53:43 PM
// Design Name: 
// Module Name: alu_tb
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

`timescale 1ns / 1ps
module alu_tb;
    logic [7:0] a1;
    logic [7:0] b1;
    logic [3:0] s1;
    logic [7:0] r1;
    logic c1, v1;
    
    alu alu0(
        .a(a1),
        .b(b1),
        .s(s1),
        .r(r1),
        .c(c1),
        .v(v1)
        );
        
    task alu_test;
        input[7:0] aT;
        input[7:0] bT;
        input[3:0] sT; 
        input[7:0] rT;
        input cT;
        input vT;
        #5
        
        a1 = aT;
        b1 = bT;
        s1 = sT;
        #5
        
        assert ((r1 == rT) && (c1 == cT) && (v1 == vT))
        else $fatal(1,"alu0(%b,%b,%b,%b,%b,%b) failed!", a1, b1, s1, r1, c1, v1);
        endtask
        
     initial begin
        a1 = 0;
        b1 = 0;
        s1 = 0;
        //r1 = 0;
        //c1 = 0;
        //v1 = 0;
        #10
        $monitor("%h%h%h", r1, c1, v1);
            //a                     b           s           r         c     v
            #10
            alu_test(8'b00000001, 8'b00000001, 4'b1110, 8'b00000001, 1'b0, 1'b0); // AND
            #10
            alu_test(8'b00001111, 8'b00001011, 4'b1110, 8'b00001011, 1'b0, 1'b0); // AND
            
            #10
            alu_test(8'b11000110, 8'b00001111, 4'b1101, 8'b11001111, 1'b0, 1'b0); // OR
            #10
            alu_test(8'b00001111, 8'b11110000, 4'b1101, 8'b11111111, 1'b0, 1'b0); // OR
            
            #10
            alu_test(8'b01100111, 8'b00000000, 4'b1100, 8'b10011000, 1'b0, 1'b0); // NOT
            #10
            alu_test(8'b00001101, 8'b00000000, 4'b1100, 8'b11110010, 1'b0, 1'b0); // NOT
            
            #10
            alu_test(8'b11010010, 8'b00001111, 4'b1011, 8'b11011101, 1'b0, 1'b0); // XOR
            #10
            alu_test(8'b00001001, 8'b01000111, 4'b1011, 8'b01001110, 1'b0, 1'b0); // XOR
            
            #10
            alu_test(8'b00000000, 8'b00000000, 4'b1010, 8'b00000000, 1'b0, 1'b0); // ADDITION
            #10
            alu_test(8'b11111111, 8'b00000001, 4'b1010, 8'b00000000, 1'b1, 1'b0); // ADDITION
            
            #10
            alu_test(8'b11110000, 8'b00001111, 4'b1001, 8'b11100001, 1'b0, 1'b0); // SUBTRACTION
            #10
            alu_test(8'b11111111, 8'b11111111, 4'b1001, 8'b00000000, 1'b0, 1'b0); // SUBTRACTION
            
            #10
            alu_test(8'b00000010, 8'b00000000, 4'b1000, 8'b00000010, 1'b0, 1'b0); // TRANSFER
            #10
            alu_test(8'b00001011, 8'b00000000, 4'b1000, 8'b00001011, 1'b0, 1'b0); // TRANSFER
            
            #10
            alu_test(8'b00000000, 8'b00000000, 4'b0111, 8'b00000001, 1'b0, 1'b0); // TEST
            //#10
            alu_test(8'b11111111, 8'bXXXXXXXX, 4'b0111, 8'b00000000, 1'b0, 1'b0);
            
        $display("@@@Passed");
        $finish;
    end
endmodule