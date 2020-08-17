function [ func_EM ] = func_Err_SNR( D_apprx, D_accur )
%DC1_ERR_MSE Summary of this function goes here
%   Detailed explanation goes here

func_msa = func_Err_MSA (D_accur);
func_mse = func_Err_MSE (D_apprx, D_accur);
func_EM = (func_msa ./ func_mse );
end

