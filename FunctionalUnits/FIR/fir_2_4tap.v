module fir_2_4tap(Clk,Xin,Yout);
    
    //inputs and outputs
    input Clk;
    input [7:0] Xin;
    output [15:0] Yout;
    //Internal variables.
    reg [15:0] Yout;
    wire    [7:0] H0,H1,H2,H3;
    wire    [15:0] MCM0,MCM1,MCM2,MCM3,add_out1,add_out2,add_out3;

    
//filter coefficient initializations.
//H = [-2 -1 3 4].
    assign H0 = -2;
    assign H1 = -1;
    assign H2 = 3;
    assign H3 = 4;

//Multiple constant multiplications.
    assign MCM3 = H3*Xin;
    assign MCM2 = H2*Xin;
    assign MCM1 = H1*Xin;
    assign MCM0 = H0*Xin;

//adders
    assign add_out1 = MCM3 + MCM2;
    assign add_out2 = add_out1 + MCM1;
    assign add_out3 = add_out2 + MCM0;    



//Assign the last adder output to final output.
    always@ (posedge Clk)
        Yout <= add_out3;

endmodule
