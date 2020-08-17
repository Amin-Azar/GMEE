function [ GMM_sum_appx_tot, lookuptable ] = lookupAppxGMM( table, GMM_sum_conv_in )
%LOOKUPAPPXGMM Summary of this function goes here
%   Detailed explanation goes here

%initialize
GMM_sum_appx = zeros(3,1);
GMM_sum_appx_tot = zeros(3,1);
s2= size(table);
s2 = s2(3:4);
lookuptable = zeros(s2);
itt = numsamples(GMM_sum_conv_in);
for j=1:itt

miu_conv_tmp = GMM_sum_conv_in(1,j);
sigma_conv_tmp = GMM_sum_conv_in(2,j);
por_conv_tmp = GMM_sum_conv_in(3,j);

%MIU
miu_exp = round(log2(abs(miu_conv_tmp)));
if (miu_conv_tmp < 0)
    miu_exp = -miu_exp;
elseif (miu_exp == 0)
    miu_exp = 0;
end
%SIGMA
sigma_exp = round(log2(abs(sigma_conv_tmp)));

indx_miu = 33+ (miu_exp);
indx_sig = sigma_exp;
GMM_sum_appx_tmp = table(:,:,indx_miu,indx_sig);
lookuptable(indx_miu,indx_sig) =1;
%%
%age sefr bashe hazf mikonim az array
for i=1:numsamples(GMM_sum_appx_tmp)
    if (GMM_sum_appx_tmp(3,i) ~= 0 )
        
        GMM_sum_appx = horzcat( GMM_sum_appx , GMM_sum_appx_tmp(:,i));
    end
end

GMM_sum_appx = GMM_sum_appx(:,2:end);
GMM_sum_appx(3,:) = GMM_sum_appx(3,:)* por_conv_tmp;

%%
% final response
if ( sum(GMM_sum_appx(3,:)) == 0)
    GMM_sum_appx_tot = horzcat( GMM_sum_appx_tot , GMM_sum_appx);
end
GMM_sum_appx_tot = GMM_sum_appx_tot(:,2:end);

end
end

