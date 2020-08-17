

% in bayad step one bashe


% accurate data PMFs
[l_accur_1 pmf_accur_1] = convertToPMF(out_datas_accr(:,1));
[l_accur_2 pmf_accur_2] = convertToPMF(out_datas_accr(:,2));
[l_accur_3 pmf_accur_3] = convertToPMF(out_datas_accr(:,3));
% approximate simulation data PMFs
[l_apprx_1 pmf_apprx_1] = convertToPMF(out_datas_appx(:,1));
[l_apprx_2 pmf_apprx_2] = convertToPMF(out_datas_appx(:,2));
[l_apprx_3 pmf_apprx_3] = convertToPMF(out_datas_appx(:,3));
% approximate MIA estimation data PMFs
[l_apprx_MIA_1 pmf_apprx_MIA_1] = convertToPMF(out_datas_appx_MIA(:,1));
[l_apprx_MIA_2 pmf_apprx_MIA_2] = convertToPMF(out_datas_appx_MIA(:,2));
[l_apprx_MIA_3 pmf_apprx_MIA_3] = convertToPMF(out_datas_appx_MIA(:,3));

% if functions were overwritten
clear min;
clear max;

%ina adadaye daghighe


 
%min of mins
min1 = min (min(l_apprx_1),min(l_apprx_MIA_1));
min2 = min (min(l_apprx_2),min(l_apprx_MIA_2));
min3 = min (min(l_apprx_3),min(l_apprx_MIA_3));
%max of maxs
max1 = max (max(l_apprx_1),max(l_apprx_MIA_1));
max2 = max (max(l_apprx_2),max(l_apprx_MIA_2));
max3 = max (max(l_apprx_3),max(l_apprx_MIA_3));


%min1 = resp_apprx_Array(1,1,1) - 3* resp_apprx_Array(2,1,1)
%min1 = -10000;
%max1 = 10000;

%to compare hellinger distance we need same indices

%min-max range for approximate simulation -- bin shode 200 ta 200 ta
[rl_apprx_1 rpmf_apprx_1] = convertToRangePMF(l_apprx_1,pmf_apprx_1,min1,max1,10);
[rl_apprx_2 rpmf_apprx_2] = convertToRangePMF(l_apprx_2,pmf_apprx_2,min2,max2,1);
[rl_apprx_3 rpmf_apprx_3] = convertToRangePMF(l_apprx_3,pmf_apprx_3,min3,max3,200);

%min-max range for approximate MIA estimation
[rl_apprx_MIA_1 rpmf_apprx_MIA_1] = convertToRangePMF_MIA(l_apprx_MIA_1,pmf_apparx_MIA_1,min1,max1);
[rl_apprx_MIA_2 rpmf_apprx_MIA_2] = convertToRangePMF_MIA(l_apprx_MIA_2,pmf_apprx_MIA_2,min2,max2);
[rl_apprx_MIA_3 rpmf_apprx_MIA_3] = convertToRangePMF_MIA(l_apprx_MIA_3,pmf_apprx_MIA_3,min3,max3);

%calculate hellinger distances MIA
HD_MIA_1 = sqrt(1-sum(sqrt(rpmf_apprx_1 .* rpmf_apprx_MIA_1)));
HD_MIA_2 = sqrt(1-sum(sqrt(rpmf_apprx_2 .* rpmf_apprx_MIA_2)));
HD_MIA_3 = sqrt(1-sum(sqrt(rpmf_apprx_3 .* rpmf_apprx_MIA_3)));



%descretize multiple gaussians

% array numofGuasian min max
l=1;
HowmanyFit
[rl_SAM_1 rpmf_SAM_1] = convertToRangePMF_norm(resp_apprx_Array(:,:,1),1,min1,max1);%SAM
[rl_GMEE_1 rpmf_GMEE_1] = convertToRangePMF_norm(resp_apprx_Array(:,:,5),6,min1,max1);%GMEE

