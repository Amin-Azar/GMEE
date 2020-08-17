%intitalization
Sigma_itt = 2 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
Nonums = 10000; % 5-7K samples for better sigma evaluation in matlab - zire in std(X) khatash ok nis
input_err = 1; % sigma of input error injected
%path1='${HOME_DIR}/approxiSynthesys/simulations';% unjayi ke darim save mikonim khorujiaro
path1='~/approxiSynthesys/simulations';% unjayi ke darim save mikonim khorujiaro
bits=32; % bara 32 biti
bias=0;

up =Sigma_itt-1; % 14*14 ro nega kone vase regression
save ('~/params.mat');
%save ('strcat(path1,params.mat'),'-append');
