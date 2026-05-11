`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 03:53:15 PM
// Design Name: 
// Module Name: SevSegDisplay
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


module SevSegDisplay(
    input [1:0] floorSel,
    input door,
    output logic [6:0] segments,
    output logic [3:0] select
);

always_comb begin
//    segments = 7'b0000000;
//    select = 4'b1111;

//    case(floorSel)
//        2'b00: begin
//            select = 4'b1110;
//            segments = door ? 7'b1100001 : 7'b1100010; 
//        end
//        2'b01: begin
//            select = 4'b1101;
//            segments = door ? 7'b1100001 : 7'b1100010;
//        end
//        2'b10: begin
//            select = 4'b1011;
//            segments = door ? 7'b1100010 : 7'b1100010;
//        end
//        2'b11: begin
//            select = 4'b0111;
//            segments = door ? 7'b1100010 : 7'b1100010;
//        end
//    endcase
//end

    case(floorSel)
        2'h0: begin
        select = 4'b1110;
            if (floorSel == 2'b00) begin
                if(door == 1'h1) begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b0;
                    segments[6] = 7'b1;
                 end
                 else begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b1;
                    segments[6] = 7'b0;
                 end
              end
        end
        2'h1: begin
        select = 4'b1101;
            if (floorSel == 2'b01) begin
                if(door == 1'h1) begin
//                if(door == 1'h1) begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b0;
                    segments[6] = 7'b1;
                 end
                 else begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b1;
                    segments[6] = 7'b0;
                 end
              end
        end
        2'h2: begin
        select = 4'b1011;
            if(floorSel == 2'b10) begin
                if(door == 1'h1) begin
//                if(door == 1'h1) begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b0;
                    segments[6] = 7'b1;
                 end
                 else begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b1;
                    segments[6] = 7'b0;
                 end
              end
        end
        2'h3: begin
        select = 4'b0111;
            if(floorSel == 2'b11) begin
                if(door == 1'h1) begin
//                if(door == 1'h1) begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b0;
                    segments[6] = 7'b1;
                 end
                 else begin
                    segments[0] = 7'b1;
                    segments[1] = 7'b1;
                    segments[2] = 7'b0;
                    segments[3] = 7'b0;
                    segments[4] = 7'b0;
                    segments[5] = 7'b1;
                    segments[6] = 7'b0;
                 end
              end
        end
        
        default: segments = 7'b0000000;
        
     endcase
  end                                              
endmodule
