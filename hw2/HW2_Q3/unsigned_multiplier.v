module unsigned_multiplier (m, a, b);
    output [7:0] m;
    input [3:0] a;
    input [3:0] b;

    wire [3:0] a1a0_b1b0;
    wire [3:0] a1a0_b3b2;
    wire [3:0] a3a2_b1b0;
    wire [3:0] a3a2_b3b2;

    wire [4:0] adder_result1;
    wire [6:0] adder_result2;

    unsigned_2bit_multiplier u2bm_a1a0_b1b0 (a1a0_b1b0, a[1:0], b[1:0]);
    unsigned_2bit_multiplier u2bm_a1a0_b3b2 (a1a0_b3b2, a[1:0], b[3:2]);
    unsigned_2bit_multiplier u2bm_a3a2_b1b0 (a3a2_b1b0, a[3:2], b[1:0]);
    unsigned_2bit_multiplier u2bm_a3a2_b3b2 (a3a2_b3b2, a[3:2], b[3:2]);
    
    buf buff_1 [1:0] (m[1:0], a1a0_b1b0[1:0]);
    
    adder adder_1 (adder_result1, {1'b0, a1a0_b3b2}, {1'b0, a3a2_b1b0});
    defparam adder_1.N = 5;
    
    adder adder_2 (m[7:2], {1'b0, adder_result1}, {a3a2_b3b2, a1a0_b1b0[3:2]});
    defparam adder_2.N = 6;

endmodule
