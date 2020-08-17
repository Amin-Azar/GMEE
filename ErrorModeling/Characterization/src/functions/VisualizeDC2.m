


j=254;

xlm = [min(DC2_DATA_out_sum_appx_inAP_vec(:,j)),max(DC2_DATA_out_sum_appx_inAP_vec(:,j))];

%Approximate additiion
figure
subplot(3,2,6);
histDATA(DC2_DATA_out_sum_appx_inAP_vec(:,j),1)
xlim(xlm);

%hist IN1 - plot fitted gaussians
subplot(3,2,1);
histDATA(DC2_DATA_in1_vec(:,j),1);
xlim(xlm);
[DC1_GMM_sum_appx_tmp1, DC1_cnvrgd_flag, DC1_fit_NLL_tmp1 ] = findDist( DC2_DATA_in1_vec(:,j),5 ,500);
[DC1_rl_GMEE_1  DC1_rpmf_GMEE_1]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp1,xlm(1),xlm(2));
hold on
plot(DC1_rl_GMEE_1, DC1_rpmf_GMEE_1,'color','red')

%hist IN2 - plot fitted gaussian
subplot(3,2,3);
histDATA(DC2_DATA_in2_vec(:,j),1);
xlim(xlm);
[DC1_GMM_sum_appx_tmp2, DC1_cnvrgd_flag, DC1_fit_NLL_tmp2 ] = findDist( DC2_DATA_in2_vec(:,j),1 ,500);
[DC1_rl_GMEE_2  DC1_rpmf_GMEE_2]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp2,xlm(1),xlm(2));
hold on
plot(DC1_rl_GMEE_2, DC1_rpmf_GMEE_2,'color','red')

%accurate adiition
subplot(3,2,5);
histDATA(DC2_DATA_in1_vec(:,j)+DC2_DATA_in2_vec(:,j),1)
xlim(xlm);

%conv
subplot(3,2,2);
xlim(xlm);
DC1_GMM_sum_appx_tmp3 = convolveGMMs(DC1_GMM_sum_appx_tmp1,DC1_GMM_sum_appx_tmp2);
[DC1_rl_GMEE_3  DC1_rpmf_GMEE_3]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp3,xlm(1),xlm(2));
hold on
plot(DC1_rl_GMEE_3, DC1_rpmf_GMEE_3,'color','red')
