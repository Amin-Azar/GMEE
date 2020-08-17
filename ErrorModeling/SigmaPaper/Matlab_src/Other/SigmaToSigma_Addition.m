
Sigma_itt = 100

% 1D 

if 0
SigmaToSigma = zeros(3,Sigma_itt);
SigmaToSigma_matrix = zeros(Sigma_itt,Sigma_itt);
Sig = 0
for c = 1:Sigma_itt
    
    
Sig = Sig + 1
normrand_A = normrnd(0, Sig , [Nonums 1]);
normrand_B = normrnd(0, Sig , [Nonums 1]);
normrand_Sum = normrand_A + normrand_B; %Import/read From File

std_A=std(normrand_A);
std_B=std(normrand_B);
std_Sum=std(normrand_Sum);

SigmaToSigma(1,c)= std_A;
SigmaToSigma(2,c)= std_B;
SigmaToSigma(3,c)= std_Sum;
SigmaToSigma_matrix(Sig,Sig) = std_Sum;
SigmaToSigma_array(Sig) = std_Sum;
end

end

if 1
    
    
SigmaToSigma = zeros(3,Sigma_itt*Sigma_itt);
SigmaToSigma_matrix = zeros(Sigma_itt,Sigma_itt);
Sig1 = 0
for c = 1:Sigma_itt
  Sig2 = 0  ;
  Sig1 = Sig1 + 1
for k = 1:Sigma_itt    
    
Sig2 = Sig2 + 1;
normrand_A = normrnd(0, Sig1 , [Nonums 1]);
normrand_B = normrnd(0, Sig2 , [Nonums 1]);
normrand_Sum = normrand_A + normrand_B; %Import/read From File

std_A=std(normrand_A);
std_B=std(normrand_B);
std_Sum=std(normrand_Sum);

SigmaToSigma(1,c*k)= std_A;
SigmaToSigma(2,c*k)= std_B;
SigmaToSigma(3,c*k)= std_Sum;
SigmaToSigma_matrix(Sig1,Sig2) = std_Sum;
end 
end
    
    
surf(SigmaToSigma_matrix)
    
    
end