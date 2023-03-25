module DSP(c, a, b);
    input [31:0] a, b;
    output [63:0] c;

    assign c = a * b;
endmodule
