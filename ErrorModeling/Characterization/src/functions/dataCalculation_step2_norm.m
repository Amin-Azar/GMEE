%{
%intitalization
% Sigma_itt = 15 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
% INT_sample_cnt = 100,000; % 5-7K samples for better sigma evaluation in
matlab
%
%
% bias =3; %chand ta aghab jolotar bere
% 
% 6 SECs/itteration
%}


%% Load parameters
DC2_inP_path = '/data/tmp/out_MAT/initP.mat';

%loadFlag =1;
if loadFlag
    load (DC2_inP_path);
end

%%
addpath(genpath(INT_SRC_path));

%indexing
DC2_indx_loop                       = 1; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
DC2_indx_disp                       = 1;
DC2_indx_mtx                        = 1;
DC2_col_cnt                         = DG1_indx_col;
DC2_indx_col                        = 0;
DC2_indx_row                        = 0;

% MED calc
DC2_out_med_itt                     = 0;
DC2_ste_out_sum_MED_mtx             = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DC2_ste_out_sum_MED_thisStep_mtx    = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);

DC2_EM_in12_extrct                  = zeros (3,1);

DC2_file_1itt_line                  = zeros(1,4);
DC2_file_1itt                       = zeros(INT_sample_cnt,4);

rst                                 =1;

%Sig reading
DC2_cur_sigs                        = zeros(1,2);
DC2_nxt_sigs                        = zeros(1,2);
%Miu reading
DC2_cur_mius                        = zeros(1,2); % aval sig/miu mikhune bad data, vas hamimn bas berim be miu ghabli moraje konim
DC2_nxt_mius                        = zeros(1,2); % vaghti resid inja yani data balayiaro process ko


% col be col data has be andazeye dade haye Ijad shode 1 dune bishtar ke
% dafe avalle ke sefre ru dashte bashim, bad hazf mikonim
DC2_DATA_in1_vec                    = zeros(INT_sample_cnt,DC1_col_cnt+1); %zeros(INT_sample_cnt,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC2_DATA_in2_vec                    = zeros(INT_sample_cnt,DC1_col_cnt+1);

DC2_DATA_out_sum_appx_inAP_vec      = zeros(INT_sample_cnt,DC1_col_cnt+1); %inam bas az simulation be das biad dge

% in dota badiaro chon az dorost shode bardashtim, ye sefr ezafe mizarim o
% az 2 shoru mikonim be copy kardan baz ke mese hame kharab bashe
DC2_DATA_out_sum_accr_inAP_vec      = zeros(INT_sample_cnt,DC1_col_cnt+1);
DC2_DATA_out_sum_accr_inAP_vec(:,2:end) = DG2_DATA_out_sum_accr_inAP_vec;% ino

%mituni test koni bebini vaghean ye vec hastan ya na!
DC2_DATA_out_sum_accr_inAC_vec      = zeros(INT_sample_cnt,DC1_col_cnt+1);
DC2_DATA_out_sum_accr_inAC_vec(:,2:end) = DG2_DATA_out_sum_accr_inAC_vec; 

%std and miu s 
DC2_sig_in1_vec                     = zeros(1,DC2_col_cnt+1); %zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp+INT_DG1_sig_bias)*DC1_max_miu);
DC2_sig_in2_vec                     = zeros(1,DC2_col_cnt+1);
DC2_std_sum_accr_inAC_vec           = zeros(1,DC2_col_cnt+1);
DC2_std_sum_appx_inAP_vec           = zeros(1,DC2_col_cnt+1);
DC2_std_sum_accr_inAP_vec           = zeros(1,DC2_col_cnt+1);

DC2_sts_sum_appx_inAP_mtx           = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DC2_sts_sum_accr_inAP_mtx           = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DC2_sts_sum_accr_inAC_mtx           = zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);


%% CODE

%file open
DC2_msm_mat_file = fopen(strcat(INT_DIR_path,INT_DC2_path_msm_mat),'r');

