function [ Cout ] = CGEN4_vec( Ab,Bb,Cin )
%CGEN4_VEC Summary of this function goes here
%inja Cin bayad double biad! na str


%make char logical
Ab = Ab - 48;
Bb = Bb - 48;

G = bitand(Ab,Bb); %Generattion
P = bitor(Ab,Bb); %Propagatation


Cout = G(:,4) | (P(:,4) & G(:,3)) | (P(:,4) & P(:,3) & G(:,2)) | (P(:,4) & P(:,3) & P(:,2) & G(:,1)) | (P(:,4) & P(:,3) & P(:,2) & P(:,1) & Cin);



end


