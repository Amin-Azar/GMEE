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
indx1 =0; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
i=1;


coefs_total_a= zeros(bits,1); 
coefs_total_b= zeros(bits,1);
coefs_total_z_accr= zeros(bits,1); 
notfirstRound=0;

out_data=zeros(1,4);
out_datas=zeros(1,4);
corr_out_datas=zeros(Nonums,1); % in hamunie ke mikhaym dade haye dorosto tush berizim vase MSE out hesab kardan

coefs= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)


%Sig reading
sigma_old=2*ones(1,2);
%sigma_old(1)=2;
%sigma_old(2)=2;
sigma=2*ones(1,2);
sigmas=ones(1,2);
%sigma(1)=2;
%sigma(2)=2;

SigmaToEMa_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
SigmaToEMb_MED_matrix=zeros(Sigma_itt+bias,Sigma_itt);
%SigmaToEMz_accr_MED_matrix2=zeros(Sigma_itt+bias,Sigma_itt);

Regression=zeros(4, 1);Regression_Coefs=zeros(4, 1);
%file open
%fileID = fopen('${HOME_DIR}/approxiSynthesys/benchmarks/custom/RCA/out_ETAIIM32_Matlab.txt','r');
fileID = fopen(strcat(path1,'/out_ETAIIM32_Matlab.txt'),'r');


fileID2 = fopen(strcat(path1,'/in_data_reg.txt'),'w');
fprintf(fileID2,'s%12s %12s %12s %12s \ns\n','A_err','B_err', 'A.+B. ', 'A.*B. ');

%code starts here

while ~feof(fileID)
    indx1= indx1+1;
    %{
    if(indx1==Nonums);
        indx1=1;
        indx2=indx2+7; %1K index semicolon nazashtim index beznae bbeinim kojayim asan
  
    end
  %}      
type = fgets(fileID,1);

 if strcmp(type,'s');
 
 % display('type =s');  
line = fgets(fileID,101);
%fprintf(fileID2,'s%s\n',line); 
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
      
      
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a_original=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b_original=log2(sigma_old(2));%logarthmic Sig_i s
      skip=1;
      
      if(notfirstRound)
 %     if(Sig_a<30)%&&(Sig_b<6) % tedad halataye mokhtalef e sigma ke mikhaym regression konim bash
% age mikhaym kamtar ejra she ino maslan mikonim kamtar az 5. 30 gozashtam
% ke hamash ejra she

    
errrand_A =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
errrand_B =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));

A_err = out_datas(:,1)+ errrand_A;
B_err = out_datas(:,2)+ errrand_B;

std_A_err=std(A_err);
std_B_err=std(B_err);
%injam roundesh konim
std_A_err=round(log2(std_A_err));
std_B_err=round(log2(std_B_err));




%inja az sigmahaye vorudi haye khatadar darim estefade mikonim
Sig_a=std_A_err;
Sig_b=std_B_err;

 if(Sig_a >=1 ) && (Sig_b >= 1) && (Sig_a <= Sigma_itt) && (Sig_b <= Sigma_itt) % index out of bound nazanim

EM_a = EM_med( out_datas(:,1) , A_err, Nonums );
EM_b = EM_med( out_datas(:,2) , B_err, Nonums );

%EM_z_accr = EM_med(out_datas(:,3)  , (B_err+A_err), Nonums );



SigmaToEMa_MED_matrix(Sig_a,Sig_b)=EM_a;
SigmaToEMb_MED_matrix(Sig_a,Sig_b)=EM_b;



corr_out_datas = horzcat(corr_out_datas,out_datas(:,4));% data khoruji doroste bedune khataye input

 %Sigma prints
 fprintf(fileID2,'s%12d %12d S_orig\n',2^Sig_a_original,2^Sig_b_original');
fprintf(fileID2,'p%12d %12d\n',2^Sig_a,2^Sig_b); % ba ina sakhtim vali badia darumade
fprintf(fileID2,'s%12s %12s %12s\n','EM_a','EM_b','EM_in');
fprintf(fileID2,'t%12f %12f %12f\n',EM_a,EM_b,SigmaToEMin_MED_matrix(Sig_a,Sig_b)); % EMa EMb EMin

for i = 1:Nonums
fprintf(fileID2,'d%12d %12d %12d %12d\n',A_err(i),B_err(i),A_err(i)+B_err(i),A_err(i)*B_err(i));
end
 
       else
          display('Sigma out of bound'); display(Sig_a); display(Sig_b);
      end 
      
 sigma_old = sigma;
      end
      notfirstRound=1;
      
else
     
     line = fgets(fileID,101);
     %display(line);
      
      
 end


end

%for the very last one:

    
      
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a_original=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b_original=log2(sigma_old(2));%logarthmic Sig_i s
      skip=1;


 errrand_A =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));
errrand_B =round( normrnd(0, 2^(randi(5)) , [Nonums 1]));

A_err = out_datas(:,1)+ errrand_A;
B_err = out_datas(:,2)+ errrand_B;

std_A_err=std(A_err);
std_B_err=std(B_err);
%injam roundesh konim
std_A_err=round(log2(std_A_err));
std_B_err=round(log2(std_B_err));


%inja az sigmahaye vorudi haye khatadar darim estefade mikonim
Sig_a=std_A_err;
Sig_b=std_B_err;

 if(Sig_a >=1 ) && (Sig_b >= 1) && (Sig_a <= Sigma_itt) && (Sig_b <= Sigma_itt) % index out of bound nazanim

EM_a = EM_med( out_datas(:,1) , A_err, Nonums );
EM_b = EM_med( out_datas(:,2) , B_err, Nonums );

%EM_z_accr = EM_med(out_datas(:,3)  , (B_err+A_err), Nonums );



SigmaToEMa_MED_matrix(Sig_a,Sig_b)=EM_a;
SigmaToEMb_MED_matrix(Sig_a,Sig_b)=EM_b;


%SigmaToEMz_accr_MED_matrix2(Sig_a,Sig_b)=EM_z_accr;

corr_out_datas = horzcat(corr_out_datas,out_datas(:,4));% data khoruji doroste bedune khataye input

 %Sigma prints 
fprintf(fileID2,'s%12d %12d S_orig\n',2^Sig_a_original,2^Sig_b_original');
fprintf(fileID2,'p%12d %12d\n',2^Sig_a,2^Sig_b); % ba ina sakhtim vali badia darumade
fprintf(fileID2,'s%12s %12s %12s\n','EM_a','EM_b','EM_in');
fprintf(fileID2,'t %12d %12d %12d\n',EM_a,EM_b,SigmaToEMin_MED_matrix(Sig_a,Sig_b)); % EMa EMb EMin

for i = 1:Nonums
    fprintf(fileID2,'d%12d %12d %12d %12d\n',A_err(i),B_err(i),A_err(i)+B_err(i),A_err(i)*B_err(i));

end
 
      end


save (strcat(path1,'/params_dataReg.mat'));
save ('~/params.mat','-append');















