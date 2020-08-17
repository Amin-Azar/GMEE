
resp_apprx_Array = zeros(3,10,8);


% acuurate simulation data PMFs
[l_accur_O1 pmf_accur_O1] = convertToPMF(H264_O1);

% approximate simulation data PMFs
[l_apprx_O1 pmf_apprx_O1] = convertToPMF(H264_O1_appx);

[l_apprx_A pmf_apprx_A] = convertToPMF(H264_A);
[l_apprx_B pmf_apprx_B] = convertToPMF(H264_B);

%%
%MIA



out_datas_accr = -1*H264_A;
out_datas_appx = -1* H264_A;
MIA_quantize
H264_A_MIA = out_datas_appx_MIA;

out_datas_accr = -1 * H264_B;
out_datas_appx = -1 *H264_B;
MIA_quantize
H264_B_MIA = out_datas_appx_MIA;

%migim ke MIA asan intori add mikone

H264_O1_med = H264_A_MIA + H264_B_MIA; % hanuz kamel mia nashod in

% inja dobare mikonim be form e mia
out_datas_accr = -1*H264_O1;
out_datas_appx = H264_O1_med;
MIA_quantize
H264_O1_MIA = out_datas_appx_MIA;

[l_apprx_MIA_A pmf_apprx_MIA_A] = convertToPMF(H264_A_MIA);
[l_apprx_MIA_B pmf_apprx_MIA_B] = convertToPMF(H264_B_MIA);

min1 = min (min(min(min(l_apprx_O1),min(l_apprx_MIA_A)),min(l_apprx_MIA_B)),min(l_apprx_A));
max1 = max (max(max(max(l_apprx_O1),max(l_apprx_MIA_A)),max(l_apprx_MIA_B)),max(l_apprx_A));
[rl_apprx_A rpmf_apprx_A] = convertToRangePMF(l_apprx_A,pmf_apprx_A,min1,max1,16);
[rl_apprx_B rpmf_apprx_B] = convertToRangePMF(l_apprx_B,pmf_apprx_B,min1,max1,16);
[rl_apprx_O1 rpmf_apprx_O1] = convertToRangePMF(l_apprx_O1,pmf_apprx_O1,min1,max1,16);

[rl_apprx_MIA_A rpmf_apprx_MIA_A] = convertToRangePMF_MIA(l_apprx_MIA_A,pmf_apprx_MIA_A,min1,max1);
%hist(-1*H264_A,1000)
[rl_apprx_MIA_B rpmf_apprx_MIA_B] = convertToRangePMF_MIA(l_apprx_MIA_B,pmf_apprx_MIA_B,min1,max1);
%hist(-1*H264_B,1000)
%bar(-1*l_apprx_B, pmf_apprx_B,'g')

MIA_O1_conv = conv(rpmf_apprx_MIA_A,rpmf_apprx_MIA_B);
r_l_MIA_O1_conv = min1-max1:1:max1 - min1;


min1_extnd = min(r_l_MIA_O1_conv);
max1_extnd = max(r_l_MIA_O1_conv);
%[rl_r_l_MIA_O1_conv rpmf_MIA_O1_conv] = convertToRangePMF(r_l_MIA_O1_conv,MIA_O1_conv,min1_extnd,max1_extnd,16);
[rl_r_l_MIA_O1_conv rpmf_MIA_O1_conv] = quantizePMF_MIA(r_l_MIA_O1_conv,MIA_O1_conv,min1_extnd,max1_extnd);

%{
% asna nemidunam chera injas
out_datas_accr = -1*H264_A;
out_datas_appx = -1* H264_A;
MIA_quantize
H264_A_MIA = out_datas_appx_MIA;

out_datas_accr = -1 * H264_B;
out_datas_appx = -1 *H264_B;
MIA_quantize
H264_B_MIA = out_datas_appx_MIA;
%}

[rl_accur_O1_extnd rpmf_accur_O1_extnd] = convertToRangePMF(l_accur_O1,pmf_accur_O1,min1_extnd,max1_extnd,16);


HD_MIA_O1 = sqrt(1-sum(sqrt( rpmf_accur_O1_extnd.* rpmf_MIA_O1_conv)));


%{
%plot A,B
ylim = [0 0.0025];
xlim = [-5000 10000];

figure
bar(rl_apprx_A, rpmf_apprx_A,'Facecolor', [0.5 0.5 0.5])
hold on
plot(-1*rl_apprx_MIA_A, rpmf_apprx_MIA_A,'r')
ylim(ylm)
xlim(xlm)


figure
bar(rl_apprx_B, rpmf_apprx_B,'Facecolor', [0.5 0.5 0.5])
hold on
plot(-1*rl_apprx_MIA_B, rpmf_apprx_MIA_B,'r')
ylim(ylm)
xlim(xlm)
%}



