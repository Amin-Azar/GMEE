module tb;

    // Inputs
    reg Clk;
    reg [7:0] Xin;

    // Outputs
    wire [15:0] Yout;
    wire [15:0] Yout2;


    // Instantiate the Unit Under Test (UUT)
    fir_4tap uut (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(Yout)
    );
        fir_2_4tap uut2 (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(Yout2)
    );
    //Generate a clock with 10 ns clock period.
    initial Clk = 0;
    always #50 Clk =~Clk;

//Initialize and apply the inputs.
    initial begin
          #200;
	  Xin = 0; #100;
          Xin = -3; #100;
          Xin = 1;  #100;
          Xin = 0;  #100;
          Xin = -2; #100;
          Xin = -1; #100;
          Xin = 4;  #100;
          Xin = -5; #100;
          Xin = 6;  #100;
          Xin = 0;  #100;
    end
      
endmodule
