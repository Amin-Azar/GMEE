function [ func_EM ] = func_Err_MSA( D_accur )
%DC1_ERR_ Summary of this function goes here
%   Detailed explanation goes here

func_EM = mean(D_accur.^2);
end

