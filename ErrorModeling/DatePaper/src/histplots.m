up=size(out_datas_accr)

for i=2:up(2)
figure;    

subplot(3,1,2);
hist(out_datas_appx(:,i),2^15);
xlm1=xlim;
subplot(3,1,1);
hist(out_datas_accr(:,i),2^15);
xlim(xlm1);
subplot(3,1,3);
hist(out_AE(:,i),2^15);
sm=sum(out_AE(:,i)==0)
title(strcat('Probability of accurate results',int2str(sm)));
end