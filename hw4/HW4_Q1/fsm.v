// Mealy implmentation 
module fsm (out, in, clk, reset);
    output  reg out;
    input       in, clk, reset;

    parameter   STT_START = 3'b111;
    parameter   STT_0     = 3'b000;
    parameter   STT_1     = 3'b001;
    parameter   STT_11    = 3'b010;
    parameter   STT_110   = 3'b011;
    parameter   STT_1100  = 3'b100;
    parameter   STT_11001 = 3'b101;

    reg [2:0] state;
    reg [2:0] next;

    always @(*) begin
        next = STT_START;
        if (in || !in) begin    // To avoid `x` and `z`
            case (state)
                STT_START:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_0;
                STT_0:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_0;
                STT_1:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_0;
                STT_11:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_110;
                STT_110:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_1100;
                STT_1100:
                    if (in)
                        next = STT_11001;
                    else
                        next = STT_0;
                STT_11001:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_0;
            endcase
        end
    end

    always @(posedge clk, posedge reset) begin
        if (reset) 
            state <= STT_START;
        else 
            state <= next;
    end

    always @(*) begin
        if (in && state == STT_1100)
            out = 1;
        else
            out = 0;
    end
endmodule

/*
// Moore implmentation
module fsm (out, in, clk, reset);
    output      out;
    input       in, clk, reset;

    parameter   STT_START = 3'b111;
    parameter   STT_0     = 3'b000;
    parameter   STT_1     = 3'b001;
    parameter   STT_11    = 3'b010;
    parameter   STT_110   = 3'b011;
    parameter   STT_1100  = 3'b100;
    parameter   STT_11001 = 3'b101;

    reg [2:0] state;
    reg [2:0] next;

    always @(*) begin
        next = STT_START;
        if (in || !in) begin        // To avoid `x` and `z`
            case (state)
                STT_START:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_0;
                STT_0:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_0;
                STT_1:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_0;
                STT_11:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_110;
                STT_110:
                    if (in)
                        next = STT_1;
                    else
                        next = STT_1100;
                STT_1100:
                    if (in)
                        next = STT_11001;
                    else
                        next = STT_0;
                STT_11001:
                    if (in)
                        next = STT_11;
                    else
                        next = STT_0;
            endcase
        end
    end

    always @(posedge clk, posedge reset) begin
        if (reset) 
            state <= STT_START;
        else 
            state <= next;
    end

    assign out = (state == STT_11001);
endmodule
*/
