// The 1-bit full adder can be expressed in a sum of products form.
// sum = a.b.c_in + a'.b.c_in' + a'.b'.c_in + a.b'.c_in'
// c_out = a.b + b.c_in + a.c_in
/*
Assuming a, b, c_in are the inputs and sum and c_out are the outputs, design a logic circuit
to implement
the 1-bit full adder, using only AND, NOT, and OR gates. Write the Verilog description for the
circuit.
You may use up to 4-input Verilog primitive and AND, OR gates. Write the stimulus for the
full adder and
check the functionality for all input combinations.
*/

`timescale 1ns/1ns

module one_bit_adder(
    // initalising all the inputs and outputs
    input a, b, c_in,
    output sum, c_out
);

    wire a1 , b1, c_in1, w1, w2, w3, w4, w5, w6, w7;

    // finding sum
    not (a1, a);
    not (b1, b);
    not (c_in1, c_in);
    and (w1, a, b, c_in);     // a.b.c_in
    and (w2, a1, b, c_in1);   // a'.b.c_in'
    and (w3, a1, b1, c_in);   // a'.b'.c_in
    and (w4, a, b1, c_in1);   // a.b'.c_in'
    or (sum, w1, w2, w3, w4); // adding all above

    // finding c_out
    and (w5, a, b);          // a.b
    and (w6, c_in, b);          // b.c_in
    and (w7, a, c_in);          // a.c_in
    or (c_out, w5, w6, w7);  // adding all above
endmodule;