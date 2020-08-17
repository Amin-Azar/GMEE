function [ med, coefs ] = EM_med( accurate,inaccurate,Nonums)
%EM_MED Summary of this function goes here
%   Detailed explanation goes here

%const. params
bits=32;

AEs = abs(accurate - inaccurate);
AEs(:,2) = round (log2(AEs(:,1) + 0.001));%log2 gereftim azashun gozashtim radif 2 ke 0 nabashe INF beshe

coefs= zeros(bits,1);
MED1=0;  

size1= size (AEs);
size1= size1(1);

for k = 1:size1

val = AEs(k,2);
	if ( val > 0)
	coefs(val) = coefs(val)+1;
end
end
	
for f= 1:bits
    if ( coefs(f) ~=0)
    MED1= MED1 + coefs(f) * (2^f);
    end
end

med= MED1 /Nonums;

end

