%intitalization
%{
% A+B ro begirim ye C mes khodshun tolid konim berim jolo
%
% 2 SECs/itteration
%}


%% Load parameters

DG2_inP_path = '/data/tmp/out_MAT/initP.mat';

loadFlag=1;
if loadFlag
    load (DG2_inP_path);
end

%%
% number of bits to truncate tabdil mishe be value inja
DG2_num_bit_trnc  = INT_DG2_num_bit_trnc;
DG2_in2_type_trnc = INT_DG2_in2_type_trnc;
DG2_in2_type_rand = INT_DG2_in2_type_rand;
DG2_in2_type_read = INT_DG2_in2_type_read;
DG2_val_trnc      = 2^DG2_num_bit_trnc;

DG2_ste_in1_MED_mtx = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DG2_ste_in2_MED_mtx = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
% khata chejuri dar adder e salem montaghel mishe. az vorud ta khorud. be
% marhale ghabl kari nadarim.
DG2_ste_out_sum_accr_MED_thisStep_inAP_mtx = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);

%% CODE
%file open
DG2_mat_msm_file = fopen(strcat(INT_DIR_path,INT_DG2_path_mat_msm ),'w');
fprintf(DG2_mat_msm_file,'s%12s %12s %12s %12s \ns\n','A_err','B_err', 'A.+B. ', 'A.*B. ');

%in1
DG2_DATA_in1_appx_vec = DC1_DATA_out_sum_appx_vec; %out_datas(:,3)
DG2_DATA_in1_accr_vec = DC1_DATA_out_sum_accr_vec;
%cols (itterations) count
DG2_indx_col = numsamples(DG2_DATA_in1_appx_vec);
%in2
DG2_DATA_in2_accr_vec = zeros(INT_sample_cnt,DG2_indx_col);
DG2_DATA_in2_appx_vec = zeros(INT_sample_cnt,DG2_indx_col);
%out
DG2_DATA_out_sum_accr_inAC_vec = zeros(INT_sample_cnt,DG2_indx_col); % khoruji ba dade haye daghigh va operation e daghigh
DG2_DATA_out_sum_accr_inAP_vec = zeros(INT_sample_cnt,DG2_indx_col); % khoruji ba dade haye appx vali va operation daghigh
%DG2_ins_apprx_out_sum_apprx_vec = zeros(INT_sample_cnt,DG2_indx_col); %
%khoruji ba dade haye appx va jame khata dar=> bad az simulation malum mishe dge javabe in

