module lift (
    src_lvl,
    dst_lvl,
    clk,
    reset,
    up,
    down,
    open
);
    input [2:0] src_lvl;
    input [2:0] dst_lvl;
    input clk;
    input reset;
    output reg up;
    output reg down;
    output reg open;

    reg [2:0] current_state;
    reg [2:0] current_lvl;
    reg [2:0] wait_in;

    reg [2:0] next_state;
    reg [2:0] next_level;
    reg [2:0] next_wait_in;

    reg requests [0:4];
    reg [2:0] last_src_requested;
    reg [2:0] last_dst_requested;

    parameter idle_state = 3'b000;
    parameter up_state   = 3'b100;
    parameter down_state = 3'b010;
    parameter open_state = 3'b001;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= idle_state;
            current_lvl   <= 0;
            wait_in       <= 0;
        end else begin
            if (src_lvl != last_src_requested) begin
                requests[src_lvl] <= 1;
                last_src_requested <= src_lvl;
            end

            if (dst_lvl != last_dst_requested && ((current_state == idle_state) || (current_state == open_state) || (current_state == up_state && dst_lvl >= current_lvl) || (current_state == down_state && dst_lvl <= current_lvl))) begin
                requests[dst_lvl] <= 1;
                last_src_requested <= dst_lvl;
            end

            current_state <= next_state;
            current_lvl   <= next_level;
            wait_in       <= next_wait_in;
        end
    end

    always @(*) begin
        up   = current_state[2];
        down = current_state[1];
        open = current_state[0];
    end

    always @(*) begin
        next_state   = current_state;
        next_level   = current_lvl;
        next_wait_in = wait_in;

        case (current_state)
            idle_state: begin
                if (last_src_requested == current_lvl) begin
                    next_state = open_state;
                end else if (last_src_requested > current_lvl) begin
                    next_state = up_state;
                end else if (last_src_requested < current_lvl) begin
                    next_state = down_state;
                end else begin
                    next_state = idle_state;
                end
                next_level   = current_lvl;
                next_wait_in = 0;
            end

            up_state: begin
                if (wait_in < 3) begin
                    next_state   = up_state;
                    next_level   = current_lvl;
                    next_wait_in = wait_in + 1;
                end else begin
                    if (requests[current_lvl + 1] == 1) begin
                        next_state = open_state;
                    end else begin
                        next_state = up_state;
                    end
                    next_level   = current_lvl + 1;
                    next_wait_in = 0;
                end
            end

            down_state: begin
                if (wait_in < 3) begin
                    next_state   = down_state;
                    next_level   = current_lvl;
                    next_wait_in = wait_in + 1;
                end else begin
                    if (requests[current_lvl - 1] == 1) begin
                        next_state = open_state;
                    end else begin
                        next_state = down_state;
                    end
                    next_level   = current_lvl - 1;
                    next_wait_in = 0;
                end
            end

            open_state: begin
                if (wait_in == 0) begin
                    next_state   = open_state;
                    next_level   = current_lvl;
                    next_wait_in = wait_in + 1;
                end else begin
                    next_state   = idle_state;
                    next_level   = current_lvl;
                    next_wait_in = 0;
                end
            end
        endcase
    end
endmodule
