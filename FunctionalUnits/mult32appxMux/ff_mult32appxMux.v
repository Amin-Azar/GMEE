module ff_mult32appxMux(clk,aa,bb,yy1,yy2,yy3,yy_out);

input clk;
input [31:0] aa;
input [31:0] bb;

output [63:0] yy1,yy2,yy3,yy_out;
//reg [63:0] yy1;
//reg [63:0] yy2;
//reg [15:0] yy3;


reg [31:0] a1;
reg [31:0] b1;
wire [63:0] y1;
wire [63:0] y2;
wire [63:0] y_out;
//wire [15:0] y3;

always @(posedge clk)
begin

a1 <= aa;
b1 <= bb;

yy_out <= y_out;
//yy1 <= y1;
//yy2 <= y2;
//yy3 <= y3;

end

assign y_out = (y1 < y2)? y2 : y1;

signed_Mult32_3_Y81_final_2 m1 (a1,b1,y1);
mult32exact m2 (a1,b1,y2);
//mult16exact m16xct (a1,b1,y3);

endmodule


