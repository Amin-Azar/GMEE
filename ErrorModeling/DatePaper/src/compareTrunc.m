% inja oomadim aval un 2 ta matrix e ke avalesh zero dasht ro hamsize
% kardim ba baghie. tu ye file dge be esme calulation o regress umadim
% unjaha ke sigma manfi ina mishod  va khali mizashtim ro ba 0 por kardim

%trunc ne ETAIIM


size1 = size(out_datas_appx);
size1 = size1(2);
miu1 = 0;
plotKon = 0; % bekeshe ya nakeshe
plotKon2 = 1; % bekeshe ya nakeshe

adjust =1 ;% age baham farg dashte bashan adjust 1 age na 0


aa = zeros([size1-1 1]);
bb = zeros([size1-1 1]);
dd = zeros([size1-1 1]);
ee = zeros([size1-1 1]);

yebar =1
if yebar
%% yebar ejra kon inaro dadash vagarna riiidi!
corr_out_datas = corr_out_datas(:,2:end); % un yedune zeros e aval o hazf mikonim intori
appx_out_datas = appx_out_datas(:,2:end); % un yedune zeros e aval o hazf mikonim intori
%% yebar bas ejra she!
end

for i =1:2:size1-1
if plotKon
subplot (size1,2,2*i-1)
hist(out_datas_accr(:,i+1),10000)
ylm1 = ylim;

subplot (size1,2,2*i)
hist(corr_out_datas(:,i+1),10000)

ylim(ylm1);

end
end
figure
for i =1:2:size1-1
    
    if plotKon2



subplot (size1,2,2*i-1)
hist(appx_out_datas(:,i+1),10000)
ylm1 = ylim;

subplot (size1,2,2*i)
hist(out_datas_appx(:,i+1),10000)
ylim(ylm1);
end
end


for i =2:size1-1
%B+A <->B tunc_  ETAIIM A
bb(i) = EM_med(out_datas_accr(:,i),appx_out_datas(:,i) , Nonums);
%B+A <->B ETAIIM A
aa(i) = EM_med(out_datas_accr(:,i),out_datas_appx(:,i) , Nonums);

dd(i) = EM_med(out_datas_accr(:,i),corr_out_datas(:,i) , Nonums);

ee(i) = EM_med(appx_out_datas(:,i),corr_out_datas(:,i) , Nonums);
end

uitable('Data', horzcat(aa,bb, bb - aa, 100*(bb-aa) ./ bb , dd,ee), 'ColumnName', {'estm', 'Trunc->ETAIM','AE' ,'ERR(%)','truncErr','ETAIM'}, 'Position', [20 20 5*700 250],'ColumnWidth',{90});
