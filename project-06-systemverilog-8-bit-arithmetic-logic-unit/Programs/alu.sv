`timescale 1ns / 1ps

module alu(
    input        [7:0] a, //operand
    input        [7:0] b, //operand
    input        [3:0] s, //operation Select
    
    output logic [7:0] r, //the Result value
    output logic       c, //for unsigned Carry
    output logic       v //for signed oVerflow
);

logic out;

wire [8:0] a9 = {1'h0, a}; //Nine Bit Value
wire [8:0] b9 = {1'h0, b}; // Nine Bit Value

always_comb begin

    r = 0;
    c = 0;
    v = 0;
    
    case(s)
        
        4'b1110: r = a & b; //And
        4'b1101: r = a | b; // Or
        4'b1100: r = ~a; // Not
        4'b1011: r = a ^ b; //XOR
        4'b1010: //Addition
        begin
            {c,r} = a9+b9;
            v = ~a[7] & ~b[7] & r[7] | a[7] & b[7] & ~r[7];
        end        
        
        4'b1001: //Subtraction
        begin
            {c,r} = a9-b9;
            v = ~a[7] & b[7] & r[7] | a[7] & ~b[7] & ~r[7];
        end
       
        4'b1000: r = a; //Transfer
        4'b0111: r = (a == 0); // Test
            
    endcase
    end

endmodule