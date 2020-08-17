
n=4

figure;


table = zeros ([(2^n)*(2^n) 4*n]);
table_appx = zeros ([(2^n)*(2^n) 4*n]);

for i=0:2^n-1
    for j = 0:2^n-1
        
        sum = i+j;
        sum2 = 2* round(sum/2 - 0.1);
        
        i1=de2bi(i,n,'left-msb');
        j1=de2bi(j,n,'left-msb');
        
        
        if (sum >7)
            carry = 1;
        else
            carry=0;
        end
        
        sum = mod ( sum,2^n );
        sum2 = mod ( sum2,2^n );
        
        sum22=de2bi(sum2,n,'left-msb');
        sum1=de2bi(sum,n,'left-msb');
        carry1=de2bi(carry,n,'left-msb');
        
        table(i*2^n + j +1,1:n)=i1;table(i*2^n + j +1,n+1:n+n)=j1;table(i*2^n + j +1,n+n+1:n+n+n)=carry1;table(i*2^n + j +1,n+n+n+1:n+n+n+n)=sum1;
        table_appx(i*2^n + j +1,1:n)=i1;table_appx(i*2^n + j +1,n+1:n+n)=j1;table_appx(i*2^n + j +1,n+n+1:n+n+n)=carry1;table_appx(i*2^n + j +1,n+n+n+1:n+n+n+n)=sum22;

       
    end
end

table_err = table_appx - table;
table_err = table_err(:,2*n+1:end);

subplot(2,1,1);
hist(table_err(:,2*n))




table_dist = zeros ([(2^n)*(2^n) 4*n]);
table_dist_appx = zeros ([(2^n)*(2^n) 4*n]);

    i_dist = round ( abs (normrnd(0,2,[(2^n)*(2^n) 1])));
    j_dist = round ( abs (normrnd(0,2,[(2^n)*(2^n) 1])));

for i=0:2^n-1
for j = 0:2^n-1
        


    
        sum = i_dist(i+1)+j_dist(j+1);
        sum2 = 2* round(sum/2 - 0.1);

        
        
        i1=de2bi(i_dist(i+1),n,'left-msb');
        j1=de2bi(j_dist(j+1),n,'left-msb');
                if (sum >7)
            carry = 1;
        else
            carry=0;
        end
        
        sum = mod ( sum,2^n );
        sum2 = mod ( sum2,2^n );
        
        sum22=de2bi(sum2,n,'left-msb');
        sum1=de2bi(sum,n,'left-msb');
        carry1=de2bi(carry,n,'left-msb');

        
        table_dist(i*2^n + j +1,1:n)=i1;table_dist(i*2^n + j +1,n+1:n+n)=j1;table_dist(i*2^n + j +1,n+n+1:n+n+n)=carry1;table_dist(i*2^n + j +1,n+n+n+1:n+n+n+n)=sum1;
        table_dist_appx(i*2^n + j +1,1:n)=i1;table_dist_appx(i*2^n + j +1,n+1:n+n)=j1;table_dist_appx(i*2^n + j +1,n+n+1:n+n+n)=carry1;table_dist_appx(i*2^n + j +1,n+n+n+1:n+n+n+n)=sum22;

        
end
end

table_dist_err = table_dist_appx - table_dist;
table_dist_err = table_dist_err(:,2*n+1:end);
subplot(2,1,2);
hist(table_dist_err(:,2*n))
