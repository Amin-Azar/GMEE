function [ pdf_out ] = getGMM( Array )
%GETGMM Summary of this function goes here
%   beja inke 3 bodi begire index bezanim , 2 bodi pass mikonim tush ke
%   beshe harr resp_ppx ro dad besh
load('~/params.mat')


pdf_out.Mu =Array(1,:);
pdf_out.Mu =pdf_out.Mu ( pdf_out.Mu ~= 0);

pdf_out.w =Array(3,:);
pdf_out.w =pdf_out.w ( pdf_out.w ~= 0);

size1 = size(pdf_out.w);
pdf_out.Cov = {} ;

for i = 1 : size1(2)
    pdf_out.Cov = horzcat(pdf_out.Cov, (Array(2,i))^2); 

  
end

display('estimation');
pdf_out