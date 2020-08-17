module signed_Mult32_3_Y81_final_2 (a,b,y); // y = a << b;
input [31:0] a,b;
output [63:0] y;

//reg [31:0] _a,_b;
reg [63:0] out_y;//,_out_y;


always @(a or b)
begin

//_a=0;_b=0;
out_y=0;
//_out_y=0;

if( (~|a) | (~|b) ) out_y = 0;
else
begin

if ( b == 32'b1)
out_y = {32'd0,a};
else // 2 itself and above
out_y = {31'd0,a ,1'd0};


end

end


assign y = out_y;


endmodule

//	if (b[31]) // negative
//	_b = ~b[30:0]+ 32'b1; // 2's complement -1 !!
//	else
//	_b = b;
	
//	if (a[31]) // negative
//	_a = ~a[30:0] + 32'b1; // 2's complement -1 !!
//	else
//	_a = a;


//if ( _b == 32'b1)
//out_y = _a;
//else // 2 itself and above
//out_y = _a << 1;

//_out_y = (a[31] ^ b[31])? ~out_y+32'b1 : out_y;
//_out_y=out_y;
