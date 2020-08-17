

%%
        % set this dists
        
 Nonums = 100000;
n=20; % tedad nemudarhaye joda

%% yadata haro az simulation ha ber ebekhune
if (1) 
    
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

for i=1:Len
     
     
    % avali result simulation o barmidare, dovomi truncation e 32 maslan ;)
data_apprx=in_appx(:,i);
%data_apprx = 32*round(out_datas_accr(:,i)/32 - 0.2);

data_accur=in_accr(:,i);
AE = data_accur - data_apprx;

format longG
%std(data_accur)^2


resp_accur = findDist (data_accur,1)
resp_apprx = findDist (data_apprx,n)



%hist(data_accur,10000);
%figure
%hist(data_apprx,10000);

%format shortEng
%display(resp_accur);
%display(resp_apprx);

%build  estimated dist+

 dist_1 = round (normrnd(round( resp_apprx(1,1)), round(resp_apprx(2,1)), [round(resp_apprx(3,1)*Nonums) 1]) );  
 %dist1 = round(dist_1);
estm_dist = dist_1;
for j=2:n
    
 dist_1 = round(normrnd(resp_apprx(1,j),resp_apprx(2,j), [round(resp_apprx(3,j)*Nonums) 1])) ;  
% dist1 = round(dist_1);
estm_dist = vertcat(estm_dist,dist_1);

end

%% how to calculate EM !! so easy
appxPart = sum(resp_apprx(1,:) .* resp_apprx(3,:)); % each mean * nomber of data/Area
accurPart = resp_accur(1,:) .* resp_accur(3,:); % mean * 1

MAE_estimated = abs (appxPart - accurPart)
    
MAE_calculated = EM_med(data_accur,data_apprx,Nonums)
%% az plotHist kesh raftam
figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,2,2);
hist(data_apprx,2^15);
xlm1=xlim;
title(strcat('approximate addition'));
subplot(3,2,4);
hist(estm_dist,2^15);
xlim(xlm1);
title(strcat('estimated addition'));

subplot(3,2,1);
hist(data_accur,2^15);
xlim(xlm1);
title(strcat('accurate addition'));

% error plot histogram
subplot(3,2,3);
hist(AE,2^15); % h = ...
sm=sum(AE==0) % in ham mishode dge sm=h(1);
title(strcat('Probability of accurate results: ',int2str(sm)));




uitable('Data', horzcat(resp_accur,resp_apprx), 'ColumnName', {'accur', 'app1','app2','app3', 'app4'}, 'Position', [20 20 5*700 100],'ColumnWidth',{125});
uitable('Data', horzcat(MAE_estimated,MAE_calculated, 100*(MAE_estimated-MAE_calculated)/MAE_calculated), 'ColumnName', {'MAE_estimated','MAE_calculated','Estimation err in %'}, 'Position', [20 150 700 50],'ColumnWidth',{200},'ColumnFormat',{'long'});

%%



display(i+1);
end