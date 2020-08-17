
load ('~/params.mat');
out_data= regressFunc(0.034471,0.98704,0.32482,Matrix_reg_Apprx_noZero);
target_data=Matrix_reg_Apprx_noZero(:,4);
plotregression(out_data,target_data,'Regression')