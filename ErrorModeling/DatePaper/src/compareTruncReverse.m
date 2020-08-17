%trunc ne ETAIIM
%ETAIM be trunc

abs_errors= zeros([size1 1 ]);

for trunc = 2:8
%% truncate
% inja A ro hamun negar midarim, B ro truncate mikonim bebinim chi mishe
% natijash az bad az khode adder ETAIIM baz
m = trunc% number of bits to truncate
r=2^m;
%%


size1 = size(out_datas_appx);
size1 = size1(2);
miu1 = 0;
plotKon = 0; % bekeshe ya nakeshe

%figure

aa = zeros([size1-1 1]);
bb = zeros([size1-1 1]);
dd = zeros([size1-1 1]);

for i =1:size1-1

normrand_C = miu1 + normrnd(0, 2^(2*i -1) , [Nonums 1]);
normrand_C = round ( normrand_C ) ;


out_datas_accr_exact =out_datas_accr(:,i+1) + normrand_C;
out_datas_appx_exact = out_datas_appx(:,i+1)  + normrand_C;

out_datas_appx_trunc= r*round ((out_datas_appx_exact)/r - 0.05);

if plotKon
subplot (size1,2,2*i)
hist(out_datas_appx_trunc,10000)
ylm1 = ylim;

subplot (size1,2,2*(i-1)+1)
hist(out_datas_appx_exact,10000)
ylim(ylm1);
end


%A+B+C <-> ETAIIM + C
aa(i) = EM_med(out_datas_accr_exact,out_datas_appx_exact, Nonums);
% A+B+C <-> A_ETAIIM_B_TRUNC_C

bb(i)=EM_med(out_datas_accr_exact,out_datas_appx_trunc, Nonums);

dd(i) = EM_med(out_datas_appx_exact,out_datas_appx_trunc, Nonums);
end



uitable('Data', horzcat(aa,bb, bb - aa, 100*(bb-aa) ./ bb , 100*( bb - (aa + 2^(m-2)) )./bb ,dd    , bb - aa  - dd), 'ColumnName', {'ETAIIM', 'ETAIIM->Trunc','AE' ,'ERR(%)','estERR(%)', 'Err_truncAdd',' AE - Err_truncAdd'}, 'Position', [20 20 5*700 250],'ColumnWidth',{90});

%tbl3 = table(bb,aa,'VariableNames',{'bb','aa'});
%fitlm(tbl3,'bb~aa')
abs_errors =horzcat( abs_errors, vertcat(trunc,bb-aa));



end


