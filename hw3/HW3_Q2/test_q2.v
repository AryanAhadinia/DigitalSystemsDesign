module test_q2;
    wire clock;

    reg start;
    reg [127:0] in1, in2;

    wire ready;
    wire [255:0] out;

    integer i;

    reg [255:0] expected;

    clock_generator clk_ins (clock);
    multiplier mult_ins (clock, start, in1, in2, ready, out);

    initial begin
        in1 = 128'b0;
        in2 = 128'b0;
        for (i = 0; i < 4; i = i + 1) begin
            in1 = in1 + ($random << (32 * i));
            in2 = in2 + ($random << (32 * i));
        end
        $display("%H", in1);
        $display("%H", in2);
        start = 1'b1;
    end

    always @(posedge ready) begin
        expected = in1 * in2;
        $display("ex:\t%H%H", expected[255:128], expected[127:0]);
        $display("ac:\t%H%H", out[255:128], out[127:0]);
    end

    initial begin
        #200 $finish;
    end
endmodule
