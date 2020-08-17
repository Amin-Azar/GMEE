

resp_apprx_Array_O2 = zeros(3,10,8);


O2_AE = (H264_O2_appx) - (-1*H264_O2);

MSE_step2 = mean (O2_AE.^2);
maxbit = 15;
PSNR_step2 =  ( (2^(maxbit-1))^2 / MSE_step2);
MED_step2 = EM_med(-1*H264_O2,H264_O2_appx,Nonums);

% acuurate simulation data PMFs
[l_accur_O2 pmf_accur_O2] = convertToPMF(H264_O2);

% approximate simulation data PMFs
[l_apprx_O2 pmf_apprx_O2] = convertToPMF(H264_O2_appx);

[l_apprx_C pmf_apprx_C] = convertToPMF(H264_C);
%O1_appx ro az ghabli vardarim

% ram MIA konim
out_datas_accr = -1*H264_C;
out_datas_appx = -1* H264_C;
MIA_quantize
H264_C_MIA = out_datas_appx_MIA;

%migim ke MIA asan intori add mikone
H264_O2_med = H264_C_MIA + H264_O1_MIA; % hanuz kamel mia nashod in

% inja dobare mikonim be form e mia
out_datas_accr = -1*H264_O2;
out_datas_appx = H264_O2_med;
MIA_quantize
H264_O2_MIA = out_datas_appx_MIA;

[l_apprx_MIA_C pmf_apprx_MIA_C] = convertToPMF(H264_C_MIA);
[l_apprx_MIA_O1_1 pmf_apprx_MIA_O1_1] = convertToPMF(H264_O1_MIA);

min1 = min (min(min(min(l_apprx_O2),min(l_apprx_MIA_C)),min(l_apprx_MIA_O1_1)),min(l_apprx_C));
max1 = max (max(max(max(l_apprx_O2),max(l_apprx_MIA_C)),max(l_apprx_MIA_O1_1)),max(l_apprx_C));

[rl_apprx_C rpmf_apprx_C] = convertToRangePMF(l_apprx_C,pmf_apprx_C,min1,max1,16);
[rl_apprx_O1_1 rpmf_apprx_O1_1] = convertToRangePMF(l_apprx_O1,pmf_apprx_O1,min1,max1,16);
[rl_apprx_O2 rpmf_apprx_O2] = convertToRangePMF(l_apprx_O2,pmf_apprx_O2,min1,max1,16);

