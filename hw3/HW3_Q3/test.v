module test;
    reg [1:0] in;
    wire out0, out1, out2, out3;
    
    decoder2_4 decoder2_4_instance(in, out0, out1, out2, out3);

    initial begin
        $monitor($time, " %b %b %b %b", out0, out1, out2, out3);

        #1  in = 2'b00;
        #1  in = 2'b01;
        #1  in = 2'b10;
        #1  in = 2'b11;
        #1  $finish;
    end
endmodule
