module mult_test;
 
	reg [15:0] a,b;
	wire [31:0] prod1,prod2;
	reg clk;
 	
	integer out_file,out_file2;

	mult16appx2 m1(a,b,prod1);
	mult16exact m2(a,b,prod2); 
 
	initial begin
		
		out_file = $fopen("/ubc/ece/home/ml/grads/aming/approxiSynthesys/mult16appx/error_mult2_modelsim_out.out","w");
		out_file2 = $fopen("/ubc/ece/home/ml/grads/aming/approxiSynthesys/mult16appx/error_SHORT_mult2_modelsim_out2.out","w");
		clk = 0;
		#200000;
		$fclose(out_file);
		$finish;
	end
 
	always@(posedge clk) begin
		a = $random;
		b = $random;
		#20;
	end
 
	always #10 clk = !clk;
 
	reg [15:0] a_reg,b_reg;
 
	always@(posedge clk) begin
		a_reg <= a;
		b_reg <= b;
	end
 
	always@(posedge clk)begin
		if((a_reg > 0) && (b_reg > 0)) begin
			if(prod1 == a_reg *b_reg)
begin
				$display("ERR: 0 - %d x %d = %d, Test Passed ", a_reg, b_reg, prod1);
				$fwrite(out_file, "ERR: 0 - %d x %d = %d, Test Passed \n", a_reg, b_reg, prod1);
				$fwrite(out_file2, "0 %d %d ERR-b-orig_y\n", b_reg, prod1);
end	
		else
begin
				$display("ERR: %d - %d x %d = %d, Test Failed, original_prod=  %d", prod1 - prod2 , a_reg, b_reg, prod1, prod2 );
				$fwrite(out_file, "ERR: %d - %d x %d = %d, Test Failed, original_prod=  %d \n", prod1 - prod2 , a_reg, b_reg, prod1, prod2 );
				$fwrite(out_file2, "%d %d %d ERR-b-orig_y\n", prod1 - prod2, b_reg, prod2 );
end
		end
	end
 
endmodule
