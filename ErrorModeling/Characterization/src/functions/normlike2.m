function [ nlogL ] = normlike2( params,data )
%NORMLIKE2 Negative log-likelihood for multiple normal distributions.
%   NLOGL = NORMLIKE(PARAMS,DATA) returns the negative of the log-likelihood
%   for multiple normal distributions, evaluated at parameters 
%   PARAMS(:,1) = MU, PARAMS(:,2) = SIGMA and PARAMS(:,3) = Portion
%   given DATA.  NLOGL is a scalar.

%[37.7601, 95.1817,0.4211;-6.7343,87.9968, 0.5789 ]
%vertcat(transpose(test1.mu),transpose(squeeze(sqrt(test1.Sigma))),test1.PComponents)

mu = params(1,:);
sigma = params(2,:);
weights = params(3,:);


s2=size(mu);
s2 = s2(2);


%z = (data - mu) ./ sigma;
%F = (1/(sqrt(2.*pi).*sigma))* exp (-.5.*z.*z);

F=0;
for i=1:s2
    F = F+ weights(i)*normpdf(data,mu(i),sigma(i));
end

nlogL = -sum (log(F));


end

