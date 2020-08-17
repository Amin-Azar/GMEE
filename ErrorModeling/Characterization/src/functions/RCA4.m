function [ Cb_c,Cb ] = RCA4( Ab,Bb,Cin )
%RCA4 Summary of this function goes here
%   Detailed explanation goes here

%A bit and B bit have been flipped at ETAIIM32
Ab = fliplr(Ab);
Bb = fliplr(Bb);

C= bin2dec(num2str(Ab))+bin2dec(num2str(Bb))+bin2dec(num2str(Cin));
Cb = dec2bin(C,5);
Cb = fliplr(Cb); % jahate array tu inja ba chizi ke ma tu bin midunim farg dare
Cb_c = Cb(5);
Cb = Cb(1:4);

end

