
x = 1:20;
hellingers_x =[1,2,4,5,6,10,11:20];
hellingers_y = [ 0.89	0.34 0.09	0.05	0.03 0.01	0.01	0.01	0.01	0.01	0.01	0.01	0.01	0.01	0.01	0.01];

complexity_x =[ 2		4		6		8		10		12		14		16		18		20];
complexity_y =[ 16		40		80		136		208		296		400		520		656		808];
complexity_y = complexity_y /1000;
figure

f = fit(transpose(hellingers_x),transpose(hellingers_y),'exp1')
y = zeros(1,20);
for i = 1:20
   y(i) = f(i); 
end

set(gcf,'PaperPosition',[0 0 3.33 1.125])
hold on

plot(x,y,'color',[0.5 0.3 0.3],'linewidth',1)
plot(complexity_x,complexity_y ,'--','color',[0.2 0.5 0.1],'linewidth',1)
legend('Location','north','Hellinger Distance','Complexity (#kops)')
set(gca, 'FontSize', 7);
xlim([1 20])

set(gca,'position',[0.075 0.2 0.9 0.75])

box off;


%WAIT
print('~/approxiSynthesys/paper/figures/GMEE', '-depsc2', '-painters')