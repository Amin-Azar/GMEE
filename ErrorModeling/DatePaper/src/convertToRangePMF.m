function [labels pmf2] = convertToRangePMF( l,p,min1,max1,bucket )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here

labels = min1:max1;
count = max1 - (min1-1);
pmf = zeros(1,count);
pmf2 = zeros(1,count);

s_1 = numel(l);

%bucket size is 1 by default
b=bucket;
%inja ru label harekat mikonim o tu index pmf minvisim
for i = 1:s_1
pmf(l(i) - (min1-1)) = p(i);   
end



for i = 1:b:count-b
    pmf_temp=0;
    for j =1:b
    pmf_temp =pmf_temp+ pmf(i+j-1);
    end
pmf2(i:i+b-1) = pmf_temp/b;   
end



% inja ru pmf harekat mardim ta az label peyda konim
%{
labels = min:max;
count = max - (min-1);

for i = 1:count
    i
    indx = findIndexLabel(l,labels(i));
    if (indx == -1)
     pmf(i) =0;
    else
        l(indx)
    pmf(i) = p(indx);
    end
end
%}


end