if 1
    while ~feof(DC2_msm_mat_file)
        %fprintf('w%d\n',DC2_indx_loop);
        DC2_indx_loop= DC2_indx_loop+1;
        % vase neshun dadan e progress bood
        %{
        if(DC2_indx_loop == INT_sample_cnt);
            DC2_indx_loop=1;
            DC2_indx_disp=DC2_indx_disp+1; %100K index semicolon nazashtim index beznae bbeinim kojayim asan
            
        end
        %}
        
        DC2_line_type = fgets(DC2_msm_mat_file,1);
        %display(type);
        if strcmp(DC2_line_type,'s');
            %display('type =s');
            DC2_line_ignr = fgets(DC2_msm_mat_file,102);
            
        elseif  strcmp(DC2_line_type,'m');
            %display('type =m');
            
            DC2_line_mius = fscanf (DC2_msm_mat_file,' %f %f\n');
            DC2_line_mius = transpose(DC2_line_mius);
            
            DC2_line_mius = round(DC2_line_mius);
            
            DC2_miu_line_in2 = DC2_line_mius(2);
            DC2_miu_line_in1 = DC2_line_mius(1);
            
            DC2_miu_line_in1_exp = log2(abs(DC2_miu_line_in1));
            DC2_miu_line_in2_exp = log2(abs(DC2_miu_line_in2));
            
            %manfiasho doros konim. sefram sefr beshe, na -INF
            if (DC2_miu_line_in1 < 0)
                DC2_miu_line_in1_exp = -DC2_miu_line_in1_exp;
            elseif ( DC2_miu_line_in1 == 0 )
                DC2_miu_line_in1_exp = 0;
            end
            
            if (DC2_miu_line_in2 < 0)
                DC2_miu_line_in2_exp = -DC2_miu_line_in2_exp;
            elseif (DC2_miu_line_in1 == 0)
                DC2_miu_line_in2_exp = 0;
            end
            
            DC2_nxt_mius(1) = DC2_miu_line_in1_exp; DC2_nxt_mius(2) = DC2_miu_line_in2_exp;
            
            
        elseif  strcmp(DC2_line_type,'t');
            DC2_EM_in12_extrct=fscanf (DC2_msm_mat_file,' %f %f %f\n'); %EM_a EM_b EM _in
            DC2_EM_in12_extrct=transpose(DC2_EM_in12_extrct);
            
        elseif  strcmp(DC2_line_type,'d');
            %         display('type = d');
            DC2_data_line=fscanf (DC2_msm_mat_file,' %d %d %d %d\n'); %a_d,a_h,b_d,b_h,appx_d,appx_h,accr_d,accr_h   d(%h) %d(%h) %d(%h) %d(%h)'
            DC2_file_1itt_line= transpose(DC2_data_line);
            
            
            if ( rst >0) % yani yek e
                DC2_indx_row =1;
                DC2_file_1itt = DC2_file_1itt_line; %index 1 ro mizarim inja
                rst =0;
            else
                DC2_indx_row = DC2_indx_row +1;
                DC2_file_1itt(DC2_indx_row,:) = DC2_file_1itt_line; % dafe dovome az index 2 ham injaro por mikonim
            end

            
        elseif  strcmp(DC2_line_type,'p');
            
            DC2_indx_col=DC2_indx_col+1; %avali ke sefre bezarim injam oke
            
            rst=1;% resifdim be abdi dge inja bayad ghabliaro besporim be daste sarnevesht!
            DC2_sig_line=fscanf (DC2_msm_mat_file,' %d %d\n');%sigmaharo az tu file mikhunim
            DC2_nxt_sigs(1)=DC2_sig_line(1); DC2_nxt_sigs(2)=DC2_sig_line(2); % row be column e sh fargh dare chonle
                                
            if(DC2_cur_sigs(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
                
                disp(' ');
                DC1_disp = '=========================================================';
                disp(DC1_disp);
                DC1_disp = ['Itteration ',num2str(DC2_indx_col-1) ,' for <Sig1,Miu1>=<',num2str(DC2_cur_sigs(1)),',',num2str(DC2_cur_mius(1)),'> , <Sig2,Miu2>=<',num2str(DC2_cur_sigs(2)),',',num2str(DC2_cur_mius(2)),'>'];
                disp(DC1_disp);%actuall 2^Sig_i values
                DC1_disp = '---------------------------------------------------------';
                disp(DC1_disp);
                
                DC2_sig_in1_exp =log2(DC2_cur_sigs(1)); %logarthmic Sig_i s
                DC2_sig_in2_exp =log2(DC2_cur_sigs(2));%logarthmic Sig_i s
                
                DC2_miu_in1_exp=DC2_cur_mius(1);
                DC2_miu_in2_exp=DC2_cur_mius(2);
                
                DC2_DATA_in1_vec(:,DC2_indx_col) = DC2_file_1itt(:,1);
                DC2_DATA_in2_vec(:,DC2_indx_col) = DC2_file_1itt(:,2);
                DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,3);
                DC2_DATA_out_sum_accr_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,4);
                
                %sigma to Sigma approximate
                DC2_std_sum_accr_inAC=std(DC2_DATA_out_sum_accr_inAC_vec(:,DC2_indx_col)); %std khata dar chie
                DC2_std_sum_accr_inAP=std(DC2_DATA_out_sum_accr_inAP_vec(:,DC2_indx_col)); %std khata dar chie
                DC2_std_sum_appx_inAP=std(DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col)); %std khata dar chie
                
                DC2_sig_in1_vec(DC2_indx_col) = DC2_cur_sigs(1);
                DC2_sig_in2_vec(DC2_indx_col) = DC2_cur_sigs(2);
                
                DC2_std_sum_accr_inAC_vec(DC2_indx_col) = DC2_std_sum_accr_inAC;
                DC2_std_sum_appx_inAP_vec(DC2_indx_col) = DC2_std_sum_appx_inAP;
                DC2_std_sum_accr_inAP_vec(DC2_indx_col) = DC2_std_sum_accr_inAP;
                %DC1_std_mlt_array(DC1_indx_data) = std_Mult;
                      
                DC2_sts_sum_appx_inAP_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_appx_inAP;
                DC2_sts_sum_accr_inAP_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_accr_inAP;
                DC2_sts_sum_accr_inAC_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_accr_inAC;
                
                %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult;
                
                
                DC2_sdata = numelements(DC2_DATA_out_sum_accr_inAC_vec);
                DC2_sread = numelements(DC2_file_1itt);
                
                if (DC2_sdata == DC2_sread)
                    
                    if (  (DC2_sig_in1_exp > 0) && (DC2_sig_in2_exp > 0) )
                        DC2_out_med_itt = func_Err_MED(DC2_file_1itt(:,3), DC2_DATA_out_sum_accr_inAC_vec(:,DC2_indx_col), INT_sample_cnt);
                        DC2_ste_out_sum_MED_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp)=DC2_out_med_itt; %logarithmic indexed
                        
                        % enghar input salem e ama adder khata dar. tu in
                        % marhlahe cheghad error dad bemun
                        DC2_out_med_step_itt = func_Err_MED(DC2_file_1itt(:,3), DC2_file_1itt(:,4), INT_sample_cnt);
                        DC2_ste_out_sum_MED_thisStep_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp)=DC2_out_med_step_itt; %logarithmic indexed
                        
                    end
                    
                    DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,3);% A+B truncate shode javabe approx
                    
                    
                else
                    display('Error **');
                    display(DC2_sread);
                end
                
            end
            
        else
            %asterics o ina
            DC2_line_ignr = fgets(DC2_msm_mat_file,102);% age chize kharabi bud varesh dare!
        end
        
        %   sigmas = vertcat ( sigmas,sigma);
        DC2_cur_sigs = DC2_nxt_sigs;
        DC2_cur_mius = DC2_nxt_mius;
        
    end
