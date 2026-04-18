module saturating_counter_tb;

    // Testbench signals
    logic clk;
    logic rst;
    logic enable;
    logic up_down;
    logic [1:0] count;

    // Instantiate the saturating counter
    saturating_counter uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 100MHz clock, 10ns period
    end

    // Stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        enable = 0;
        up_down = 0;

        // Apply reset
        rst = 1;
        #10 rst = 0;

        // Enable counter and test incrementing
        enable = 1;
        up_down = 1; // Up direction
        #50;

        // Test saturating at 3
        up_down = 1; // Try to increment beyond 3
        #50;

        // Test decrementing
        up_down = 0; // Down direction
        #50;

        // Test saturating at 0
        up_down = 0; // Try to decrement beyond 0
        #50;

        // Finish simulation
        $finish;
    end

    // Monitor the count value
    initial begin
        $monitor("Time = %0t, Count = %b, Enable = %b, Up/Down = %b", $time, count, enable, up_down);
    end

endmodule

