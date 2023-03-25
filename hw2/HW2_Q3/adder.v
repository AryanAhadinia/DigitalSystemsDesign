module adder (r, a, b);
    parameter N = 8;

    output [N-1:0] r;
    input [N-1:0] a;
    input [N-1:0] b;

    wire [N:0] carry;

    buf (carry[0], 1'b0);

    genvar i;
    generate for (i = 0; i < N; i = i + 1) begin: add_loop
        full_adder fa (r[i], carry[i + 1], a[i], b[i], carry[i]);
        end
    endgenerate
endmodule
