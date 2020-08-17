module DFF(Q,Clk,D);

    input Clk;
    input [15:0] D;
    output [15:0] Q;
    reg [15:0] Q;
    
    always@ (posedge Clk)
        Q = D;
    
endmodule
