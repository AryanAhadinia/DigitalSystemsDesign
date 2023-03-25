module top;
    reg C;

    wire #4 A;
    wire #2 B;

    assign #3 A = C;
    assign #5 B = C;

    initial begin
        assign C = 1'b1;
        #4
        assign C = 1'b0;
    end
endmodule