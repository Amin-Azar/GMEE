
%looking into 100 loops cases%
%looking into 10 cases%
Sigma = 10


S=100;
Nonums = 10;
figure;

if 0
subplot(2,3,1);


hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= std (normrand1);
end
error = results - Sigma;
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
scatter(1:S,error);
hold off;


S=100;
Nonums = 100;
hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= (std (normrand1));

end
error = results -  Sigma;
scatter(1:S,error);
hold off;

%figure;
subplot(2,3,2);
S=100;
Nonums = 1000;
hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= (std (normrand1));


end

title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));

error = results - Sigma ;
scatter(1:S,error);
hold off;

%figure;
subplot(2,3,3);
S=100;
Nonums = 10000;
hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= (std (normrand1));

end

title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
error = results - Sigma ;
scatter(1:S,error);

hold off;



%looking into 1000 loops cases%
%looking into 10 cases%


%figure;
subplot(2,3,5);
S=1000;
Nonums = 1000;
hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= (std (normrand1));


end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));

error = results - Sigma ;
scatter(1:S,error);
hold off;

%figure;
subplot(2,3,6);
S=1000;
Nonums = 7000;
hold on;
results = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
results(1,c)= (std (normrand1));


end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));

error = results - Sigma ;
scatter(1:S,error);
hold off;


end

















%az inja be bad, ekhtelaf e vaghti ke roud mikonim o nemikonim o sanjidam





%figure;
Sigma =1;
subplot(2,3,1);
S=1000;
Nonums = 7000;
hold on;
results1 = zeros(1,S);
results2 = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
for i = 1:Nonums
normrand2(i,1) = round(normrand1(i));
end
results1(1,c)= std (normrand1);
results2(1,c)= std (normrand2);
end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
error = results1 - results2;
scatter(1:S,error);
hold off;

Sigma =10;
subplot(2,3,2);
S=1000;
Nonums = 7000;
hold on;
results1 = zeros(1,S);
results2 = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
for i = 1:Nonums
normrand2(i,1) = round(normrand1(i));
end
results1(1,c)= std (normrand1);
results2(1,c)= std (normrand2);
end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
error = results1 - results2;
scatter(1:S,error);
hold off;


Sigma =100;
subplot(2,3,4);
S=1000;
Nonums = 7000;
hold on;
results1 = zeros(1,S);
results2 = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
for i = 1:Nonums
normrand2(i,1) = round(normrand1(i));
end
results1(1,c)= std (normrand1);
results2(1,c)= std (normrand2);
end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
error = results1 - results2;
scatter(1:S,error);
hold off;

Sigma =1000;
subplot(2,3,5);
S=1000;
Nonums = 7000;
hold on;
results1 = zeros(1,S);
results2 = zeros(1,S);
for c = 1:S
    
normrand1 = normrnd(0, Sigma , [Nonums 1]);
for i = 1:Nonums
normrand2(i,1) = round(normrand1(i));
end
results1(1,c)= std (normrand1);
results2(1,c)= std (normrand2);
end
title(strcat('Sigma= ', num2str(Sigma), ' ** i="',num2str(S),'" loops and <', num2str(Nonums),'> differnet normal numbers generated in range'));
error = results1 - results2;
scatter(1:S,error);
hold off;