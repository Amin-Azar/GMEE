

module mult16appx (a,b,y); 



input [15:0] a;
input [15:0] b; 

output reg [31:0] y; 

always @ (a or b ) //input or select
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
														y = a << 2;
													
													else
													y = a << 3;
												
												else
												y = a << 4;
											
											else
											y = a << 5;
										
										else
										y = a << 6;
									
									else
									y = a << 7;
								
								else
								y = a << 8;
							
							else
							y = a << 9;
						
						else
						y = a << 10;
					
					else
					y = a << 11;
				
				else
				y = a << 12;
			
			else
			y = a << 13;
		
		else
		y = a << 14;
	
	else
	y = a << 15;

else
y = a << 16;




end
 
endmodule

		
