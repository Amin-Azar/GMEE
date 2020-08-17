function [ DC1_flags ] = TrimVisualizeArray( DC1_smtsmw_mtx,findChar,replaceChar )
%TRIMVISUALIZEARRAY Summary of this function goes here
%   aval az akhare X Y pak mikone, bad index mizanim az avala ham pak
%   mikonim. bad replace mikonim harchimikhyam o string pas midim

DC1_flags = DC1_smtsmw_mtx;
% Delete emtpy columns from end
DC1_flags_EmptyCol=1;
while (DC1_flags_EmptyCol ==1 ) 
    if (sum(DC1_flags(:,end))== 0)
        DC1_flags = DC1_flags(:,1:end-1);
    else
        DC1_flags_EmptyCol =0;
    end
end
%Delete empty rows from end
DC1_flags_EmptyRow=1;
while (DC1_flags_EmptyRow ==1 ) 
    if (sum(DC1_flags(end,:))== 0)
        DC1_flags = DC1_flags(1:end-1,:);
    else
        DC1_flags_EmptyRow =0;
    end
end

%Concat indices
[DC1_X,DC1_Y]=size(DC1_flags);
DC1_flags =  vertcat(1:DC1_Y,DC1_flags);
DC1_flags =  horzcat(transpose(0:DC1_X),DC1_flags);

% Delete emtpy columns from begingin conserving indxing
DC1_flags_EmptyCol=1;
while (DC1_flags_EmptyCol ==1 ) 
    if (sum(DC1_flags(2:end,2))== 0)
        DC1_flags = horzcat(DC1_flags(:,1) ,DC1_flags(:,3:end));
    else
        DC1_flags_EmptyCol =0;
    end
end
%Delete empty rows from end
DC1_flags_EmptyRow=1;
while (DC1_flags_EmptyRow ==1 ) 
    if (sum(DC1_flags(2,2:end))== 0)
        DC1_flags= vertcat(DC1_flags(1,:) ,DC1_flags(3:end,:));
    else
        DC1_flags_EmptyRow =0;
    end
end

DC1_flags = num2str(DC1_flags);
%© better demonstration
%DC1_flags (DC1_flags ~= '0') = '©'
DC1_flags (DC1_flags == findChar) = replaceChar;


end

