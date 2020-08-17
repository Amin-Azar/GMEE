function [ out_data ] = regressFunc( a,b,c,Matrix_reg_Apprx_noZero )
%REGRESSFUNC Summary of this function goes here
%   Detailed explanation goes here
out_data= a*(Matrix_reg_Apprx_noZero(:,1)+Matrix_reg_Apprx_noZero(:,2))+b*Matrix_reg_Apprx_noZero(:,3)+c;


end

