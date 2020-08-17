%intitalization
%{
% open modelsim file and read line by line
% store in variables
% accurate addition "out_datas_accr"
% approximate addition "out_datas_appx"
% absolute error out_AE
% calculate MSE, SNR, MED for one level of adders
%
% it was less than 1 Min/itteration
%}


%{

Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
INT_sample_cnt = 7000; % 5-7K samples for better sigma evaluation in matlab
%%bias =3; %chand ta aghab jolotar bere
INT_HWS_bits=32; % bara 32 biti
bias=0;
%}
%bordim tu params


%% Load parameters
DC1_inP_path = '/data/tmp/out_MAT/initP.mat';


loadFlag=0;
if loadFlag
    load (DC1_inP_path);
end

%%
addpath(genpath(INT_SRC_path));

%indexing
DC1_indx_loop           =1; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
DC1_indx_disp           =1;
DC1_indx_col            =0; % index e vec ke tu har ejra mikhunim
DC1_indx_row            =0; % index e array haye data ke tu har p mikhunim

%i=1;

DC1_col_cnt             = DG1_indx_col;     % chandta itt shode ba sigma o moiu ha
DC1_miu_sum_out_min_exp = DG1_miu_sum_out_min_exp;
DC1_miu_sum_out_cnt     = DG1_miu_sum_out_cnt;

DC1_HD_th               = INT_DC1_HD_th;
DC1_fit_maxIter         = INT_fit_maxIter;
DC1_HD_maxtry           = INT_DC1_HD_maxtry;
DC1_cnvrged_maxtry      = INT_DC1_cnvrged_maxtry;
DC1_HD_uppertry         = INT_DC1_HD_uppertry;
DC1_HD_std_log_th       = INT_DC1_HD_std_log_th;
DC1_find_best_GMM       = INT_DC1_find_best_GMM;
DC1_max_GMM             = INT_DC1_max_GMM;
DC1_num_GMM             = INT_DC1_num_GMM;

DC1_sclng_fac           = INT_DC1_sclng_fac;
DC1_smpl_covrg_wrst     = INT_DC1_smpl_covrg_wrst
DC1_smpl_per_bin        = INT_DC1_smpl_per_bin


% MED calc
DC1_ste_int_MED_mtx     = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DC1_file_1itt_line      = zeros(1,4);                % ye khat khunde
DC1_file_1itt           = zeros(INT_sample_cnt,4);   % vase ye 100K taro khunde az kolli itt

%DC1_max_miu= 2*round(INT_max_sig_itt_exp/4)+1;

