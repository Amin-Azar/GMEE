module tb32;
    // Inputs
    reg [31:0] A;
    reg [31:0] B;
 

    // Outputs
    wire [31:0] S;
	wire [31:0] S_accurate;
    wire Cout;


    // Instantiate the Unit Under Test (UUT)
    ETAIIM32 uut (.A(A), 
    .B(B), 
    .S(S)
    );

    initial begin
    // Initialize Inputs
    A = 0;  B = 0;
    // Wait 100 ns for global reset to finish
    #100;
        
    // Add stimulus here
    A=4'b00011;B=4'b00010;
    #10 A=4'b100;B=4'b0011;
    #10 A=4'b1101;B=4'b1010;
    #10 A=4'b1110;B=4'b1001;
    #10 A=4'b0001110001110001111;B=4'b001100110011001010;
	#10 A=4'b01111111111111111111111111111111;B=4'b001111111111100110011001010;
    end 

assign S_accurate = A+B;
endmodule
