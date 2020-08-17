function [ test_l, test_pmf ] = convertToPMF2( arrayOfData, c )
%CONVERTTOPMF2 Summary of this function goes here
%   Detailed explanation goes here

% c = chunk

elems = numel(arrayOfData);

size1 = max(arrayOfData) - min(arrayOfData) +1;
[ test_pmf test_l] = hist ( arrayOfData,round(size1/c));

test_l = int64 (test_l);
test_pmf = test_pmf/elems;

end

