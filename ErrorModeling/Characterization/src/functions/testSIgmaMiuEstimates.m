
table_sig_miu = zeros (65,30);
table_miu_off = zeros (65,30);
table_sig_off = zeros (65,30);

NOsamples   = 100000;
x_m           = 1:25;
means       = 2.^x_m;
means       = [-fliplr(means),0, means];

x_s           = 1:25;
sigmas      = [2.^x_s];

disp(['miu_indx, ','sigma_indx, ','#tries','miu_rr, ','sigma_err'])

counter_th  = 500;
step        = 500;

% ta hame belakhare peyda nashode
while (max(max(table_sig_miu)) == 0 || max(max(table_sig_miu)) == counter_th-step)
    
    for sg = sigmas
        disp(sg);
        for mn=means
            
            sg1 = 10000000;
            mn1_best = 10000000;
            
            sg_exp = log2(sg);
            sg_indx = sg_exp;
            
            mn_exp = log2(abs(mn));
            if (mn <0)
                mn_exp = - mn_exp;
            elseif (mn ==0)
                mn_exp=0;
            end
            mn_indx = 33+ mn_exp;
            
            counter = table_sig_miu(mn_indx,sg_indx);
            
            
            %try nashode ya max ta try shode
            if(counter == 0 || counter == counter_th-step)
                while ( (mn1_best ~= 0 || sg1 ~= log2(sg)) && counter < counter_th)
                    counter = counter+1;
                    
                    test = normrnd(mn,sg,[NOsamples,1]);
                    
                    sg1 = round(abs(log2(std(test))));
                    
                    mn_tmp = mean(test);
                    if ( abs(mn_tmp) < 1)
                        mn_tmp = 1;
                    end
                    
                    mn1_exp = round(log2(abs(mn_tmp)));
                    if ( mn_tmp < 0 )
                        mn1_exp = -1*mn1_exp;
                    end
                    
                    mn_diff = abs(mn1_exp - mn_exp);
                    
                    if (abs(mn1_best) > abs(mn_diff))
                        mn1_best = mn_diff;
                    end
                    
                end
                
                table_sig_miu(mn_indx,sg_indx) = counter;
                table_miu_off(mn_indx,sg_indx) = mn1_best;
                table_sig_off(mn_indx,sg_indx) = sg_exp-sg1;
                
            end
            
            
            
            
            
            %disp([mn_exp,sg_exp,counter,mn1,sg_exp-sg1]);
            
        end
        
    end
    
    counter_th = step+counter_th;
    TrimVisualizeArray(table_sig_miu,0,0)
end