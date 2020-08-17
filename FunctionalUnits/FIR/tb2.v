module tb2;



integer	data_file,out_file    ; // file handler
integer	status,status2    ; // file handler
real	ssnr,snr,n;real	eof_count;
integer max_ae,ae,sae,sse; //sum abs error - abs err ...
//reg [7:0] data_ina;
//reg [7:0] data_inb;
`define NULL 0


    // Inputs
    reg Clk;
    reg [7:0] Xin;

    // Outputs
    wire [15:0] adder_out;
    wire [15:0] adder_out2;


    // Instantiate the Unit Under Test (UUT)
    fir_4tap uut (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(adder_out)
    );
        fir_4tap2 uut2 (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(adder_out2)
    );
    //Generate a clock with 10 ns clock period.


    initial begin

  data_file = $fopen("test_fir.txt", "r");
  out_file = $fopen("out_fir.txt", "w");
  if (data_file == `NULL) begin
    $display("File Error: data_file handle was NULL");
    $finish;
  end
  if (out_file == `NULL) begin
    $display("File Error: out_file handle was NULL");
    $finish;
  end

	$fwrite(out_file,"Count(n) \tMSE \tMAE \tSNR \tmax{AE}\n");
	Clk = 0;
	max_ae=0;sae=0;sse=0;ae=0;n=0;eof_count=0;



end


    always #50 Clk =~Clk;

always @(posedge Clk) begin
	n = n+1;
  status = $fscanf(data_file, "%d\n", Xin); 

if (adder_out > adder_out2) // find absolute error
ae = (adder_out-adder_out2);
else
ae = (adder_out2-adder_out);
snr = ((adder_out)**2)/((ae)**2);

if (max_ae < ae)
max_ae=ae;

sse = sse + (ae)**2;
sae = sae + ae;
ssnr = ssnr + snr;

  if (!$feof(data_file)) begin
	
	eof_count=n;
	end
	else
begin
$display("eof reached");
if ( eof_count +4 < n) // 2 clks in the begining initiation. 2 clks at the end takes to produce the result.
begin
// $fwrite(out_file,"MSE: %f",(ae)/(n-2)); // first 2 clock is initiation
$fclose(out_file);
$fclose(data_file);
$finish;
end
end



if (n-2>0) begin
$display("ae: %f",ae);
$display("mse,1,2,n: %f,%d,%d, %d",(ae)/(n-2),adder_out,adder_out2,n); // first 2 clock is initiation
$display("MSE: %f",(sse)/(n-2)); // first 2 clock is initiation
$display("MSE: %f",(sae)/(n-2)); // first 2 clock is initiation
$fwrite(out_file,"%d, %f, %f, %f, %d\n",n-2,(sse)/(n-2),(sae)/(n-2), (ssnr)/(n-2), max_ae); // first 2 clock is initiation
end
end


    
endmodule
