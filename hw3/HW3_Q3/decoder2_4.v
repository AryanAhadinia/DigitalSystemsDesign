/*
module decoder2_4 (in, out0, out1, out2, out3);
    input [1:0] in;
    output reg out0, out1, out2, out3;

    always @(in) begin
        out0 = (in == 2'b00);
        out1 = (in == 2'b01);
        out2 = (in == 2'b10);
        out3 = (in == 2'b11);
    end
endmodule
*/

module decoder2_4 (in, out0, out1, out2, out3);
    input [1:0] in;
    output out0, out1, out2, out3;

    assign out0 = (in == 2'b00);
    assign out1 = (in == 2'b01);
    assign out2 = (in == 2'b10);
    assign out3 = (in == 2'b11);
endmodule
