module stimulus();
    reg [3:0] A, B;
    wire A_eq_B, A_gt_B, A_lt_B;
    mag_comp mag(A,B,A_gt_B,A_lt_B,A_eq_B);
    initial begin
        $dumpfile("mag_comp.vcd");
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

module and_gate(
    input A,
    input B,
    output Y
);
    assign Y = A & B;
endmodule

module or_gate(
    input A,
    input B,
    output Y
);
    assign Y = A | B;
endmodule

module not_gate(
    input A,
    output Y
);
    assign Y = ~A;
endmodule

module xnor_gate(
    input A,
    input B,
    output Y
);
    assign Y = (A & B) | (~A & ~B);
endmodule

module mag_comp(A, B, A_gt_B, A_lt_B, A_eq_B);
input [3:0] A;
input [3:0] B;
output A_gt_B, A_lt_B, A_eq_B;

wire temp_xnor0, temp_xnor1, temp_xnor2, temp_xnor3;
xnor_gate xnor0(A[0], B[0], temp_xnor0);
xnor_gate xnor1(A[1], B[1], temp_xnor1);
xnor_gate xnor2(A[2], B[2], temp_xnor2);
xnor_gate xnor3(A[3], B[3], temp_xnor3);

wire temp_notA0, temp_notA1, temp_notA2, temp_notA3;
not_gate notA0(A[0], temp_notA0);
not_gate notA1(A[1], temp_notA1);
not_gate notA2(A[2], temp_notA2);
not_gate notA3(A[3], temp_notA3);

wire temp_notB0, temp_notB1, temp_notB2, temp_notB3;
not_gate notB0(B[0], temp_notB0);
not_gate notB1(B[1], temp_notB1);
not_gate notB2(B[2], temp_notB2);
not_gate notB3(B[3], temp_notB3);

wire wire1, wire2, wire3, wire4, wire5, wire6, wire7, wire8;
wire main1, main2, main3, main4;
wire main12, main123;
and_gate and0(A[3], temp_notB3, main1);
and_gate and1(temp_xnor3, A[2], wire1);
and_gate and2(wire1, temp_notB2, main2);
and_gate and3(temp_xnor3, temp_xnor2, wire3);
and_gate and4(wire3, A[1], wire4);
and_gate and5(wire4, temp_notB1, main3);
and_gate and6(temp_xnor3, temp_xnor2, wire6);
and_gate and7(wire6, temp_xnor1, wire7);
and_gate and8(wire7, A[0], wire8);
and_gate and9(wire8, temp_notB0, main4);
or_gate or0(main1, main2, main12);
or_gate or1(main12, main3, main123);
or_gate or2(main123, main4, A_gt_B);

wire temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8;
wire sub1, sub2, sub3, sub4;
wire sub12, sub123;
and_gate and10(B[3], temp_notA3, sub1);
and_gate and11(temp_xnor3, B[2], temp1);
and_gate and12(temp1, temp_notA2, sub2);
and_gate and13(temp_xnor3, temp_xnor2, temp3);
and_gate and14(temp3, B[1], temp4);
and_gate and15(temp4, temp_notA1, sub3);
and_gate and16(temp_xnor3, temp_xnor2, temp6);
and_gate and17(temp6, temp_xnor1, temp7);
and_gate and18(temp7, B[0], temp8);
and_gate and19(temp8, temp_notA0, sub4);
or_gate or10(sub1, sub2, sub12);
or_gate or11(sub12, sub3, sub123);
or_gate or12(sub123, sub4, A_lt_B);

wire elc1, elc2;
and_gate and20(temp_xnor3, temp_xnor2, elc1);
and_gate and21(temp_xnor1, temp_xnor0, elc2);
and_gate and22(elc1, elc2, A_eq_B);

endmodule