end
    %round akhar
    DC2_indx_col=DC2_indx_col+1;
    if(DC2_cur_sigs(1)>0) % meghdar gerefte bashe. round e avval ke 0 has ro bazi nadim
      
        disp(' ');
        DC1_disp = '=========================================================';
        disp(DC1_disp);
        DC1_disp = ['Itteration ',num2str(DC2_indx_col-1) ,' for <Sig1,Miu1>=<',num2str(DC2_cur_sigs(1)),',',num2str(DC2_cur_mius(1)),'> , <Sig2,Miu2>=<',num2str(DC2_cur_sigs(2)),',',num2str(DC2_cur_mius(2)),'>'];
        disp(DC1_disp);%actuall 2^Sig_i values
        DC1_disp = '---------------------------------------------------------';
        disp(DC1_disp);
       
        DC2_sig_in1_exp =log2(DC2_cur_sigs(1)); %logarthmic Sig_i s
        DC2_sig_in2_exp =log2(DC2_cur_sigs(2));%logarthmic Sig_i s
        
        DC2_miu_in1_exp=DC2_cur_mius(1);
        DC2_miu_in2_exp=DC2_cur_mius(2);
        
        
        DC2_DATA_in1_vec(:,DC2_indx_col) = DC2_file_1itt(:,1);
        DC2_DATA_in2_vec(:,DC2_indx_col) = DC2_file_1itt(:,2);
        DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,3);
        DC2_DATA_out_sum_accr_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,4);
        
        %sigma to Sigma approximate
        DC2_std_sum_accr_inAC=std(DC2_DATA_out_sum_accr_inAC_vec(:,DC2_indx_col)); %std khata dar chie
        DC2_std_sum_accr_inAP=std(DC2_DATA_out_sum_accr_inAP_vec(:,DC2_indx_col)); %std khata dar chie
        DC2_std_sum_appx_inAP=std(DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col)); %std khata dar chie
        
        DC2_sig_in1_vec(DC2_indx_col) = DC2_cur_sigs(1);
        DC2_sig_in2_vec(DC2_indx_col) = DC2_cur_sigs(2);
        
        DC2_std_sum_accr_inAC_vec(DC2_indx_col) = DC2_std_sum_accr_inAC;
        DC2_std_sum_appx_inAP_vec(DC2_indx_col) = DC2_std_sum_appx_inAP;
        DC2_std_sum_accr_inAP_vec(DC2_indx_col) = DC2_std_sum_accr_inAP;
        %DC1_std_mlt_array(DC1_indx_data) = std_Mult;
        
        
        DC2_sts_sum_appx_inAP_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_appx_inAP;
        DC2_sts_sum_accr_inAP_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_accr_inAP;
        DC2_sts_sum_accr_inAC_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp) = DC2_std_sum_accr_inAC;
        
        %SigmaToSigma_Mult_matrix_apprx(k,c) = std_Mult;
        
        
        DC2_sdata = numel(DC2_DATA_out_sum_accr_inAC_vec);
        DC2_sread = numel(DC2_file_1itt);
        
        if (DC2_sdata == DC2_sread)
            
            if (  (DC2_sig_in1_exp > 0) && (DC2_sig_in2_exp > 0) )
                DC2_out_med_itt = func_Err_MED(DC2_file_1itt(:,3), DC2_DATA_out_sum_accr_inAC_vec(:,DC2_indx_col), INT_sample_cnt);
                DC2_ste_out_sum_MED_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp)=DC2_out_med_itt; %logarithmic indexed
                
                % enghar input salem e ama adder khata dar. tu in
                % marhlahe cheghad error dad bemun
                DC2_out_med_step_itt = func_Err_MED(DC2_file_1itt(:,3), DC2_file_1itt(:,4), INT_sample_cnt);
                DC2_ste_out_sum_MED_thisStep_mtx(DC2_sig_in1_exp,DC2_sig_in2_exp)=DC2_out_med_step_itt; %logarithmic indexed
                
                %regression nadarim dge
                %{
                        Matrix_reg_Accur(DC2_indx_col,[1 2])=DC2_EM_in12_extrct(1,[1 2]);
                        Matrix_reg_Accur(DC2_indx_col,3)=MED_z_accr;
                        
                        Matrix_reg_Apprx(DC2_indx_col,[1 2 3])=DC2_EM_in12_extrct;
                        Matrix_reg_Apprx(DC2_indx_col,4)=MED_z;
                %}
            end
            
            DC2_DATA_out_sum_appx_inAP_vec(:,DC2_indx_col) = DC2_file_1itt(:,3);% A+B truncate shode javabe approx
            
            
        else
            display('Error **');
            display(DC2_sread);
        end
    end
    
    
    %%  **^** MOHEMM **^**
