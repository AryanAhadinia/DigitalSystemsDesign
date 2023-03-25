module procesor (
    input       [31:0]  data,
    input               data_ready,
    input               clk,
    input               reset,
    input       [31:0]  constant,
    input       [3:0]   opcode,
    output  reg [31:0]  out,
    output  reg         out_valid
);
    reg         [255:0] matrix1;
    reg         [255:0] matrix2;
    reg         [4:0]   rows_in;

    wire        [255:0] lgcl_result;
    wire        [255:0] arth_result;
    reg         [4:0]   rows_out;

    parameter NOP = 4'b0000;    // no operation
    parameter MUL = 4'b0001;    // multiply
    parameter ADD = 4'b0010;    // add
    parameter SUB = 4'b0011;    // subtract
    parameter SDC = 4'b1000;    // down shift column
    parameter SRR = 4'b1001;    // right shift row
    parameter SUC = 4'b1010;    // up shift column
    parameter SLR = 4'b1011;    // left shift row
    parameter AWC = 4'b1100;    // logical and with constant
    parameter AND = 4'b1101;    // logical and two matrices
    parameter XWC = 4'b1110;    // logical xor with constant
    parameter LOR = 4'b1111;    // logical or two matrices

    logic       lgcal   (opcode, matrix1, matrix2, constant, lgcl_result);
    arithmetic  arcal   (opcode, matrix1, matrix2, arth_result);

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            rows_in <= 0;
            rows_out <= 0;
            out_valid <= 0;
        end else begin
            if (rows_in < input_rows(opcode)) begin
                out_valid <= 0;
                if (data_ready) begin
                    if (rows_in < 8) begin
                        matrix1[(rows_in * 32)+:32] <= data;
                    end else begin
                        matrix2[((rows_in - 8) * 32)+:32] <= data;
                    end
                    rows_in <= rows_in + 1;
                end
            end else begin
                out_valid <= 1;
                if (rows_out < 8) begin
                    if (&opcode[3:2]) begin
                        out <= lgcl_result[(rows_out * 32)+:32];
                    end else begin
                        out <= arth_result[(rows_out * 32)+:32];
                    end
                    rows_out <= rows_out + 1;
                end
            end
        end
    end

    function [4:0] input_rows;
        input [3:0] opcode;
        begin
            case (opcode)
                NOP: begin
                    input_rows = 0;
                end
                SDC, SRR, SUC, SLR, AWC, XWC: begin
                    input_rows = 8;
                end
                MUL, ADD, SUB, AND, LOR: begin
                    input_rows = 16;
                end
            endcase 
        end
    endfunction
endmodule
