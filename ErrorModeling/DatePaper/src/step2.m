
resp_apprx_Array = zeros(3,10,8);





%%
%MIA
s2 = size(in_accr);
s2 = s2(2);

A_B_MIA = in_appx_MIA;
C_MIA = in_C_datas2;
Out2_med = in_C_datas2;
Out2_MIA = in_C_datas2;

%avali sefre hazf konim
%appx_out_datas = appx_out_datas(:,2:end);
Out2_appx = appx_out_datas;
for j = 1:s2
    
% acuurate simulation data PMFs
[l_accur_O2, pmf_accur_O2] = convertToPMF(corr_out_datas2(:,j));

% approximate simulation data PMFs
[l_apprx_O2, pmf_apprx_O2] = convertToPMF(Out2_appx(:,j));

%in already MIA e
[l_apprx_A_B, pmf_apprx_A_B] = convertToPMF(in_appx_MIA(:,j));
[l_apprx_C, pmf_apprx_C] = convertToPMF(in_C_datas2(:,j));



out_datas_accr = in_C_datas2(:,j);
out_datas_appx = in_C_datas2(:,j);
MIA_quantize
C_MIA(:,j) = out_datas_appx_MIA;

%migim ke MIA asan intori add mikone

Out2_med(:,j) = A_B_MIA(:,j) + C_MIA(:,j); % hanuz kamel mia nashod in

% inja dobare mikonim be form e mia
out_datas_accr =corr_out_datas2(:,j) ;
out_datas_appx = Out2_med(:,j);
MIA_quantize
Out2_MIA(:,j) = out_datas_appx_MIA;

[l_apprx_MIA_A_B, pmf_apprx_MIA_A_B] = convertToPMF(A_B_MIA(:,j));
[l_apprx_MIA_C, pmf_apprx_MIA_C] = convertToPMF(C_MIA(:,j));

min1 = min (min(min(min(l_apprx_O2),min(l_apprx_MIA_A_B)),min(l_apprx_MIA_C)),min(l_apprx_A_B));
max1 = max (max(max(max(l_apprx_O2),max(l_apprx_MIA_A_B)),max(l_apprx_MIA_C)),max(l_apprx_A_B));
[rl_apprx_A_B, rpmf_apprx_A_B] = convertToRangePMF(l_apprx_A_B,pmf_apprx_A_B,min1,max1,16);
[rl_apprx_C, rpmf_apprx_C] = convertToRangePMF(l_apprx_C,pmf_apprx_C,min1,max1,16);
[rl_apprx_O2, rpmf_apprx_O2] = convertToRangePMF(l_apprx_O2,pmf_apprx_O2,min1,max1,16);


[rl_apprx_MIA_A_B, rpmf_apprx_MIA_A_B] = convertToRangePMF_MIA(l_apprx_MIA_A_B,pmf_apprx_MIA_A_B,min1,max1);
%hist(-1*H264_A,1000)
[rl_apprx_MIA_C, rpmf_apprx_MIA_C] = convertToRangePMF_MIA(l_apprx_MIA_C,pmf_apprx_MIA_C,min1,max1);

MIA_O2_conv = conv(rpmf_apprx_MIA_C,rpmf_apprx_MIA_A_B);
%r_l_MIA_O2_conv = min1-max1:1:max1 - min1;
r_l_MIA_O2_conv = 2*min1:2*max1;

min1_extnd = min(r_l_MIA_O2_conv);
max1_extnd = max(r_l_MIA_O2_conv);
%[rl_r_l_MIA_O1_conv rpmf_MIA_O1_conv] = convertToRangePMF(r_l_MIA_O1_conv,MIA_O1_conv,min1_extnd,max1_extnd,16);
[rl_r_l_MIA_O2_conv, rpmf_MIA_O2_conv] = quantizePMF_MIA(r_l_MIA_O2_conv,MIA_O2_conv,min1_extnd,max1_extnd);

[rl_accur_O2_extnd, rpmf_accur_O2_extnd] = convertToRangePMF(l_accur_O2,pmf_accur_O2,min1_extnd,max1_extnd,16);
[rl_apprx_O2_extnd, rpmf_apprx_O2_extnd] = convertToRangePMF(l_apprx_O2,pmf_apprx_O2,min1_extnd,max1_extnd,16);

