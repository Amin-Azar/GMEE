function [value] = tc2dec(bin,N)
%TC2DEC Summary of this function goes here
%   Detailed explanation goes here

val = bin2dec(bin);

y = sign(2^(N-1)-val) .* (2^(N-1)-abs(2^(N-1)-val));


value = y;
indxs1 = find (y==0);
indxs2 = find(val ~=0);
indxs = intersect ( indxs1,indxs2);
value (indxs) = -val(indxs);

%{
if ((y == 0) && (val ~= 0))
value = -val;
else
value = y;
end
%}
end 


