module test;
    reg in, reset;
    wire out;

    reg clk;
    initial begin
        clk = 1'b0;
    end
    always begin
        #5 clk = ~clk;
    end

    sd_mealy    ins (out, in, clk, reset);

    initial begin
        $monitor($time, "in: %b, out: %b", in, out);

        #1  reset = 1'b1;
        #1  reset = 1'b0;
        #2  in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10 in = 1'b0;
        #10 in = 1'b0;
        #10 in = 1'b1;
        #10

        $stop;
    end

endmodule
