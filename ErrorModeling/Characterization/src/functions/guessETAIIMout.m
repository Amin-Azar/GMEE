function [ GMMs,indx1, out_appx_guess,NOsamples ] = guessETAIIMout( IN1_GMM, IN2_GMM)
%GUESSETAIIMOUT Summary of this function goes here
%   Detailed explanation goes here


NOsamples = 10000;
DC1_cnvrged_maxtry = 500;
DC1_GMMs_cnt = 5 ;
DC1_fit_maxIter = 500;

in1m = IN1_GMM(1);
in1s = IN1_GMM(2);
in1w = IN1_GMM(3);

in2m = IN2_GMM(1);
in2s = IN2_GMM(2);
in2w = IN2_GMM(3);

in1_guess = round(normrnd(in1m,in1s, [NOsamples 1]));
in2_guess = round(normrnd(in2m,in2s, [NOsamples 1]));

%correct_add = in1_guess + in2_guess;


% ya miangin az 2* bar kuchiktar az miu daghigh bashe ke beshe khata! ya khode miangin
% birun e nemudar e daghigh bashe dge!

mn1 = in1m + in2m;

mn1_uptobit = round(log2 (abs(mn1+1)));
mn1_upto = -2^(mn1_uptobit+4);
 if( abs(mn1_upto) < 255)
     mn1_upto = -255;
 end

%min1 = min(in1_guess) + min(in2_guess);
min1 = (in1m+in2m)-3*sqrt(in1s^2 + in2s^2); % math bud ke kho kamtar
%nehsun mide


out_appx_guess = ETAIIM32_vec(in1_guess,in2_guess);

% repeat untill get converged results
DC1_cnvrgd_flag =0;
%fitting loops
DC1_fit_loop_cnt=0;

while ( DC1_cnvrgd_flag < 1 && DC1_fit_loop_cnt < DC1_cnvrged_maxtry)
    if ( mod(DC1_fit_loop_cnt,20) ==0)
        fprintf('%s..',num2str(DC1_fit_loop_cnt));
    end
    fprintf('<');
    DC1_fit_loop_cnt = DC1_fit_loop_cnt+1;
    
    [DC1_GMM_sum_appx_tmp, DC1_cnvrgd_flag, DC1_fit_NLL_tmp ] = findDist(out_appx_guess,DC1_GMMs_cnt ,DC1_fit_maxIter);
end



GMMs_mus = DC1_GMM_sum_appx_tmp(1,:);

indx1 = 0 | (GMMs_mus<min1);
%{
indx2 = logical(abs(indx1 -1));

GMMs_ERR = DC1_GMM_sum_appx_tmp(:, indx1);
GMMs_CRR = DC1_GMM_sum_appx_tmp(:, indx2);

%plot correct and err parts
% vase baze haye bozorg asan be dard nakhore chon 10K kame vase model kardaneshun %histDATA(out_appx_guess);
figure('units','normalized','outerposition',[0 0 1 1])
plotGMMs([in1m+in2m;sqrt(in1s^2 + in2s^2);1],out_appx_guess,'blue');
hold on;
plotGMMs(GMMs_ERR,out_appx_guess,'red');
hold on;
plotGMMs(GMMs_CRR,out_appx_guess,'green');
title('Blue: actual ADD - Green: correct part - Red: error part');

figure;histDATA(out_appx_guess - correct_add,1,1);

%}
GMMs =  DC1_GMM_sum_appx_tmp;

end

 