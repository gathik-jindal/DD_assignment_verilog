// Code your design here
module mux_2to1 (
    input a,
    input b,
    input sel,
    output reg out
);

    always @(*)
    begin
        case(sel)
            1'b0: out = a;
            1'b1: out = b;
            default: out = 1'bx; 
        endcase
    end
endmodule
module or1(
    input a,
    input b,
    output reg out
);

    always @(*) begin
        // Behavioral logic for OR gate
        out = a | b; // OR operation using bitwise OR
    end

endmodule

module question_3(
    input i1,
    input i2,
    input i3,
    input i4,
    input i5,
    input i6,
    input i7,
    input i8,
    output f
);
    wire x1, x2, x3;

    mux_2to1 mux1(
        .a(i4),
        .b(i5),
        .sel(i3),
        .out(x1)
    );

    mux_2to1 mux2(
        .a(i7),
        .b(i8),
        .sel(i6),
        .out(x2)
    );

    // OR gate instantiation
    or1 a1(
        .out(x3),
        .a(i1),
        .b(i2)
    );

    mux_2to1 mux3(
        .a(x1),
        .b(x2),
        .sel(x3),
        .out(f) // Missing comma corrected here
    );
endmodule
module stimulus;
    
    reg i1, i2, i3, i4, i5, i6, i7, i8;
    wire f;

    question_3 uut (
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .i4(i4),
        .i5(i5),
        .i6(i6),
        .i7(i7),
        .i8(i8),
        .f(f)
    );

    initial begin
        i2=0;
        i3=0;
        i5=0;
        i6=0;
        i7=0;
        i4 = 0;
        i1 = 0;
        i8 = 1;
        // Add more initial statements if needed for your test scenario
        // Your testbench actions, stimulus, and checks go here
        // For example, changing input values over time
        $monitor("w1=%b w2=%b w3=%b w4=%b f=%b",i2,i3,i5,i7,f);
        #10 i2=0;i3=0;i6=0;i7=0;i5=0;
        #10 i2=1;i3=1;i6=1;i7=1;i5=1;
        #10 i2=0;i3=0;i6=0;i7=0;i6=1;
    end
endmodule
