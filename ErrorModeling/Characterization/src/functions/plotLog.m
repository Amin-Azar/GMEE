

x = 0.0001:0.0001:2^4;


figure
hold on

plot(x,round(log2(x)),'-.r')
plot(x,log2(round(x)),'--.g')
plot(x,log2((x)),'cyan')
plot(x,round(log2(round(x))))