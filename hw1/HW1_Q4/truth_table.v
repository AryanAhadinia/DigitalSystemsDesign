module truth_table (A, B, C, Q);
    output Q;
    input A, B, C;

    wire C_not, and_res;

    nor (C_not, C, C);
    and (and_res, C_not, B);
    nor (Q, A, and_res);
endmodule
