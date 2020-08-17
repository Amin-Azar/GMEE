function [ OUT_dec_vec ] = maskDEC( IN_dec_vec ,n)
%MASKDEC Summary of this function goes here
%   n= number of bits is going to be masked from Real & Imagginary parts

if ( n <1)
    OUT_dec_vec = IN_dec_vec;
else
    
RL_fft = real(IN_dec_vec);
IM_fft = imag(IN_dec_vec);

RL_fft_ieee = dec2IEEE754(RL_fft, 64);
IM_fft_ieee = dec2IEEE754(IM_fft, 64);

RL_fft_ieee_new = maskBits(RL_fft_ieee, n);
IM_fft_ieee_new = maskBits(IM_fft_ieee, n);

RL_fft_new = IEEE7542dec(RL_fft_ieee_new);
IM_fft_new = IEEE7542dec(IM_fft_ieee_new);

OUT_dec_vec = complex (RL_fft_new, IM_fft_new);
OUT_dec_vec = OUT_dec_vec.';
end

end

