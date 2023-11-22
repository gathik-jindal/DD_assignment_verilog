module stimulus();
    reg [3:0] A, B;
    wire A_eq_B, A_gt_B, A_lt_B;
    magnitude_comparator mag(A,B,A_gt_B,A_lt_B,A_eq_B);
    initial begin
        $dumpfile("hope.vcd");
        $dumpvars(0, stimulus);
        A = 4'b0000;
        B = 4'b0000;
        #255 $finish;
    end
    always
        #1 A[0] = ~A[0];
    always
        #2 A[1] = ~A[1];
    always
        #4 A[2] = ~A[2];
    always
        #8 A[3] = ~A[3];
    always
        #16 B[0] = ~B[0];
    always
        #32 B[1] = ~B[1];
    always
        #64 B[2] = ~B[2];
    always
        #128 B[3] = ~B[3];
    initial
    $monitor("%d B: %b, A: %b, GT: %b, LT: %b, EQ: %b",$time, B, A, A_gt_B, A_lt_B, A_eq_B);
    
endmodule

module magnitude_comparator (
    A, B, A_gt_B, A_lt_B, A_eq_B
);
input [3:0] A;
input [3:0] B;
output A_gt_B, A_lt_B, A_eq_B;

wire notA0, notA1, notA2, notA3;
wire notB0, notB1, notB2, notB3;
wire xnor0, xnor1, xnor2, xnor3;

not (notA0, A[0]);
not (notA1, A[1]);
not (notA2, A[2]);
not (notA3, A[3]);
not (notB0, B[0]);
not (notB1, B[1]);
not (notB2, B[2]);
not (notB3, B[3]);

xnor(xnor3, A[3], B[3]);
xnor(xnor2, A[2], B[2]);
xnor(xnor1, A[1], B[1]);
xnor(xnor0, A[0], B[0]);


wire main1, main2, main3, main4;

and(main1, notB3, A[3]);
and(main2, xnor3, A[2], notB2);
and(main3, xnor3, xnor2, A[1], notB1);
and(main4, xnor3, xnor2, xnor1, A[0], notB0);

or(A_gt_B, main1, main2, main3, main4);


wire main11, main12, main13, main14;

and(main11, notA3, B[3]);
and(main12, xnor3, B[2], notA2);
and(main13, xnor3, xnor2, B[1], notA1);
and(main14, xnor3, xnor2, xnor1, B[0], notA0);

or(A_lt_B, main11, main12, main13, main14);

and(A_eq_B, xnor0, xnor1, xnor2, xnor3);


endmodule