function [ S_total,S_c_total ] = ETAIIM32 (A,B)
%ETAIIM32 Summary of this function goes here
%   Detailed explanation goes here


    
    N = 32;
    
    size_a = numel (A);
    size_b = numel (B);
    
    if (size_a ~= size_b)
        S = NaN; S_c = NaN;
    else
    
        
        
    S_total   = zeros(size_a,1);%S = dec2bin(S);
    S_c_total   = zeros(size_a,1);%S = dec2bin(S);

    for i =1: size_a
        
        
    Ab = dec2tc(A(i),N);
    Bb = dec2tc(B(i),N);
    
    Ab = fliplr(Ab);
    Bb = fliplr(Bb);

    c           = zeros (1 ,7); %c = dec2bin(c);
    c_dummy     = zeros (1 ,7); %c_dummy = dec2bin(c_dummy);
    S   = zeros ( 1,33);%S = dec2bin(S);
    
    
    c(1) = CGEN4 (Ab(1:4)    ,Bb(1:4)     , 0);		
	c(2) = CGEN4 (Ab(5:8)    ,Bb(5:8)     , 0);
	c(3) = CGEN4 (Ab(9:12)   ,Bb(9:12)    , 0);
   	c(4) = CGEN4 (Ab(13:16)  ,Bb(13:16)   , 0);  %door rikhte mishe carrysh
	c(5) = CGEN4 (Ab(17:20)  ,Bb(17:20)   , 0);  %propagate
    c(6) = CGEN4 (Ab(21:24)  ,Bb(21:24)   ,c(5)); %propagate
    c(7) = CGEN4 (Ab(25:28)  ,Bb(25:28)   ,c(6)); %propagate
    

	[S(33),S(29:32)]        = RCA4 (Ab(29:32)  ,Bb(29:32)   ,c(7));
	[c_dummy(7),S(25:28)]   = RCA4 (Ab(25:28)  ,Bb(25:28)   ,c(6)); %carya kolan dur rikhte mishe
	[c_dummy(6),S(21:24)]   = RCA4 (Ab(21:24)  ,Bb(21:24)   ,c(5));
	[c_dummy(5),S(17:20)]   = RCA4 (Ab(17:20)  ,Bb(17:20)   ,c(4));
	[c_dummy(4),S(13:16)]   = RCA4 (Ab(13:16)  ,Bb(13:16)   ,c(3));
	[c_dummy(3),S(9:12)]    = RCA4 (Ab(9:12)   ,Bb(9:12)    ,c(2));
	[c_dummy(2),S(5:8)]     = RCA4 (Ab(5:8)    ,Bb(5:8)     ,c(1));
    [c_dummy(1),S(1:4)]     = RCA4 (Ab(1:4)    ,Bb(1:4)     ,'0');


    
    S_c = tc2dec(fliplr(char(S(33))),N);
    S = tc2dec(fliplr(char(S(1:32))),N);
    
    S_total(i)= S;
    S_c_total(i) = S_c;
    
    end
    
    end

end

