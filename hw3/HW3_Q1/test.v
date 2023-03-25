module test;
    wire clock;

    reg reset, gray;
    wire [3:0] out;

    clock_generator clk_gen (clock);
    counter counter_instance (reset, gray, clock, out);

    initial begin
        $monitor($time, "\t%b", out);

        reset = 1'b0;
        gray = 1'b0;
    end

    initial begin
        #32
        gray = 1'b1;
    end

    initial begin
        #68
        reset = 1'b1;
        #6
        reset = 1'b0;
        gray = 1'b0;
    end

    initial begin
        #100 $finish;
    end
endmodule