% col be col data has be andazeye dade haye Ijad shode 1 dune bishtar ke
% dafe avalle ke sefre ru dashte bashim, bad hazf mikonim
DC1_DATA_in1_vec         = zeros(INT_sample_cnt,DC1_col_cnt+1); %zeros(INT_sample_cnt,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_DATA_in2_vec         = zeros(INT_sample_cnt,DC1_col_cnt+1); %zeros(INT_sample_cnt,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_DATA_out_sum_appx_vec= zeros(INT_sample_cnt,DC1_col_cnt+1); %zeros(INT_sample_cnt,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_DATA_out_sum_accr_vec= zeros(INT_sample_cnt,DC1_col_cnt+1); %zeros(INT_sample_cnt,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);

%DC1_coefs= zeros(INT_HWS_bits,1); % zarayebi ke zarb mishe dar har AEs(i,2)
%coefs_total= zeros(INT_HWS_bits,1);

%Sig reading
DC1_cur_sigs             = zeros(1,2); % aval sig mikhune bad data, vas hamimn bas berim be sig ghabli moraje konim
DC1_nxt_sigs             = zeros(1,2); % vaghti resid inja yani data balayiaro process ko
%Miu reading
DC1_cur_mius             = zeros(1,2); % aval sig/miu mikhune bad data, vas hamimn bas berim be miu ghabli moraje konim
DC1_nxt_mius             = zeros(1,2); % vaghti resid inja yani data balayiaro process ko

%std and miu s
DC1_sig_in1_vec          = zeros(1,DC1_col_cnt+1); %zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_sig_in2_vec          = zeros(1,DC1_col_cnt+1); %zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_std_sum_accr_vec     = zeros(1,DC1_col_cnt+1); %zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC1_std_sum_appx_vec     = zeros(1,DC1_col_cnt+1); %zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);


%std_Mult_array=zeros(Sigma_itt*(Sigma_itt+bias),1);
%sig to sig be sig  =[log-> actual Sig (2^X)]

DC1_sts_sum_accr_mtx     = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DC1_sts_sum_appx_mtx     = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
%DC1_sts_mlt_appx_mtx=zeros(Sigma_itt+bias,Sigma_itt);
DC1_smte_MED_mtx         = zeros(2*INT_HWS_bits, 10*INT_max_sig_itt_exp+6 ); % 64x255 % nemidunam chie

% [ GMM (miu-sigma-w x #GMM ) x sigma x miu (khoruji bikhata)] yani inke be sigma o miu khoruji dar halati ke khata nadash nega kon, va begu alan ba kahta chia shode!
% sigma miu of accur addition to (miu sigma w) sets of fitted guassians -
% it should be upt to root2(2) times of sigma when combining! so 2xsigma is
% safe
DC1_smtsmw_sum_mtx        = zeros(3,DC1_max_GMM,DC1_miu_sum_out_cnt,2*INT_max_sig_itt_exp);
% harja tu balayi data darim, inja 1 mikonim. (sig,miu) out bedune khata mohemme
DC1_smtsmw_sum_flags_mtx  = zeros(DC1_miu_sum_out_cnt,2*INT_max_sig_itt_exp);
DC1_smtsmw_sum_tires_mtx  = zeros(DC1_miu_sum_out_cnt,2*INT_max_sig_itt_exp);
DC1_smtsmw_sum_HDs_mtx    = zeros(DC1_miu_sum_out_cnt,2*INT_max_sig_itt_exp);

%transfer matrix - in mige ((sigma1,miu1),(sigma2,miu2)) ->
%(sigma_simulation,miu_simulation) chie! avalia unas ke bashun khastim
%doros konim DATA haro, ama vagean shayad una az ab dar nayumade bashe o
%khata dashte bashe. pas sigma_out miu_out az ru formul mathematical hesab
%nashode dge!
DC1_smsmtsm_sum_accr_sim_mtx = zeros(2,INT_max_sig_itt_exp,DG1_miu_in_cnt,INT_max_sig_itt_exp,DG1_miu_in_cnt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CODE
DC1_msm_mat_file = fopen(strcat(INT_DIR_path,INT_DC1_path_msm_mat),'r');

if 1
    while ~feof(DC1_msm_mat_file)
        DC1_indx_loop= DC1_indx_loop+1;
        if(DC1_indx_loop==INT_sample_cnt);
            DC1_indx_loop=1;
            DC1_indx_disp=DC1_indx_disp+7; %1K index semicolon nazashtim index beznae bbeinim kojayim asan
            
            
            %indx3=indx3+1;
        end
        
        DC1_line_type = fgets(DC1_msm_mat_file,1);
        
        if strcmp(DC1_line_type,'s');
            % display('type =s');
            DC1_line_ignr = fgets(DC1_msm_mat_file,101);
            
            
        elseif  strcmp(DC1_line_type,'m');
            DC1_line_mius = fscanf (DC1_msm_mat_file,' %d %d\n');
            DC1_line_mius = transpose(DC1_line_mius);
            
            DC1_miu_line_in2 = DC1_line_mius(2);
            DC1_miu_line_in1 = DC1_line_mius(1);
            
            DC1_miu_line_in1_exp = log2(abs(DC1_miu_line_in1));
            DC1_miu_line_in2_exp = log2(abs(DC1_miu_line_in2));
            
            %manfiasho doros konim. sefram sefr beshe, na -INF
            if (DC1_miu_line_in1 < 0)
                DC1_miu_line_in1_exp = -DC1_miu_line_in1_exp;
            elseif ( DC1_miu_line_in1 == 0 )
                DC1_miu_line_in1_exp = 0;
            end
            
            if (DC1_miu_line_in2 < 0)
                DC1_miu_line_in2_exp = -DC1_miu_line_in2_exp;
            elseif (DC1_miu_line_in1 == 0)
                DC1_miu_line_in2_exp = 0;
            end
            
            DC1_nxt_mius(1) = DC1_miu_line_in1_exp; DC1_nxt_mius(2) = DC1_miu_line_in2_exp;
            
        elseif  strcmp(DC1_line_type,'d');
            
            DC1_indx_row = DC1_indx_row +1;
            %  display('type = d');
            DC1_data_line=fscanf (DC1_msm_mat_file,' %d %d %d %d\n'); %a_d,a_h,b_d,b_h,appx_d,appx_h,accr_d,accr_h   d(%h) %d(%h) %d(%h) %d(%h)'
            DC1_file_1itt_line(1)=DC1_data_line(1); DC1_file_1itt_line(2)=DC1_data_line(2); DC1_file_1itt_line(3)=DC1_data_line(3); DC1_file_1itt_line(4)=DC1_data_line(4);
            
            if DC1_rst_flg==1
                DC1_indx_row = 1;
                DC1_rst_flg =0;
                %DC1_coefs= zeros(INT_HWS_bits,1);
            end
            
            
            DC1_file_1itt (DC1_indx_row,:) = DC1_file_1itt_line;
            
        elseif  strcmp(DC1_line_type,'p');
            
            DC1_indx_col=DC1_indx_col+1;
            
            DC1_rst_flg=1;% residim be abdi dge inja bayad ghabliaro besporim be daste sarnevesht!
            DC1_sig_line=fscanf (DC1_msm_mat_file,' %d %d\n');%sigmaharo az tu file mikhunim
            DC1_nxt_sigs(1)=DC1_sig_line(1); DC1_nxt_sigs(2)=DC1_sig_line(2); % row be column e sh fargh dare chonke
            
            if(DC1_cur_sigs(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
                
                disp(' ');
                DC1_disp = '=========================================================';
                disp(DC1_disp);
                DC1_disp = ['Itteration ',num2str(DC1_indx_col-1) ,' for <Sig1,Miu1>=<',num2str(DC1_cur_sigs(1)),',',num2str(DC1_cur_mius(1)),'> , <Sig2,Miu2>=<',num2str(DC1_cur_sigs(2)),',',num2str(DC1_cur_mius(2)),'>'];
                disp(DC1_disp);%actuall 2^Sig_i values
                DC1_disp = '---------------------------------------------------------';
                disp(DC1_disp);
                DC1_sig_in1_exp=log2(DC1_cur_sigs(1)); %logarthmic Sig_i s
                DC1_sig_in2_exp=log2(DC1_cur_sigs(2));%logarthmic Sig_i s
                
                DC1_miu_in1_exp=DC1_cur_mius(1);
                DC1_miu_in2_exp=DC1_cur_mius(2);
                
                DC1_DATA_in1_vec(:,DC1_indx_col) = DC1_file_1itt(:,1);
                DC1_DATA_in2_vec(:,DC1_indx_col) = DC1_file_1itt(:,2);
                DC1_DATA_out_sum_appx_vec(:,DC1_indx_col) = DC1_file_1itt(:,3);
                DC1_DATA_out_sum_accr_vec(:,DC1_indx_col) = DC1_file_1itt(:,4);
                
                
                DC1_std_sum_appx=std(DC1_file_1itt(:,3)); %std khata dar chie
                
                %% fit matrix
                DC1_std_sum_accr=std(DC1_file_1itt(:,4)); %std BIKHATA chie
                DC1_miu_sum_accr = mean(DC1_file_1itt(:,4));
                DC1_std_sum_accr_log = round(log2(DC1_std_sum_accr));
                DC1_miu_sum_accr_log = round(log2(abs(DC1_miu_sum_accr)));
                
                if (DC1_miu_sum_accr < 0)
                    DC1_miu_sum_accr_log = -1 * DC1_miu_sum_accr_log;
                end
                
                
                DC1_hist_x_range = max(DC1_file_1itt(:,3)) - min(DC1_file_1itt(:,3)) +1;
                
                DC1_bin=round ( (DC1_hist_x_range / ((INT_sample_cnt* DC1_samples_covrg_worst)/DC1_smpl_per_bin))/DC1_sclng_fac )*DC1_sclng_fac;
                if ( DC1_bin<1 )
                    DC1_bin=1
                end
                
                
                %PMS Appx
                [DC1_l_apprx_1 DC1_pmf_apprx_1] = convertToPMF2(DC1_file_1itt(:,3),DC1_bin);
                
                %min of mins
                DC1_min_mins = min (DC1_l_apprx_1);
                %max of maxs
                DC1_max_maxs = max (DC1_l_apprx_1);
                
                [DC1_rl_apprx_1 DC1_rpmf_apprx_1] = convertToRangePMF2(DC1_l_apprx_1,DC1_pmf_apprx_1,DC1_min_mins,DC1_max_maxs);
                
                
                %Set while loop itterations
                if ( DC1_std_sum_accr_log > DC1_HD_std_log_th)
                    DC1_HD_tries = DC1_HD_uppertry;
                else
                    DC1_HD_tries = DC1_HD_maxtry;
                end
                
                
                %fitting loops
                DC1_fit_loop_cnt=0;
                % make sure HD is less than threshold but repeat until it is
                % allowed
                DC1_HD_GMEE_appx = 1;
                DC1_add_num_GMM = 0;
                while (DC1_HD_GMEE_appx > DC1_HD_th && DC1_fit_loop_cnt < DC1_HD_tries )
                    fprintf('[');
                    
                    
                    % repeat untill get converged results
                    DC1_cnvrgd_flag =0;
                    
                    while ( DC1_cnvrgd_flag < 1 && DC1_fit_loop_cnt < DC1_cnvrged_maxtry)
                        if ( mod(DC1_fit_loop_cnt,20) ==0)
                            fprintf('%s..',num2str(DC1_fit_loop_cnt));
                        end
                        fprintf('<');
                        DC1_fit_loop_cnt = DC1_fit_loop_cnt+1;
                        DC1_GMMs_cnt = DC1_num_GMM + DC1_add_num_GMM;
                        [DC1_GMM_sum_appx_tmp, DC1_cnvrgd_flag, DC1_fit_NLL_tmp ] = findDist(DC1_file_1itt(:,3),DC1_GMMs_cnt ,DC1_fit_maxIter);
                        fprintf('%d',DC1_cnvrgd_flag);
                    end
                    
                    %age valid e DATA va nazdiktaram has be data, zakhire kon
                    if (DC1_cnvrgd_flag == 1)
                        
                        %fitted PMF
                        [DC1_rl_GMEE_1  DC1_rpmf_GMEE_1]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp,DC1_min_mins,DC1_max_maxs);%GMEE
                        DC1_HD_GMEE_appx_tmp = HellingerDistance(DC1_rpmf_apprx_1 , DC1_rpmf_GMEE_1);
                        fprintf('|%2.0f',100*DC1_HD_GMEE_appx_tmp);
                        
                        if(DC1_HD_GMEE_appx_tmp < DC1_HD_GMEE_appx)
                            fprintf('*');
                            DC1_GMM_sum_appx = DC1_GMM_sum_appx_tmp;
                            DC1_HD_GMEE_appx = DC1_HD_GMEE_appx_tmp;
                            DC1_fit_slct_cnt = DC1_fit_loop_cnt;
                            DC1_fit_NLL = DC1_fit_NLL_tmp;
                        end
                        fprintf('>');
                    end
                    fprintf(']');
                    
                    if ( DC1_find_best_GMM == 1 && DC1_add_num_GMM < DC1_max_GMM)
                        DC1_add_num_GMM = DC1_add_num_GMM +1;
                    end
                end
                
                %while akhar yeki ezafe besh add shode
                if ( DC1_find_best_GMM == 1)
                        DC1_GMMs_cnt = DC1_GMMs_cnt -1;
                end
                
                
                
                
                %{
         % ** SHOW **
         figure;
         set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
         plot(DC1_rl_apprx_1, DC1_rpmf_apprx_1);
         hold on
         plot(DC1_rl_GMEE_1, DC1_rpmf_GMEE_1,'color','red')
         hold off
         
         % ** SHOW END **
                %}
                
                fprintf('\n');
                DC1_disp = ['#tries to fit=',num2str(DC1_fit_loop_cnt),', Best one was #',num2str(DC1_fit_slct_cnt)];
                disp(DC1_disp);
                
                DC1_disp = ['#HD of fit=',num2str(DC1_HD_GMEE_appx), ' Using ',num2str(DC1_GMMs_cnt),'components - #AIC of fit=',num2str(DC1_fit_NLL)];
                disp(DC1_disp);
                DC1_disp = ['IN: <Sig1,Miu1>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in1_exp),'> , <Sig2,Miu2>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in2_exp),'>'];
                disp(DC1_disp);
                
                DC1_smtsmw_indx_sig = round(log2(DC1_std_sum_accr));
                DC1_smtsmw_indx_miu = 1-DC1_miu_sum_out_min_exp + DC1_miu_sum_accr_log; % shift midim ta index manfi ya mosbat az 1+0 shour she. yani 1-66 beshe. bad
                DC1_disp = ['smtsmw_indx: <Sigma_o,',num2str(1- DC1_miu_sum_out_min_exp),'+Miu_o>=<',num2str(DC1_smtsmw_indx_sig), ',', num2str(DC1_smtsmw_indx_miu),'>'];
                disp(DC1_disp);
                
                %store in matrix dg
                [DC1_GMM_x DC1_GMM_y] =  size(DC1_GMM_sum_appx);
                DC1_smtsmw_sum_mtx(1:DC1_GMM_x,1:DC1_GMM_y,DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)= DC1_GMM_sum_appx;
                %put 1 in cells we have gaussians
                
                if (DC1_cnvrgd_flag == 1)
                    DC1_smtsmw_sum_flags_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_GMMs_cnt;
                    DC1_smtsmw_sum_tires_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_fit_loop_cnt;
                    DC1_smtsmw_sum_HDs_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_HD_GMEE_appx;
                else
                    DC1_smtsmw_sum_flags_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)='-';
                    DC1_smtsmw_sum_tires_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_cnvrged_maxtry;
                    DC1_smtsmw_sum_HDs_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=1;
                end
                
                DC1_smsmtsm_indx_miu1 = 1- DC1_miu_sum_out_min_exp + DC1_miu_in1_exp;
                DC1_smsmtsm_indx_miu2 = 1- DC1_miu_sum_out_min_exp + DC1_miu_in2_exp;
                %transfer matrix
                DC1_smsmtsm_sum_accr_sim_mtx(:,DC1_sig_in1_exp,DC1_smsmtsm_indx_miu1,DC1_sig_in2_exp,DC1_smsmtsm_indx_miu2) = [DC1_smtsmw_indx_sig, DC1_smtsmw_indx_miu];
                %%
                DC1_sig_in1_vec(DC1_indx_col) = DC1_cur_sigs(1);
                DC1_sig_in2_vec(DC1_indx_col) = DC1_cur_sigs(2);
                DC1_std_sum_accr_vec(DC1_indx_col) = DC1_std_sum_accr;
                DC1_std_sum_appx_vec(DC1_indx_col) = DC1_std_sum_appx;
                %DC1_std_mlt_array(DC1_indx_data) = std_Mult;
                
                DC1_sts_sum_accr_mtx(DC1_sig_in1_exp,DC1_sig_in2_exp) = DC1_std_sum_accr;
                DC1_sts_sum_appx_mtx(DC1_sig_in1_exp,DC1_sig_in2_exp) = DC1_std_sum_appx;
                %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult;
                
                DC1_EM_in = EM_med(DC1_file_1itt(:,4) ,DC1_file_1itt(:,3),INT_sample_cnt );
                DC1_ste_int_MED_mtx (DC1_sig_in1_exp,DC1_sig_in2_exp)=DC1_EM_in; %logarithmic indexed
                
                DC1_sum_accur_miu = mean(DC1_file_1itt(:,4));
                if (DC1_sum_accur_miu < 0)
                    DC1_sum_accur_miu = -round(log2(-DC1_sum_accur_miu));
                else
                    DC1_sum_accur_miu = round(log2(DC1_sum_accur_miu));
                end
                
                
                DC1_sum_accur_sig = round(10*log2(std(DC1_file_1itt(:,4))));
                
                DC1_smte_MED_mtx (INT_HWS_bits+DC1_sum_accur_miu , DC1_sum_accur_sig)=DC1_EM_in; %INT_HWS_bits+ guarantee no negative
                
            end
            %coefs_total = horzcat(coefs_total,coefs); % vase inke bebinim kolan khataha koja ha bude X*Y = runhayeMokhtalef * 2^adadeKhata
        else
            DC1_line_ignr = fgets(DC1_msm_mat_file,101);
            %display(line);
            
            
            
        end
        DC1_cur_sigs = DC1_nxt_sigs;
        DC1_cur_mius = DC1_nxt_mius;
    end
    
    
    
    %end of file for the last one dgE!
    DC1_indx_col=DC1_indx_col+1;
    
    disp(' ');
    DC1_disp = '=========================================================';
    disp(DC1_disp);
    DC1_disp = ['Itteration ',num2str(DC1_indx_col-1) ,' for <Sig1,Miu1>=<',num2str(DC1_cur_sigs(1)),',',num2str(DC1_cur_mius(1)),'> , <Sig2,Miu2>=<',num2str(DC1_cur_sigs(2)),',',num2str(DC1_cur_mius(2)),'>'];
    disp(DC1_disp);%actuall 2^Sig_i values
    DC1_disp = '---------------------------------------------------------';
    disp(DC1_disp);
    
    DC1_sig_in1_exp=log2(DC1_cur_sigs(1)); %logarthmic Sig_i s
    DC1_sig_in2_exp=log2(DC1_cur_sigs(2));%logarthmic Sig_i s
    
    DC1_miu_in1_exp=DC1_cur_mius(1);
    DC1_miu_in2_exp=DC1_cur_mius(2);
    
    DC1_DATA_in1_vec(:,DC1_indx_col) = DC1_file_1itt(:,1);
    DC1_DATA_in2_vec(:,DC1_indx_col) = DC1_file_1itt(:,2);
    DC1_DATA_out_sum_appx_vec(:,DC1_indx_col) = DC1_file_1itt(:,3);
    DC1_DATA_out_sum_accr_vec(:,DC1_indx_col) = DC1_file_1itt(:,4);
    %{ Sigma %}
    
    DC1_std_sum_appx=std(DC1_file_1itt(:,3)); %std khata dar chie
    
    %% fit matrix
    DC1_std_sum_accr=std(DC1_file_1itt(:,4)); %std BIKHATA chie
    DC1_miu_sum_accr = mean(DC1_file_1itt(:,4));
    DC1_std_sum_accr_log = round(log2(DC1_std_sum_accr));
    DC1_miu_sum_accr_log = round(log2(abs(DC1_miu_sum_accr)));
    
    if (DC1_miu_sum_accr < 0)
        DC1_miu_sum_accr_log = -1 * DC1_miu_sum_accr_log;
    end
    
    
    DC1_hist_x_range = max(DC1_file_1itt(:,3)) - min(DC1_file_1itt(:,3)) +1;
    
    DC1_bin=round ( (DC1_hist_x_range / ((INT_sample_cnt* DC1_samples_covrg_worst)/DC1_smpl_per_bin))/DC1_sclng_fac )*DC1_sclng_fac;
    if ( DC1_bin<1 )
        DC1_bin=1
    end
    
    
    %PMS Appx
    [DC1_l_apprx_1 DC1_pmf_apprx_1] = convertToPMF2(DC1_file_1itt(:,3),DC1_bin);
    
    %min of mins
    DC1_min_mins = min (DC1_l_apprx_1);
    %max of maxs
    DC1_max_maxs = max (DC1_l_apprx_1);
    
    [DC1_rl_apprx_1 DC1_rpmf_apprx_1] = convertToRangePMF2(DC1_l_apprx_1,DC1_pmf_apprx_1,DC1_min_mins,DC1_max_maxs);
    
    
    %Set while loop itterations
    if ( DC1_std_sum_accr_log > DC1_HD_std_log_th)
        DC1_HD_tries = DC1_HD_uppertry;
    else
        DC1_HD_tries = DC1_HD_maxtry;
    end
    
    
    %fitting loops
    DC1_fit_loop_cnt=0;
    % make sure HD is less than threshold but repeat until it is
    % allowed
    DC1_HD_GMEE_appx = 1;
    while (DC1_HD_GMEE_appx > DC1_HD_th && DC1_fit_loop_cnt < DC1_HD_tries )
        
        
        % repeat untill get converged results
        DC1_cnvrgd_flag =0;
        DC1_add_num_GMM = 0;
        while ( DC1_cnvrgd_flag < 1 && DC1_fit_loop_cnt < DC1_cnvrged_maxtry)
            if ( mod(DC1_fit_loop_cnt,20) ==0)
                fprintf('%s..',num2str(DC1_fit_loop_cnt));
            end
            DC1_fit_loop_cnt = DC1_fit_loop_cnt+1;
            DC1_GMMs_cnt = DC1_num_GMM + DC1_add_num_GMM ;
            [DC1_GMM_sum_appx_tmp, DC1_cnvrgd_flag,DC1_fit_NLL_tmp ] = findDist(DC1_file_1itt(:,3),DC1_GMMs_cnt,DC1_fit_maxIter);
        end
        
        %age valid e DATA va nazdiktaram has be data, zakhire kon
        if (DC1_cnvrgd_flag == 1)
            
            %fitted PMF
            [DC1_rl_GMEE_1  DC1_rpmf_GMEE_1]  = convertToRangePMF_norm(DC1_GMM_sum_appx_tmp,DC1_min_mins,DC1_max_maxs);%GMEE
            DC1_HD_GMEE_appx_tmp = HellingerDistance(DC1_rpmf_apprx_1 , DC1_rpmf_GMEE_1);
            
            
            if(DC1_HD_GMEE_appx_tmp < DC1_HD_GMEE_appx)
                DC1_GMM_sum_appx = DC1_GMM_sum_appx_tmp;
                DC1_HD_GMEE_appx = DC1_HD_GMEE_appx_tmp;
                DC1_fit_slct_cnt = DC1_fit_loop_cnt;
                DC1_fit_NLL = DC1_fit_NLL_tmp;
            end
        end
        
        if ( DC1_find_best_GMM == 1 && DC1_add_num_GMM < DC1_max_GMM)
        DC1_add_num_GMM = DC1_add_num_GMM +1;
        end
    end
    
     %while akhar yeki ezafe besh add shode
                if ( DC1_find_best_GMM == 1)
                        DC1_GMMs_cnt = DC1_GMMs_cnt -1;
                end
    
    fprintf('\n');
    DC1_disp = ['#tries to fit=',num2str(DC1_fit_loop_cnt),', Best one was #',num2str(DC1_fit_slct_cnt)];
    disp(DC1_disp);
    
    DC1_disp = ['#HD of fit=',num2str(DC1_HD_GMEE_appx), ' Using ',num2str(DC1_GMMs_cnt),'components - #AIC of fit=',num2str(DC1_fit_NLL)];
    disp(DC1_disp);
    DC1_disp = ['IN: <Sig1,Miu1>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in1_exp),'> , <Sig2,Miu2>=<',num2str(DC1_sig_in1_exp),',',num2str(DC1_miu_in2_exp),'>'];
    disp(DC1_disp);
    
    DC1_smtsmw_indx_sig = round(log2(DC1_std_sum_accr));
    DC1_smtsmw_indx_miu = 1-DC1_miu_sum_out_min_exp + DC1_miu_sum_accr_log; % shift midim ta index manfi ya mosbat az 1+0 shour she. yani 1-66 beshe. bad
    DC1_disp = ['smtsmw_indx: <Sigma_o,',num2str(1- DC1_miu_sum_out_min_exp),'+Miu_o>=<',num2str(DC1_smtsmw_indx_sig), ',', num2str(DC1_smtsmw_indx_miu),'>'];
    disp(DC1_disp);
    %store in matrix dg
    [DC1_GMM_x DC1_GMM_y] =  size(DC1_GMM_sum_appx);
    DC1_smtsmw_sum_mtx(1:DC1_GMM_x,1:DC1_GMM_y,DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)= DC1_GMM_sum_appx;
    %put 1 in cells we have gaussians
    
    if (DC1_cnvrgd_flag == 1)
        DC1_smtsmw_sum_flags_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_GMMs_cnt;
        DC1_smtsmw_sum_tires_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_fit_loop_cnt;
        DC1_smtsmw_sum_HDs_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_HD_GMEE_appx;
    else
        DC1_smtsmw_sum_flags_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)='-';
        DC1_smtsmw_sum_tires_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=DC1_cnvrged_maxtry;
        DC1_smtsmw_sum_HDs_mtx(DC1_smtsmw_indx_miu,DC1_smtsmw_indx_sig)=1;
    end
    
    %miu indices
    DC1_smsmtsm_indx_miu1 = 1- DC1_miu_sum_out_min_exp + DC1_miu_in1_exp;
    DC1_smsmtsm_indx_miu2 = 1- DC1_miu_sum_out_min_exp + DC1_miu_in2_exp;
    %transfer matrix
    DC1_smsmtsm_sum_accr_sim_mtx(:,DC1_sig_in1_exp,DC1_smsmtsm_indx_miu1,DC1_sig_in2_exp,DC1_smsmtsm_indx_miu2) = [DC1_smtsmw_indx_sig, DC1_smtsmw_indx_miu];
    %%
    DC1_sig_in1_vec(DC1_indx_col) = DC1_cur_sigs(1);
    DC1_sig_in2_vec(DC1_indx_col) = DC1_cur_sigs(2);
    DC1_std_sum_accr_vec(DC1_indx_col) = DC1_std_sum_accr;
    DC1_std_sum_appx_vec(DC1_indx_col) = DC1_std_sum_appx;
    %std_Mult_array(indx3) = std_Mult;
    
    DC1_sts_sum_appx_mtx(DC1_sig_in1_exp,DC1_sig_in2_exp) = DC1_std_sum_appx;
    DC1_sts_sum_accr_mtx(DC1_sig_in1_exp,DC1_sig_in2_exp) = DC1_std_sum_accr;
    %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult;
    
    %inja log e hamunaro chap konim
    DC1_sts_sum_appx_exp_mtx = round(log2(DC1_sts_sum_appx_mtx));
    DC1_sts_sum_accr_exp_mtx = round(log2(DC1_sts_sum_accr_mtx));
    DC1_EM_in = EM_med(DC1_file_1itt(:,4) ,DC1_file_1itt(:,3), INT_sample_cnt);
    DC1_ste_int_MED_mtx (DC1_sig_in1_exp,DC1_sig_in2_exp)=DC1_EM_in; %logarithmic indexed
    
    DC1_sum_accur_miu = mean(DC1_file_1itt(:,4));
    if (DC1_sum_accur_miu < 0)
        DC1_sum_accur_miu = -round(log2(-DC1_sum_accur_miu));
    else
        DC1_sum_accur_miu = round(log2(DC1_sum_accur_miu));
    end
    
    
    DC1_sum_accur_sig = round(10*log2(std(DC1_file_1itt(:,4))));
    
    DC1_smte_MED_mtx (INT_HWS_bits+DC1_sum_accur_miu , DC1_sum_accur_sig)=DC1_EM_in; %INT_HWS_bits+ guarantee no negative
    
end

%%  **^** MOHEMM **^**
%sizesho doros konim - inja das chapia data haye tolid shode va std hashune
% vas ine ke dafe aval ke be p mirese, dade ghablia kolan 0 bude dge
DC1_DATA_in1_vec         = DC1_DATA_in1_vec(:,2:DC1_indx_col);
DC1_DATA_in2_vec         = DC1_DATA_in2_vec(:,2:DC1_indx_col);
DC1_DATA_out_sum_appx_vec= DC1_DATA_out_sum_appx_vec(:,2:DC1_indx_col);
DC1_DATA_out_sum_accr_vec= DC1_DATA_out_sum_accr_vec(:,2:DC1_indx_col);

DC1_sig_in1_vec         = DC1_sig_in1_vec(:,2:DC1_indx_col);
DC1_sig_in2_vec         = DC1_sig_in2_vec(:,2:DC1_indx_col);
DC1_std_sum_accr_vec    = DC1_std_sum_accr_vec(:,2:DC1_indx_col);
DC1_std_sum_appx_vec    = DC1_std_sum_appx_vec(:,2:DC1_indx_col);

%% ERROR METRICS
%rename
DC1_dosAP               = DC1_DATA_out_sum_appx_vec;
DC1_dosAC               = DC1_DATA_out_sum_accr_vec;
%compute
DC1_out_sum_AE_vec      = func_Err_AE(DC1_dosAP,DC1_dosAC);
DC1_out_sum_MSE_vec     = func_Err_MSE(DC1_dosAP,DC1_dosAC);
DC1_out_sum_MSA_vec     = func_Err_MSA(DC1_dosAC);
DC1_out_sum_SNR_vec     = func_Err_SNR(DC1_dosAP,DC1_dosAC);
DC1_out_sum_PSNR_vec    = func_Err_PSNR(DC1_dosAP,DC1_dosAC);
DC1_out_sum_MED_vec     = func_Err_MED(DC1_dosAP,DC1_dosAC,INT_sample_cnt);
%{
DC1_out_sum_MED_vec = zeros(1,DC1_col_cnt);
for DCcol = 1:DC1_col_cnt
DC1_out_sum_MED_vec(1,DCcol) = EM_med(DC1_DOSAC(:,DCcol),DC1_DOSAP(:,DCcol),INT_sample_cnt);
end
%}
%% DISPLAY

disp(' ');
DC1_disp = '=========================================================';
disp(DC1_disp);
DC1_disp = ['Resluts for out_sum_XXX for ', num2str(DC1_indx_col-1), ' Columns'];
disp(DC1_disp);%actuall 2^Sig_i values
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);

DC1_disp = ['MSE: ']; %, num2str(DC1_out_sum_MSE_vec) ];
disp(DC1_disp);
disp(DC1_out_sum_MSE_vec);
DC1_disp = ['SNR: '];%, num2str(DC1_out_sum_SNR_vec) ];
disp(DC1_disp);
disp(DC1_out_sum_SNR_vec);
DC1_disp = ['PSNR: '];%, num2str(DC1_out_sum_PSNR_vec) ];
disp(DC1_disp);
disp(DC1_out_sum_PSNR_vec);
DC1_disp = ['MED: '];%, num2str(DC1_out_sum_MED_vec) ];
disp(DC1_disp);
disp(DC1_out_sum_MED_vec);




DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);
%DISPLAY FILLED CELLS
DC1_smtsmw_flags_nonEmpty = DC1_smtsmw_sum_flags_mtx (DC1_smtsmw_sum_flags_mtx ~=0);
DC1_numelsmtsmw_nonEmpty_cnt = numel(DC1_smtsmw_flags_nonEmpty);
disp(' ');
DC1_disp = '=========================================================';
disp(DC1_disp);
DC1_disp = ['Filled matrix: ',num2str(DC1_numelsmtsmw_nonEmpty_cnt),' cells have data. => ',num2str((DC1_indx_col-1) -DC1_numelsmtsmw_nonEmpty_cnt), ' cells overlapped.'];
disp(DC1_disp);%actuall 2^Sig_i values
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);


DC1_flags = TrimVisualizeArray( DC1_smtsmw_sum_flags_mtx,'0','.');
%show
disp(DC1_flags);
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);

DC1_tries = TrimVisualizeArray( DC1_smtsmw_sum_tires_mtx,'0','*');
%show
disp(DC1_tries);
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);

DC1_HDs = TrimVisualizeArray( DC1_smtsmw_sum_HDs_mtx,'0','o');
%show
disp(DC1_HDs);
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);



%ino nemidunam chie filan
%{

%disp (SigmaToEMin_MED_matrix);

reliabilities=coefs_total(1,:); % initialize
reliabilities1=size(coefs_total);
reliabilities1=reliabilities1(2);
for r =1:reliabilities1
reliabilities(1,r) = sum(coefs_total(:,r))
end

reliabilities  = 1-  reliabilities /INT_sample_cnt;


%occurences percent total
occurs_total=coefs_total(:,1); % initialize
occurs1=size(coefs_total); %number of itterations (runs)
occurs1=occurs1(1);
for r =1:occurs1
occurs_total(r,1) = sum(coefs_total(r,:))
end

occurs_total = (100 * occurs_total) / (INT_sample_cnt*occurs1);


%}

%%
fclose(DC1_msm_mat_file);

if saveFlag
    save (DC1_inP_path);
end









