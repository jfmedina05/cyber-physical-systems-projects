`timescale 1ns / 1ps
module demux_tb;

    logic a, b, c;
    logic e;
    wire d0,d1,d2,d3,d4,d5,d6,d7;

    demux demux0 (
        .a(a),
        .b(b),
        .c(c),
        .e(e),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7)
    );
    task demux_test;
        input aT, bT, cT;
        input eT;
        input d0T, d1T, d2T, d3T, d4T;
        input d5T, d6T, d7T;
        #5
        a = aT; b=bT; c=cT; e=eT;
        #5
        
        assert( ( d0 == d0T ) && ( d1 == d1T ) &&
        ( d2 == d2T ) && ( d3 == d3T ) &&
        ( d4 == d4T ) && ( d5 == d5T ) &&
        ( d6 == d6T ) && ( d7 == d7T ) )
        else $fatal(1,"demux0(%b,%b,%b,%b) failed!", a, b, c, e);
    endtask
    
    initial
    begin

        //your testcode here!
        a=0; b=0; c=0; e=0;
        #10
        //a=0; b=0; c=1; 
        demux_test(0,0,0,0, 0,0,0,0, 0,0,0,0);
        #10
        //a=0; b=1; c=0;
        demux_test(0,0,1,0, 0,0,0,0, 0,0,0,0);
        #10
        //a=0; b=1; c=1;
        demux_test(0,1,0,0, 0,0,0,0, 0,0,0,0);
        #10
        //a=1; b=0; c=0;
        demux_test(0,1,1,0, 0,0,0,0, 0,0,0,0); //4
        #10
        //a=1; b=0; c=1;
        demux_test(1,0,0,0, 0,0,0,0, 0,0,0,0);
        #10
        //a=1; b=1; c=0;
        demux_test(1,0,1,0, 0,0,0,0, 0,0,0,0);
        #10
        //a=1; b=1; c=1;
        demux_test(1,1,0,0, 0,0,0,0, 0,0,0,0);
        #10
        demux_test(1,1,1,0, 0,0,0,0, 0,0,0,0); //8
        
       
        #10
        demux_test(0,0,0,1 ,1,0,0,0, 0,0,0,0);
        #10
        demux_test(0,0,1,1 ,0,1,0,0 ,0,0,0,0);
        #10
        demux_test(0,1,0,1, 0,0,1,0  ,0,0,0,0);
        #10
        demux_test(0,1,1,1, 0,0,0,1, 0,0,0,0);
        #10
        demux_test(1,0,0,1, 0,0,0,0 ,1,0,0,0);
        #10
        demux_test(1,0,1,1, 0,0,0,0 ,0,1,0,0);
        #10
        demux_test(1,1,0,1, 0,0,0,0, 0,0,1,0);
        #10
        demux_test(1,1,1,1, 0,0,0,0, 0,0,0,1);
        

        $display("@@@Passed");
        $finish;

    end
endmodule