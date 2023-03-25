module test;
    reg c, b, a;
    wire o;

    truth_table ins (a, b, c, o);

    initial begin
        c = 1'b0;    b = 1'b0;   a = 1'b0;

        $monitor($time, "in:%b%b%b -> out:%b", c, b, a, o);

        #1   c = 1'b0;    b = 1'b0;   a = 1'b1;
        #1   c = 1'b0;    b = 1'b1;   a = 1'b0;
        #1   c = 1'b0;    b = 1'b1;   a = 1'b1;
        #1   c = 1'b1;    b = 1'b0;   a = 1'b0;
        #1   c = 1'b1;    b = 1'b0;   a = 1'b1;
        #1   c = 1'b1;    b = 1'b1;   a = 1'b0;
        #1   c = 1'b1;    b = 1'b1;   a = 1'b1;
    end
endmodule