%%
%SAM
%find SAM after 1 propagation
H264_step1_miu = mean(H264_A) + mean(H264_B);
%H264_step1_std = look up in a table
H264_step1_std = 2^15;
H264_step1_w =1;

resp_apprx = [H264_step1_miu, H264_step1_std, H264_step1_w ] ;
resp_apprx_Array(1:3,1,1) = resp_apprx;


%%
%GMEE

itter1 = [1 2 4 5 6 10];
for itt= 4:4 % che tedad fit konim - vase moghayese bud dge alan az hamin estefade mikonim. aslio "20" ta fit migirim takhmine khodemuno "6" ta fit
itter = itter1(itt); % 1-2-4

resp_apprx = findDist (H264_O1_appx,itter); % H264_O1_appx

size1 = size(resp_apprx);
resp_apprx_Array(1:size1(1),1:size1(2),itt) = resp_apprx;

end

%%
%min1_flipped = -1*max1;
%max1_flipped = -1*min1;

[rl_SAM_O1_extnd rpmf_SAM_O1_extnd] = convertToRangePMF_norm(resp_apprx_Array(:,:,1),1,min1_extnd,max1_extnd);%SAM


[rl_GMEE_1_extnd rpmf_GMEE_1_extnd] = convertToRangePMF_norm(resp_apprx_Array(:,:,4),5,min1_extnd,max1_extnd);%GMEE

HD_SAM_O1 = sqrt(1-sum(sqrt(rpmf_accur_O1_extnd .* rpmf_SAM_O1_extnd)));
HD_GMEE_1 = sqrt(1-sum(sqrt(rpmf_accur_O1_extnd .* rpmf_GMEE_1_extnd)));

%% how to calculate EM !! so easy
%SAM
resp_apprx = resp_apprx_Array(1:3,1,1);
resp_accur = findDist (H264_O1,1);

appxPart = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart = resp_accur(1,:) .* resp_accur(3,:); % mean * 1

MED_estimated_SAM= abs (appxPart - accurPart)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_SAM = sum (  ((resp_apprx(1,:)-resp_accur(1,:)).^2 ).* resp_apprx(3,:))
SNR_estimated_SAM = (resp_accur(2,:).^2) ./ MSE_estimated

PSNR_estimated_SAM = ((resp_accur(1,:) + 3*resp_accur(2,:) ).^2) ./ MSE_estimated_SAM

%GMEE

resp_apprx = resp_apprx_Array(1:3,1:5,4);
resp_accur = findDist (-1*H264_O1,5); % yani 5 ta be bi khata fit ko, simulaition ham manfie rasti

kce2.pdf = getGMM_Array (resp_apprx);
kde1.pdf = getGMM_Array (resp_accur);

figure('color','w');hold on;
visualizeKDE('kde', kce2, 'decompose', 0, 'showkdecolor', 'r' ,'Style','-')
visualizeKDE('kde', kde1, 'decompose', 0, 'showkdecolor', 'b' ,'Style','--')


appxPart_2 = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart_2 = sum(resp_accur(1,:) .* resp_accur(3,:)); % mean * 1

MED_estimated_GMEE = abs (appxPart_2 - accurPart_2)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_GMEE = sum (  ((resp_apprx(1,:)-resp_accur(1,:)).^2 ).* resp_apprx(3,:))
SNR_estimated_GMEE = (resp_accur(2,:).^2) ./ MSE_estimated

resp_accur_3 = findDist (H264_O1,5) % just to choose range
PSNR_estimated_GMEE = ((resp_accur_3(1,:) + 3*resp_accur_3(2,:) ).^2) ./ MSE_estimated


%%
%plots

%{
%plot O1
figure
%plot(-1*rl_apprx_O1, rpmf_apprx_O1,'g')
bar(-1*rl_apprx_O1, rpmf_apprx_O1,'facecolor',[0.75 0.75 0.75],'edgecolor',[0.75 0.75 0.75])
hold on
%plot(r_l_MIA_O1_conv, MIA_O1_conv,'b') % in MIA nashodas
plot(rl_GMEE_1_extnd, rpmf_GMEE_1_extnd,'color',[0.5 0.3 0.3],'linewidth',2)
plot(rl_r_l_MIA_O1_conv, rpmf_MIA_O1_conv,'b') % in MIA shodas
plot(rl_SAM_O1_extnd, rpmf_SAM_O1_extnd,'--','color',[0.2 0.5 0.1])
legend('Location','northwest','SIM','GMEE','MIA','SAM')
set(gca, 'FontSize', 7);
box off;
set(gcf, 'PaperPosition', [0 0 3.33 1.6]);
set(gca,'position',[0.05 0.2 0.9 0.7])
%xlim([-5000 15000])
xlim([-2000 10000])
ylim([0 0.00075])
%}