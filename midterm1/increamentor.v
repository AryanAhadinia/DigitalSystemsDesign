module increamentor (
    o,
    a,
    i
);
    parameter N = 8;

    output [N-1:0] o;
    input [N-1:0] a;
    input i;

    wire [N:0] c;
    buf (c[0], i);

    genvar g;
    generate 
        for (g = 0; g < N; g = g + 1) begin
            half_adder ha (c[g + 1], o[g], a[g], c[g]);
        end
    endgenerate
endmodule
