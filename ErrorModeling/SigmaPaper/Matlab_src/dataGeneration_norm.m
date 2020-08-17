%{
%intitalization
Sigma_itt = 3 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
Nonums = 7000; % 5-7K samples for better sigma evaluation in matlab
%%bias =3; %chand ta aghab jolotar bere
bias=0;
%}

load ('params.mat');
indx =0; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
Sig1 = 0;
Sig2 = 0;

%Pre-allocation
normrand_Sum=zeros(Nonums,1);
normrand_Mult=zeros(Nonums,1);

std_A_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
std_B_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
std_Sum_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
std_Mult_array=zeros(Sigma_itt*(Sigma_itt+bias),1);

SigmaToSigma_Sum_matrix=zeros(Sigma_itt+bias,Sigma_itt);
SigmaToSigma_Mult_matrix=zeros(Sigma_itt+bias,Sigma_itt);

%file open
fileID = fopen('in_data.txt','w');
fprintf(fileID,'s%12s %12s %12s %12s \ns\n','A','B', 'A+B ', 'A*B ');


%code starts here
if 1

    
for c = 1:Sigma_itt

    %age bekhaym kam ejra konim
%for k = c-bias:c+bias; % in yani 15 beshe, vagarna vase 30% kardan e simulation mishe az for k = itt:itt+3 estefade kard
    
    
    %age hamaro darim ejra mikonim
for k = 1:Sigma_itt
if k > 0 % index manfi nazanim
    
Sig1 = 2^c % semicolon nazashtim ke neshun bedi yechi un zir befahmim dare mire jolo
Sig2 = 2^k;


% adada inja generate mishe
normrand_A = normrnd(0, Sig1 , [Nonums 1]);
normrand_B = normrnd(0, Sig2 , [Nonums 1]);
%normrand_Sum = normrand_A + normrand_B; %Import/read From File

%inja round mikonim mire, didim ke round kardna hamchinam tasire badi
%nadare

normrand_A_rounded = round(normrand_A);
normrand_B_rounded = round(normrand_B);
normrand_Sum = normrand_A_rounded + normrand_B_rounded;%sum e daghigh a zinput haye round shode

normrand_Mult = normrand_A_rounded .* normrand_B_rounded;

%for i = 1:Nonums
%normrand_Mult(i) = normrand_A_rounded(i) * normrand_B_rounded(i); %Import/read From File
%end

%std hayi ke khode matlab be das miare
std_A=std(normrand_A_rounded);
std_B=std(normrand_B_rounded);
std_Sum=std(normrand_Sum);
std_Mult=std(normrand_Mult);

indx = indx+1;
if (mod(indx,10) ==0);
disp(indx);
end

std_A_array(indx) = std_A;
std_B_array(indx) = std_B;
std_Sum_array(indx) = std_Sum;
std_Mult_array(indx) = std_Mult;

%Sigma prints
fprintf(fileID,'p%12d %12d\n',Sig1,Sig2); % ba ina sakhtim vali badia darumade
fprintf(fileID,'s\ns** [Sigma_A=%12d Sigma_B=%12d]\n',Sig1,Sig2); % ba ina sakhtim vali badia darumade
fprintf(fileID,'s== [ s_A=%10.2f s_B=%10.2f s_Sum=%10.2f s_Mult=%10.2f]\n',std_A,std_B,std_Sum,std_Mult); % in daghigheshe
fprintf(fileID,'s~~ [std_A=%12d std_B=%12d std_Sum=%12d std_Mult=%12d]\ns\n',round(std_A),round(std_B),round(std_Sum),round(std_Mult)); % in round shodashe


%7000 ta minvisim
for i = 1:Nonums
fprintf(fileID,'d%12d %12d %12d %12d\n',normrand_A_rounded(i),normrand_B_rounded(i),normrand_Sum(i),normrand_Mult(i));
end

SigmaToSigma_Sum_matrix(k,c) = std_Sum;
SigmaToSigma_Mult_matrix(k,c) = std_Mult;
end 

end
end
    
if 0 % age khastim figure ro bekeshe ke nemikhaym filan
    
figure

subplot(1,3,1)
hold on
surf(log2(SigmaToSigma_Sum_matrix)) 
%surf1 = Sigma_itt*ones(Sigma_itt,Sigma_itt);
%mesh(surf1);
hold off


subplot(1,3,2)
hold on
surf(log2(SigmaToSigma_Mult_matrix)) 
%surf1 = Sigma_itt*ones(Sigma_itt,Sigma_itt);
%mesh(surf1);
hold off
end


end

%linear and nonlinear fit! hichi haminjuri

%tbl1 = table(std_A_array,std_B_array,std_Sum_array,'VariableNames',{'std_A','std_B','std_Sum'});
%lm1 = fitlm(tbl1,'std_Sum~std_A+std_B')

%tbl2 = table(std_A_array,std_B_array,std_Mult_array,'VariableNames',{'std_A','std_B','std_Mult'});
%modelfun = @(b,x)b(1) +b(2)*x(:,1)+b(3)*x(:,1)+b(4)*x(:,1).*x(:,2);
%lm2 = fitnlm(tbl2,modelfun,[1 1 1 10])

fclose(fileID);

save ('params_dataGen.mat');
save ('params.mat','-append');