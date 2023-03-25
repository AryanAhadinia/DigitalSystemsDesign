module sd_mealy (out, in, clk, reset);
    output  reg out;
    input       in, clk, reset;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] state;
    reg [1:0] next;

    always @(*) begin
        next = S0;
        if (in || !in) begin    // To avoid `x` and `z`
            case (state)
                S0: if (!in)
                        next = S0;
                    else
                        next = S1;
                S1: if (!in)
                        next = S2;
                    else
                        next = S1;
                S2: if (!in)
                        next = S3;
                    else
                        next = S1;
                S3: next = S0;
            endcase
        end
    end

    always @(posedge clk, posedge reset) begin
        if (reset) 
            state <= S0;
        else 
            state <= next;
    end

    always @(*) begin
        if (in && state == S3)
            out = 1;
        else
            out = 0;
    end
endmodule
