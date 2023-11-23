`include "first_question.v"

module tb_one_bit_adder;

    // Inputs
    reg a, b, c_in;

    // Outputs
    wire sum, c_out;

    // Initiating the one-bit adder module
    one_bit_adder uut ( // uut stands for unit under test
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
    );

    initial begin
        $monitor("Time=%0t a=%b b=%b c_in=%b sum=%b c_out=%b", $time, a, b, c_in, sum, c_out);
        $dumpfile("quesiton1.vcd");
        $dumpvars();

        a = 0; b = 0; c_in = 0;
        #10;

        a = 1; b = 0; c_in = 1;
        #10;

        a = 1; b = 1; c_in = 0;
        #10;

        a = 0; b = 1; c_in = 1;
        #10;

        a = 1; b = 1; c_in = 1;
        #10;

        a = 1; b = 0; c_in = 0;
        #10;

        a = 0; b = 1; c_in = 0;
        #10;

        a = 0; b = 0; c_in = 1;
        #10;

        $finish;
    end

endmodule