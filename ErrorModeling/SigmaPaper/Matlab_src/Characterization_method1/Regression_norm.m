%{
%intitalization
%Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
%Nonums = 7000; % 5-7K samples for better sigma evaluation in matlab
up =3; % 10*10 ro nega kone vase regression
bits=32; % bara 32 biti
bias =0;
%}



load ('~/params.mat');
Matrix_reg = zeros (up*up,4);
Matrix_reg_ETAIIM = zeros (up*up,4);

for S_a = 1:up
    for S_b = 1:up
        
     %   display(S_a);
     %  display(S_b);
Matrix_reg((S_a-1)*up+S_b,3) = SigmaToEMz_accr_MED_matrix(S_a,S_b);
%Matrix_reg((S_a-1)*up+S_b,3) =0;
Matrix_reg((S_a-1)*up+S_b,2) =SigmaToEMb_MED_matrix(S_a,S_b);
Matrix_reg((S_a-1)*up+S_b,1) =SigmaToEMa_MED_matrix(S_a,S_b);

Matrix_reg_ETAIIM((S_a-1)*up+S_b,4) = SigmaToEMz_MED_matrix(S_a,S_b);
Matrix_reg_ETAIIM((S_a-1)*up+S_b,3) =SigmaToEMin_MED_matrix(S_a,S_b);
Matrix_reg_ETAIIM((S_a-1)*up+S_b,2) =SigmaToEMb_MED_matrix(S_a,S_b);
Matrix_reg_ETAIIM((S_a-1)*up+S_b,1) =SigmaToEMa_MED_matrix(S_a,S_b);

    end
end


tbl1 = table(Matrix_reg(:,1),Matrix_reg(:,2),Matrix_reg(:,3),'VariableNames',{'EM_A','EM_B','EM_Z'});
fitlm(tbl1,'EM_Z~EM_A+EM_B')
tbl4 = table(Matrix_reg(:,1)+Matrix_reg(:,2),Matrix_reg(:,3),'VariableNames',{'EM_A_EM_B','EM_Z'});
fitlm(tbl4,'EM_Z~EM_A_EM_B')


tbl2 = table(Matrix_reg_ETAIIM(:,1),Matrix_reg_ETAIIM(:,2),Matrix_reg_ETAIIM(:,3),Matrix_reg_ETAIIM(:,4),'VariableNames',{'EM_A','EM_B','EM_in','EM_Z'});
fitlm(tbl2,'EM_Z~EM_A+EM_B+EM_in')

tbl3 = table(Matrix_reg_ETAIIM(:,1)+Matrix_reg_ETAIIM(:,2),Matrix_reg_ETAIIM(:,3),Matrix_reg_ETAIIM(:,4),'VariableNames',{'EM_A_EM_B','EM_in','EM_Z'});
fitlm(tbl3,'EM_Z~(EM_A_EM_B)+EM_in')


save (strcat(path1,'/params_Reggression.mat'));
save (strcat(path1,'/params.mat'));
save ('~/params.mat','-append');
