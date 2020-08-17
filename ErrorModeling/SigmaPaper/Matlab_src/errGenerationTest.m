Nonums=7000; 
MED_t=0;    
bits=32; 
itter=20; 
val=0;
SigRange=20;

SigmaToMED_array = zeros(SigRange,itter);
AEs= zeros(Nonums,SigRange*itter);

for itt =1:itter
 coefs_t= zeros(bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
   
for sig = itt:SigRange
    
 Sig1=2^itt; % girim tu har itt yeki az sigmaha sabete unyeki avaz mishe
 Sig2= 2^sig;

 val=0;



 
normrand_A1 = normrnd(0, Sig1 , [Nonums 1]);
normrand_A2 = normrnd(0, Sig2 , [Nonums 1]); 

AEs(:,itt*itter+sig) = abs( normrand_A1 -  normrand_A2);

r_AEs = round (log2(AEs));%log2 gereftim azashun
      
size1= size (AEs);
size1= size1(1);

for k = 1:size1

val = r_AEs(k,itt*itter+sig);
	if ( val >0)
	coefs_t(val) = coefs_t(val)+1;
end
end

 coefs_test = horzcat(coefs_test,coefs_t);
	for f= 1:bits
if ( coefs_t(f) ~=0)
MED_t = MED_t + coefs_t(f) * (2^f);
end
end
%ans=(coefs_t)

MED_t= MED_t /Nonums


SigmaToMED_matrix (sig,itt)=MED_t; %logarithmic indexed
end


end