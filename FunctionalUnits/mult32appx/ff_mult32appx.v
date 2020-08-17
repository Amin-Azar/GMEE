module ff_mult32appx(clk,aa,bb,yy1,yy2,yy3);

input clk;
input [31:0] aa;
input [31:0] bb;

output [63:0] yy1,yy2,yy3;
reg [63:0] yy1;
reg [63:0] yy2;
//reg [15:0] yy3;


reg [31:0] a1;
reg [31:0] b1;
wire [63:0] y1;
wire [63:0] y2;
//wire [15:0] y3;

always @(posedge clk)
begin

a1 <= aa;
b1 <= bb;
yy1 <= y1;
yy2 <= y2;
//yy3 <= y3;

end

signed_Mult32_3_Y21_final_4 m1 (a1,b1,y1);
mult32exact m2 (a1,b1,y2);
//mult16exact m16xct (a1,b1,y3);

endmodule


