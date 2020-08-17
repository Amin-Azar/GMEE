D1 = out_datas_appx(:,1);
D2 = out_datas_appx_MIA(:,1);

minRange = min (min(D1),min(D2));
maxRange = max ( max(D1), max(D2));

[l_D1 pmf_D1] = convertToPMF(D1);
[l_D2 pmf_D2] = convertToPMF(D2);

[rl_D1 rangepmf_D1] = convertToRangePMF(l_D1,pmf_D1,minRange,maxRange);
[rl_D2 rangepmf_D2] = convertToRangePMF(l_D2,pmf_D2,minRange,maxRange);

plot(rangepmf_D1);
plot(rangepmf_D2);