[rl_apprx_MIA_C rpmf_apprx_MIA_C] = convertToRangePMF_MIA(l_apprx_MIA_C,pmf_apprx_MIA_C,min1,max1);
%hist(-1*H2
[rl_apprx_MIA_O1_1 rpmf_apprx_MIA_O1_1] = convertToRangePMF_MIA(l_apprx_MIA_O1_1,pmf_apprx_MIA_O1_1,min1,max1);

%hist(-1*H264_B,1000)

%% 
%check
%C
%{
figure
hold on
bar(-1*rl_apprx_C, rpmf_apprx_C)
plot(rl_apprx_MIA_C, rpmf_apprx_MIA_C,'r')
xlim([-500 500])
%} 

%O1
%{
figure
hold on
bar(-1*rl_apprx_O1, rpmf_apprx_O1)
plot(-1*rl_apprx_MIA_O1_1, rpmf_apprx_MIA_O1_1,'r')
xlim([00 10000])
%}

%%


MIA_O2_conv = conv(rpmf_apprx_MIA_C,rpmf_apprx_MIA_O1_1);
r_l_MIA_O2_conv = min1-max1:1:max1 - min1;
min1_extnd = min(r_l_MIA_O2_conv);
max1_extnd = max(r_l_MIA_O2_conv);
%[rl_r_l_MIA_O1_conv rpmf_MIA_O1_conv] = convertToRangePMF(r_l_MIA_O1_conv,MIA_O1_conv,min1_extnd,max1_extnd,16);
[rl_r_l_MIA_O2_conv rpmf_MIA_O2_conv] = quantizePMF_MIA(r_l_MIA_O2_conv,MIA_O2_conv,min1_extnd,max1_extnd);

%O2_quantized
%{
figure
hold on 
bar(r_l_MIA_O2_conv,MIA_O2_conv)
plot(rl_r_l_MIA_O2_conv, rpmf_MIA_O2_conv,'r')
%}


[rl_accur_O2_extnd rpmf_accur_O2_extnd] = convertToRangePMF(l_accur_O2,pmf_accur_O2,min1_extnd,max1_extnd,16);

HD_MIA_O2 = sqrt(1-sum(sqrt( rpmf_accur_O2_extnd.* rpmf_MIA_O2_conv)));

%%
%SAM
%find SAM after 1 propagation
H264_step2_miu = mean(H264_C) + H264_step1_miu % mean(H264_O1_appx);
%H264_step1_std = look up in a table

log2(std(H264_C))
2^15 % az marhale ghabl umade


H264_step2_std = 2^18; % look up in  table
H264_step2_w =1;

resp_apprx_2 = [H264_step2_miu, H264_step2_std, H264_step2_w ] ;
resp_apprx_Array_O2(1:3,1,1) = resp_apprx_2;

%%
%GMEE

itter1 = [1 2 4 5 6 10];
for itt= 4:4 % che tedad fit konim - vase moghayese bud dge alan az hamin estefade mikonim. aslio "20" ta fit migirim takhmine khodemuno "6" ta fit
itter = itter1(itt); % 1-2-4

resp_apprx_2 = findDist (H264_O2_appx,itter); % H264_O1_appx

size1 = size(resp_apprx_2);
resp_apprx_Array_O2(1:size1(1),1:size1(2),itt) = resp_apprx_2;

end

%%
%hellinger distances
%min1_flipped = -1*max1;
%max1_flipped = -1*min1;

[rl_SAM_O2_extnd rpmf_SAM_O2_extnd] = convertToRangePMF_norm(resp_apprx_Array_O2(:,:,1),1,min1_extnd,max1_extnd);%SAM
rpmf_SAM_O2_extnd = fliplr(rpmf_SAM_O2_extnd); % bara inke ina manfian ama dorostesh ine ke tu tike mosbat bashan
rl_SAM_O2_extnd = fliplr(rl_SAM_O2_extnd);

[rl_GMEE_2_extnd rpmf_GMEE_2_extnd] = convertToRangePMF_norm(resp_apprx_Array_O2(:,:,4),5,min1_extnd,max1_extnd);%GMEE
rpmf_GMEE_2_extnd = fliplr(rpmf_GMEE_2_extnd);
rl_GMEE_2_extnd = fliplr(rl_GMEE_2_extnd);

HD_SAM_O2 = sqrt(1-sum(sqrt(rpmf_accur_O2_extnd .* rpmf_SAM_O2_extnd)));
HD_GMEE_2 = sqrt(1-sum(sqrt(rpmf_accur_O2_extnd .* rpmf_GMEE_2_extnd)));

%% how to calculate EM !! so easy
%SAM - check shavad
resp_apprx_2 = resp_apprx_Array_O2(1:3,1,1);
resp_accur_2 = findDist (H264_O2,1);

appxPart_2 = sum(resp_apprx_2(1,:) .* resp_apprx_2(3,:)); % each mean * nomber of data/Area
accurPart_2 = resp_accur_2(1,:) .* resp_accur_2(3,:); % mean * 1

MED_estimated_SAM_2= abs (appxPart_2 - accurPart_2)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_SAM_2 = sum (  ((resp_apprx_2(1,:)-resp_accur_2(1,:)).^2 ).* resp_apprx_2(3,:))
SNR_estimated_SAM_2 = (resp_accur_2(2,:).^2) ./ MSE_estimated_2

PSNR_estimated_SAM_2 = ((resp_accur_2(1,:) + 3*resp_accur_2(2,:) ).^2) ./ MSE_estimated_SAM_2


%GMEE

resp_apprx_3 = resp_apprx_Array_O2(1:3,1:5,4);
resp_accur_3 = findDist (-1*H264_O2,5); % yani 5 ta be bi khata fit ko, simulaition ham manfie rasti



appxPart_3 = sum(resp_apprx_3(1,:) .* resp_apprx_3(3,:)); % each mean * nomber of data/Area
accurPart_3 = sum(resp_accur_3(1,:) .* resp_accur_3(3,:)); % mean * 1

MED_estimated_GMEE_2 = abs (appxPart_3 - accurPart_3)  
%MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated_GMEE_2 = sum (  ((resp_apprx_3(1,:)-resp_accur_3(1,:)).^2 ).* resp_apprx_3(3,:))
SNR_estimated_GMEE = (resp_accur_3(2,:).^2) ./ MSE_estimated

resp_accur_3 = findDist (H264_O1,5) % just to choose range
PSNR_estimated_GMEE_2 = ((resp_accur_3(1,:) + 3*resp_accur_3(2,:) ).^2) ./ MSE_estimated

%%

%O2_out
%{
figure
hold on 
bar(-1*rl_apprx_O2, rpmf_apprx_O2,'facecolor',[0.75 0.75 0.75],'edgecolor',[0.75 0.75 0.75])
plot(-1*rl_GMEE_2_extnd, rpmf_GMEE_2_extnd,'color',[0.5 0.3 0.3],'linewidth',2)
plot(rl_r_l_MIA_O2_conv, rpmf_MIA_O2_conv,'b')
plot(-1*rl_SAM_O2_extnd, rpmf_SAM_O2_extnd,'--','color',[0.2 0.5 0.1])
legend('SIM','GMEE','MIA','SAM')
%legend('SIM',strcat('GMEE - HD=',num2str(0.224)),strcat('SAM   - HD= ',num2str(0.952)),strcat('MIA    - HD= ',num2str(0.832)))
set(gca, 'FontSize', 7);
set(gcf, 'PaperPosition', [0 0 3.33 1.6]);
set(gca,'position',[0.05 0.2 0.9 0.7])
box off;
xlim([-2000 18000])
%ylim([0 0.00125])
ylim([0 0.00075])

%}