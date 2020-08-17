function [ pdf_out ] = getGMM_ref( )
%GETGMM Summary of this function goes here
%   Detailed explanation goes here
load('~/params.mat');

pdf_out.Mu =resp_apprx_estimated(1,:);
pdf_out.Mu =pdf_out.Mu ( pdf_out.Mu ~= 0);

pdf_out.w =resp_apprx_estimated(3,:);
pdf_out.w =pdf_out.w ( pdf_out.w ~= 0);

size1 = size(pdf_out.w);
pdf_out.Cov = {} ;

for i = 1 : size1(2)
    pdf_out.Cov = horzcat(pdf_out.Cov, (resp_apprx_estimated(2,i))^2) ;

end

pdf_out