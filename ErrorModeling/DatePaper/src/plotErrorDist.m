
Len=size(out_datas_appx);
Len=Len(2);
%Nonums = 10000;
n=3; % tedad nemudarhaye joda
estm_dist=zeros(1);
for i=1:Len
   
    % avali result simulation o barmidare, dovomi truncation e 32 maslan ;)
%data_apprx=out_datas_appx(:,i);
data_apprx = 256*round(out_datas_accr(:,i)/256 - 0.2);

data_accur=out_datas_accr(:,i);
AE = data_accur - data_apprx;

format longG





%% how to calculate EM !! so easy
appxPart = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart = resp_accur(1,:) .* resp_accur(3,:); % mean * 1

MAE_estimated = abs (appxPart - accurPart)
    
MAE_calculated = EM_med(data_accur,data_apprx,Nonums)
%% az plotHist kesh raftam
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,2);
hist(data_apprx,2^15);
xlm1=xlim;
title(strcat('approximate addition'));


subplot(3,1,1);
hist(data_accur,2^15);
xlim(xlm1);
title(strcat('accurate addition'));

% error plot histogram

subplot(3,1,3);
h=hist(AE,max(AE)-min(AE));
sm=h(1);
bar(h(2:end))
title(strcat('Probability of accurate results: ',int2str(sm)));

uitable('Data', horzcat(resp_accur,resp_apprx), 'ColumnName', {'accur', 'app1','app2','app3', 'app4'}, 'Position', [20 20 700 100],'ColumnWidth',{125});
uitable('Data', horzcat(MAE_estimated,MAE_calculated, 100*(MAE_estimated-MAE_calculated)/MAE_calculated), 'ColumnName', {'MAE_estimated','MAE_calculated','Estimation err in %'}, 'Position', [20 150 700 50],'ColumnWidth',{200},'ColumnFormat',{'long'});

%%



display(i+1);
end