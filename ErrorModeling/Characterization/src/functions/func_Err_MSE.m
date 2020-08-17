function [ func_EM ] = func_Err_MSE( D_apprx, D_accur )
%DC1_ERR_MSE Summary of this function goes here
%   Detailed explanation goes here

func_em = func_Err_AE(D_apprx,D_accur);
func_EM = mean(func_em.^2);
end

