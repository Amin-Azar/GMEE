%%
1
test = zeros(100,1);

for i= 1:100
test(i) = ETAIIM32(-i,0);
end

plot(-100:-1,flipud(test))
hold on 
plot(-100:-1,-100:-1,'--.r');

test2 = zeros(100,1);

for i= 1:100
test(i) = ETAIIM32(i,0);
end

plot(1:100,(test))
hold on 
plot(1:100,1:100,'--.r');
hold off


%%
2


%A = 524000:575000;
%B = 522000:2:624001;

%AB1+AB2 = N
samplesAround = 5000;
N = 4130
mn = N/2;
AB1 = mn-samplesAround;
AB2 = mn+samplesAround;
%A  = AB1:AB2;
%B  = fliplr(AB1:AB2);

%ino darim estefade mikonim ke bebinim az kojaha mitune umade bashe natije
%jame
A  = mn:AB2;
B = fliplr(AB1:mn)

%A= 1000:2000;
%B = 500 : 4 : 4500;

%ino estefade kardim ke halate manfisho dark konim
%B = 2^5 -1;
%A = -1;

ApB = transpose(A + B);
AEB = ETAIIM32(A,B);

diffEp = AEB -ApB;

diff_log = round(log2(abs(diffEp)));
diff_log(diffEp ==0) =0;
diff_log(diffEp <0) = -diff_log(diffEp <0)

plot(A, diff_log ,'--.r');

plot(ApB, diff_log ,'--.r');
hold off


plot(ApB, diffEp ,'--.g');

hold on
plot(ApB, AEB);
plot(ApB,ApB,'-.r');

%%
3
A = round(normrnd(500,30,[10000 1]));
B = round(normrnd(500,60,[10000 1]));

AEB = ETAIIM32(A,B);
hist (AEB,1000);


%%
N = 2310;4130
indx = find(ApB == N);
test_A = dec2tc(A(indx),32);
test_B = dec2tc(B(indx),32);
test_ApB = dec2tc(ApB(indx),32);
test_AEB = dec2tc(AEB(indx),32);
test_diff = dec2tc(abs(diffEp(indx)),32);

disp(['  A: ',test_A(1:4),' | ',test_A(5:8),' | ',test_A(9:12),' | ',test_A(13:16),' | ',test_A(17:20),' | ',test_A(21:24),' | ',test_A(25:28),' | ',test_A(29:32),'  = ',num2str(A(indx))]);
disp(['  B: ',test_B(1:4),' | ',test_B(5:8),' | ',test_B(9:12),' | ',test_B(13:16),' | ',test_B(17:20),' | ',test_B(21:24),' | ',test_B(25:28),' | ',test_B(29:32),'  = ',num2str(B(indx))]);
disp(['A+B: ',test_ApB(1:4),' | ',test_ApB(5:8),' | ',test_ApB(9:12),' | ',test_ApB(13:16),' | ',test_ApB(17:20),' | ',test_ApB(21:24),' | ',test_ApB(25:28),' | ',test_ApB(29:32),'  = ',num2str(ApB(indx))]);
disp(['AeB: ',test_AEB(1:4),' | ',test_AEB(5:8),' | ',test_AEB(9:12),' | ',test_AEB(13:16),' | ',test_AEB(17:20),' | ',test_AEB(21:24),' | ',test_AEB(25:28),' | ',test_AEB(29:32),'  = ',num2str(AEB(indx))]);
disp(['Err: ',test_diff(1:4),' | ',test_diff(5:8),' | ',test_diff(9:12),' | ',test_diff(13:16),' | ',test_diff(17:20),' | ',test_diff(21:24),' | ',test_diff(25:28),' | ',test_diff(29:32),'  = ',num2str(diffEp(indx))]);