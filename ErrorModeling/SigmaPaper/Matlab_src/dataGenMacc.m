Sig1 = 2^2
Sig2 = 2^2

bits=32;


Nonums = 10000; % 5-7K samples for better sigma evaluation in matlab - zire in std(X) khatash ok nis
path1='~/approxiSynthesys/simulations';% unjayi ke darim save mikonim khorujiaro
load('~/approxiSynthesys/simulations/Evaluation/25x25/ETAIIM/params.mat','SigmaToEMin_MED_matrix');


fileID = fopen(strcat(path1,'/in_data.txt'),'w');
fprintf(fileID,'s%12s %12s %12s %12s \ns\n','ZA1','ZM3', 'ZA1+ZM3 ', 'Zero! ');



normrand_A1 = normrnd(0, Sig1 , [Nonums 1]);
normrand_B1 = normrnd(0, Sig2 , [Nonums 1]);
normrand_A1_rounded = round(normrand_A1);
normrand_B1_rounded = round(normrand_B1);

normrand_A2 = normrnd(0, Sig1 , [Nonums 1]);
normrand_B2 = normrnd(0, Sig2 , [Nonums 1]);
normrand_A2_rounded = round(normrand_A2);
normrand_B2_rounded = round(normrand_B2);


normrand_A3 = normrnd(0, Sig1 , [Nonums 1]);
normrand_B3 = normrnd(0, Sig2 , [Nonums 1]);
normrand_A3_rounded = round(normrand_A3);
normrand_B3_rounded = round(normrand_B3);


normrand_A4 = normrnd(0, Sig1 , [Nonums 1]);
normrand_B4 = normrnd(0, Sig2 , [Nonums 1]);
normrand_A4_rounded = round(normrand_A4);
normrand_B4_rounded = round(normrand_B4);

in_Values = horzcat(normrand_A1_rounded,normrand_B1_rounded,normrand_A2_rounded,normrand_B2_rounded,normrand_A3_rounded,normrand_B3_rounded,normrand_A4_rounded,normrand_B4_rounded);


ZM1= normrand_A1_rounded .* normrand_B1_rounded;
ZM2= normrand_A2_rounded .* normrand_B2_rounded;
ZM3= normrand_A3_rounded .* normrand_B3_rounded;
ZM4= normrand_A4_rounded .* normrand_B4_rounded;

std_A1=std(normrand_A1_rounded);
std_B1=std(normrand_B1_rounded);
std_ZM1=std(ZM1);

std_A2=std(normrand_A2_rounded);
std_B2=std(normrand_B2_rounded);
std_ZM2=std(ZM2);

std_A3=std(normrand_A3_rounded);
std_B3=std(normrand_B3_rounded);
std_ZM3=std(ZM3);

std_A4=std(normrand_A4_rounded);
std_B4=std(normrand_B4_rounded);
std_ZM4=std(ZM4);

ZA1 = ZM1 + ZM2;
std_ZA1=std(ZA1);



%round mikonim midmi adder aval! va tavan do 2 nazdikesho select mikonim.
std_ZA1_rounded = 2^round(log2(std_ZA1));
std_ZM3_rounded = 2^round(log2(std_ZM3));

%for ittereration dasti
std_ZM1_rounded_log = round(log2(std_ZM1));
std_ZM2_rounded_log = round(log2(std_ZM2));
std_ZA1_rounded_log = round(log2(std_ZA1));

%Sigma prints
fprintf(fileID,'p %12d %12d\n',std_ZA1_rounded,std_ZM3_rounded); % mifrestim be aavalin adder khata dar
fprintf(fileID,'s 1= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',std_A1,std_B1,std_ZM1); 
fprintf(fileID,'s 2= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',std_A2,std_B2,std_ZM2); 
fprintf(fileID,'s 3= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',std_A3,std_B3,std_ZM3); 
fprintf(fileID,'s 4= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',std_A4,std_B4,std_ZM4); 

ZA2 = ZA1 + ZM3;
std_ZA2=std(ZA2);
std_ZA2_rounded_log = round(log2(std_ZA2));


ZA3 = ZM4 + ZA2;
std_ZA3=std(ZA3);
std_ZA3_rounded_log = round(log2(std_ZA3));

out1_accurate = ZA3;


%10000 ta minvisim
for i = 1:Nonums
fprintf(fileID,'d%12d %12d %12d %12d\n',ZA1(i),ZM3(i),ZA1(i)+ZM3(i),1);
end

fclose(fileID);

%{
%%%%%WAITTT
prompt = 'Press any number after Running modelsim ';
x=input(prompt);
%}
%save('~/macc.mat');