l=2;
HowmanyFit
[rl_SAM_2 rpmf_SAM_2] = convertToRangePMF_norm(resp_apprx_Array(:,:,1),1,min2,max2);
[rl_GMEE_2 rpmf_GMEE_2] = convertToRangePMF_norm(resp_apprx_Array(:,:,5),6,min2,max2);

l=3;
HowmanyFit
[rl_SAM_3 rpmf_SAM_3] = convertToRangePMF_norm(resp_apprx_Array(:,:,1),1,min3,max3);
[rl_GMEE_3 rpmf_GMEE_3] = convertToRangePMF_norm(resp_apprx_Array(:,:,4),5,min3,max3);



HD_SAM_1 = sqrt(1-sum(sqrt(rpmf_apprx_1 .* rpmf_SAM_1)));
HD_SAM_2 = sqrt(1-sum(sqrt(rpmf_apprx_2 .* rpmf_SAM_2)));
HD_SAM_3 = sqrt(1-sum(sqrt(rpmf_apprx_3 .* rpmf_SAM_3)));

HD_GMEE_1 = sqrt(1-sum(sqrt(rpmf_apprx_1 .* rpmf_GMEE_1)));
HD_GMEE_2 = sqrt(1-sum(sqrt(rpmf_apprx_2 .* rpmf_GMEE_2)));
HD_GMEE_3 = sqrt(1-sum(sqrt(rpmf_apprx_3 .* rpmf_GMEE_3)));


%figures
%{


figure
fig.Units = 'inches';
fig.PaperPosition = [0 0 3.33 2];
bar(rl_apprx_1,rpmf_apprx_1,'g')
hold on
plot(rl_apprx_MIA_1,rpmf_apprx_MIA_1,'b')
legend('SIM','GMEE','MIA','SAM')
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 2]);



figure;
bar(rl_apprx_2,rpmf_apprx_2,'g')
hold on
plot(rl_apprx_MIA_2,rpmf_apprx_MIA_2,'b')


l_MIA_temp = rl_apprx_MIA_3(1:100:end);
pmf_MIA_temp = rpmf_apprx_MIA_3(1:100:end);

l_apprx_temp = rl_apprx_3(1:100:end);
pmf_apprx_temp = rpmf_apprx_3(1:100:end);

figure;
fig.Units = 'inches';
fig.PaperPosition = [0 0 3.33 1.25];
bar(l_apprx_temp,pmf_apprx_temp,'facecolor',[0.5 0.5 0.5],'edgecolor',[0.5 0.5 0.5])
hold on
plot(l_MIA_temp,pmf_MIA_temp,'b')
plot(rl_SAM_3, rpmf_SAM_3,'--','color',[0.2 0.7 0]);
legend('Location','northwest','SIM','MIA','SAM')
set(gca, 'FontSize', 7);
set(gca,'yticklabel',[],'ytick',[])
set(gca,'ycolor','w')
box off;
box off;
set(gcf, 'PaperPosition', [0 0 3.33 2]);
xlim([min3*(1.01) max3]*(1.01));
ylim([0 0.00002])
%}


%{
%one-level
figure;
fig.Units = 'inches';

subplot(1,2,1);
set(gcf, 'PaperPosition', [0 0 3.33 0.75]);
bar(l_apprx_temp,pmf_apprx_temp,'facecolor',[0.65 0.65 0.65],'edgecolor',[0.65 0.65 0.65])
hold on
plot(l_MIA_temp,pmf_MIA_temp,'b')
plot(rl_SAM_3, rpmf_SAM_3,'--','color',[0.2 0.5 0.1]);
%legend('Location','northwest','SIM','MIA','SAM')
set(gca, 'FontSize', 7);
set(gca,'yticklabel',[],'ytick',[])
set(gca,'ycolor','w')
box off;
box off;
set(gcf, 'PaperPosition', [0 0 3.33 5]);
set(gca,'position',[0 0.15 0.49 1])
xlim([min3*(1.05) max3]*(1.05));
%xlim([min1*(1.01) max1]*(1.01));
ylim([0 0.000017])
%}