%sizesho doros konim - inja das chapia data haye tolid shode va std hashune
% vas ine ke dafe aval ke be p mirese, dade ghablia kolan 0 bude dge
DC2_DATA_in1_vec         = DC2_DATA_in1_vec(:,2:DC1_indx_col);
DC2_DATA_in2_vec         = DC2_DATA_in2_vec(:,2:DC1_indx_col);

DC2_DATA_out_sum_appx_inAP_vec = DC2_DATA_out_sum_appx_inAP_vec(:,2:DC1_indx_col);
DC2_DATA_out_sum_accr_inAP_vec = DC2_DATA_out_sum_accr_inAP_vec(:,2:DC1_indx_col);
DC2_DATA_out_sum_accr_inAC_vec = DC2_DATA_out_sum_accr_inAC_vec(:,2:DC1_indx_col);

DC2_sig_in1_vec       = DC2_sig_in1_vec(:,2:DC1_indx_col);
DC2_sig_in2_vec       = DC2_sig_in2_vec(:,2:DC1_indx_col);

DC2_std_sum_accr_inAC_vec    = DC2_std_sum_accr_inAC_vec(:,2:DC1_indx_col);
DC2_std_sum_appx_inAP_vec    = DC2_std_sum_appx_inAP_vec(:,2:DC1_indx_col);
DC2_std_sum_accr_inAP_vec    = DC2_std_sum_accr_inAP_vec(:,2:DC1_indx_col);

     
%% ERROR METRICS
%rename
DC2_dosAP = DC2_std_sum_appx_inAP_vec;
DC2_dosAC = DC2_std_sum_accr_inAC_vec;
%compute
DC2_out_sum_AE_tot_vec      = func_Err_AE(DC2_dosAP,DC2_dosAC);
DC2_out_sum_MSE_tot_vec     = func_Err_MSE(DC2_dosAP,DC2_dosAC);
DC2_out_sum_MSA_tot_vec     = func_Err_MSA(DC2_dosAC);
DC2_out_sum_SNR_tot_vec     = func_Err_SNR(DC2_dosAP,DC2_dosAC);
DC2_out_sum_PSNR_tot_vec    = func_Err_PSNR(DC2_dosAP,DC2_dosAC);
DC2_out_sum_MED_tot_vec     = func_Err_MED(DC2_dosAP,DC2_dosAC,INT_sample_cnt);
 

