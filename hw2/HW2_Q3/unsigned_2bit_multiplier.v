module unsigned_2bit_multiplier (p, a, b);
    output [3:0] p;
    input [1:0] a;
    input [1:0] b;

    wire a0b1, a1b0, a1b1, c;

    and (p[0], a[0], b[0]);
    and (a0b1, a[0], b[1]);
    and (a1b0, a[1], b[0]);
    and (a1b1, a[1], b[1]);

    half_adder ha1 (p[1], c, a0b1, a1b0);
    half_adder ha2 (p[2], p[3], c, a1b1);
endmodule
