module q2 (q, a, b, lda, ldb, clk);
    parameter N = 2;

    input [N-1:0] a;
    input [N-1:0] b;
    input lda, ldb, clk;
    output [N-1:0] q;
    wire out_one;
    wire out_two;

    xor (out_one, a[N-1], ldb);
    and (out_two, b[0], lda);

    buf (q[0], out_one);
    buf (q[N-1], out_two);
endmodule
