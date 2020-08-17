%bebinim ke ba feln sigma adada tu che rangian
%hist(normrand_A)
normrand_A = normrnd(0, 2^15 , [7000 1])
normrand_B = normrnd(0, 2^15 , [7000 1])
figure
hold on
hist(log2(abs(normrand_A)))
hist(log2(abs(normrand_B)))

figure
hist(log2( abs(normrand_A + normrand_B) ))

log2(max(normrand_A))
log2(max(normrand_B))
log2(max(normrand_A + normrand_B))