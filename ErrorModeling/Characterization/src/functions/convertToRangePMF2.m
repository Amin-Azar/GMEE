function [labels pmf2] = convertToRangePMF2( l,p,min1,max1 )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here

labels = min1:max1;
count = max1 - (min1-1);
pmf = zeros(1,count);
pmf2 = zeros(1,count);


s_l = numel(l);

%bucket size is 1 by default
c= double(l(2) - l(1));
if (c <2)
    % no need to chunking
    for i = 1:s_l
        pmf(l(i) - (min1-1)) = p(i);
    end
    
    pmf2=pmf;
    
else

    % time consuming
    for i = 1:s_l-1
        
        j= l(i) -min1 +1;
        c= double(l(i+1) - l(i));
        currStep = p(i);
        nxtStep  = p(i+1); %p(i+)1 moadele pmf (i+b) mimune albate ye mosheli has ye yedune jabeja mishe tu har khat !
        step = (nxtStep-currStep)/c;
        
        if( nxtStep == currStep)
            %step = 0
            pmf2(j:j+c-1)= currStep*ones(1,c);
            
        else
            
            %beja inke avg ro bezarim vas hame ke yekhate saf mishe
            % ye khat az vasate har hist be badi mikeshi ba shib
            pmf2(j:j+c-1)= currStep:step:nxtStep-(step);
            
        end
    end
end

pmf2 = pmf2/ sum(pmf2);

end

