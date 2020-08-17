function [  ] = plotGMMs_ErrCrr( input_GMMs, err_indx, range_data )
%PLOTGMMS_ERRCRR Summary of this function goes here
%   bakhshe err o correcto khodesh kjoda mikone o RED o GREEN mikeshe


indx1 = logical ( err_indx); %  Err part indices
indx2 = logical(abs(err_indx -1));

GMMs_ERR = input_GMMs(:, indx1);
GMMs_CRR = input_GMMs(:, indx2);

figure('units','normalized','outerposition',[0 0 1 1])
%plotGMMs([in1m+in2m;sqrt(in1s^2 + in2s^2);1],out_appx_guess,'blue');
hold on;
plotGMMs(GMMs_ERR,range_data,'red');
hold on;
plotGMMs(GMMs_CRR,range_data,'green');
%title('Blue: actual ADD - Green: correct part - Red: error part');
title('Green: correct part - Red: error part');

end

