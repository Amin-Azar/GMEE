

figure

bar(rl_apprx_1, rpmf_apprx_1,'g','edgecolor','g')
hold on 
plot(rl_apprx_MIA_1, rpmf_apprx_MIA_1,'r')

figure

% shuffle first arrray to have new data with same rang o same hist
M2_datas_1 = out_datas_appx(:,1);
num_el  = numel(M2_datas_1);
shuf_indx = randperm(num_el);
M2_datas_2 = M2_datas_1 ( shuf_indx);

% to make this -> accur_conv = conv(rpmf_apprx_1,rpmf_apprx_1);
M2_datas_out = M2_datas_1 + M2_datas_2;
[M2_l_datas_out, M2_pmf_datas_out] = convertToPMF(M2_datas_out);
min1 = min(M2_l_datas_out);
max1 = max(M2_l_datas_out)
[M2_l_datas_out, M2_pmf_datas_out] = convertToRangePMF(M2_l_datas_out, M2_pmf_datas_out,min1,max1,10); % binned them 10 by 10

rpmf_apprx_MIA_2 = rpmf_apprx_MIA_1; % cause assuming same datas but shuffled ke avaz nemikone hist ro
MIA_conv = conv(rpmf_apprx_MIA_1,rpmf_apprx_MIA_2);


bar(M2_l_datas_out,M2_pmf_datas_out)
hold on
plot(MIA_conv,'r')