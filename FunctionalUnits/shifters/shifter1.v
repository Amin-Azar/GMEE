module shifter1 (a,b,y); 



input [15:0] a;
input [15:0] b; 

output reg [31:0] y; 


always @ (a or b) //input or select
begin

y= a <<12;


end


     
endmodule
