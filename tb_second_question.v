`include "second_question.v"

module tb_magnitude_comparator;

    reg [3:0] A, B;

    wire A_eq_B, A_gt_B, A_lt_B;

    magnitude_comparator uut(
        .A(A),
        .B(B),
        .A_eq_B(A_eq_B),
        .A_lt_B(A_lt_B),
        .A_gt_B(A_gt_B)
    );

    initial begin
        $monitor("Time=%0t A=%4b B=%4b A_eq_B=%b A_lt_B=%b A_gt_B=%b", $time, A, B, A_eq_B, A_lt_B, A_gt_B);

        A = 4'b0000; B = 4'b0000;
        #10;

        A = 4'b0000; B = 4'b0000;
        #10;

        A = 4'b0000; B = 4'b0001;
        #10;

        A = 4'b0001; B = 4'b0000;
        #10;

        A = 4'b0000; B = 4'b0010;
        #10;

        A = 4'b0010; B = 4'b0000;
        #10;

        A = 4'b0010; B = 4'b0011;
        #10;

        A = 4'b0011; B = 4'b0010;
        #10;

        A = 4'b0000; B = 4'b0100;
        #10;

        A = 4'b0000; B = 4'b0110;
        #10;

        A = 4'b0000; B = 4'b0111;
        #10;

        $finish;
    end

endmodule