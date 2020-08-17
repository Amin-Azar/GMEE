%{
%intitalization
Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
Nonums = 7000; % 5-7K samples for better sigma evaluation in matlab


%%bias =3; %chand ta aghab jolotar bere
bits=32; % bara 32 biti
bias=0;
%} 
%bordim tu params

load ('~/params.mat');

%indexing
indx1 =1; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
indx2=1; 
indx3=0; % index e array haye std ke tu har p mikhunim
i=1;

notfirstRound=0;

% MED calc
MED_in=0;
SigmaToEMin_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
out_data=zeros(1,4);
out_datas=zeros(1,4);

coefs= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
coefs_total= zeros(bits,1); 

%Sig reading
sigma_old=zeros(1,2);
%sigma_old(1)=2;
%sigma_old(2)=2;
sigma=zeros(1,2);
sum_Apprx_datas=zeros(Nonums,1); 
corr_out_datas=zeros(Nonums,1); 

%Sig to sig  =[log-> actual Sig (2^X)]
std_A_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
std_B_array=zeros(Sigma_itt*(Sigma_itt+bias),1);

std_Sum_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
%std_Mult_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
SigmaToSigma_Sum_matrix_apprx=zeros(Sigma_itt+bias,Sigma_itt);
SigmaToSigma_Mult_matrix_apprx=zeros(Sigma_itt+bias,Sigma_itt);


%file open
%fileID = fopen('${HOME_DIR}/approxiSynthesys/benchmarks/custom/RCA/out_ETAIIM32_Matlab.txt','r');
fileID = fopen(strcat(path1,'/out_ETAIIM32_Matlab.txt'),'r');

%code starts here
if 1
while ~feof(fileID)
    indx1= indx1+1;
    if(indx1==Nonums);
        indx1=1;
        indx2=indx2+7; %1K index semicolon nazashtim index beznae bbeinim kojayim asan
        
        
    %indx3=indx3+1;
    end
        
type = fgets(fileID,1);

 if strcmp(type,'s');
 % display('type =s');  
 line = fgets(fileID,101);
 %fprintf('line=%s\n',line); 
 elseif  strcmp(type,'d');
        %  display('type = d');
 out_data_1=fscanf (fileID,' %d %d %d %d\n'); %a_d,a_h,b_d,b_h,appx_d,appx_h,accr_d,accr_h   d(%h) %d(%h) %d(%h) %d(%h)'
 out_data(1)=out_data_1(1); out_data(2)=out_data_1(2); out_data(3)=out_data_1(3); out_data(4)=out_data_1(4);
 
 if rst==1
     out_datas = out_data;
     rst =0;
     coefs= zeros(bits,1);
 else
     out_datas = vertcat ( out_datas,out_data);
 end
 
 %indx = indx+1;
 
  elseif  strcmp(type,'p');
      
      rst=1;% resifdim be abdi dge inja bayad ghabliaro besporim be daste sarnevesht!
      sigma_1=fscanf (fileID,' %d %d\n');%sigmaharo az tu file mikhunim
      sigma(1)=sigma_1(1); sigma(2)=sigma_1(2); % row be column e sh fargh dare chonle
      
      if(sigma_old(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
          
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s

      
     %{
 Sigma 
     %}
 
      %sigma to Sigma approximate
     std_Sum_apprx=std(out_datas(:,3)); %std khata dar chie
     std_A_array(indx3) =sigma_old(1);
     std_B_array(indx3) = sigma_old(1);
     std_Sum_array(indx3) = std_Sum_apprx;
     %std_Mult_array(indx3) = std_Mult;

     SigmaToSigma_Sum_matrix_apprx(Sig_a,Sig_b) = std_Sum_apprx;
     %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult; 

     EM_in = EM_med(out_datas(:,4) ,out_datas(:,3), Nonums);     
     sum_Apprx=out_datas(:,3);
     sum_Apprx_datas = horzcat(sum_Apprx_datas,sum_Apprx);% data khoruji doroste bedune khataye input
     corr_out_datas = horzcat(corr_out_datas,out_datas(:,4));% age step ghabli doros bud, A o B bedune khata ro mizarim inja

     SigmaToEMin_MED_matrix (Sig_a,Sig_b)=EM_in; %logarithmic indexed

      end
     %coefs_total = horzcat(coefs_total,coefs); % vase inke bebinim kolan khataha koja ha bude X*Y = runhayeMokhtalef * 2^adadeKhata
 else
 line = fgets(fileID,101);
 %display(line);
 end
   %   sigmas = vertcat ( sigmas,sigma);
    sigma_old = sigma;


    %     display('File format error!!');
    indx3= indx3+1;
end



%end of file for the last one dgE!
      
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s
      
     %{ Sigma %}
     %sigma to Sigma approximate
     std_Sum_apprx=std(out_datas(:,3)); %std khata dar chie
     std_A_array(indx3) =sigma_old(1);
     std_B_array(indx3) = sigma_old(1);
     std_Sum_array(indx3) = std_Sum_apprx;
     %std_Mult_array(indx3) = std_Mult;

     SigmaToSigma_Sum_matrix_apprx(Sig_a,Sig_b) = std_Sum_apprx;
     %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult; 
     
     %inja log e hamunaro chap konim 
     SigmaToSigma_sum_matrix_apprx_log = round(log2(SigmaToSigma_Sum_matrix_apprx));
     SigmaToSigma_sum_matrix_log = round(log2(SigmaToSigma_Sum_matrix));
     EM_in = EM_med(out_datas(:,4) ,out_datas(:,3), Nonums);
     sum_Apprx=out_datas(:,3);
     sum_Apprx_datas = horzcat(sum_Apprx_datas,sum_Apprx);     
     corr_out_datas = horzcat(corr_out_datas,out_datas(:,4));% age step ghabli doros bud, A o B bedune khata ro mizarim inja

     SigmaToEMin_MED_matrix (Sig_a,Sig_b)=EM_in; %logarithmic indexed




end


%ino nemidunam chie filan
%{

%disp (SigmaToEMin_MED_matrix);

reliabilities=coefs_total(1,:); % initialize
reliabilities1=size(coefs_total);
reliabilities1=reliabilities1(2);
for r =1:reliabilities1
reliabilities(1,r) = sum(coefs_total(:,r))
end

reliabilities  = 1-  reliabilities /Nonums;


%occurences percent total
occurs_total=coefs_total(:,1); % initialize
occurs1=size(coefs_total); %number of itterations (runs)
occurs1=occurs1(1);
for r =1:occurs1
occurs_total(r,1) = sum(coefs_total(r,:))
end

occurs_total = (100 * occurs_total) / (Nonums*occurs1);


%}




%%sigmas = sigmas([2 : 100],:);
%names1 = {'A';'B';'Apprx';'Accur';'Abs_Err'};
%disp(out_datas);
%disp(sigmas);
%T= table(out_datas(:,1) ,out_datas(:,2),out_datas(:,3),out_datas(:,4), abs(out_datas(:,4) - out_datas(:,3)),'VariableNames',names1);
fclose(fileID);

save (strcat(path1,'/params_dataCalc.mat'));
%save ('~/params.mat','-append');
save ('~/params.mat');










