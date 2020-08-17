module ff_mult16appx(clk,aa,bb,yy1,yy2,yy3);

input clk;
input [15:0] aa;
input [15:0] bb;

output [15:0] yy1,yy2,yy3;
//reg [15:0] yy1;
//reg [15:0] yy2;
reg [15:0] yy3;


reg [15:0] a1;
reg [15:0] b1;
//wire [15:0] y1;
//wire [15:0] y2;
wire [15:0] y3;

always @(posedge clk)
begin

a1 <= aa;
b1 <= bb;
//yy1 <= y1;
//yy2 <= y2;
yy3 <= y3;

end

//mult16appx m16apx (a1,b1,y1);
//mult16appx2 m16apx2 (a1,b1,y2);
mult16exact m16xct (a1,b1,y3);

endmodule


