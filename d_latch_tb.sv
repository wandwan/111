module d_latch_tb;

    // Inputs
    logic d, e, reset;

    // Outputs
    logic q, q_bar;

    // Instantiate the D latch module
    d_latch dut (
        .d(d),
        .e(e),
        .reset(reset),
        .q(q),
        .q_bar(q_bar)
    );

    // Clock generation
    logic clk;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        d = 0;
        e = 0;
        reset = 0;

        // Apply inputs and observe outputs
        #10 d = 1;
        #10 e = 1;
        #10 reset = 1;
        #10 d = 0;
        #10 e = 0;
        #10 reset = 0;

        // Add more test cases as needed

        // End simulation
        #10 $finish;
    end

endmodule