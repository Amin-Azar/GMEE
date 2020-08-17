up=size(out_datas_accr)

for i=2:up(2)
%figure;    

subplot(2,1,2);
hist(out_datas_appx(:,i),1000);
xlm1=xlim;
subplot(2,1,1);
hist(out_datas_accr(:,i),1000);
xlim(xlm1);

end