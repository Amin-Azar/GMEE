function [labels pmf] = convertToRangePMF_norm( Array,array_bgn,array_end )
%   gets Array contatining GMMs and extract pmf of of it from array_bgn to array_end

labels = array_bgn:array_end;
%count = array_end - (array_bgn-1);
pmf = zeros(1,numel(labels));
labels = double(labels);

A = Array; % 2D ba harchangta mixture!
s_a = size(A); % bebinim chandta mixture e

for j= 1:s_a(2)
    pmf = pmf + A(3,j)*normpdf(labels ,A(1,j),A(2,j));
end


end

