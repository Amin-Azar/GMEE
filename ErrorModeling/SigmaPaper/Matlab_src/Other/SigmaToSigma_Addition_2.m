
Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim
normrand_Sum=zeros(Nonums,1);
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
for k = 1:Sigma_itt ;   
    
Sig2 = Sig2 + 1;
normrand_A = normrnd(0, 2^Sig1 , [Nonums 1]);
normrand_B = normrnd(0, 2^Sig2 , [Nonums 1]);
%normrand_Sum = normrand_A + normrand_B; %Import/read From File
for i = 1:Nonums
normrand_Sum(i) = round(normrand_A(i)) + round(normrand_B(i)); %Import/read From File
end

std_A=std(normrand_A);
std_B=std(normrand_B);
std_Sum=std(normrand_Sum);

%SigmaToSigma(1,c*k)= std_A;
%SigmaToSigma(2,c*k)= std_B;
%SigmaToSigma(3,c*k)= std_Sum;

SigmaToSigma_matrix(Sig1,Sig2) = std_Sum;
end 
end
    
    
%surf(SigmaToSigma_matrix)
figure

subplot(1,3,1)
hold on
surf(log2(SigmaToSigma_matrix)) 
surf1 = Sigma_itt*ones(Sigma_itt,Sigma_itt);
mesh(surf1);
hold off


subplot(1,3,2)
hold on
surf(log2(SigmaToSigma_matrix)) 
surf1 = Sigma_itt*ones(Sigma_itt,Sigma_itt);
mesh(surf1);

subplot(1,3,3)
hold on
surf(log2(SigmaToSigma_matrix)) 
surf1 = Sigma_itt*ones(Sigma_itt,Sigma_itt);
mesh(surf1);
hold off
end