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