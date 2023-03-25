module counter(reset, gray, clock, out);
    input reset, gray, clock;
    output reg[3:0] out;

    initial begin
        out = 4'b0000;
    end
    
    always @(posedge reset) begin
        out = 4'b0000;
    end

    always @(posedge clock) begin
        if (reset == 1'b0) begin
            if (gray == 1'b0) begin
                out = out + 1;
            end else begin
                out[3] <= (out[2] & ~out[1] & ~out[0]) | (out[3] & out[1]) | (out[3] & out[0]);
                out[2] <= (~out[3] & out[1] & ~out[0]) | (out[2] & ~out[1]) | (out[2] & out[0]);
                out[1] <= (~out[3] & ~out[2] & out[0]) | (out[3] & out[2] & out[0]) | (out[1] & ~out[0]);
                out[0] <= (~out[3] & out[2] & out[1]) | (out[3] & ~out[2] & out[1]) | (out[3] & out[2] & ~out[1]) | (~out[3] & ~out[2] & ~out[1]);
            end
        end
    end
endmodule
