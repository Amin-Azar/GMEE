

module HA1(
    output S,C,
  input A,B
    );
 xor(S,A,B);
 and(C,A,B);
 
endmodule


module FA1(
    output S,Cout,
    input A,B,Cin
    );
 wire s1,c1,c2;
 HA HA1(s1,c1,A,B);
 HA HA2(S,c2,s1,Cin);
 or OG1(Cout,c1,c2);

endmodule

//jaye porta faghat fargh mikone :)


module HA(
    
input A,B,
output S,Cout
    );

xor(S,A,B);
and(Cout,A,B);
 
endmodule


module FA(

input A,B,Cin,
output S,Cout
    );

wire s1,c1,c2;
HA HA1(A,B,s1,c1);
HA HA2(s1,Cin,S,c2);
or OG1(Cout,c1,c2);

endmodule
