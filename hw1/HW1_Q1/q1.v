module q1;

reg [3:0] a;
reg [3:0] b;
reg [0:3] c;
reg [0:3] d;
reg [5:0] e;

integer i = 32'h4a6c;

initial begin
    a = 4'hA;
    b = 4'hB;
    c = 4'h5;
    d = 4'hF;
    e = i[3+:6];

    $display("%b %b", a&c, b~^d);
    $display("%b %b", {2'b10, b}|e, a&&b);
end 
endmodule
