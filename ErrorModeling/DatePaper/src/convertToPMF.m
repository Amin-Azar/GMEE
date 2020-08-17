function [labels pmf] = convertToPMF( arrayOfData )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here


[V,~,labels] = grp2idx(arrayOfData);
%mx = max(V);
t = tabulate(V);
pmf = t(:, 3) ./ 100;


end

