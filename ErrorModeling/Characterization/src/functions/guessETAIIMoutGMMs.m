function [ addedGMMs,indices1,out_guess ] = guessETAIIMoutGMMs( in_GMMs1, in_GMMs2,in_Indx1,in_Indx2,plotIt )
%GUESSETAIIMOUTGMMS Summary of this function goes here
%   Detailed explanation goes here

    %make it column-wise
    if size(in_GMMs1,1) == 1 %row vector
            in_GMMs1 = in_GMMs1.';
    end
    
    if size(in_GMMs2,1) == 1 %row vector
            in_GMMs2 = in_GMMs2.';
    end
    
    GMMs = 5; % 5 ta GMM tolid mikone
    
    % first bat ya inke hame corrrect partan
    if (nargin < 3)
      in_Indx1 = logical(zeros(1,numsamples(in_GMMs1)));
      in_Indx2 = logical(zeros(1,numsamples(in_GMMs2)));
    end
    
    
s=size(in_GMMs1);
size_GMM1 = s(2);

s=size(in_GMMs2);
size_GMM2 = s(2);

addedGMMs = zeros (3,GMMs* size_GMM1*size_GMM2);
indices = zeros (1,GMMs* size_GMM1*size_GMM2);
% run mikonim bebinim chandta sample bude
%[addedGMMs(:,1:1+GMMs-1),out_guess, NOsamples] = guessETAIIMout( inputGMMs1(:,1), inputGMMs2(:,1));
NOsamples = 10000;
out_appx_guess = zeros (NOsamples,size_GMM1*size_GMM2);


for i= 1:size_GMM1
    for j= 1:size_GMM2
        indx = (i-1)*size_GMM2+j;
        
        adjust_w = in_GMMs1(3,i)*in_GMMs2(3,j);
        ErORCrr = in_Indx1(i) | in_Indx2(j);
        
        [addedGMMs(:,GMMs*(indx-1)+1:GMMs*indx),indices(1,GMMs*(indx-1)+1:GMMs*indx),out_appx_guess(:,indx)] = guessETAIIMout( in_GMMs1(:,i), in_GMMs2(:,j));
        indices(1,GMMs*(indx-1)+1:GMMs*indx) = indices(1,GMMs*(indx-1)+1:GMMs*indx) | ErORCrr;
        addedGMMs(3,GMMs*(indx-1)+1:GMMs*indx) = adjust_w *addedGMMs(3,GMMs*(indx-1)+1:GMMs*indx);
    end
end

if nargin >4
plotGMMs_ErrCrr(addedGMMs,indices,out_appx_guess);
end

%sort
[tmp , indx] = sort(addedGMMs(3,:),'descend');
addedGMMs = addedGMMs(:, indx);
indices1 = indices(:, indx);

%plot data va takhmina baham ke ziad be kar nemiad vaghti sigma ziad mishe
%{
figure;
histDATA(out_appx_guess,1,1);
title('many gmms');
hold on
plotGMMs(addedGMMs,out_appx_guess);
%}


    

end

