module voter(in1, in2, in3, out, error);
    input [1:0] in1, in2, in3;
    output [1:0] out;
    output error;

    wire [1:0] in_bits [0:3];
    wire [1:0] inequal [0:2];
    wire e [0:2];
    wire ne [0:2];
    wire sel [0:3];

    buf buff_1 [1:0] (in_bits[0], in1);
    buf buff_2 [1:0] (in_bits[1], in2);
    buf buff_3 [1:0] (in_bits[2], in3);
    buf buff_4 [1:0] (in_bits[3], 2'bxx);

    genvar i;
    generate for (i = 0; i < 3; i = i + 1) begin: xor_loop
        xor ieq [1:0] (inequal[i], in_bits[i], in_bits[(i + 1) % 3]);
        end
    endgenerate

    genvar j;
    generate for (j = 0; j < 3; j = j + 1) begin: error_loop
        or (e[j], inequal[j][0], inequal[j][1]);
        not (ne[j], e[j]);
        end
    endgenerate

    nor (error, ne[0], ne[1], ne[2]);

    buf (sel[0], ne[0]);
    and (sel[1], ne[1], e[0]);
    and (sel[2], ne[2], e[1], e[0]);
    and (sel[3], e[2],  e[1], e[0]);

    genvar k;
    generate for (k = 0; k < 4; k = k + 1) begin: out_loop
        bufif1 tribuff [1:0] (out, in_bits[k], sel[k]);
        end
    endgenerate
endmodule
