function [ Cout ] = CGEN4( Ab,Bb,Cin )
%CGEN4 Summary of this function goes here
%   Detailed explanation goes here


%make char logical
Ab = Ab - 48;
Bb = Bb - 48;

G = bitand(Ab,Bb); %Generattion
P = bitor(Ab,Bb); %Propagatation


Cout = G(4) | (P(4) & G(3)) | (P(4) & P(3) & G(2)) | (P(4) & P(3) & P(2) & G(1)) | (P(4) & P(3) & P(2) & P(1) & Cin);



end

