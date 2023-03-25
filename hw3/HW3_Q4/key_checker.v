module key_checker(clock, reset, start, in, key, ready, valid, out);
    parameter N = 32;
    parameter W = 32;
    parameter M = N * W;

    input clock, reset, start;
    input [W-1:0] in;
    input [M-1:0] key;

    output reg ready, valid;
    output reg [M-1:0] out;

    initial begin
        ready = 1'b0;
        valid = 1'b0;
        out   = 1'b0;
    end

    always @(posedge reset, posedge start) begin
        ready = 1'b0;
        valid = 1'b0;
    end

    always @(posedge clock) begin
        if (start == 1'b1 && reset == 1'b0) begin
            out = (out << W) + in;
        end
    end

    always @(negedge start) begin
        if (reset == 1'b0) begin
           valid = (out == key);
           ready = 1'b1;
        end
    end
endmodule
