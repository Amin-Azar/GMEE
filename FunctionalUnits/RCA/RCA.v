
module RCA4(
input [3:0] A,B,
input Cin,
output [4:0] S
);
wire c1,c2,c3;
 FA FA1(A[0],B[0],Cin,S[0],c1),
    FA2(A[1],B[1],c1,S[1],c2),
    FA3(A[2],B[2],c2,S[2],c3),
    FA4(A[3],B[3],c3,S[3],S[4]);

endmodule

module RCA8(
    input [7:0] A,B,
    input Cin,
    output [8:0] S

    );
wire c1;

RCA4 F1(A[3:0],B[3:0],1'b0,{c1,S[3:0]});
RCA4 F2(A[7:4],B[7:4],c1,S[8:4]);

endmodule


module RCA32(
    input [31:0] A,B,
    output [32:0] S
    );

//Cin dar nazar nagereftam vase ina kollan
wire c1,c2,c3,c4,c5,c6,c7;

RCA4 F1(A[3:0],B[3:0]  ,1'b0,{c1,S[3:0]});
RCA4 F2(A[7:4],B[7:4]	 ,c1,{c2,S[7:4]});
RCA4 F3(A[11:8],B[11:8]	 ,c2,{c3,S[11:8]}); 
RCA4 F4(A[15:12],B[15:12],c3,{c4,S[15:12]}); 
RCA4 F5(A[19:16],B[19:16],c4,{c5,S[19:16]}); 
RCA4 F6(A[23:20],B[23:20],c5,{c6,S[23:20]}); 
RCA4 F7(A[27:24],B[27:24],c6,{c7,S[27:24]}); 
RCA4 F8(A[31:28],B[31:28],c7,S[32:28]);

endmodule