%HD_MIA_O2 = sqrt(1-sum(sqrt( rpmf_accur_O2_extnd.* rpmf_MIA_O2_conv)));
HD_MIA_O2 = sqrt(1-sum(sqrt( rpmf_apprx_O2_extnd.* rpmf_MIA_O2_conv)))

%%
%SAM
%find SAM after 1 propagation
step2_miu = mean(in_appx(:,j)) + mean(in_C_datas2(:,j));
%step2_std = look up in a table. ziriaro nega mikonim az ru jadval mikhunim
log2(std(in_appx(:,j)))
log2(std(in_C_datas2(:,j)))

step2_std = 2^22;
step2_w =1;

resp_apprx = [step2_miu, step2_std, step2_w ] ;
resp_apprx_Array(1:3,1,1) = resp_apprx;

%%
%GMEE

itter1 = [1 2 4 5 6 10];
for itt= 4:4 % che tedad fit konim - vase moghayese bud dge alan az hamin estefade mikonim. aslio "20" ta fit migirim takhmine khodemuno "6" ta fit
itter = itter1(itt); % 1-2-4

resp_apprx = findDist (Out2_appx(:,j),itter); % H264_O1_appx

size1 = size(resp_apprx);
resp_apprx_Array(1:size1(1),1:size1(2),itt) = resp_apprx;

end

%%
%min1_flipped = -1*max1;
%max1_flipped = -1*min1;

[rl_SAM_O2_extnd, rpmf_SAM_O2_extnd] = convertToRangePMF_norm(resp_apprx_Array(:,:,1),1,min1_extnd,max1_extnd);%SAM


[rl_GMEE_2_extnd, rpmf_GMEE_2_extnd] = convertToRangePMF_norm(resp_apprx_Array(:,:,4),5,min1_extnd,max1_extnd);%GMEE

HD_SAM_O2 = sqrt(1-sum(sqrt(rpmf_apprx_O2_extnd .* rpmf_SAM_O2_extnd)));
HD_GMEE_2 = sqrt(1-sum(sqrt(rpmf_apprx_O2_extnd .* rpmf_GMEE_2_extnd)));

%% how to calculate EM !! so easy
%SAM
resp_apprx = resp_apprx_Array(1:3,1,1);
resp_accur = findDist (in_accr(:,j),1);

appxPart = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart = resp_accur(1,:) .* resp_accur(3,:); % mean * 1

MED_estimated_SAM_2= abs (appxPart - accurPart)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_SAM_2 = sum (  ((resp_apprx(1,:)-resp_accur(1,:)).^2 ).* resp_apprx(3,:))
SNR_estimated_SAM_2 = (resp_accur(2,:).^2) ./ MSE_estimated

PSNR_estimated_SAM_2 = ((resp_accur(1,:) + 3*resp_accur(2,:) ).^2) ./ MSE_estimated_SAM

%GMEE

resp_apprx = resp_apprx_Array(1:3,1:5,4);
resp_accur = findDist (in_accr(:,j),5); % yani 5 ta be bi khata fit ko, simulaition ham manfie rasti


appxPart_2 = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart_2 = sum(resp_accur(1,:) .* resp_accur(3,:)); % mean * 1

MED_estimated_GMEE_2 = abs (appxPart_2 - accurPart_2)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_GMEE_2 = sum (  ((resp_apprx(1,:)-resp_accur(1,:)).^2 ).* resp_apprx(3,:))
SNR_estimated_GMEE_2 = (resp_accur(2,:).^2) ./ MSE_estimated

resp_accur_3 = findDist (H264_O1,5) % just to choose range
PSNR_estimated_GMEE_2 = ((resp_accur_3(1,:) + 3*resp_accur_3(2,:) ).^2) ./ MSE_estimated

%plots



rl_apprx_O2_temp = rl_apprx_O2_extnd(1:200:end);
rpmf_apprx_O2_temp = rpmf_apprx_O2_extnd(1:200:end);

