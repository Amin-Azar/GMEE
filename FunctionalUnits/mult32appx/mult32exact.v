module mult32exact (a,b,y); 

input [31:0] a;
input [31:0] b; 

output [63:0] y; 
 
 
assign y = a*b ;
     
endmodule 
