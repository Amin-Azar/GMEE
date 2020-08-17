%load('~/macc.mat');
fileID2 = fopen(strcat(path1,'/out_ETAIIM32_Matlab.txt'),'r');

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
      
    S1_ZA2 = round(log2(std(ZA1)));
    S2_ZA2 = round(log2(std(ZM3)));
    
 ZA2_Apprx = out_datas(:,3);
    std_ZA2_Apprx=std(ZA2_Apprx); %std khata dar chie
     EM_ZA2_Apprx = EM_med(out_datas(:,4) ,ZA2_Apprx, Nonums);
     EM_ZA2_prop =  SigmaToEMin_MED_matrix(S1_ZA2,S2_ZA2);
    
end

fclose(fileID2);

%save('~/macc.mat');