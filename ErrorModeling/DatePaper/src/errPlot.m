%initialization
%{
%   in miad khoruji haye un itteration o err ha o inaro mikeshe
%}

errPlot2= zeros ([10000 1]);
 errPlot3= zeros ([10000 1]);
 
 len = size(out_datas_accr);
 len = len(2);
 

 init1=2495;
for col= init1:len % avali sefre
 %col =2000
   errPlot2= zeros ([10000 1]);
 errPlot3= zeros ([10000 1]);
 for i=1:Nonums

 if(out_datas_accr(i,col) ~= out_datas_appx(i,col) )

     errPlot2(i) =out_datas_accr(i,col);
     errPlot3(i) =out_datas_appx(i,col);
 end
 
 
 end
 

bin12=  max(out_datas_appx(:,col)) -  min(out_datas_appx(:,col))+1;
if (bin12 >10000)
    bin12 = 10000;
end

 subplot(4,2,7)
 hist(out_datas_appx(:,col),bin12);
 xlm1=xlim;
  subplot(4,2,8)
 hist(out_datas_appx(:,col),bin12);
 xlm1=xlim;
 
 
 bin11=  max(out_datas_accr(:,col)) -  min(out_datas_accr(:,col))+1;
 if (bin11 >10000)
     bin11 = 10000
 end
 
 subplot(4,2,1)
 hist(out_datas_accr(:,col),bin11);
 xlim(xlm1);
  subplot(4,2,2)
 hist(out_datas_accr(:,col),bin11);
 xlim(xlm1);
 
 
 changePlot = zeros ([xlm1(2)-xlm1(1)+1 1]);
  sumErrPlot = zeros ([xlm1(2)-xlm1(1)+1 1]);
 subplot(4,2,3)

 errPlot2 = errPlot2 (errPlot2 ~=0);
 bin22 =  max(errPlot2) -  min(errPlot2)+1;
 h2=hist(errPlot2,bin22);
 hist(errPlot2,bin22);
     xlim(xlm1);
     
 changePlot(min(errPlot2)-xlm1(1): max(errPlot2)-xlm1(1),1)=-h2;
 sumErrPlot(min(errPlot2)-xlm1(1): max(errPlot2)-xlm1(1),1)=h2;
 
 subplot(4,2,5)

 errPlot3 = errPlot3 (errPlot3 ~=0);
 bin33 =  max(errPlot3) -  min(errPlot3) +1
 errPlot3 = errPlot3 (errPlot3 ~=0);
 h3=hist(errPlot3,bin33);
 hist(errPlot3,bin33);
  xlim(xlm1);
 changePlot(min(errPlot3)-xlm1(1): max(errPlot3)-xlm1(1),1)= changePlot(min(errPlot3)-xlm1(1): max(errPlot3)-xlm1(1),1) +transpose(h3);
 sumErrPlot(min(errPlot3)-xlm1(1): max(errPlot3)-xlm1(1),1)=sumErrPlot(min(errPlot3)-xlm1(1): max(errPlot3)-xlm1(1),1) + transpose(h3);
  subplot(4,2,4)
 plot(xlm1(1):xlm1(2),changePlot)
 subplot(4,2,6)
 plot(xlm1(1):xlm1(2),sumErrPlot)
% mean ( out_datas_accr (:,3010))
 mean(errPlot2)- mean ( out_datas_accr (:,col))
 %std ( out_datas_accr (:,3010))
 std(errPlot2)- std ( out_datas_accr (:,col))
 
end