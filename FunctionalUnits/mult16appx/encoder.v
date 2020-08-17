
 module encoder(
 binary_out , //  4 bit binary Output
 encoder_in  //  16-bit Input
 );
 output [3:0] binary_out  ;

 input [17:0] encoder_in ; 
      
 reg [4:0] binary_out ; // +1 bit bayad bashe
       
 always @ (encoder_in)
 begin
   binary_out = 0;
     case (1) 
		 encoder_in[0] : binary_out = 0;
		 encoder_in[1] : binary_out = 1;

       encoder_in[2] : binary_out = 2; 

       encoder_in[3] : binary_out = 3; 
       encoder_in[4] : binary_out = 4; 
       encoder_in[5] : binary_out = 5;
       encoder_in[6] : binary_out = 6; 
       encoder_in[7] : binary_out = 7; 
       encoder_in[8] : binary_out = 8; 
       encoder_in[9] : binary_out = 9;
       encoder_in[10] : binary_out = 10;
       encoder_in[11] : binary_out = 11; 
       encoder_in[12] : binary_out = 12; 
       encoder_in[13] : binary_out = 13; 
       encoder_in[14] : binary_out = 14; 
       encoder_in[15] : binary_out = 15; 
       encoder_in[16] : binary_out = 16; 
		 encoder_in[17] : binary_out = 17; 
    endcase
   
 end
 
 endmodule