
module CGEN4(A,B,Cin,Cout);

    output Cout;
    input [3:0] A,B;
    input Cin;

	wire [3:0] P,G;
    assign G = A & B; //Generattion
    assign P = A ^ B; //Propagatation
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & Cin);   

endmodule
