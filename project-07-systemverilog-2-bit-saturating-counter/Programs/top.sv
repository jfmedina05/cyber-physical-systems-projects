`timescale 1ns / 1ps

module top (
    input CLK100MHZ, //clk
    input btnC, //reset
    input btnD, //enable
    input [15:0] sw,
    output logic [15:0] LED
);

wire clk = CLK100MHZ;
wire rst = btnC;
wire stable;
logic enable;
wire [1:0] count;

// Debounce our incoming signal
debounce db0 (
    .clk(clk),
    .rst(rst),
    .bouncy(btnD),
    .stable(stable)
);

// Then limit enable high to 1 clock cycle
enum {ST_IDLE, ST_WAIT} state, nextState;

always_ff @(posedge clk) begin
    if (rst)
        state <= ST_IDLE;
    else
        state <= nextState;
end

always_comb begin
    nextState = state;
    enable = 'h0;
    case (state)
    ST_IDLE: begin
        if (stable) begin
            enable = 'h1;
            nextState = ST_WAIT;
        end
    end
    ST_WAIT: if (!stable) nextState = ST_IDLE;
    endcase
end

//finally our saturating counter
saturating_counter sCnt0(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .up_down(sw[0]),
    .count(count)
);

//decoder for the output
always_comb begin
    LED = 16'h0;
    LED[count] = 1'h1;
end

endmodule
