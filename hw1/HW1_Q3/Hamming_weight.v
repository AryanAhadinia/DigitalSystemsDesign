module Hamming_weight (a, q);
    output q;
    input [2:0]a;

    wire a1, a2, a3;

    and (a1, a[0], a[1]);
    and (a2, a[1], a[2]);
    and (a3, a[2], a[0]);

    or (q, a1, a2, a3);
endmodule
