function [labels pmf2] = convertToRangePMF( l,p,min1,max1,bucket )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here

labels = min1:max1;
count = max1 - (min1-1);
pmf = zeros(1,count);
pmf2 = zeros(1,count);

%untike az pmf ke p tush ja shode
%pmf( (l(1)-min1+1):(l(end)-min1+1) ) = p;

s_l = numel(l);

for i = 1:s_l
pmf(l(i) - (min1-1)) = p(i);   
end


%bucket size is 1 by default
    b=1;
if (bucket <2)
    % no need to chunking
    pmf2=pmf;
else
    b=bucket;
    % time consuming
    for i = 1:b:count-b
        pmf2(i:i+b-1) = sum(pmf(i:i+b-1))/b;
    end
end

end

