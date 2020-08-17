%{
%intitalization
%Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
%Nonums = 7000; % 5-7K samples for better sigma evaluation in matlab
up =3; % 10*10 ro nega kone vase regression
bits=32; % bara 32 biti
bias =0;
%}



load ('~/params.mat');

%{
Matrix_reg_Accur = zeros (up*up,3); % no intrinsic  error
Matrix_reg_Apprx = zeros (up*up,4);
Matrix_reg_Apprx_noZero = zeros (1,4);

for S_a = 1:up
    for S_b = 1:up
        
     %   display(S_a);
     %  display(S_b);
     
Matrix_reg_Accur((S_a-1)*up+S_b,3) = SigmaToEMz_accr_MED_matrix(S_a,S_b);
Matrix_reg_Accur((S_a-1)*up+S_b,2) =SigmaToEMb_MED_matrix(S_a,S_b);
Matrix_reg_Accur((S_a-1)*up+S_b,1) =SigmaToEMa_MED_matrix(S_a,S_b);

Matrix_reg_Apprx((S_a-1)*up+S_b,4) = SigmaToEMz_MED_matrix(S_a,S_b);
Matrix_reg_Apprx((S_a-1)*up+S_b,3) =SigmaToEMin_MED_matrix(S_a,S_b);
Matrix_reg_Apprx((S_a-1)*up+S_b,2) =SigmaToEMb_MED_matrix(S_a,S_b);
Matrix_reg_Apprx((S_a-1)*up+S_b,1) =SigmaToEMa_MED_matrix(S_a,S_b);

    end
end

for i= 1:up*up
    if(Matrix_reg_Apprx(i,1) ~= 0)
    Matrix_reg_Apprx_noZero =  vertcat(Matrix_reg_Apprx_noZero, Matrix_reg_Apprx(i,:));
    end
end
%}

tbl1 = table(Matrix_reg_Accur(:,1),Matrix_reg_Accur(:,2),Matrix_reg_Accur(:,3),'VariableNames',{'EM_A','EM_B','EM_Z'});
fitlm(tbl1,'EM_Z~EM_A+EM_B')
tbl4 = table(Matrix_reg_Accur(:,1)+Matrix_reg_Accur(:,2),Matrix_reg_Accur(:,3),'VariableNames',{'EM_A_EM_B','EM_Z'});
fitlm(tbl4,'EM_Z~EM_A_EM_B')


tbl2 = table(Matrix_reg_Apprx(:,1),Matrix_reg_Apprx(:,2),Matrix_reg_Apprx(:,3),Matrix_reg_Apprx(:,4),'VariableNames',{'EM_A','EM_B','EM_in','EM_Z'});
fitlm(tbl2,'EM_Z~EM_A+EM_B+EM_in')

tbl3 = table(Matrix_reg_Apprx(:,1)+Matrix_reg_Apprx(:,2),Matrix_reg_Apprx(:,3),Matrix_reg_Apprx(:,4),'VariableNames',{'EM_A_EM_B','EM_in','EM_Z'});
fitlm(tbl3,'EM_Z~(EM_A_EM_B)+EM_in')


%save (strcat(path1,'/params_Reggression.mat'));
save (strcat(path1,'/params.mat'));

