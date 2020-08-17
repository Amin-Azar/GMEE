function [ func_EM ] = func_Err_PSNR( D_apprx, D_accur )
%DC1_ERR_MSE Summary of this function goes here
%   Detailed explanation goes here
func_mse = func_Err_MSE(D_apprx, D_accur );
func_EM = ((mean(D_accur) + 3* std(D_accur)).^2 ./ func_mse);%( (2^(INT_HWS_bits-1)).^2 ./ MSE_step1); % maximum possible value 
end

