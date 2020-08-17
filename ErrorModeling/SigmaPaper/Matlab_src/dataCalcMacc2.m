%load('~/macc.mat');


indx1 =1; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
indx2=1; 
indx3=0; % index e array haye std ke tu har p mikhunim
i=1;

notfirstRound=0;

% MED calc
MED_in=0;
out_data=zeros(1,4);
out_datas=zeros(1,4);

coefs= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
coefs_total= zeros(bits,1); 

%Sig reading
sigma_old=zeros(1,2);
%sigma_old(1)=2;
%sigma_old(2)=2;
sigma=zeros(1,2);


fileID2 = fopen(strcat(path1,'/out_ETAIIM32_Matlab.txt'),'r');

if 1
while ~feof(fileID2)
    indx1= indx1+1;
    if(indx1==Nonums);
        indx1=1;
        indx2=indx2+7 %1K index semicolon nazashtim index beznae bbeinim kojayim asan
        
        
    %indx3=indx3+1;
    end
        
type = fgets(fileID2,1);

 if strcmp(type,'s');
 % display('type =s');  
 line = fgets(fileID2,101);
 %fprintf('line=%s\n',line); 
 elseif  strcmp(type,'d');
        %  display('type = d');
 out_data_1=fscanf (fileID2,' %d %d %d %d\n'); %a_d,a_h,b_d,b_h,appx_d,appx_h,accr_d,accr_h   d(%h) %d(%h) %d(%h) %d(%h)'
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
      
      sigma_1=fscanf (fileID2,' %d %d\n');%sigmaharo az tu file mikhunim
      sigma(1)=sigma_1(1); sigma(2)=sigma_1(2); % row be column e sh fargh dare chonle
      %{
      if(sigma_old(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
          
      disp(sigma_old);%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s

      
     %{
 Sigma 
     %}
 
      %sigma to Sigma approximate
     std_Sum_apprx=std(out_datas(:,3)); %std khata dar chie
     EM_in = EM_med(out_datas(:,4) ,out_datas(:,3), Nonums);

     

 end
      %}  
     %coefs_total = horzcat(coefs_total,coefs); % vase inke bebinim kolan khataha koja ha bude X*Y = runhayeMokhtalef * 2^adadeKhata
 else
 line = fgets(fileID2,101)
 %display(line);
 end
   %   sigmas = vertcat ( sigmas,sigma);
    sigma_old = sigma;


    %     display('File format error!!');
    indx3= indx3+1;
end



%end of file for the last one dgE!
      
      disp(sigma_old)%actuall 2^Sig_i values
      Sig_a=log2(sigma_old(1)); %logarthmic Sig_i s
      Sig_b=log2(sigma_old(2));%logarthmic Sig_i s
      

     std_ZA3_Apprx=std(out_datas(:,3)); %std khata dar chie
     ZA3_Apprx = out_datas(:,3);
     EM_ZA3_Apprx = EM_med(ZA2+ZM4 ,ZA3_Apprx, Nonums);
 
end


out2_apprx=ZA3_Apprx;
EM_total = EM_med(out1_accurate ,out2_apprx, Nonums);


fclose(fileID2);

fprintf('s 1= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',log2(std_A1),log2(std_B1),log2(std_ZM1)); 
fprintf('s 2= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',log2(std_A2),log2(std_B2),log2(std_ZM2)); 
fprintf('s 3= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',log2(std_A3),log2(std_B3),log2(std_ZM3)); 
fprintf('s 4= [ s_A=%10.2f s_B=%10.2f s_Mult=%10.2f ]\n',log2(std_A4),log2(std_B4),log2(std_ZM4)); 
fprintf('s E= [ EM_ZA2_Apprx=%10.2f EM_ZA3_Apprx=%10.2f ]\n',round(EM_ZA2_Apprx),round(EM_ZA3_Apprx)); 
fprintf('s E= [ EM_ZA2_Apprx=%10.2f EM_ZA2_prop=%10.2f ]\n',round(EM_ZA2_Apprx),round(EM_ZA2_prop)); 
fprintf('s E= [ EM_inZA2=%10.2f EM_inZA3=%10.2f ]\n',round(SigmaToEMin_MED_matrix(round(log2(std_ZA1)),round(log2(std_ZM3)))),round(SigmaToEMin_MED_matrix(round(log2(std_ZA2_Apprx)),round(log2(std_ZM4))))); 


fprintf('s A= [ s_ZA1=%10.2f s_ZA2=%10.2f s_ZA3=%10.2f ]\n',log2(std_ZA1),log2(std_ZA2),log2(std_ZA3)); 
fprintf('s A= [ s_ZA1=%10.2f s_ZA2_apprx=%10.2f s_ZA3_apprx=%10.2f ]\n',log2(std_ZA1),log2(std_ZA2_Apprx),log2(std_ZA3_Apprx)); 

fprintf('s O= [ s_out1=%10.2f s_out2=%10.2f ]\n',log2(std(out1_accurate)),log2(std(out2_apprx))); 
fprintf('s E= [ EM_total=%10.2f  ]\n',round(EM_total)); 

S1 = round(log2(std_ZA2_Apprx));
S2 = round(log2(std_ZM4));
EMin = SigmaToEMin_MED_matrix(S1,S2);
EMz= 0.9991*(EM_ZA2_prop)+1.1782*EMin-2448.1;
fprintf('s E= [ EM_propagated=%10.2f  ]\n',round(EMz)); 

%save('~/macc.mat');
