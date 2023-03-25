module similariy_v2 (
    reset,
    in1,
    in2,
    count
);
    parameter N = 8;

    input reset;
    input [N-1:0] in1;
    input [N-1:0] in2;
    output [N-1:0] count;     // TODO

    wire reset_not;
    wire [N-1:0] diff;
    wire [N-1:0] sum_reduced;

    not (reset_not, reset);

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin
            xor (diff[i], in1[i], in2[i]);
        end
    endgenerate

    reduce_sum rs_ins (count, 0, diff);
    defparam rs_ins.A_size = N;
    defparam rs_ins.B_size = N;

    genvar j;
    generate
        for (j = 0; j < N; j = j + 1) begin
            and (count[j], sum_reduced[j], reset);
        end
    endgenerate
endmodule
