function [ combined_GMM ] = combineGMMs( GMM1,GMM2 )
%COMBINEGMMS Summary of this function goes here
%   Detailed explanation goes here

mu1 = GMM1(1);
sg1 = GMM1(2);
wt1 = GMM1(3);

mu2 = GMM2(1);
sg2 = GMM2(2);
wt2 = GMM2(3);

c_wt = wt1 + wt2;
c_mu = (wt1*mu1 + wt2*mu2)/c_wt;
c_sg = sqrt( ((wt1*(sg1^2 + mu1^2) + wt2*(sg2^2 + mu2^2)) /c_wt ) - c_mu^2 ); 

combined_GMM = [c_mu;c_sg;c_wt];




end

