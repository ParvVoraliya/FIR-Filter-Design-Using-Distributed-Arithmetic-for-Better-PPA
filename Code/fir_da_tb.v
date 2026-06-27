`timescale 1ns/1ps

module lpf_tb;

    // --------------------------------------------------------
    // Parameters
    // --------------------------------------------------------
    parameter CLK_PERIOD = 10;   // 10 ns clock (100 MHz)
    parameter NUM_SAMPLES = 50;

    // --------------------------------------------------------
    // DUT signals
    // --------------------------------------------------------
    reg                 clk;
    reg                 rst;
    reg  signed [9:0]   data_in;
    wire signed [21:0]  data_out;

    // --------------------------------------------------------
    // Instantiate your LPF
    // --------------------------------------------------------
    fir_da uut (
        .clk (clk),
        .rst (rst),
        .x0  (data_in),
        .y   (data_out)
    );

    // --------------------------------------------------------
    // Clock generation
    // --------------------------------------------------------
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // --------------------------------------------------------
    // Memory Arrays to hold file data
    // --------------------------------------------------------
    reg signed [9:0]  input_samples [0:NUM_SAMPLES-1];
    reg signed [21:0] expected_out  [0:NUM_SAMPLES-1];

    // Read the files at the very beginning of the simulation
    initial begin
        $readmemb("input.mem", input_samples);
        $readmemb("output.mem", expected_out);
    end

    // --------------------------------------------------------
    // Stimulus and Output Checker Combined
    // --------------------------------------------------------
    integer i;
    integer pass_count;
    integer fail_count;

    initial begin
        // Initialize
        rst = 1;
        data_in = 0;
        pass_count = 0;
        fail_count = 0;

        // Hold reset for 3 clock cycles
        repeat(3) @(posedge clk);
        rst = 0;
        @(posedge clk);

        // Process all samples
        for (i = 0; i < NUM_SAMPLES; i = i + 1) begin
            
            // 1. Feed the new sample from the memory array
            data_in = input_samples[i];
            
            // 2. Wait exactly 10 clock cycles for the DA to shift and add
            repeat(9) @(posedge clk);
            
            // 3. On the 10th cycle, the output is ready. Check it against expected memory!
            if (data_out === expected_out[i]) begin
                $display("[PASS] n=%0d  got=%0d  expected=%0d", i, data_out, expected_out[i]);
                pass_count = pass_count + 1;
            end else begin
                $display("[FAIL] n=%0d  got=%0d  expected=%0d", i, data_out, expected_out[i]);
                fail_count = fail_count + 1;
            end
            
            
            @(posedge clk);
        end

        // Summary
        $display("========================================");
        $display(" TEST COMPLETE");
        $display(" PASS : %0d", pass_count);
        $display(" FAIL : %0d", fail_count);
        $display("========================================");
        $finish;
    end

    // --------------------------------------------------------
    // Waveform dump
    // --------------------------------------------------------
    initial begin
        $dumpfile("lpf_tb.vcd");
        $dumpvars(0, lpf_tb);
    end

endmodule