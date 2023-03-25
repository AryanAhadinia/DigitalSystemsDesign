// module logic: logical part of ALU

module logic (
    opcode,
    matrix1,
    matrix2,
    constant,
    matrixr
);
    input       [3:0]   opcode;
    input       [255:0] matrix1;
    input       [255:0] matrix2;
    input       [31:0]  constant;
    output  reg [255:0] matrixr;

    integer             i;

    always @(*) begin
        case (opcode)
            procesor.AWC:    begin       // logical and with constant
                for (i = 0; i < 8; i = i + 1) begin
                    matrixr[(i * 32)+:32] = matrixr[(i * 32)+:32] & constant;
                end
            end 

            procesor.AND:    begin       // logical and two matrices
                matrixr = matrix1 & matrix2;
            end

            procesor.XWC:    begin       // logical xor with constant
                for (i = 0; i < 8; i = i + 1) begin
                    matrixr[(i * 32)+:32] = matrixr[(i * 32)+:32] ^ constant;
                end
            end

            procesor.LOR:    begin       // logical or two matrices
                matrixr = matrix1 | matrix2;
            end
        endcase
    end
endmodule
