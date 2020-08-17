function [ lables pmf ] = quantizePMF_MIA( l,p,min1,max1 )
%QUANTIZEPMF_MIA Summary of this function goes here
%   age khode datil o nadashtim o khastim az ru pmf quantize konim


count = max1-min1+1;

lables = min1:max1;
pmf = zeros(1,count);


sign_min =1;
if(min1<0)
    sign_min =-1;
end
min1_pow2 = sign_min * 2^(ceil(log2(abs(min1))));


sign_max =1;
if(max1<0)
    sign_max =-1;
end
max1_pow2 = sign_max * 2^(ceil(log2(abs(max1))));


i = count;


while (i >0)
        
        
    if(max1_pow2 >2) %adade 3 be bala

 while ( l(i) > max1_pow2/2 ) % yani khode tavan do inja nabashe
    i = i-1;
 end     

 
  
 if(i+max1_pow2/2 > count) % osulan faghat bas vase dafe aval bas bashe - upper bound
      temp_p = sum(p(i: count));
     pmf(i: count)= temp_p/ (max1_pow2/2);
     %i = i -count +1;
     
 else
      temp_p = sum(p(i: i + max1_pow2/2 -1));
      pmf(i: i+max1_pow2/2-1)= temp_p/ (max1_pow2/2);
 end
   
    max1_pow2 = max1_pow2/2;
    
    
    elseif ( abs(max1_pow2) <3) % 0 o 1 o -1 , 2 ,-2
        pmf(i) = p(i);
        i = i-1;
        max1_pow2 = max1_pow2 -1;
        

    else % -3 be payin
        if(max1_pow2 == -3)
            max1_pow2 = -2;
        end
        
        if( min1_pow2 < max1_pow2*2) % age hanuz ye gam munde be akharie, age na ke dge halle
            while ( l(i)+1 > max1_pow2*2 )
            i = i-1;
            end   
        end
        
         if(i+max1_pow2 < 1)
         temp_p = sum(p(1: i));  
         pmf(1: i)= temp_p/ max1_pow2;
         i=0;
         else
         temp_p = sum(p(i: i + abs(max1_pow2) -1)); 
         pmf(i: i+abs(max1_pow2)-1)= temp_p/ abs(max1_pow2);
         end    
        
         max1_pow2 = max1_pow2*2;
        
           
     
    end
    
end



end

