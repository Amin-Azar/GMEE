/*
module FA_TT1(A,B,Cin,S,Cout); //first approximation

output S,Cout;
input A,B,Cin;
reg S, Cout;
wire [2:0] sel;
	
assign sel = {A,B,Cin};

always @ ( A or B or Cin) begin
case (sel)
0 : S =1;
1 : S =1;
2 : S =0;
3 : S =0;
4 : S =1;
5 : S =0;
6 : S =0;
7 : S =0;
default : S =0;
endcase

case (sel)
0 : Cout =0;
1 : Cout =0;
2 : Cout =1;
3 : Cout =1;
4 : Cout =0;
5 : Cout =1;
6 : Cout =1;
7 : Cout =1;
default : Cout =0;
endcase

end

endmodule

*/

/*
module FA1_TT3(S,Cout,A,B,Cin); //3rd approximation porta faghat fargh dare jahatesh
output S,Cout;
input A,B,Cin;

assign S =B;
assign Cout =A;

endmodule

module HA1_TT3(S,Cout,A,B); //3rd approximation porta faghat farg dare tartibesh
output S,Cout;
input A,B;

assign S =B;
assign Cout =A;

endmodule
*/

module FA_TT3(A,B,Cin,S,Cout); //3rd approximation
output S,Cout;
input A,B,Cin;
//logic - carry o enga nega nemikone
assign S =B;
assign Cout =A;

endmodule

module HA_TT3(A,B,Cin,S,Cout); //3rd approximation
output S,Cout;
input A,B,Cin;
//logic - az ru full adere e bedune carry sakhtam ke hamun mishe HA
assign S =B;
assign Cout =A;

endmodule


module RCA4_TT3( //all approximate truth table adders
    input [3:0] A,B,
    input Cin,
    output [4:0] S
    );
//signalaye carry
wire c1,c2,c3;

//hame ina approximate hast
FA_TT3 FA1(A[0],B[0],Cin,S[0],c1),
    FA2(A[1],B[1],c1,S[1],c2),
    FA3(A[2],B[2],c2,S[2],c3),
    FA4(A[3],B[3],c3,S[3],S[4]);

endmodule


module RCA32_TT3( // 8bit LSB is inaccurate FA_TT3 rest is FA
    input [31:0] A,B,
    output [32:0] S
    );
wire c1,c2,c3,c4,c5,c6,c7;
//ina approximate estefade shode tushun
RCA4_TT3 F1(A[3:0],B[3:0]  ,1'b0,{c1,S[3:0]});
RCA4_TT3 F2(A[7:4],B[7:4]  ,c1,{c2,S[7:4]});
//azinja be bad accurate hast
RCA4 F3(A[11:8],B[11:8]	 ,c2,{c3,S[11:8]}); 
RCA4 F4(A[15:12],B[15:12],c3,{c4,S[15:12]}); 
RCA4 F5(A[19:16],B[19:16],c4,{c5,S[19:16]}); 
RCA4 F6(A[23:20],B[23:20],c5,{c6,S[23:20]}); 
RCA4 F7(A[27:24],B[27:24],c6,{c7,S[27:24]}); 
RCA4 F8(A[31:28],B[31:28],c7,S[32:28]);

endmodule

/*
module RCA8_TT3( // 3bit LSB is inaccurate FA_TT3 rest is FA
    input [7:0] A,B,
    input Cin,    output [8:0] S,
    );
 wire c1,c2,c3,c4,c5,c6,c7;

 FA_TT3 FA1(A[0],B[0],Cin,S[0],c1),
    FA2(A[1],B[1],c1,S[1],c2),
    FA3(A[2],B[2],c2,S[2],c3);
//5 bit bala daghigh RCA ba FA
FA1 FA4(A[3],B[3],c3,S[3],c4);
RCA4 F5678(A[7:4],B[7:4],c4,S[8:4]);


endmodule

*/