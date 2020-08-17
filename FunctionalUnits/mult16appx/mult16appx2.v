module mult16appx2 (a,b,y); 
//less faulty version for 33.33%


input [15:0] a;
input [15:0] b; 

output reg [31:0] y; 

wire _3a;

always @ (a or b or _3a) //input or select
begin


if(b < 49152 )

	if(b < 24576 )
	
		if(b < 12288 )
		
			if(b < 6144 )
			
				if(b < 3072 )
				
					if(b < 1536 )
					
						if(b < 768 )
						
							if(b < 384 )
							
								if(b < 192 )
								
									if(b < 96 )
									
										if(b < 48 )
										
											if(b < 24 )
											
												if(b < 12 )
												
													if(b < 6 )
													
														if(b < 3 )
														begin
														
															if(b == 2)
																y = a << 1;
															if(b == 1)
																y = a ;
															else
																y = 0;
															
														end
														
																											
														else
														if (b ==3)
														y = _3a;
														else
														y = a << 2;
													
													else
													if (b ==6)
													y = _3a<<1;
													else
													y = a << 3;
												
												else
												if (b ==12)
												y = _3a<<2;
												else
												y = a << 4;
											
											else
											if (b ==24)
											y = _3a<<3;
											else
											y = a << 5;
										
										else
										if (b ==48)
										y = _3a<<4;
										else
										y = a << 6;
									
									else
									if (b ==96)
									y = _3a<<5;
									else
									y = a << 7;
								
								else
								if (b ==192)
								y = _3a<<6;
								else
								y = a << 8;
							
							else
							if (b ==384)
							y = _3a<<7;
							else
							y = a << 9;
							
						else
						if (b ==768)
						y = _3a<<8;
						else
						y = a << 10;
					
					else
					if (b ==1536)
					y = _3a<<9;
					else
					y = a << 11;
				
				else
				if (b ==3072)
				y = _3a<<10;
				else
				y = a << 12;
			
			else
			if (b ==6144)
			y = _3a<<11;
			else
			y = a << 13;
		
		else
		if (b ==12288)
		y = _3a<<12;
		else
		y = a << 14;
	
	else
	if (b ==24576)
	y = _3a<<13;
	else
	y = a << 15;

else
if (b ==49152)
y = _3a<<14;
else
y = a << 16;




end

assign _3a = a + a << 1;
     
endmodule
