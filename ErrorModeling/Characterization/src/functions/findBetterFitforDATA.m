
%%

% in ja say kardim yeseri chiza ezafe konim ke fit haye behtari vas HD
% peyda konim vali didim HD CHERT BUDE
% index ke az 1-343 ta halate mokhtalefe miu o sigma darim - badtarin 254
% bude ! ba bin ina bazi kardim

%test_itteration = 10

for test_itteration = 161:1:161 %1:20:300

%%


DC1_file_1itt(:,4) = DC1_DATA_out_sum_accr_vec(:,test_itteration);
DC1_file_1itt(:,3) = DC1_DATA_out_sum_appx_vec(:,test_itteration);



    %% fit matrix
    DC1_std_sum_accr=std(DC1_file_1itt(:,4)); %std BIKHATA chie
    DC1_miu_sum_accr = mean(DC1_file_1itt(:,4));
    DC1_std_sum_accr_log = round(log2(DC1_std_sum_accr));
    DC1_miu_sum_accr_log = round(log2(abs(DC1_miu_sum_accr)));
    
    if (DC1_miu_sum_accr < 0)
        DC1_miu_sum_accr_log = -1 * DC1_miu_sum_accr_log;
    end

DC1_hist_x_range = max(DC1_file_1itt(:,3)) - min(DC1_file_1itt(:,3)) +1;

% mige ke bin hayi ke gharare peyda kone 1,10,20,30, 40, ... bashe
DC1_sclng_fac = 10;
DC1_samples_covrg_worst = 0.8;
DC1_smpl_per_bin=30;

DC1_bin=round ( (DC1_hist_x_range / ((INT_sample_cnt* DC1_samples_covrg_worst)/DC1_smpl_per_bin))/DC1_sclng_fac )*DC1_sclng_fac;
if ( DC1_bin<1 )
    DC1_bin=1;
end

for DC1_bin = [1 10 100 1000]

% DC1_bin = 200;   
[test_l test_pmf] = convertToPMF2 ( DC1_file_1itt(:,3),DC1_bin);%plot(test_l,test_pmf)

%[test_l test_pmf] = convertToPMF(DC1_file_1itt(:,3));


DC1_min_mins = min (test_l);DC1_max_maxs = max (test_l);
[test_rl test_rpmf] = convertToRangePMF2(test_l,test_pmf,DC1_min_mins,DC1_max_maxs);%plot(test_rl, test_rpmf)
xlim([-0.1 0.1]*10^5)

DC1_fit_loop_cnt=0;
% make sure HD is less than threshold but repeat until it is
% allowed
DC1_HD_GMEE_appx = 1;
DC1_add_num_GMM = 0;
DC1_find_best_GMM = 0 ;

while (DC1_HD_GMEE_appx > DC1_HD_th && DC1_fit_loop_cnt < DC1_HD_tries )
%    fprintf('[');
    
    
    % repeat untill get converged results
    DC1_cnvrgd_flag =0;
    
    while ( DC1_cnvrgd_flag < 1 && DC1_fit_loop_cnt < DC1_cnvrged_maxtry)
        if ( mod(DC1_fit_loop_cnt,20) ==0)
%            fprintf('%s..',num2str(DC1_fit_loop_cnt));
        end
%        fprintf('<');
        DC1_fit_loop_cnt = DC1_fit_loop_cnt+1;
        DC1_GMMs_cnt = DC1_num_GMM + DC1_add_num_GMM;
        [DC1_GMM_sum_appx_tmp, DC1_cnvrgd_flag, DC1_fit_NLL_tmp ] = findDist(DC1_file_1itt(:,3),DC1_GMMs_cnt ,DC1_fit_maxIter);
%        fprintf('%d',DC1_cnvrgd_flag);
    end
    
    %age valid e DATA va nazdiktaram has be data, zakhire kon
    if (DC1_cnvrgd_flag == 1)
        
        %fitted PMF
        [DC1_rl_GMEE_1  DC1_rpmf_GMEE_1]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp,DC1_min_mins,DC1_max_maxs);%GMEE
        DC1_HD_GMEE_appx_tmp = HellingerDistance(test_rpmf , DC1_rpmf_GMEE_1);
        fprintf('|%2.0f',100*DC1_HD_GMEE_appx_tmp);
        
        if(DC1_HD_GMEE_appx_tmp < DC1_HD_GMEE_appx)
 %           fprintf('*');
            DC1_GMM_sum_appx = DC1_GMM_sum_appx_tmp;
            DC1_HD_GMEE_appx = DC1_HD_GMEE_appx_tmp;
            DC1_fit_slct_cnt = DC1_fit_loop_cnt;
            DC1_fit_AIC = DC1_fit_NLL_tmp;
        end
%        fprintf('>');
    end
%    fprintf(']');
    
%    if ( DC1_find_best_GMM == 1 && DC1_add_num_GMM < DC1_max_GMM)
%        DC1_add_num_GMM = DC1_add_num_GMM +1;
%    end
end

%{
fprintf('\n');
DC1_disp = ['#tries to fit=',num2str(DC1_fit_loop_cnt),', Best one was #',num2str(DC1_fit_slct_cnt)];
disp(DC1_disp);

DC1_disp = ['#HD of fit=',num2str(DC1_HD_GMEE_appx), ' Using ',num2str(DC1_GMMs_cnt),'components - #AIC of fit=',num2str(DC1_fit_AIC)];
disp(DC1_disp);

DC1_disp = ['IN: <Sig1,Miu1>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in1_exp),'> , <Sig2,Miu2>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in2_exp),'>'];
    disp(DC1_disp);
    
    DC1_smtsmw_indx_sig = round(log2(DC1_std_sum_accr));
    DC1_smtsmw_indx_miu = 1-DC1_miu_sum_out_min_exp + DC1_miu_sum_accr_log; % shift midim ta index manfi ya mosbat az 1+0 shour she. yani 1-66 beshe. bad
    DC1_disp = ['smtsmw_indx: <Sigma_o,',num2str(1- DC1_miu_sum_out_min_exp),'+Miu_o>=<',num2str(DC1_smtsmw_indx_sig), ',', num2str(DC1_smtsmw_indx_miu),'>'];
    disp(DC1_disp);
    %store in matrix dg
    [DC1_GMM_x DC1_GMM_y] =  size(DC1_GMM_sum_appx)
%}

  figure  
%  %plot(test_rl, test_rpmf)
  title(num2str(DC1_HD_GMEE_appx));
  scatter(test_rl, test_rpmf,12,'.')
  hold on 
  plot(DC1_rl_GMEE_1,  DC1_rpmf_GMEE_1, 'color','red')
  title(['HD=',num2str(DC1_HD_GMEE_appx), ' - bin=',num2str(DC1_bin)]);
  xlim([-0.1 0.1]*10^5)

end

%%
%DC1_GMM_sum_appx