for DG2col = 1:DG2_indx_col
    
    % see the progress
    DG2col
        
    %find std of APPX data in IN1
    DG2_std_in1_accr_exp = round(log2(std(DG2_DATA_in1_accr_vec(:,DG2col))));
    DG2_std_in2_accr_exp = DG2_std_in1_accr_exp;
    
    
    DG2_miu_in1_accr = mean(DG2_DATA_in1_accr_vec(:,DG2col))));
       
    %% IN1
    DG2_in1_accr_array = DG2_DATA_in1_accr_vec(:,DG2col);
    DG2_in1_appx_array = DG2_DATA_in1_appx_vec(:,DG2col); % A+B khata dar
    DG2_std_in1_appx=std(DG2_in1_appx_array);
    if(DG2_std_in1_appx ==0) % exception handling
        DG2_std_in1_appx_exp =0;
    else
        DG2_std_in1_appx_exp=round(log2(DG2_std_in1_appx));
    end
    
    %% IN2 
    
    if (DG2_in2_type_read)
    DG2_in1_read_array = DG2_DATA_in2_read_vec(:,DG2col); 
    DG2_in2_accr_array = DG2_in1_read_array;
    DG2_in2_err_array = 0;
    DG2_in2_appx_array = DG2_in2_accr_array + DG2_in2_err_array;
    end
    
    %yechizi ba sigma mosavi A + khata
    if (DG2_in2_type_trnc)
    DG2_in2_accr_array =round( normrnd(0, 2^(DG2_std_in2_accr_exp) , [INT_sample_cnt 1])); %ye b ke daghighesh randome ba std A
    DG2_in2_appx_array = DG2_val_trnc* round (DG2_in2_accr_array/DG2_val_trnc - 0.01);
    DG2_in2_err_array = DG2_in2_accr_array - DG2_in2_appx_array; % might be unused! just in case
    end
    
    %yechizi ba sigma mosavi A + khata
    if (DG2_in2_type_rand)
        DG2_in2_accr_array =round( normrnd(0, 2^(DG2_std_in2_accr_exp) , [INT_sample_cnt 1])); %ye b chize jadid
        DG2_in2_err_array =0; %err khastim bedim inas => %round( normrnd(0, 2^(randi(5)) , [INT_sample_cnt 1])); % asan khata ham nadare
        DG2_in2_appx_array = DG2_in2_accr_array + DG2_in2_err_array;
    end
    
    
    DG2_std_in2_appx=std(DG2_in2_appx_array);
    if(DG2_std_in2_appx ==0) % exception handling
        DG2_std_in2_appx_exp =0;
    else
        DG2_std_in2_appx_exp=round(log2(DG2_std_in2_appx));
    end
    %%
    %out
    DG2_out_sum_accr_inAC_array = DG2_in1_accr_array + DG2_in2_accr_array;
    DG2_out_sum_accr_inAP_array = DG2_in1_appx_array + DG2_in2_appx_array;
    
    %%
    %inja az sigmahaye vorudi haye khatadar darim estefade mikonim
    %rename
    DG2_si1=DG2_std_in1_accr_exp;
    DG2_si2=DG2_std_in2_appx_exp;
    
    if(DG2_si1 >=1 ) && (DG2_si2 >= 1)  % index out of bound nazanim
        
        %DATAS out
        DG2_DATA_out_sum_accr_inAC_vec(:,DG2col) = DG2_out_sum_accr_inAC_array;
        DG2_DATA_out_sum_accr_inAP_vec(:,DG2col) = DG2_out_sum_accr_inAP_array;
        %DATAS in2
        DG2_DATA_in2_appx_vec(:,DG2col) = DG2_in2_appx_array;
        DG2_DATA_in2_accr_vec(:,DG2col) = DG2_in2_accr_array;
        
        %MED in1
        DG2_in1_MED_itt = func_Err_MED(DG2_in1_appx_array, DG2_in1_accr_array, INT_sample_cnt ); % inja bas hamun EMin beshe
        DG2_ste_in1_MED_mtx(DG2_si1,DG2_si2) = DG2_in1_MED_itt;
        %MED in2
        DG2_in2_MED_itt = func_Err_MED(DG2_in2_appx_array, DG2_in2_accr_array, INT_sample_cnt );
        DG2_ste_in2_MED_mtx(DG2_si1,DG2_si2) = DG2_in2_MED_itt;
        %MED out
        DG2_out_sum_accr_MED_thisStep_inAP_itt = func_Err_MED(DG2_out_sum_accr_inAP_array, DG2_out_sum_accr_inAC_array,INT_sample_cnt ); 
        DG2_ste_out_sum_accr_MED_thisStep_inAP_mtx(DG2_si1,DG2_si2) = DG2_out_sum_accr_MED_thisStep_inAP_itt;     
        
        
        
     
        %% PRINT to FILE
        % Miu & Sigma print
        fprintf(DG2_mat_msm_file,'m %12d %12d\n',DG2_miu_in1_accr,0); % miu in1 daghigh va in2=0
        fprintf(DG2_mat_msm_file,'s Sigmas of Accur_in1 and in2 generation\n');
        fprintf(DG2_mat_msm_file,'p%12d %12d\n',2^DG2_std_in1_accr_exp,2^DG2_std_in2_accr_exp); % ba ina sakhtim vali badia darumade
        fprintf(DG2_mat_msm_file,'s\ns** [Sigma_A=%12d Sigma_B=%12d]\n',2^DG2_std_in1_accr_exp,2^DG2_std_in2_accr_exp); % ba ina sakhtim vali badia darumade

        fprintf(DG2_mat_msm_file,'s one Sigma for *Appx_in1 and estim. std(in2)\n');
        fprintf(DG2_mat_msm_file,'s== [*s_A=%10.2f s_B=%10.2f s_Sum=%10.2f s_Mult=%10.2f]\n',2^DG2_std_in1_appx_exp,2^DG2_std_in2_appx_exp,0,0); % in daghigheshe
        fprintf(DG2_mat_msm_file,'s~~ [*std_A=%12d std_B=%12d std_Sum=%12d std_Mult=%12d]\ns\n',round(2^DG2_std_in1_appx_exp),round(2^DG2_std_in2_appx_exp),round(0),round(0)); % in round shodashe
        
        fprintf(DG2_mat_msm_file,'s%12s %12s %12s\n','EM_a','EM_b','EM_in');
        fprintf(DG2_mat_msm_file,'t %12f %12f %12f\n',DG2_in1_MED_itt,DG2_in2_MED_itt,0); % EMa EMb EMin
  
        
        
       
        
        
        
        for i = 1:INT_sample_cnt
            fprintf(DG2_mat_msm_file,'d%12d %12d %12d %12d\n',DG2_in1_appx_array(i),DG2_in2_appx_array(i),DG2_out_sum_accr_inAP_array(i),DG2_in1_appx_array(i)*DG2_in2_appx_array(i));
        end
    else
        display('Sigma out of bound'); display(DG2_si1);display(DG2col);% display(Sig_b);
    end
    
end


if saveFlag
    save (DG2_inP_path);
end













