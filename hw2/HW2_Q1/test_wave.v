module test_wave;
    reg a, b, c, d;
    wire e, g, f;

    or #(2, 3) (e, a, b);
    and #(4, 1) (f, e, c);
    nor #(5, 2) (g, f, d);

    initial begin
        a = 1'b1;
        b = 1'b0;
        c = 1'b0;
        d = 1'b1;
        #2
        a = 1'b0;
        c = 1'b1;
        d = 1'b0;
        #1
        b = 1'b1;
        #3
        b = 1'b0;
        #3
        a = 1'b1;
        #3
        a = 1'b0;
        b = 1'b0;
        #4
        d = 1'b1;
    end
endmodule