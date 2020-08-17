%initialization
%{
%    inja test mikonim bebinim ke convolution vagean hamun natije ke
mikhaym o ru dade haye asli mide ya na!
yani concat konim 2 ta data ro o shuffle konim o ...
%}
sample_num =20000;

s1=round(10*rand(1));
s3=round(10*rand(1));
s4=round(10*rand(1));
s5=round(10*rand(1));
s6=round(10*rand(1));

miu5=round(10*rand(1));
miu6=round(100*rand(1));

miu3 =round(10*rand(1));
miu4 =round(100*rand(1));

X5=miu5 + round(normrnd(0,s5,[sample_num/2 1]));
X6=miu6 + round(normrnd(0,s6,[sample_num/2 1]));
s5=std(X5);
miu5=mean(X5);
s6=std(X6);
miu6=mean(X6);


X3=miu3 + round(normrnd(0,s3,[sample_num/2 1]));
X4=miu4 + round(normrnd(0,s4,[sample_num/2 1]));

s3=std(X3);
miu3=mean(X3);
s4=std(X4);
miu4=mean(X4);


%X1=miu5 + round(normrnd(0,s1,[sample_num 1]));
X1=vertcat( X5,X6);
X2=vertcat( X4,X3);

%shuffle
X1=X1(randperm(length(X1)));
X2=X2(randperm(length(X2)));
  
%X2=vertcat( X5,X6,X3,X4);
X_sum = X1+X2;

t1= tabulate(X1);
t2= tabulate(X2);

min1= min(t1(:,1))
min2= min(t2(:,1))

max1= max(t1(:,1))
max2=max(t2(:,1))


t1(:,1) = t1(:,1) - min1 +1;
t2(:,1) = t2(:,1) - min2 +1;

pmf1= zeros([max1-min1+1 1])
pmf2= zeros([max2-min2+1 1])

up1= size(t1);
up1=up1(1);

up2= size(t2);
up2=up2(1);

for i = 1:up1
pmf1(t1(i,1),1) = t1(i,3) ./100;
end


for i = 1:up2
pmf2(t2(i,1),1) = t2(i,3) ./100;
end

size1= size(pmf1);
size1=size1(1);

size2= size(pmf2);
size2=size2(1);


conv1= conv(pmf1,pmf2);
size3= size(conv1);
size3=size3(1);


figure
subplot(3,2,1);
bar([min1+1:1:size1+min1],pmf1)
subplot(3,2,3);
bar( [min2+1:1:size2+min2],pmf2)
subplot(3,2,5);
bar( [min1+min2:1:size3+min1+min2-1],conv1)

subplot(2,2,2);
%histfit(X_sum, max(X_sum)-min(X_sum));
hist(X_sum, max(X_sum)-min(X_sum));
hold
plot([min1+min2:1:size3+min1+min2-1],conv1*sample_num)

subplot(2,2,4);
plot([min1+min2:1:size3+min1+min2-1],conv1)