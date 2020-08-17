function [ output_args ] = histDATA( array,flag,fig,color )
%HISTDATA Summary of this function goes here
%   Detailed explanation goes here


 %age chand bodiam bud ba ye array konim bere dge
 
 array = array(:);
NoSamples = max(array) - min (array) +1 ; 
%NoSamples

if (NoSamples > 2^19)
    NoSamples = 2^19;
end

%figure;
[h_y,h_x] = hist(array,NoSamples);

% flag =1 yani inke tabdil kon be Probability. (sum =1)
if (flag ==1)
    h_y = h_y / sum(h_y);
end

if nargin <4
    color = 'blue';
end
    


if nargin <3
    scatter(h_x,h_y,'.',color);
else
    plot(h_x,h_y,'color',color);
end

title(['Samples=',num2str(NoSamples)]);
end

