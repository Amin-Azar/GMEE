

% Inputs - change right size
M1_appx_datas = out_datas_appx;
M1_accr_datas = out_datas_accr;


%%
M1_appx_datas_MIA = zeros(size(M1_appx_datas));
n = size(M1_appx_datas);
n = n(2);

for M1_cols = 1:n
 
    
%seprate signs
M1_col = M1_appx_datas(:,M1_cols);
M1_col_coef = ones(size(M1_col));
s1 = size(M1_col)
for i= 1: s1(1)
   if M1_col(i,1) <0 
M1_col_coef(i,1) = -1 ;
   end
end

%quantize positive numbers
M1_col = abs(M1_col);
M1_col = log2(M1_col);
M1_col = ceil(M1_col); % ya ham ke ceil
M1_col = 2.^M1_col;
%multiply by their sign
M1_col = M1_col_coef .* M1_col;

M1_appx_datas_MIA(:,M1_cols) = M1_col;

end

out_AE_MIA = M1_appx_datas_MIA -M1_accr_datas;
MSE_step1_MIA = mean (out_AE_MIA.^2);
MSA_step1_MIA = mean (M1_accr_datas.^2);
SNR_step1_MIA = ( MSA_step1_MIA ./ MSE_step1_MIA);
PSNR_step1_MIA =  ( (mean(M1_accr_datas) + 3* std(M1_accr_datas)).^2 ./ MSE_step1_MIA);%( (2^(bits-1)).^2 ./ MSE_step1); % maximum possible value 


size2 = size(out_datas_accr);
size2= size2(2);

MED_step1_MIA = EM_med(M1_accr_datas(:,1),M1_appx_datas_MIA(:,1),Nonums);
for M1_col = 2:size2
med_partial_MIA = EM_med(M1_accr_datas(:,M1_col),M1_appx_datas_MIA(:,M1_col),Nonums);
MED_step1_MIA = horzcat(MED_step1_MIA , med_partial_MIA);
end

%displays
MSE_step1_MIA
SNR_step1_MIA
MED_step1_MIA
PSNR_step1_MIA


%%
% Outputs
out_datas_appx_MIA = M1_appx_datas_MIA;












