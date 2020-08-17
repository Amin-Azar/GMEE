module tb2_32;


integer	data_file,out_file    ; // file handler
integer	status,status2    ; // file handler
real	ssnr,snr,n;real	eof_count;
integer max_ae,ae,sae,sse; //sum abs error - abs err ...
//reg [7:0] data_ina;
//reg [7:0] data_inb;
`define NULL 0


    // reg
	reg [31:0] dataa;
	reg [31:0] datab;
	reg Clk;
    // Outputs
    wire [32:0] adder_out;wire [32:0] adder_out2;//wire [15:0] ae;



//faulty adder
    ETAIIM32 uut2 (dataa,datab,adder_out);

    initial begin

  data_file = $fopen("test_randi6.txt", "r");
  out_file = $fopen("out_ETAIIM32_6.txt", "w");
  if (data_file == `NULL) begin
    $display("File Error: data_file handle was NULL");
    $finish;
  end
  if (out_file == `NULL) begin
    $display("File Error: out_file handle was NULL");
    $finish;
  end

	//$fwrite(out_file,"Count(n) \tMSE \tMAE \tSNR \tmax{AE}\n");
	Clk=0;
	max_ae=0;sae=0;sse=0;ae=0;n=0;eof_count=0;



end


   always #50 Clk =~Clk;

always @(posedge Clk) begin
	n = n+1;
  status = $fscanf(data_file, "%d %d\n", dataa,datab); 
//$display("a=%d, b=%d",dataa,datab);

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

  if ($feof(data_file)) begin

// $fwrite(out_file,"MSE: %f",(ae)/(n-2)); // first 2 clock is initiation
$fclose(out_file);
$fclose(data_file);
$finish;

end



$fwrite(out_file,"a=%d, b=%d, %d, %d\n",dataa,datab, adder_out, adder_out2);
$display ("n=%d, mse= %f",n,(100*sse)/(n-1));
end


assign adder_out2 = dataa+ datab;
      
endmodule

