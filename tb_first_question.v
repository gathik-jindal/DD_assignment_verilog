`include "first_question.v"
`timescale 1ns/1ns

module tb_one_bit_adder;

    // Inputs
    reg a, b, c_in;

    // Outputs
    wire sum, c_out;

    // Initiating the one-bit adder module
    one_bit_adder uut ( // uut stands for unit under test
        .a(a),          // Connects the external signal a to the internal signal a of the module. (since they're inputs)
        .b(b),
        .c_in(c_in),
        .sum(sum),      // Connects the internal signal sum of the instantiated module to the external signal sum. (since they're outputs)
        .c_out(c_out)
    );

    // input / output generation
    initial begin
        $monitor("Time=%0t a=%b b=%b c_in=%b sum=%b c_out=%b", $time, a, b, c_in, sum, c_out);

        // Test case 1: a=0, b=0, c_in=0
        a = 0; b = 0; c_in = 0;
        #10;

        // Test case 2: a=1, b=0, c_in=1
        a = 1; b = 0; c_in = 1;
        #10;

        // Test case 3: a=1, b=1, c_in=0
        a = 1; b = 1; c_in = 0;
        #10;

        // Test case 4: a=0, b=1, c_in=1
        a = 0; b = 1; c_in = 1;
        #10;

        // Test case 5: a=1, b=1, c_in=1
        a = 1; b = 1; c_in = 1;
        #10;

        // Test case 6: a=1, b=0, c_in=0
        a = 1; b = 0; c_in = 0;
        #10;

        // Test case 7: a=0, b=1, c_in=0
        a = 0; b = 1; c_in = 0;
        #10;

        // Test case 8: a=0, b=0, c_in=1
        a = 0; b = 0; c_in = 1;
        #10;

        $finish;
    end

endmodule