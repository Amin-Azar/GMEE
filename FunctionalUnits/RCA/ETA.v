module ETAI32(A,B,S); //12 accurate 20 inaccurate //RCP
    
//inputs and outputs
input [31:0] A;
input [31:0] B;
output [32:0] S;
reg [19:0] S_20;

wire [19:0] ctl;
wire c5,c6,c7;
integer i;

	CTL uut1 (A[19:16],B[19:16], 2'b0,ctl[19:16] );
	CTL uut2 (A[15:12],B[15:12],{ctl[19],ctl[16]},ctl[15:12] );//barax propagate mishe dge
	CTL uut3 (A[11:8],B[11:8],{ctl[15],ctl[12]},ctl[11:8] );
	CTL uut4 (A[7:4],B[7:4],{ctl[11],ctl[8]},ctl[7:4] );
        CTL uut5 (A[3:0],B[3:0],{ctl[7],ctl[4]},ctl[3:0] );

always@ (A or B) begin
	for (i=19;i>-1;i=i-1) begin // carry free addition
	if ( ctl[i]) S_20[i] =1;
	else S_20[i] = A[i] ^ B[i];
	end
end
//acccurate part
RCA4 F6(A[23:20],B[23:20],c5,{c6,S[23:20]}); 
RCA4 F7(A[27:24],B[27:24],c6,{c7,S[27:24]}); 
RCA4 F8(A[31:28],B[31:28],c7,S[32:28]);

assign S[19:0] = S_20;
assign c5= 1'b0;
endmodule


module CTL(A,B,ctl_i,ctl_o); // control block - age harkodum az ctl_i1 ya 2 yek bashe yani inke ghablia 1 bude o toam 1 o propagate ko bere
    
//inputs and outputs
    	input [3:0] A;	
	input [3:0] B;
    	input [1:0] ctl_i;
	output [3:0] ctl_o;

assign ctl_o[3] = ( (ctl_i[1]|ctl_i[0]) | (A[3]&B[3]) ) ? 1 : 0;
assign ctl_o[2] = ( (ctl_o[3]) | (A[2]&B[2]) ) ? 1 : 0;
assign ctl_o[1] = ( (ctl_o[2]) | (A[1]&B[1]) ) ? 1 : 0;
assign ctl_o[0] = ( (ctl_o[1]) | (A[0]&B[0]) ) ? 1 : 0;
        
endmodule


module ETAI8(A,B,S);
    
//inputs and outputs
input [7:0] A;
input [7:0] B;
output [8:0] S;
reg [2:0] S_3;

wire [2:0] ctl;
integer i;


always@ (A or B) begin // 5 accurate 3
	for (i=2;i>-1;i=i-1) begin // carry free addition
	if ( ctl[i]) S_3[i] =1;
	else S_3[i] = A[i] ^ B[i];
	end
end

assign S[8:3] = A[7:3] + B[7:3];
assign S[2:0] = S_3;


assign ctl[2] = ( (A[2]&B[2]) ) ? 1 : 0;
assign ctl[1] = ( (ctl[2]) | (A[1]&B[1]) ) ? 1 : 0;
assign ctl[0] = ( (ctl[1]) | (A[0]&B[0]) ) ? 1 : 0;


endmodule