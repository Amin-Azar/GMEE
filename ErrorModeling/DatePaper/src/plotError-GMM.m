
figure('color','w')


s = size(rpmf_apprx_3);

temp = zeros(1, floor(s(2)/2) +1);

n=100; % 100 ta 100 ta bere jolo plot kone
 l_1  = rl_apprx_3(1:n:end);
 pmf_1 = [temp rpmf_apprx_3(floor(s(2)/2)+2:end)];
 pmf_c= pmf_1(1:n:end);
 pmf_1 = [rpmf_apprx_3(1:floor(s(2)/2)) temp];
 pmf_e = pmf_1(1:n:end);
 pmf_a= rpmf_apprx_3(1:n:end);
 
 ylm = ([0 0.00002])
subplot(1,3,1);
bar(l_1, pmf_c);
xlim([-1150000 250000]);
ylim(ylm);
title('cPMF');
set(gca,'ytick',[])
box off;
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 2]);


subplot(1,3,2);
bar(l_1, pmf_e);
xlim([-1150000 250000]);
ylim(ylm);
title('ePMF');
set(gca,'ytick',[])
box off;
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 2]);


subplot(1,3,3);
bar(l_1, pmf_a);
xlim([-1150000 250000]);
ylim(ylm);
title('aPMF');
set(gca,'yticklabel',[],'ytick',[])
box off;
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 2]);

 %{
 % back up 
subplot(1,5,2);
bar(rl_apprx_3, [temp rpmf_apprx_3(floor(s(2)/2)+2:end)]);
xlim([-1150000 250000]);
title('cPMF');
set(gca,'ytick',[])
box off;

subplot(1,5,3);
bar(rl_apprx_3, [rpmf_apprx_3(1:floor(s(2)/2)) temp]);
xlim([-1150000 250000]);
title('ePMF');
set(gca,'ytick',[])
box off;

subplot(1,5,4);
bar(rl_apprx_3, rpmf_apprx_3);
xlim([-1150000 250000]);
title('vPMF');
set(gca,'yticklabel',[],'ytick',[])
box off;
 
 %}