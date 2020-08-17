    

    err_dist_data=zeros(Nonums,1); % untikash ke dge nazdike data nis
    err_dist_data2_in=zeros(Nonums,1); % untikash ke dge nazdike data nis
    err_dist_data2_inErr=zeros(Nonums,1); % untikash ke dge nazdike data nis


    err_out_datas = abs(sum_Apprx_datas - corr_out_datas);
    
    err_out_datas2 = abs(sum_Apprx_datas2 - corr_out_datas2);

     %corr_out_datas2_inErr
    err_out_datas2_accr = abs(corr_out_datas2_inErr - corr_out_datas2);

    
    zoom=2; % zaribi ke zarb mishe ta rnge y ro besaze. 1 yani khode harchi hist mikeshe, 2 yani dobarabar ... ta 10K ham manteghie = Nonums

low_bound1=0;
low_bound2=0;
low_bound3=0;
 
 
    figure('units','normalized','outerposition',[0 0 1 1])

    nbin=1024*8;

    ylm1=[0 y_up];
 
    ylm2=[0 10000];
 
for i= 2:256 % ta 100 mire vase step 2.
    
    
        err_dist_data=zeros(Nonums,1); % untikash ke dge nazdike data nis
    err_dist_data2_in=zeros(Nonums,1); % untikash ke dge nazdike data nis
    err_dist_data2_inErr=zeros(Nonums,1); % untikash ke dge nazdike data nis


    %figure;
     low_bound1= min(corr_out_datas(:,i));
    for j= 1:Nonums % ta 100 mire vase step 2
    
    if(sum_Apprx_datas(j,i) <  low_bound1 )
        err_dist_data(j,1) = sum_Apprx_datas(j,i);
  
    end
    end
    err_dist_data= err_dist_data(err_dist_data~=0);

    
    subplot(3,5,1);
    hist(corr_out_datas(:,i),nbin);
    ylm1 = zoom*ylim;
    ylim(ylm1);
    xlm= xlim;
  
    subplot(3,5,2);
    hist(sum_Apprx_datas(:,i),nbin);
    ylim(ylm1);
    xlim(xlm);
    
    subplot(3,5,3);
    hist(log2(abs(err_dist_data)),nbin);
    %ylim(ylm1);
  %  xlim([-inf xlm(1)])
    
 
    
    subplot(3,5,4);
    hist(sum_Apprx_datas(:,i),nbin);
    ylim(ylm1);
    
    
    subplot(3,5,5);
    hist(-log2(err_out_datas(:,i)+1),nbin);
    ylim(ylm2);

    
    
    %%% first row
    
        %figure;
     low_bound2= min(corr_out_datas2(:,i));
    for j= 1:Nonums % ta 100 mire vase step 2
    
    if(sum_Apprx_datas2(j,i) <  low_bound2 )
        err_dist_data2_in(j,1)  = sum_Apprx_datas2(j,i);
  
    end
    end
    err_dist_data2_in= err_dist_data2_in(err_dist_data2_in~=0);
    
    
    subplot(3,5,6);
    hist((corr_out_datas2(:,i)),nbin);
    ylm1 = zoom*ylim;
    ylim(ylm1);
    xlm= xlim;
    
    subplot(3,5,7);
    hist((sum_Apprx_datas2(:,i)),nbin);
    ylim(ylm1);
    xlim(xlm);
    
    subplot(3,5,8);
    hist(log2(abs(err_dist_data2_in)),nbin);
    %ylim(ylm1);
    xlm2= xlim;
    
    subplot(3,5,9);
    hist((sum_Apprx_datas2(:,i)),nbin);
    ylim(ylm1);
    xlm3= xlim;
    
    subplot(3,5,10);
    hist(-log2(err_out_datas2(:,i)+1),nbin);
    ylim(ylm2);
    
    
    subplot(3,5,12);
    hist(corr_out_datas2_inErr(:,i),nbin);
    ylim(ylm1)
    xlim(xlm);
    
    
         low_bound3 = min(corr_out_datas2(:,i));
    for j= 1:Nonums % ta 100 mire vase step 2
    
    if(corr_out_datas2_inErr(j,i) <  low_bound3 )
        err_dist_data2_inErr(j,1)  =corr_out_datas2_inErr(j,i);
  
    end
    end
    
    err_dist_data2_inErr= err_dist_data2_inErr(err_dist_data2_inErr~=0);
    
    subplot(3,5,13);
    hist(log2(abs(err_dist_data2_inErr)),nbin);
    %ylim(ylm1)
    xlim(xlm2);
    
    subplot(3,5,14);
    hist(corr_out_datas2_inErr(:,i),nbin);
    ylim(ylm1)
    xlim(xlm3);
   
    subplot(3,5,15);
    hist(-log2(err_out_datas2_accr(:,i)+1),nbin);
    ylim(ylm2);
    
end