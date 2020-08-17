
kde1.pdf = getGMM(1);
kce2.pdf = getGMM(4);

% dasti khat be khat ejra kon
figure('color','w');hold on;

bar(rl_apprx_1,rpmf_apprx_1,'Facecolor',[0.5 0.5 0.5],'edgecolor',[0.5 0.5 0.5])
visualizeKDE('kde', kce2, 'decompose', 0, 'showkdecolor', 'r' ,'Style','-')
visualizeKDE('kde', kde1, 'decompose', 0, 'showkdecolor', 'b' ,'Style','--')
plot(rl_apprx_MIA_1,rpmf_apprx_MIA_1,'b')

%

xlim([500 8100])
ylim([0 0.002])
set(gca,'yticklabel',[],'ytick',[])
%legend('SIM','GMEE','SAM','MIA')
%
legend('SIM',strcat('GMEE - HD=',num2str(HD_GMEE_1)),strcat('SAM   - HD= ',num2str(HD_SAM_1)),strcat('MIA    - HD= ',num2str(HD_MIA_1)))
