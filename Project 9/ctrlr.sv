`timescale 1ns/1ps

module ctrlr (
    input  logic        clk,
    input  logic        rst,

    // GPIO
    input  logic [15:0] switches,
    output logic [15:0] leds,

    // SPI command interface
    input  logic        dvalid,
    input  logic [7:0]  din,
    output logic [7:0]  dout
);

    localparam CHIP_ID = 8'h07;

    typedef enum logic [1:0] {IDLE, WAIT_DATA} state_t;
    state_t state, nextState;

    // captured command fields
    logic [2:0] adder, adderNext;   // A2‑A0
    logic       r_w,  r_wNext;      // 1 = READ, 0 = WRITE
    logic [7:0] doutNext;

    // ────────── sequential ────────────────────────────────────────────
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            adder <= 3'd0;
            r_w   <= 1'b0;
            leds  <= 16'h0000;
            dout  <= 8'h00;
        end else begin
            state <= nextState;
            adder <= adderNext;
            r_w   <= r_wNext;
            dout  <= doutNext;

            // commit LED writes on WRITE commands
            if (state == WAIT_DATA && dvalid && !r_w) begin
                unique case (adder)
                    3'd3: leds[7:0]  <= din;
                    3'd4: leds[15:8] <= din;
                    default: ;  // ignore other addresses
                endcase
            end
        end
    end

    // ────────── combinational ─────────────────────────────────────────
    always_comb begin
        // hold previous values unless changed below
        nextState  = state;
        adderNext  = adder;
        r_wNext    = r_w;
        doutNext   = dout;

        unique case (state)
            // ── command byte ────────────────────────────────────────
            IDLE: if (dvalid) begin
                adderNext  = din[2:0];  // A2‑A0
                r_wNext    = din[7];    // W bit
                nextState  = WAIT_DATA; // expect data phase
            end

            // ── data byte phase ────────────────────────────────────
            WAIT_DATA: if (dvalid) begin
                if (r_w) begin  // READ request
                    unique case (adder)
                        3'd0: doutNext = CHIP_ID;
                        3'd1: doutNext = switches[7:0];
                        3'd2: doutNext = switches[15:8];
                        3'd3: doutNext = leds[7:0];
                        3'd4: doutNext = leds[15:8];
                        default: doutNext = 8'h00;
                    endcase
                end
                nextState = IDLE;       // done after one data byte
            end
        endcase
    end

endmodule