// when the following blocking statements are converted to non blocking statements
// unexpected behaviour is taking place and we cannot really predict the output

// an observation to be noted is that if only the second blocking statement is made
// a blocking statement then only the start and the ending ones are detected
// rest all are ignored

module stimulus();
    reg [7:0] A;
    wire f;
    AdjacentOnes ad(A, f);
    initial begin 
        $dumpfile("test.vcd");
        $dumpvars(0, stimulus);
        A = 8'b00000000;
        #255 $finish;
    end
    always
        #1  A[0] = ~A[0];
    always
        #2  A[1] = ~A[1];
    always
        #4  A[2] = ~A[2];
    always
        #8  A[3] = ~A[3];
    always
        #16  A[4] = ~A[4];
    always
        #32  A[5] = ~A[5];
    always
        #64  A[6] = ~A[6];
    always
        #128  A[7] = ~A[7];
    initial
    $display("\t   A\t\t\tf");
    initial
    $display("----------------------------------------");
    initial
    $monitor("\t%b\t\t%d", A, f);

endmodule


module AdjacentOnes (
    input [7:0] A,  // 8-bit binary vector input
    output reg f     // Output
);

    integer k;

    always @ (A)
    begin
        f = A[1] & A[0];
        for (k = 2; k < 8; k = k + 1)
            f = f | (A[k] & A[k - 1]);
    end

endmodule
