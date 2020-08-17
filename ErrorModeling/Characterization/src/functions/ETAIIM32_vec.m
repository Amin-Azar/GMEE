function [ S,S_c ] = ETAIIM32_vec (A,B)
%ETAIIM32_VEC Summary of this function goes here
%   Detailed explanation goes here



    
    N = 32;
    

    %make it column-wise
    if size(A,1) == 1 %row vector
            A = A.';
    end
    
    if size(B,1) == 1 %row vector
            B = B.';
    end
    
    elemnts = numel (A);
        
    
    if (elemnts ~= numel (B))
        S = NaN; S_c = NaN;
    else
    
        
        


        
        
    Ab = dec2tc(A,N);
    Bb = dec2tc(B,N);
    
    Ab = fliplr(Ab);
    Bb = fliplr(Bb);

    c           = zeros (elemnts ,7); %c = dec2bin(c);
    c_dummy     = zeros (elemnts ,7); %c_dummy = dec2bin(c_dummy);
    S   = zeros ( elemnts,33);%S = dec2bin(S);
    
    
    c(:,1) = CGEN4_vec (Ab(:,1:4)    ,Bb(:,1:4)     ,zeros(elemnts,1));		
	c(:,2) = CGEN4_vec (Ab(:,5:8)    ,Bb(:,5:8)     ,zeros(elemnts,1));
	c(:,3) = CGEN4_vec (Ab(:,9:12)   ,Bb(:,9:12)    ,zeros(elemnts,1));
   	c(:,4) = CGEN4_vec (Ab(:,13:16)  ,Bb(:,13:16)   ,zeros(elemnts,1));  %door rikhte mishe carrysh
	c(:,5) = CGEN4_vec (Ab(:,17:20)  ,Bb(:,17:20)   ,zeros(elemnts,1));  %propagate
    c(:,6) = CGEN4_vec (Ab(:,21:24)  ,Bb(:,21:24)   ,c(:,5)); %propagate
    c(:,7) = CGEN4_vec (Ab(:,25:28)  ,Bb(:,25:28)   ,c(:,6)); %propagate
    

	[S(:,33),S(:,29:32)]        = RCA4_vec (Ab(:,29:32)  ,Bb(:,29:32)   ,c(:,7));
	[c_dummy(:,7),S(:,25:28)]   = RCA4_vec (Ab(:,25:28)  ,Bb(:,25:28)   ,c(:,6)); %carya kolan dur rikhte mishe
	[c_dummy(:,6),S(:,21:24)]   = RCA4_vec (Ab(:,21:24)  ,Bb(:,21:24)   ,c(:,5));
	[c_dummy(:,5),S(:,17:20)]   = RCA4_vec (Ab(:,17:20)  ,Bb(:,17:20)   ,c(:,4));
	[c_dummy(:,4),S(:,13:16)]   = RCA4_vec (Ab(:,13:16)  ,Bb(:,13:16)   ,c(:,3));
	[c_dummy(:,3),S(:,9:12)]    = RCA4_vec (Ab(:,9:12)   ,Bb(:,9:12)    ,c(:,2));
	[c_dummy(:,2),S(:,5:8)]     = RCA4_vec (Ab(:,5:8)    ,Bb(:,5:8)     ,c(:,1));
    [c_dummy(:,1),S(:,1:4)]     = RCA4_vec (Ab(:,1:4)    ,Bb(:,1:4)     ,zeros(elemnts,1));


    
    S_c = tc2dec(fliplr(char(S(:,33))),N);
    S = tc2dec(fliplr(char(S(:,1:32))),N);
    
    end

    
end