%% DISPLAY  
disp(' ');
DC1_disp = '=========================================================';
disp(DC1_disp);
DC1_disp = ['Resluts for out_sum_tot_XXX for ', num2str(DC2_indx_col-1), ' Columns'];
disp(DC1_disp);%actuall 2^Sig_i values
DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);

DC1_disp = ['MSE: ']; %, num2str(DC1_out_sum_MSE_vec) ];
disp(DC1_disp);
disp(DC2_out_sum_MSE_tot_vec);
DC1_disp = ['SNR: '];%, num2str(DC1_out_sum_SNR_vec) ];
disp(DC1_disp);
disp(DC2_out_sum_SNR_tot_vec);
DC1_disp = ['PSNR: '];%, num2str(DC1_out_sum_PSNR_vec) ];
disp(DC1_disp);
disp(DC2_out_sum_PSNR_tot_vec);
DC1_disp = ['MED: '];%, num2str(DC1_out_sum_MED_vec) ];
disp(DC1_disp);
disp(DC2_out_sum_MED_tot_vec);




DC1_disp = '---------------------------------------------------------';
disp(DC1_disp);

    % regression nadaram dge
    %{
for i= 1:up*up
    if(Matrix_reg_Apprx(i,1) ~= 0)
        Matrix_reg_Apprx_noZero(DC2_indx_mtx,:) = Matrix_reg_Apprx(i,:);
        DC2_indx_mtx = DC2_indx_mtx+1;
    end
end
    %}
    
    fclose(DC2_msm_mat_file);
    
    if saveFlag
        save (DC2_inP_path);
    end











