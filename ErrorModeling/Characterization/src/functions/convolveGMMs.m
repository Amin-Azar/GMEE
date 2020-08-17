function [ convolvedGMMs ] = convolveGMMs( inputGMMs1, inputGMMs2 )
%CONVOLVEGMMS Summary of this function goes here
%   Detailed explanation goes here

s=size(inputGMMs1);
size_GMM1 = s(2);
s=size(inputGMMs2);
size_GMM2 = s(2);

convolvedGMMs = zeros (3,size_GMM1*size_GMM2);

for i= 1:size_GMM1
    for j= 1:size_GMM2
        indx = (i-1)*size_GMM2+j;
        convolvedGMMs(1,indx) = inputGMMs1(1,i)+inputGMMs2(1,j);
        convolvedGMMs(2,indx) = sqrt((inputGMMs1(2,i))^2+(inputGMMs2(2,j))^2);
        convolvedGMMs(3,indx) = inputGMMs1(3,i)*inputGMMs2(3,j);
    end
end


%sort
[tmp , indices] = sort(convolvedGMMs(3,:),'descend');
convolvedGMMs = convolvedGMMs(:, indices);


end

