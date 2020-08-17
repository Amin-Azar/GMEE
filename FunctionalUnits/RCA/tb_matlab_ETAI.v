


module tb_matlab_ETAI;

`define NULL 0
`define MaxChars 100 // max character e line


integer	data_file,out_file,out_file2    ; // file handler
integer	status,status2    ; // file handler
real	ssnr,snr,n;real	eof_count;
integer i; //index loop
reg [99:0] max_ae,ae,sae,sse; //sum abs error - abs err ...
reg [8:1] type;
reg [`MaxChars*8:1] line; 
reg [100*8:1] path;

    // reg
	reg signed [31:0] data_A;
	reg signed [31:0] data_B;

reg signed [31:0] data_A_old;
	reg signed [31:0] data_B_old;

	reg signed [31:0] data_Sum;
	reg signed [31:0] data_Mult;

	reg Clk;
    // Outputs
    wire [32:0] adder_out;wire [32:0] adder_out2;//wire [15:0] ae;
wire signed [31:0] out1;wire signed [31:0] out2;


//faulty adder
    ETAI32 uut2 (data_A,data_B,adder_out);

initial begin
path = "/ubc/ece/home/ml/grads/aming/approxiSynthesys/simulations";
//path = "~/approxiSynthesys/simulations";
data_file = $fopen({path,"/in_data.txt"}, "r");
//age bekhaym ba detail benvisim ke nemikhaym  out_file = $fopen({path,"/out_ETAIIM32_Matlab_detailed.txt"}, "w");
out_file2 = $fopen({path,"/out_ETAIIM32_Matlab.txt"}, "w");
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
	//max_ae=0;sae=0;sse=0;ae=0;
	n=0;eof_count=0;
	data_A=0;data_B=0;

data_A_old = 0;
data_B_old = 0;

for (i=0;i<100;i=i+1)
begin
max_ae[i] <= 1'b0;
sae[i] <= 1'b0;
sse[i] <= 1'b0;
ae[i] <= 1'b0;
end

end


   always #50 Clk =~Clk;

always @(posedge Clk) begin
	n = n+1;


status2 = $fscanf(data_file, "%s", type);
if (type =="d")
begin
status = $fscanf(data_file, "%d %d %d %d\n", data_A,data_B,data_Sum,data_Mult); 

//$display("s=%s",type);

//$display("a=%d, b=%d c=%d d=%d",data_A,data_B,data_Sum,data_Mult);

data_A_old <= data_A;
data_B_old <= data_B;
/*
if (out1 > out2) // find absolute error
ae = (out1-out2);r
else
ae = (out2-out1);

$display ("n=%d, ae= %f",n,ae);
$display ("n=%d, ae**2= %f",n,ae**2);

snr = ((out1)**2)/((ae)**2);

if (max_ae < ae)
max_ae=ae;

sse = sse + (ae)**2;
sae = sae + ae;
ssnr = ssnr + snr;

$display ("n=%d, sse= %f",n,sse);
*/
#10;

if ($feof(data_file)) begin

//for the last one ke hatman type d has ke munde
//age bekhaym ba detail benvisim ke nemikhaym$fwrite(out_file,"d a=%d(%h), b=%d(%h), Appx=%d(%h), Accr=%d(%h)\n",data_A_old,data_A_old,data_B_old,data_B_old, out1,out1, out2,out2);
$fwrite(out_file2,"d %d %d %d %d\n",data_A_old,data_B_old,out1,out2);


// $fwrite(out_file,"MSE: %f",(ae)/(n-2)); // first 2 clock is initiation
//age bekhaym ba detail benvisim ke nemikhaym$fclose(out_file);
$fclose(out_file2);
$fclose(data_file);
$finish;

end
//$display("%h %h",data_A_old,data_B_old); // mikhasam bebinam X has yana!

if(^data_A_old === 1'bX || ^data_B_old === 1'bX || ^out1 === 1'bX)
begin
$display("xxxxxxxxx");
//age bekhaym ba detail benvisim ke nemikhaym$fwrite(out_file,"d a=%d(%h), b=%d(%h), Appx=%d(%h), Accr=%d(%h)\n",0,0,0,0, 0,0,0,0);
$fwrite(out_file2,"d %d %d %d %d\n",0,0,0,0);
end
else
begin
// dare b ehx o signed int neshun mide ke a b  chian o khorujie taghribi chie o daghigh chie
//age bekhaym ba detail benvisim ke nemikhaym$fwrite(out_file,"d a=%d(%h), b=%d(%h), Appx=%d(%h), Accr=%d(%h)\n",data_A_old,data_A_old,data_B_old,data_B_old, out1,out1, out2,out2);
$fwrite(out_file2,"d %d %d %d %d\n",data_A_old,data_B_old,out1,out2);
end

//$display ("n=%d, mse= %f",n,(100*sse)/(n-1));
end
else //type s ya p
begin

$fgets(line,data_file);
//age bekhaym ba detail benvisim ke nemikhaym$fwrite(out_file,"%s %s",type,line); // string harchi bude pas midmi birun
$fwrite(out_file2,"%s %s",type,line);
$display("type %s, line=%s",type,line);
end

end

assign out1 = adder_out[31:0];
assign out2 = adder_out2[31:0];
assign adder_out2 = data_A+ data_B;
      
endmodule