%{
%intitalization
Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
Nonums = 7000; % 5-7K samples for better sigma evaluation in matlab


%bias =3; %chand ta aghab jolotar bere
bits=32; % bara 32 biti
bias=0;
%}
%bias =3; %chand ta aghab jolotar bere

load ('~/params.mat');
%indexing
indx1 =1; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
indx2=1; 

i=1;
indx11=1;
notfirstRound=0;

% MED calc
MED_z=0;
SigmaToEMz_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
SigmaToEMz_accr_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
out_data=zeros(1,4);
out_datas=zeros(1,4);

coefs= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
coefs_total= zeros(bits,1); 

%Sig reading
sigma_old=zeros(1,2);
%sigma_old(1)=2;
%sigma_old(2)=2;
sigma=zeros(1,2);


%Sig to sig  =[log-> actual Sig (2^X)]
std_A_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
std_B_array=zeros(Sigma_itt*(Sigma_itt+bias),1);

std_Sum_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
%std_Mult_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
SigmaToSigma_Sum_matrix_apprx=zeros(Sigma_itt+bias,Sigma_itt);
%SigmaToSigma_Mult_matrix_apprx=zeros(Sigma_itt+bias,Sigma_itt);


%file open
%fileID = fopen('${HOME_DIR}/approxiSynthesys/benchmarks/custom/RCA/out_ETAIIM32_Matlab_reg.txt','r');
fileID = fopen(strcat(path1,'/out_ETAIIM32_Matlab_reg.txt'),'r');


%code starts here
if 1
while ~feof(fileID)
    
    
    indx1= indx1+1;
    
    
    if(indx1==Nonums);
        indx1=1;
        indx2=indx2+7; %1K index semicolon nazashtim index beznae bbeinim kojayim asan
 
    end
        
type = fgets(fileID,1);

 if strcmp(type,'s');
 % display('type =s');  
 line = fgets(fileID,100);
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
 

 
  elseif  strcmp(type,'p');
      
      rst=1;% resifdim be abdi dge inja bayad ghabliaro besporim be daste sarnevesht!
      sigma_1=fscanf (fileID,' %d %d\n');%sigmaharo az tu file mikhunim
      sigma(1)=sigma_1(1); sigma(2)=sigma_1(2); % row be column e sh fargh dare chonle
      
      
            if(sigma_old(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
      
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s
      
     indx11=indx11+1; %avali ke sefre bezarim injam oke
  
     MED_z = EM_med(corr_out_datas(:,indx11), out_datas(:,3), Nonums);
     SigmaToEMz_MED_matrix(Sig_a,Sig_b)=MED_z; %logarithmic indexed

    % in baraye halatie ke engar adder accurat e amma inpout klhata dare
     MED_z_accr = EM_med(corr_out_datas(:,indx11), out_datas(:,4), Nonums);
     SigmaToEMz_accr_MED_matrix(Sig_a,Sig_b)=MED_z_accr; %logarithmic indexed

            end
            
 else
     line = fgets(fileID,100);% age chize kharabi bud varesh dare!
 end
 
   %   sigmas = vertcat ( sigmas,sigma);
    sigma_old = sigma;

end

%round akhar

      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s
      
     indx11=indx11+1; %avali ke sefre bezarim injam oke
  
     MED_z = EM_med(corr_out_datas(:,indx11), out_datas(:,3), Nonums);
     SigmaToEMz_MED_matrix(Sig_a,Sig_b)=MED_z; %logarithmic indexed

    % in baraye halatie ke engar adder accurat e amma inpout klhata dare
     MED_z_accr = EM_med(corr_out_datas(:,indx11), out_datas(:,4), Nonums);
     SigmaToEMz_accr_MED_matrix(Sig_a,Sig_b)=MED_z_accr; %logarithmic indexed


end


fclose(fileID);

save (strcat(path1,'/params_dataCalc_reg.mat'));
save ('~/params.mat','-append');













