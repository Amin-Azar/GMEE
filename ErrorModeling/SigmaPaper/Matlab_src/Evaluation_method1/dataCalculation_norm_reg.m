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
index_matrix=1;
i=1;
indx11=1;
notfirstRound=0;
indx_array=0;
% MED calc
MED_z=0;
SigmaToEMz_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
SigmaToEMz_accr_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
out_data=zeros(1,4);
out_datas=zeros(Nonums,4);
rst=1;

sum_Apprx_datas2=zeros(Nonums,1); 

coefs= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
coefs_total= zeros(bits,1); 

%Sig reading
sigma_old=zeros(1,2);
%sigma_old(1)=2;
%sigma_old(2)=2;
sigma=zeros(1,2);

Matrix_reg_Accur = zeros (up*up,3); % no intrinsic  error
Matrix_reg_Apprx = zeros (up*up,4);
Matrix_reg_Apprx_noZero = zeros (up*up,4);

EMs= zeros (3,1);

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
        indx2=indx2+10 %1K index semicolon nazashtim index beznae bbeinim kojayim asan
 
    end
        
type = fgets(fileID,1);
%display(type);  
 if strcmp(type,'s');
%display('type =s');  
 line = fgets(fileID,102);
 %fprintf('line=%s\n',line); 
 elseif  strcmp(type,'t');
 EMs=fscanf (fileID,' %f %f %f\n'); %EM_a EM_b EM _in
EMs=transpose(EMs);
 elseif  strcmp(type,'d');
%         display('type = d');
 out_data_1=fscanf (fileID,' %d %d %d %d\n'); %a_d,a_h,b_d,b_h,appx_d,appx_h,accr_d,accr_h   d(%h) %d(%h) %d(%h) %d(%h)'
 out_data= transpose(out_data_1);
 
 
 if ( rst >0) % yani yek e
     indx_array =1;
     out_datas = out_data; %index 1 ro mizarim inja
     rst =0;
     coefs= zeros(bits,1);
 else
indx_array = indx_array +1;
     out_datas(indx_array,:) = out_data; % dafe dovome az index 2 ham injaro por mikonim
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
     
      size1= size(corr_out_datas);
      size1=size1(1);
      size2=size(out_datas);
      size2=size2(1);

      if (size1 == size2)
     MED_z = EM_med(corr_out_datas(:,indx11), out_datas(:,3), Nonums);
     SigmaToEMz_MED_matrix(Sig_a,Sig_b)=MED_z; %logarithmic indexed

    % in baraye halatie ke engar adder accurat e amma inpout klhata dare
     MED_z_accr = EM_med(corr_out_datas(:,indx11), out_datas(:,4), Nonums);
     SigmaToEMz_accr_MED_matrix(Sig_a,Sig_b)=MED_z_accr; %logarithmic indexed
     
     sum_Apprx2=out_datas(:,3);
     sum_Apprx_datas2 = horzcat(sum_Apprx_datas2,sum_Apprx2);% data khoruji doroste bedune khataye input
     
     Matrix_reg_Accur(indx11,[1 2])=EMs(1,[1 2]);
     Matrix_reg_Accur(indx11,3)=MED_z_accr;
     
     Matrix_reg_Apprx(indx11,[1 2 3])=EMs;
     Matrix_reg_Apprx(indx11,4)=MED_z;
      else
          display(size2);
      end
     
            end
            
 else
     line = fgets(fileID,101);% age chize kharabi bud varesh dare!
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
     
     sum_Apprx2=out_datas(:,3);
     sum_Apprx_datas2 = horzcat(sum_Apprx_datas2,sum_Apprx2);% data khoruji doroste bedune khataye input
     
    % in baraye halatie ke engar adder accurat e amma inpout klhata dare
     MED_z_accr = EM_med(corr_out_datas(:,indx11), out_datas(:,4), Nonums);
     SigmaToEMz_accr_MED_matrix(Sig_a,Sig_b)=MED_z_accr; %logarithmic indexed

     Matrix_reg_Apprx(indx11,[1 2 3])=EMs;
     Matrix_reg_Apprx(indx11,4)=MED_z_accr;
     
     
     
end


for i= 1:up*up
    if(Matrix_reg_Apprx(i,1) ~= 0)
    Matrix_reg_Apprx_noZero(index_matrix,:) = Matrix_reg_Apprx(i,:);
    index_matrix = index_matrix+1;
    end
end


fclose(fileID);

save (strcat(path1,'/params_dataCalc_reg.mat'));
%save ('~/params.mat','-append');
save ('~/params.mat');  












