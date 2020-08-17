%pd = fitdist(normrand_A,'Normal');
%dfittool


normrand_A = normrnd(0, Sigma , [Nonums 1])
normrand_B = normrnd(0, Sigma , [Nonums 1])
normrand_Sum = normrand_A + normrand_B


std_A=std(normrand_A);
std_A_rounded = round (std_A);
std_B=std(normrand_B);
std_B_rounded = round (std_B);
std_Sum=std(normrand_Sum);
std_Sum_rounded = round (std_Sum);

figure('Name',strcat('Accurate addition, #samlpes:',num2str(Nonums)),'NumberTitle','off')

%A
subplot(3,2,1)
hold on;
title(strcat('Sigma= ',num2str(std_A),'  ~(',num2str(std_A_rounded),')'))
hist(normrand_A,1000)

subplot(3,2,2)
normplot(normrand_A);
hold off;

%B
subplot(3,2,3)
hold on
title(strcat('Sigma= ',num2str(std_B),'  ~(',num2str(std_B_rounded),')'))
hist(normrand_B,1000)

subplot(3,2,4)
normplot(normrand_B);
hold off

%Sum
subplot(3,2,5)
hold on
title(strcat('Sigma= ',num2str(std_Sum),'  ~(',num2str(std_Sum_rounded),')'))
hist(normrand_Sum,1000)

subplot(3,2,6)
normplot(normrand_Sum);
hold off