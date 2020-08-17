module fir_4tap_32modular(Clk,Xin,Yout);// check naashode hanuz
    
    //inputs and outputs
    input Clk;
    input [31:0] Xin;
    output [63:0] Yout;
    //Internal variables.
    reg [64:0] Yout;
    wire    [31:0] H0,H1,H2,H3;
    wire    [63:0] MCM0,MCM1,MCM2,MCM3,add_out1,add_out2,add_out3;
    wire    [63:0] Q1,Q2,Q3;
    
//filter coefficient initializations.
//H = [-2 -1 3 4].
    assign H0 = -2;
    assign H1 = -1;
    assign H2 = 3;
    assign H3 = 4;

//Multiple constant multiplications.
	mult_accurate MA1 (H3,Xin,MCM3);
	mult_accurate MA2 (H2,Xin,MCM2);
	mult_accurate MA3 (H1,Xin,MCM1);
	mult_accurate MA4 (H0,Xin,MCM0);
//adders
	add_accurate AA1 (Q1,MCM2,add_out1);
	add_accurate AA2 (Q2,MCM1,add_out2);
	add_accurate AA3 (Q3,MCM0,add_out3);

    

//flipflop instantiations (for introducing a delay).
    DFF dff1 (.Q(Q1),.Clk(Clk),.D(MCM3));
    DFF dff2 (.Q(Q2),.Clk(Clk),.D(add_out1));
    DFF dff3 (.Q(Q3),.Clk(Clk),.D(add_out2));

//Assign the last adder output to final output.
    always@ (posedge Clk)
        Yout <= add_out3;

endmodule

module mult_accurate(A,B,Yout);
    
    //inputs and outputs
    input [31:0] A,B;
    output [63:0] Yout;
    
assign Yout = A*B;

endmodule

module add_accurate(A,B,Yout);
    
    //inputs and outputs
    input [31:0] A,B;
    output [32:0] Yout;
    
assign Yout = A+B;

endmodule
