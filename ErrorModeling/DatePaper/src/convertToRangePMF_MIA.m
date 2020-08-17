function [labels pmf] = convertToRangePMF_MIA( l,p,min1,max1 )
%FINDDIST Summary of this function goes here
%   Detailed explanation goes here

labels = min1:max1;
count = max1 - min1+1;
pmf = zeros(1,count);

i = count;
noBars = numel(l);
label_temp = l(1):l(end);
count_temp = numel(label_temp);
pmf_temp = zeros(1,count_temp);

min_temp = l(1);
%index 1 yani maslan -2^14 hast

i=1;
for j = 1:noBars % ru label harekat konim peyneshun o por konim

    step_go = abs(l(j));
    i= l(j)-min_temp+1;
    
    if(l(j)<-1)    %age tu manfia budim
        pmf_temp(i:i+(step_go/2)-1) = p(j)/(step_go/2);
        i = i + (step_go/2);
    elseif(abs(l(j)) == 1)
        pmf_temp(i) = p(j);
        i=i+1;
    elseif(abs(l(j)) == 0)
        pmf_temp(i) = p(j);
        i=i+1;  
    else% age tu mosbata budim
        pmf_temp(i:i+(step_go/2)-1) = p(j)/(step_go/2);
        i = i+ (step_go/2);
    end
  
   
end

%label o doros konim vase vaghti ke akharesham tu manfia bashe, ye gam dge
%baz bishtar mire dge

label_temp = l(1):l(1)+ numel(pmf_temp)-1;

    start_margin_out = label_temp(1) - labels(1); % mosbat yani pmf bozorg tare, avalash sefr
    end_margin_out = labels(end) - label_temp(end); % mosbat yani pmf bozorgtare, akharash sefr
    
    if(start_margin_out >0) % pmf_temp tu pmf e
            if(end_margin_out >0)
            
                pmf(1+start_margin_out: end - end_margin_out)  = pmf_temp;
            else % pmf avalesh bozorge vali akharesh aghabtar az temp e 
                pmf(1+start_margin_out: end) = pmf_temp(1:end + end_margin_out);
            
            end
    else
            if(end_margin_out >0) % yani avale pmf jolo tare ama akharesh bozorg tare
                pmf(1: end - end_margin_out)  = pmf_temp(1-start_margin_out:end);
            else % yani kolan temp bozorg tar bude
                pmf = pmf_temp(1-start_margin_out:end + end_margin_out);          
            end
    end
%{
while (i >0)
    %i
    indx = findIndexLabel(l,labels(i));
    if (indx == -1)
  %   pmf(i) =0;
     i = i-1;
    else
        %indx
        %p(indx)
        indx_pow2=abs(l(indx));% bere az tu list e label ha adad  ro ke tavan e 2 e maslan 256 ro darare
        
        % 0,-1,+1 special cases
        if(indx_pow2 ==1)
         pmf(i) = p(indx);   
         i = i-1;
        elseif(indx_pow2 ==0)
         pmf(i) = p(indx);  
         i = i-1;
        elseif(indx_pow2 ==2)
         pmf(i) = p(indx);  
         i = i-1;
        else  
            if (l(indx)<0) % vase indexaye manfi roo be manfi bzorogtar ger shode, pas be andaze gam mire jolo na nesfesh
                if( i-(indx_pow2)+1 < 1)
                  %pmf(1:i) = p(indx)/(indx_pow2/2);
                  pmf(1:i) = p(indx)/(indx_pow2/2);
                  break;
                end
                pmf(i:i+(indx_pow2/2)-1) = p(indx)/(indx_pow2/2);
                %pmf(i-(indx_pow2/2)+1:i) = p(indx)/(indx_pow2/2);
                i=i-(indx_pow2/2);
            else % vase adadaye mosbat be andaze nesfeshun mire jolo
                if( i-(indx_pow2/2)+1 < 1)
                  pmf(1:i) = p(indx)/(indx_pow2/2);
                  break;
                end 
        pmf(i-(indx_pow2/2)+1:i) = p(indx)/(indx_pow2/2);
        i=i-(indx_pow2/2);
            end
        
        end
end

%}

end

