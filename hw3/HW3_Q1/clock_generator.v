module clock_generator(output reg clock);
    parameter HALF_T = 1;

    initial begin
        clock = 0;
    end

    always begin
        #HALF_T clock = ~clock;
    end
endmodule
