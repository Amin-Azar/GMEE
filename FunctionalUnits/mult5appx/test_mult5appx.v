module test_mult5appx(clk,aa,bb,yy1,yy2);

input clk;
input [4:0] aa;
input [4:0] bb;

output [4:0] yy1,yy2;
//reg [4:0] yy1,yy2,yy3;
reg [4:0] yy2;


reg [4:0] a1;
reg [4:0] b1;
//wire [4:0] y1;
wire [4:0] y2;
//wire [4:0] y3;

always @(posedge clk)
begin

a1 <= aa;
b1 <= bb;
//yy1 <= y1;
yy2 <= y2;
//yy3 <= y3;

end

//mult5appx m5apx (a1,b1,y1);
mult5appx2 m5apx2 (a1,b1,y2);
//mult5exact m5xct (a1,b1,y3);

endmodule


