module half_adder (
    c,
    s,
    a,
    b
);
    output c, s;
    input  a, b;

    xor (s, a, b);
    and (c, a, b);
endmodule
