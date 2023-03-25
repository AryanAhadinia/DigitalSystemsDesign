// module arithmetic: arithmetical part of ALU

module arithmetic (
    opcode,
    matrix1,
    matrix2,
    matrixr
);
    input       [3:0]   opcode;
    input       [255:0] matrix1;
    input       [255:0] matrix2;
    output  reg [255:0] matrixr;

    integer             i, j, k;
    integer             temp;

    always @(*) begin
        case (opcode)
            procesor.MUL: begin      // multiply
                for (i = 0; i < 8; i = i + 1) begin
                    for (j = 0; j < 8; j = j + 1) begin
                        temp = 0;
                        for (k = 0; k < 8; k = k + 1) begin
                            temp = temp + (matrix1[((i * 32) + 28 - (k * 4))+:4] * matrix2[((k * 32) + 28 - (j * 4))+:4]);
                        end
                        matrixr[((i * 32) + 28 - (j * 4))+:4] = temp;
                    end
                end
            end

            procesor.ADD: begin      // add
                for (i = 0; i < 8; i = i + 1) begin
                    for (j = 0; j < 8; j = j + 1) begin
                        matrixr[((i * 32) + (j * 4))+:4] = matrix1[((i * 32) + (j * 4))+:4] + matrix2[((i * 32) + (j * 4))+:4];
                    end
                end
            end

            procesor.SUB: begin      // subtract
                for (i = 0; i < 8; i = i + 1) begin
                    for (j = 0; j < 8; j = j + 1) begin
                        matrixr[((i * 32) + (j * 4))+:4] = matrix1[((i * 32) + (j * 4))+:4] - matrix2[((i * 32) + (j * 4))+:4];
                    end
                end
            end

            procesor.SDC: begin      // down shift column
                matrixr = {matrix1[(255-32):0], matrix1[255-:32]};
            end

            procesor.SRR: begin      // right shift row
                for (i = 0; i < 8; i = i + 1) begin
                    matrixr[(i * 32)+:32] = {matrix1[(i * 32)+:4], matrix1[((i * 32) + 4)+:28]};
                end
            end

            procesor.SUC: begin      // up shift column
                matrixr = {matrix1[31:0], matrix1[255:32]};
            end

            procesor.SLR: begin      // left shift row
                for (i = 0; i < 8; i = i + 1) begin
                    matrixr[(i * 32)+:32] = {matrix1[(i * 32)+:28], matrix1[((i * 32) + 28)+:4]};
                end
            end
        endcase
    end
endmodule
