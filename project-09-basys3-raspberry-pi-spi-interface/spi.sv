`timescale 1ns/1ps

module spi(
    input               clk, 
    input               rst, 
    
    //all signals to & from spi interface
    input               sck, //Serial Clock
    input               ss,  //Serial Reset Not
    input               mosi, //Serial input from Pi
    output              miso, //Serial output to Pi
   
    input        [7:0]  din,
    output logic [7:0]  dout,
    output logic        busy 
);
    
    logic rst_0;
    logic last; 
    
    logic [7:0] s_in; 
    logic [7:0] s_out;
    logic [2:0] bitCount;
    
    //combining external reset & slave select
    assign rst_0 = rst | ss;

    assign miso = ( rst_0 ? 'hz : s_out[7] );


    //all sequential logic on rising clock edge
    always_ff @(posedge clk) begin
        if (rst_0) begin
            last <= 'h0;
            bitCount <= 0;
            s_in <= 8'h00;
            s_out <= din;
            dout <= 8'h00;
            busy <= 1'b0;
        end else begin
            last <= sck;
            if(!busy && (bitCount == 0))begin
                s_out <= din;
            end
            if (~last && sck) begin
                dout <= {dout[6:0], mosi};
                busy <= 1'b1;
            end
            if (last && ~sck) begin
                s_out <= {s_out[6:0], 1'b0};
                bitCount <= bitCount + 1;
                if (bitCount == 3'd7) begin
                    //dout <= {s_in[6:0], mosi};
                    s_out <= din;
                    busy <= 1'b0;
                end
            end
        end
    end
    //emptying our combinational block
    always_comb begin
        ;
    end
endmodule