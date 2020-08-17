module tb;

    // reg
	reg [7:0] dataa;
	reg [7:0] datab;
	reg Clk, aclr, clken, sload;
    // Outputs
    wire [15:0] adder_out;


    // Instantiate the Unit Under Test (UUT)
    unsig_altmult_accum uut (
        .dataa(dataa), 
        .datab(datab), 
        .Clk(Clk),
	.aclr(aclr),
	.clken(clken),
	.sload(sload),
	.adder_out(adder_out)
);

    //Generate a clock with 10 ns clock period.
    initial begin
	Clk = 0;
	aclr=1;
	clken =1;
	sload =1;
end

    always #50 Clk =~Clk;

//Initialize and apply the inputs.
    initial begin
          #200;
	  aclr=0;
	
	  sload =0;
	  dataa = 0;
          datab = 0; #100;
	  dataa = 1;
          datab = 1; #100;
	  dataa = 1;
          datab = 10; #100;
	  dataa = 10;
          datab = 1; #100;
	  dataa = 9;
          datab = 8; #100;
    end
      
endmodule
