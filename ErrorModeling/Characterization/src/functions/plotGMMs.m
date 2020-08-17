function [ output_args ] = plotGMMs( DC1_GMM_sum_appx_tmp,out_guess,color )
%PLOTGMMS Summary of this function goes here
%   plot first many GMMs regarding min and max of DATA which is in 2nd in
% calculates completely but plots with 100K points for convinience


if nargin < 3
    color = 'red';
end

[DC1_rl_GMEE_3  DC1_rpmf_GMEE_3]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp,min(min(out_guess)),max(max(out_guess)));

step = round(numel(DC1_rl_GMEE_3) / 100000);
if (step <2)
    step =1;
end
plot(DC1_rl_GMEE_3(1:step:end), DC1_rpmf_GMEE_3(1:step:end),'color',color);%set(gca,'XScale','log');


end

