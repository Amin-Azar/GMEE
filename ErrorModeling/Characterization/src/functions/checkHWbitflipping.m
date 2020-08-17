% ba in script mikhastim bebinim ke sigma o miu ru bit haye khoruuji che
% tasirati mitune bezare.

Nosamples = 100000;

bits = 32

%miu = 4;
%sigma = 8;

j=0;

figure;
y = zeros(6*5,10000);
x = zeros(6*5,10000);

%miu = [-2^15,-2^10,-2^5,0,2^5,2^10,2^15]

for miu = [50,64,70,75,80,85,90]
    j= j+1;
    i=0;
for sigma=[2^0,2^2,2^5,2^8,2^10]

    i = i+1;
    
test = normrnd(miu,sigma,[Nosamples 1]);
test = round(test);

test1 = dec2tc(test,bits);
test1 = test1 - 48;

subplot(7,5,i+5*(j-1));
hold on
xlim([-bits, 0]);
plot(-bits+1:0,sum(test1)/Nosamples);
%scatter(-bits+1:0,sum(test1)/Nosamples,'filled');

[y1, x1] = hist(test,10000);
y(i+5*(j-1),:)=y1; x(i+5*(j-1),:)=x1;
title(['MIU=',num2str(miu),', Sigma=',num2str(sigma)]);
end
end

figure;
for i = 1:7*5

        subplot(7,5,i);
        plot(x(i,:),y(i,:));

end

%{
for i=1:1000
scatter(-16:-1, test1(i,:))
ylim([-2 2])
pause(0.1)
end

%}