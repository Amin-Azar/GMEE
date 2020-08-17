function [ resp ] = findDist( a,n )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here
fit1 = fitgmdist(a,n);
%fitgmdist(a,n,'Start','plus','Options',statset('MaxIter',1500))

mu1=fit1.mu;
mu1=transpose(mu1);
sig1=fit1.Sigma;
sig1=squeeze(sig1);
sig1=transpose(sig1);
por1=fit1.PComponents; % cheghad harkodum e ! area ina


resp = vertcat(mu1,sqrt(sig1),por1);

end

