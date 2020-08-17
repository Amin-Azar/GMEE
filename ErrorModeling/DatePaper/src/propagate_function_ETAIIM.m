function [ EMz ] = propagate_function_ETAIIM( Sa,Ea,Sb,Eb )
%PROPAGATE FUNCTION_ETAIIM Summary of this function goes here
%   Detailed explanation goes here

EMin = SigmaToEMin_MED_matrix(round(log2(Sa)),round(log2(Sb)))
EMz= 0.9991*(Ea+Eb)+1.1782*EMin-2448.1;

%

MSEz= 0.984363016501435 * (Ea+Eb) + 1.22248844875631*EMin + 364350201.2592

%Ea = EMin tu 2 marhale
%2.20685146525774*EMin + 364350201.2592
end

