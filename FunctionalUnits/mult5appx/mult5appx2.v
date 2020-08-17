module mult5appx2 (a,b,y); 
//less faulty version for 33.33%
input [4:0] a;
input [4:0] b; 

output reg [4:0] y; 

wire _3a;

always @ (a or b) //input or select


case (b) 
0 : y = 0; 
1 : y = a; 

2 : y = a << 1; 
3 : y = _3a ;
4,5 : y = a << 2;
6 : y = _3a << 1;
7,8,8,10,11 : y = a << 3;
12 : y = _3a << 2;
13,14,15,16,17,18,19,20,21,22,23 : y = a << 4;
24 : y = _3a << 3;
25,26,27,28,29,30,31 : y = a << 5;

default : y = 0; //overflow or something!

endcase 

assign _3a = a + a << 1;
     
endmodule
