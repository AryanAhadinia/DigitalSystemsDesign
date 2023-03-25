module reduce_sum (
    s,
    a,
    b
);
    parameter A_size = 8;
    parameter B_size = 8;

    output [A_size-1:0] s;
    input [A_size-1:0] a;
    input [B_size-1:0] b;

    wire [A_size-1:0] outs [0:B_size-1];

    increamentor inc_ins_ii (outs[0], a, b[0]);
    defparam inc_ins_ii.N = A_size;

    genvar i;
    generate
        for (i = 1; i < B_size - 1; i = i + 1) begin
            increamentor inc_ins (outs[i], outs[i - 1], b[i]);
            defparam inc_ins.N = A_size;
        end
    endgenerate

    increamentor inc_ins_il (s, outs[B_size - 2], b[B_size - 1]);
    defparam inc_ins_il.N = A_size;
endmodule
