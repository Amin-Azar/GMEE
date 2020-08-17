function [ r_GMMs,r_err_indx ] = reduceGMMcnt( inputGMMs ,err_indx, reduceTo)
%REDUCEGMMS Summary of this function goes here
%   garare maslan 36 ta guassian e tolid shode az convolution o bedim inja
%   dobare 6 ta vardarim. 5 ta gondash o nega midarim, akhariaro avg
%   migirim az baghie.

s = numsamples(inputGMMs);




%{
%sort
[tmp , indices] = sort(inputGMMs(3,:),'descend');
sortedInputGMMs = inputGMMs(:, indices);
sorted_err_indx = err_indx(indices);

%1
%scale konim bere
reducedGMMs = sortedInputGMMs(:,1:reduceTo);
reduced_err_indx = sorted_err_indx(1:reduceTo);
portionWs = 1 / sum(reducedGMMs(3,:));
reducedGMMs(3,:) =  reducedGMMs(3,:) * portionWs;
%}



%2
%combine konim

rng = sqrt(2)-1; % 40%

c_GMMs = inputGMMs;
c_indx = err_indx;

for i=1:s
    
    j=i+1;
    while(j <s)
        
        mu_I = c_GMMs(1,i);
        mu_J = c_GMMs(1,j);
        
        %{
        disp([ 's:',num2str(s)]);
        disp([ 'i:',num2str(i),'|',num2str(round(mu_I))]);
        disp([ 'j:',num2str(j),'|',num2str(round(mu_J))]);
        %}
        
        if ( (min((1-rng)*mu_I,(1+rng)*mu_I) < mu_J) && (mu_J < max((1-rng)*mu_I,(1+rng)*mu_I)) && (c_indx(i) == c_indx(j)) ) % age miu ha tu ye holo howsh bood
            
            c_GMMs(:,i) = combineGMMs(c_GMMs(:,i),c_GMMs(:,j));
            c_GMMs(:,j)=[]; %j o hazf kon
            c_indx(:,j)=[]; %index ezafiaram pak konim bere dg
            s = s-1;
        else
            j=j+1;
            
        end
    end
    
end

r_GMMs = c_GMMs;
r_err_indx = c_indx;

%remove items has weigh less than w_th
w_th = 0.0002;
inx_smallW = r_GMMs(3,:) < w_th;
r_GMMs ( :,inx_smallW) =[];
r_err_indx(inx_smallW) =[];
portionWs = 1 / sum(r_GMMs(3,:));
r_GMMs(3,:) =  r_GMMs(3,:) * portionWs;

if nargin >2 % nages shod inja
    reduceTo = 5;
end



end
