module magnitude_comparator(
    input [3:0] A, B,
    output wire A_gt_B, A_lt_B, A_eq_B
);

    wire [3:0] notB, notA, x;

    not (notB[0], B[0]),
        (notB[1], B[1]),
        (notB[2], B[2]),
        (notB[3], B[3]),
        (notA[0], A[0]),
        (notA[1], A[1]),
        (notA[2], A[2]),
        (notA[3], A[3]);

    xnor (x[0], A[0], B[0]),
         (x[1], A[1], B[1]),
         (x[2], A[2], B[2]),
         (x[3], A[3], B[3]);

    and (t1, A[3], notB[3]),
        (t2, x[3], A[2], notB[2]),
        (t3, x[3], x[2], A[1], notB[1]),
        (t4, x[3], x[2], x[1], A[0], notB[0]),
        (t5, notA[3], B[3]),
        (t6, x[3], notA[2], B[2]),
        (t7, x[3], x[2], notA[1], B[1]),
        (t8, x[3], x[2], x[1], notA[0], B[0]),
        (A_eq_B, x[3], x[2], x[1], x[0]);

    or (A_gt_B, t1, t2, t3, t4),
       (A_lt_B, t5, t6, t7, t8);

endmodule