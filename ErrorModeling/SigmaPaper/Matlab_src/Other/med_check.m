


Nonums = 7000;

reg_test = zeros(100,3);
i2=0;
for i =1:2000
    i2=i2+1;
    if(i2 ==1000)
        i2=0
    end
A= round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
errrand_A =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
A_err =A + errrand_A;

EMa=EM_med(A,A_err,Nonums);

B= round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
errrand_B =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
B_err =B + errrand_B;

EMb=EM_med(B,B_err,Nonums);

EMz_accur =EM_med(A+B,A_err+B_err,Nonums);

reg_test(i,1)=EMa;
reg_test(i,2)=EMb;
reg_test(i,3)=EMz_accur;

end

tbl_accur = table(reg_test(:,1),reg_test(:,2),reg_test(:,3),'VariableNames',{'EM_A','EM_B','EM_Z'});
fitlm(tbl_accur,'EM_Z~EM_A+EM_B')