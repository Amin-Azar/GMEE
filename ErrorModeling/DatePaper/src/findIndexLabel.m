function indx = findIndexLabel( label,fi )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here



s = numel(label);
indx =-1;
for i = 1:s(1)
    if( label(i) == fi)
        indx= i;
       break; 
    end



end

