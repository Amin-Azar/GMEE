
module ETAIIM32(A,B,Y); //3 taye akhar propagate mishan

parameter A_SIGNED = 0;
parameter B_SIGNED = 0;
parameter A_WIDTH = 0;
parameter B_WIDTH = 0;
parameter Y_WIDTH = 0;
    
    //inputs and outputs
input [31:0] A;
input [31:0] B;
output [31:0] Y;

wire [6:0] c,c_dummy;
wire [32:0] S;

	CGEN4 u7 (A[27:24],B[27:24], c[5],c[6]);//propagate
	CGEN4 u6 (A[23:20],B[23:20], c[4],c[5]);//propagate
	CGEN4 u5 (A[19:16],B[19:16],1'b0,c[4]);//propagate
	CGEN4 u4 (A[15:12],B[15:12],1'b0,c[3]);//door rikhte mishe carrysh
	CGEN4 u3 (A[11:8],B[11:8],1'b0,c[2]);
	CGEN4 u2 (A[7:4],B[7:4],1'b0,c[1]);
        CGEN4 u1 (A[3:0],B[3:0],1'b0,c[0]);

	RCA4 a8 (A[31:28],B[31:28],c[6],S[32:28]);
	RCA4 a7 (A[27:24],B[27:24],c[5],{c_dummy[6],S[27:24]});//carya kolan dur rikhte mishe
	RCA4 a6 (A[23:20],B[23:20],c[4],{c_dummy[5],S[23:20]});
	RCA4 a5 (A[19:16],B[19:16],c[3],{c_dummy[4],S[19:16]});
	RCA4 a4 (A[15:12],B[15:12],c[2],{c_dummy[3],S[15:12]});
	RCA4 a3 (A[11:8],B[11:8]  ,c[1],{c_dummy[2],S[11:8]});
	RCA4 a2 (A[7:4],B[7:4]    ,c[0],{c_dummy[1],S[7:4]});
        RCA4 a1 (A[3:0],B[3:0]    ,1'b0,{c_dummy[0],S[3:0]});

assign Y = S[31:0];
endmodule



module ETAIIM8(A,B,S); //
    
    //inputs and outputs
input [7:0] A;
input [7:0] B;
output [8:0] S;

wire  c1,c_dummy;
        CGEN4 u1 (A[3:0],B[3:0],1'b0,c1);

	RCA4 a2 (A[7:4],B[7:4]    ,c1,S[8:4]);
        RCA4 a1 (A[3:0],B[3:0]    ,1'b0,{c_dummy,S[3:0]});

endmodule
