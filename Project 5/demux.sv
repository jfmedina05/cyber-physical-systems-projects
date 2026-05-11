`timescale 1ns / 1ps
module demux(
    input a,b,c,
    input e,
    output d0, d1, d2, d3, d4, d5, d6, d7
);

    wire wire0;
    wire wire1;
    wire wire2;
    wire wire3;
    wire wire4;
    wire wire5;
    wire wire6;
    wire wire7;
   
 
 // decoder decoder (
 // .a(a), .b(b), .c(c),
//  .wire(d0),. wire1(d1),
//  .wire2(d2), .wire3(d3),
//  .wire4(d4), .wire5(d5),
//  .wire6(d6), .wire7(d7));
    
     decoder decoder (
    .a(a), .b(b), .c(c),
    .d0(wire0), .d1(wire1),
    .d2(wire2), .d3(wire3),
    .d4(wire4), .d5(wire5),
    .d6(wire6), .d7(wire7));
        
  assign d0 = wire0 & e;
  assign d1 = wire1 & e;
  assign d2 = wire2 & e;
  assign d3 = wire3 & e;
  assign d4 = wire4 & e;
  assign d5 = wire5 & e;
  assign d6 = wire6 & e;
  assign d7 = wire7 & e;
    
//    assign d0 = d0 & e;
//    assign d1 = d1 & e;
//    assign d2 = d2 & e;
//    assign d3 = d3 & e;
//    assign d4 = d4 & e;
//    assign d5 = d5 & e;
//    assign d6 = d6 & e;
//    assign d7 = d7 & e;
    
endmodule