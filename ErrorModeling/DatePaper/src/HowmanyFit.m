
% l is defined somewhere else
%%
        % set this dists
        
% Nonums = 100000;
n=4; % tedad nemudarhaye joda

%% yadata haro az simulation ha ber ebekhune
if (1) 
in_appx_MIA = out_datas_appx_MIA;    
in_appx = out_datas_appx;
in_accr = out_datas_accr;
end
%% ya yechi trandom doros konim o khata daresham begim truncate hamuno begire bere jolo
if 0
m = 1 % number of bits to truncate
r=2^m;
in_accr = round(normrnd(0,10000,[100000 1]));
in_appx = r* round (in_accr/r);
end
%%
Len=size(in_appx); Len=Len(2);
estm_dist=zeros(1);

%figure('units','normalized','outerposition',[0 0 1 1])
%for i=1:Len
 for i = l:l %2:7 % inash fagat khub neshun dade shod
     
     
    % avali result simulation o barmidare, dovomi truncation e 32 maslan ;)
data_apprx=in_appx(:,i);
data_apprx_MIA = in_appx_MIA(:,i);
%data_apprx = 32*round(out_datas_accr(:,i)/32 - 0.2);

data_accur=in_accr(:,i);
AE = data_accur - data_apprx;

format longG
%std(data_accur)^2




subplot(7,2,2);
hist(data_apprx,2^12);
xlim([-1200000 600000]);
ylim([0 120]);

title(strcat('approximate addition'));


%hist(data_accur,10000);
%figure
%hist(data_apprx,10000);

%format shortEng
%display(resp_accur);
%display(resp_apprx);

%build  estimated dist+

resp_accur = findDist (data_accur,1) % takhmini az reference
%resp_apprx_MIA = findDist (data_apprx_MIA,10);
%resp_apprx_estimated = findDist (data_apprx,10); %farz mikonim ke in dge takhmine kheili khubie, almost khdoeshe ke bagiaram ba in mogayes ekonim
resp_apprx_Array = zeros(3,10,8);
itter1 = [1 2 4 5 6 10];
for itt= 1:6 % che tedad fit konim - vase moghayese bud dge alan az hamin estefade mikonim. aslio "20" ta fit migirim takhmine khodemuno "6" ta fit
itter = itter1(itt); % 1-2-4

resp_apprx = findDist (data_apprx,itter)
size1 = size(resp_apprx);
resp_apprx_Array(1:size1(1),1:size1(2),itt) = resp_apprx;

dist_1 = round (normrnd(round( resp_apprx(1,1)), round(resp_apprx(2,1)), [round(resp_apprx(3,1)*Nonums) 1]) );  
%dist1 = round(dist_1);
estm_dist = dist_1;
for j=2:itter 
dist_1 = round(normrnd(resp_apprx(1,j),resp_apprx(2,j), [round(resp_apprx(3,j)*Nonums) 1])) ;  
% dist1 = round(dist_1);
estm_dist = vertcat(estm_dist,dist_1);
end

%% how to calculate EM !! so easy
appxPart = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart = resp_accur(1,:) .* resp_accur(3,:); % mean * 1

MAE_estimated = abs (appxPart - accurPart)  
MAE_calculated = EM_med(data_accur,data_apprx,Nonums)

MSE_estimated = sum (  ((resp_apprx(1,:)-resp_accur(1,:)).^2 ).* resp_apprx(3,:))
SNR_estimated = (resp_accur(2,:).^2) ./ MSE_estimated

PSNR_estimated = ((resp_accur(1,:) + 3*resp_accur(2,:) ).^2) ./ MSE_estimated


subplot(7,2,2*itt + 2);
%histogram(data_apprx,2^15);
hold on
hist(estm_dist,2^12);
xlim([-1200000 600000]);
ylim([0 120]);
title(strcat('Using ',int2str(itter), ' gaussian mixtures'));
%h.FaceColor = [0 0.5 0.5];


uitable('Data', horzcat(resp_accur,resp_apprx), 'ColumnName', {'accur', 'app1','app2','app3', 'app4'}, 'Position', [20 1500-itt*200 1.5*700 100],'ColumnWidth',{125});
uitable('Data', horzcat(MAE_estimated,MAE_calculated, 100*(MAE_estimated-MAE_calculated)/MAE_calculated), 'ColumnName', {'MAE_estimated','MAE_calculated','Estimation err in %'}, 'Position', [20 1650-itt*200 700 50],'ColumnWidth',{200},'ColumnFormat',{'long'});

%%

end



display(i+1);
 end

 save ('~/params.mat')