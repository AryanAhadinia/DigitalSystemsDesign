module test;
    wire clock;

    reg reset, start;
    reg [1:0] in;
    reg [3:0] key;

    wire ready, valid;
    wire [3:0] out;

    clock_generator clk_instance (clock);
    key_checker kch_instance (clock, reset, start, in, key, ready, valid, out);
    defparam kch_instance.N = 2;
    defparam kch_instance.W = 2;

    initial begin
            in = 2'b10;
        #2  in = 2'b11;
        #2  in = 2'b10;
        #2  in = 2'b11;
        #2  in = 2'b10;
        #2  in = 2'b11;
        #2  in = 2'b10;
        #2  in = 2'b11;
    end

    initial begin
        $monitor($time, "\t ready : %b, valid : %b, out : %b", ready, valid, out);

        key = 4'b1011;
        reset = 1'b0;
        start = 1'b1;
        #4  start = 1'b0;
        
        #2  reset = 1'b1;
        #1  reset = 1'b0;

        key = 4'b1111;
        start = 1'b1;
        #4  start = 1'b0;

        #10 $finish;
    end
endmodule
