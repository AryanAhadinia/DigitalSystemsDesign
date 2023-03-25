module similariy (
    clk,
    reset,
    in1,
    in2,
    count
);
    parameter N = 8;

    input clk, reset;
    input [N-1:0] in1;
    input [N-1:0] in2;
    output reg [N-1:0] count;     // TODO

    reg [N-1:0] diff;
    integer sum;
    integer i;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
        end else begin
            count <= sum;
        end
    end

    always @(*) begin
        diff = in1 ^ in2;
        sum = 0;
        for (i = 0; i < N; i = i + 1) begin
            sum = sum + diff[i];
        end
    end
endmodule
