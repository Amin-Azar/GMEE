function [labels pmf] = convertToRangePMF_norm( Array,n,min,max )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here

labels = min:max;
count = max - (min-1);
pmf = zeros(1,count);


A = Array;
A = A( :,1:n); % ezafiasho pak konim! osulan ya yekie vase sam ya 6 tas vas khodemun

s_a = size(A); % bebinim chandta mixture e 


for i = 1:count
y=0;    
for j= 1:s_a(2)
y = y+sum(A(3,j)*normpdf(i+(min-1),A(1,j),A(2,j)));

end
 pmf(i)=y  ; 
end




end

