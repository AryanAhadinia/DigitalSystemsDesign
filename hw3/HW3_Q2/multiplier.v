module multiplier (clock, start, in1, in2, ready, out);
    parameter N = 128;

    input clock, start;
    input [N-1:0] in1, in2;

    output reg ready;
    output reg [2*N-1:0] out;

    reg [15:0] i, j;

    reg [31:0] op1, op2;
    wire [63:0] res;

    DSP high_speed_mult (res, op1, op2);

    always @(posedge start) begin
        ready = 1'b0;
        out = 1'b0;
        i = 16'b0;
        j = 16'b0;
    end

    always @(posedge clock) begin
        if (start == 1'b1 && ready == 1'b0) begin
            op1 = in1 >> i;
            op2 = in2 >> j;
        end
    end

    always @(negedge clock) begin
        if (start == 1'b1 && ready == 1'b0 && res !== 64'bx) begin
            out = out + (res << (i + j));
            j = j + 32;
            if (i == N) begin
                ready = 1'b1;
            end else if (j == N) begin
                i = i + 32;
                j = 0;
            end 
        end
    end
endmodule