rl_GMEE_2_extnd_temp = rl_GMEE_2_extnd(1:200:end);
rpmf_GMEE_2_extnd_temp = rpmf_GMEE_2_extnd(1:200:end);
rpmf_MIA_O2_conv_temp = rpmf_MIA_O2_conv(1:200:end);
rl_r_l_MIA_O2_conv_temp = rl_r_l_MIA_O2_conv (1:200:end);

rl_SAM_O2_extnd_temp = rl_SAM_O2_extnd(1:200:end);
rpmf_SAM_O2_extnd_temp = rpmf_SAM_O2_extnd(1:200:end);
%{
%plot O1
figure
fig.Units = 'inches';
fig.PaperPosition = [0 0 3.33 1];
%plot(,'g')
bar(rl_apprx_O2_temp, rpmf_apprx_O2_temp,'facecolor',[0.5 0.5 0.5],'edgecolor',[0.5 0.5 0.5])
hold on
%plot(rl_GMEE_2_extnd_temp, rpmf_GMEE_2_extnd_temp,'r','linewidth',2)
plot(rl_r_l_MIA_O2_conv_temp, rpmf_MIA_O2_conv_temp,'b') % in MIA shodas
plot(rl_SAM_O2_extnd_temp, rpmf_SAM_O2_extnd_temp,'--g')
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 2]);
%xlim([-5000 15000])
%xlim([-2000 10000])
%xlim([-2000 10000])
xlim([min1*(1.01) max1*(1.01)])
legend('Location','northwest','GMEE','SIM','MIA','SAM')
set(gca, 'FontSize', 7);
set(gca,'yticklabel',[],'ytick',[])
set(gca,'ycolor','w')
box off;
%ylim([0 0.0025])
ylim([0 0.00002])

%}

%{
%two-level
%plot O1
figure
fig.Units = 'inches';
fig.PaperPosition = [0 0 3.33 1];

subplot(1,2,2)
%plot(,'g')
bar(rl_apprx_O2_temp, rpmf_apprx_O2_temp,'facecolor',[0.65 0.65 0.65],'edgecolor',[0.65 0.65 0.65])
hold on
plot(rl_r_l_MIA_O2_conv_temp, rpmf_MIA_O2_conv_temp,'b') % in MIA shodas
plot(rl_SAM_O2_extnd_temp, rpmf_SAM_O2_extnd_temp,'--','color',[0.2 0.5 0.1])
%legend('SIM','GMEE','MIA','SAM')
set(gca, 'FontSize', 7);
%set(gcf, 'PaperPosition', [0 0 3.33 0.75]);
%xlim([-5000 15000])
%xlim([-2000 10000])
%xlim([-2000 10000])
xlim([min1*(1.01) max1*(1.01)])
legend('Location','northwest','SIM','MIA','SAM')
set(gca, 'FontSize', 7);
set(gca,'yticklabel',[],'ytick',[])
set(gca,'ycolor','w')
set(gca,'position',[0.51 0.15 0.49 1])

box off;
%ylim([0 0.0025])
ylim([0 0.000017])

print('~/approxiSynthesys/paper/figures/two-level', '-depsc2', '-painters')
%}

%{
%GMEE.eps
figure
fig.Units = 'inches';
%set(gcf, 'PaperPositionMode', 'manual');
%fig.PaperPosition = [0 0 3.33 5];
set(gcf,'PaperPosition',[0 0 3.33 0.8])
%set(gcf, 'renderer', 'painters');

%plot(,'g')
bar(rl_apprx_O2_temp, rpmf_apprx_O2_temp,'facecolor',[0.75 0.75 0.75],'edgecolor',[0.75 0.75 0.75])
hold on
plot(rl_GMEE_2_extnd_temp, rpmf_GMEE_2_extnd_temp,'color',[0.5 0.3 0.3],'linewidth',1.2)
%legend('SIM','GMEE','MIA','SAM')
set(gca, 'FontSize', 7);
xlim([min1*(1.05) max1*(1.05)])
legend('Location','northwest','SIM','GMEE')
set(gca, 'FontSize', 7);
set(gca,'yticklabel',[],'ytick',[])
set(gca,'ycolor','w')
set(gca,'position',[0 0.2 1 0.8])
box off;
ylim([0 0.0000065])
%WAIT
print('~/approxiSynthesys/paper/figures/GMEE', '-depsc2', '-painters')
%}



end




%%