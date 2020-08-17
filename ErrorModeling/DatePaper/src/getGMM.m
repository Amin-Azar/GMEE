function [ pdf_out ] = getGMM( F1_index )
%GETGMM Summary of this function goes here
%   Detailed explanation goes here
load('~/params.mat')

Array = resp_apprx_Array


pdf_out.Mu =Array(1,:,F1_index);
pdf_out.Mu =pdf_out.Mu ( pdf_out.Mu ~= 0);

pdf_out.w =Array(3,:,F1_index);
pdf_out.w =pdf_out.w ( pdf_out.w ~= 0);

size1 = size(pdf_out.w);
pdf_out.Cov = {} ;

for i = 1 : size1(2)
    pdf_out.Cov = horzcat(pdf_out.Cov, (Array(2,i,F1_index))^2); 

  
end

display('estimation');
pdf_out

