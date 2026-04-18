module saturating_counter (
    input logic clk,    // Clock input
    input logic rst,    // Reset input
    input logic enable, // Enable input
    input logic up_down, // Direction: 1 for up, 0 for down
    output logic [1:0] count // 2-bit count output
);

    // Saturating counter value
    logic [1:0] counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 2'b00; // Reset the counter to 0
        end else if (enable) begin
            if (up_down) begin
                if (counter < 2'b11)
                    counter <= counter + 1; // Increment the counter
            end else begin
                if (counter > 2'b00)
                    counter <= counter - 1; // Decrement the counter
            end
        end
    end

    assign count = counter; // Output the current counter value

endmodule

