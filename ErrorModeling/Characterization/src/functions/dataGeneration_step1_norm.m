
%intitalization
%{
% set miu
% set sigma A -> c
% set sigma B -> k
% Generate A,B
% Calculate sum,mult
% Check stds
% write outfile
% (plot)
%
% 2 SECs/sigma
%}


%{
INT_max_sig_itt_exp = 3 %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
INT_sample_cnt = 7000; % 5-7K samples for better sigma evaluation in matlab
%%INT_DG1_sig_bias =3; %chand ta aghab jolotar bere
INT_DG1_sig_bias=0;
%}

%%
%{
sigma A o B yeki bashe
inaja mikhayim 1 6 .. sigma tolid konim, ba truncate shode bad moghayese
konim bebinim error chi mishe
%}
%% Load parameters

DG1_inP_path = '/data/tmp/out_MAT/initP.mat';

loadFlag=1;
if loadFlag
    load (DG1_inP_path);
end

DG1_in1_type_rand = INT_DG1_in1_type_rand;
DG1_in2_type_rand = INT_DG1_in2_type_rand;

DG1_in1_type_read = INT_DG1_in1_type_read;
DG1_in2_type_read = INT_DG1_in2_type_read;
DG2_in2_type_read = INT_DG2_in2_type_read;

%% Sigma Specs
% IN1 x<sig<x
DG1_sig_itt_strt_in1_exp = INT_bgn_sig_itt_exp; % az che sigmayi shoru kone be sakhtan va step step bere ta INT_max_sig_itt_exp
DG1_sig_itt_stop_in1_exp = INT_max_sig_itt_exp;
DG1_sig_step_in1 = INT_DG1_sig_step_in1; %2; % beza yek bemune age mikhay sigma yeki yeki bere bala
DG1_sig_in1 = 0;
% IN2 x<sig<x
DG1_sig_itt_strt_in2_exp = INT_bgn_sig_itt_exp;
DG1_sig_itt_stop_in2_exp = INT_max_sig_itt_exp;
DG1_sig_step_in2 = INT_DG1_sig_step_in2; %2; % beza yek bemune age mikhay sigma yeki yeki bere bala
DG1_sig_in2 = 0;

%% Miu Specs
DG1_bas_miu_exp=0; % base miu
DG1_miu_step=INT_DG1_miu_step ; %4 % ghablan ba 4 run kardim
DG1_miu_itt_min_exp = -2^round(log2(INT_max_sig_itt_exp));
DG1_miu_itt_max_exp =  2^round(log2(INT_max_sig_itt_exp));

% age mikhaym miu sefr bashe - age na ke ghablan moshakhas shode
if(INT_miu_in_zero >0 )
    DG1_miu_itt_stop_exp = 0;
    DG1_miu_itt_strt_exp =0;
else
    DG1_miu_itt_strt_exp = DG1_miu_itt_min_exp;
    DG1_miu_itt_stop_exp = DG1_miu_itt_max_exp;
end


%maximum number of cells we need in each matrix
DG1_miu_in_vec = DG1_miu_itt_min_exp:1:DG1_miu_itt_max_exp; % e.g. -16 0 16
DG1_miu_sum_out_vec = 2*DG1_miu_itt_min_exp:1:2*DG1_miu_itt_max_exp; %e.g. -32 -16 0 16 32
%starts
DG1_miu_sum_out_min_exp = 2*DG1_miu_itt_min_exp; % in mige avalie chi bude
%counts for making matrices
DG1_miu_in_cnt = numel(DG1_miu_in_vec);
DG1_miu_sum_out_cnt = numel(DG1_miu_sum_out_vec); % 32 - (-32) +1 = 65 ta



%% Indexing
%DG1_indx_col =0; % bekhunim az ru fiile ya -> %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
DG1_up_exp = INT_HWS_bits -4;

%% Generated DATA and accurate operations
% Datas: sum mult A B
%Pre-allocation
DG1_out_sum_array=zeros(INT_sample_cnt,1);
DG1_out_mlt_array=zeros(INT_sample_cnt,1);
%DG1_in1_vec_nrmRnd_rounded % badan tarif shodan
%DG1_in2_vec_nrmRnd_rounded % badan tarif shodan
%% STD storages
% rounded miu vectors prealloc
DG1_rmu_in1_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_rmu_in2_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_rmu_sum_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_rmu_mlt_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
%std ( sig of rounded data)
DG1_std_in1_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_std_in2_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_std_sum_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
DG1_std_mlt_vec =zeros(1,INT_max_sig_itt_exp*(INT_max_sig_itt_exp + INT_DG1_sig_bias));
%std matrices prealloc
DG1_sts_sum_mtx =zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
DG1_sts_mlt_mtx =zeros(INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);
%miu-std1-std2 to miu-std matrices preallocate
% [2(=miu,sig khoruji)] x [miu x sig1 x sig2 (=vuridua)]
%DG1_smtsm_sum_mtx =zeros(2,DG1_miu_count,INT_max_sig_itt_exp+INT_DG1_sig_bias,INT_max_sig_itt_exp);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CODE

%file open
DG1_mat_msm_file = fopen(strcat(INT_DIR_path,INT_DG1_path_mat_msm),'w');
fprintf(DG1_mat_msm_file,'s%12s %12s %12s %12s \ns\n','IN1','IN2', 'SUM ', 'MLT ');

%if we should generate
if (DG1_in1_type_rand ==1 && DG1_in2_type_rand ==1)
    
    DG1_indx_col =0; %in bara ine ke dge khodesh index bezane bere jolo fek nakonim kojayim
    
    %code starts here
    if 1
        
        
        % ********* MIU IN     %inja migi az kodum miu bashe ta kodum miu
        for DG1_bas_miu_exp = DG1_miu_itt_strt_exp:DG1_miu_step:DG1_miu_itt_stop_exp % 0:0 vase inke gaussiane ba miu e 0 bashe %-2^round(log2(INT_max_sig_itt_exp)):DG1_miu_step: 2^round(log2(INT_max_sig_itt_exp))
            if(abs(DG1_bas_miu_exp) < DG1_up_exp)
                
                %display(miu);
                
                %build miu for A and B
                if (DG1_bas_miu_exp == 0) % zero is zero not 1 (2^0=1)
                    DG1_miu_in1=0;
                    DG1_miu_in2=0;
                elseif ( DG1_bas_miu_exp <0) % negative
                    DG1_miu_in1 = -2^-DG1_bas_miu_exp;
                    DG1_miu_in2 = -2^-DG1_bas_miu_exp;
                    
                else % positive
                    DG1_miu_in1 = 2^DG1_bas_miu_exp;
                    DG1_miu_in2 = 2^DG1_bas_miu_exp;
                end
                
                % ********* SIGMA IN1
                for DG1_sig_in1_exp = DG1_sig_itt_strt_in1_exp:DG1_sig_step_in1:DG1_sig_itt_stop_in1_exp %1:step:INT_max_sig_itt_exp
                    
                    if (DG1_sig_in1_exp > 0)&& (DG1_sig_in1_exp+log2(abs(DG1_miu_in1)) < DG1_up_exp ) %over flow nashe % OLD:index manfi nazanim % ta 3 barabar ke adad mire, 1 dune ham ke sign bit e
                        %age bekhaym kam ejra konim
                        %for k = c-INT_DG1_sig_bias:c+INT_DG1_sig_bias; % in yani 15 beshe, vagarna vase 30% kardan e simulation mishe az for k = itt:itt+3 estefade kard
                        
                        % age harchi vorudi 1 dasht khastim vorudi 2 ham dashte bashe
                        if ( INT_sig_same_in1_in2 >0)
                            DG1_sig_itt_strt_in2_exp = DG1_sig_in1_exp;
                            DG1_sig_itt_stop_in2_exp = DG1_sig_in1_exp;
                        end
                        
                        % ********* SIGMA IN2
                        for DG1_sig_in2_exp = DG1_sig_itt_strt_in2_exp:DG1_sig_step_in2:DG1_sig_itt_stop_in2_exp %1:step:INT_max_sig_itt_exp
                            
                            
                            if (DG1_sig_in2_exp > 0)&& (DG1_sig_in2_exp+log2(abs(DG1_miu_in2))< DG1_up_exp) % index manfi nazanim
                                
                                DG1_sig_in1 = 2^DG1_sig_in1_exp % semicolon nazashtim ke neshun bedi yechi un zir befahmim dare mire jolo
                                DG1_sig_in2 = 2^DG1_sig_in2_exp;
                                
                                %fprintf('MSG (log2) miu is: %12d, S_a=%12d, S_b=%12d\n',miu,c,k);
                                fprintf('MSG (log2) miu is: %12d, S_a=%12d\n',DG1_bas_miu_exp,DG1_sig_in2_exp);
                                
                                %% Original DATA
                                % adada inja generate mishe
                                DG1_in1_array_nrmRnd = normrnd(DG1_miu_in1, DG1_sig_in1 , [INT_sample_cnt 1]);
                                DG1_in2_array_nrmRnd = normrnd(DG1_miu_in2, DG1_sig_in2 , [INT_sample_cnt 1]);
                                
                                %inja round mikonim, didim ke round kardan hamchinam tasire badi nadare
                                DG1_in1_array_nrmRnd_rounded = round(DG1_in1_array_nrmRnd);
                                DG1_in2_array_nrmRnd_rounded = round(DG1_in2_array_nrmRnd);
                                DG1_out_sum_array = DG1_in1_array_nrmRnd_rounded + DG1_in2_array_nrmRnd_rounded;%sum e daghigh az input haye round shode
                                DG1_out_mlt_array = DG1_in1_array_nrmRnd_rounded .* DG1_in2_array_nrmRnd_rounded;
                                
                                %%
                                %std hayi ke khode matlab be das miare
                                DG1_std_in1=std(DG1_in1_array_nrmRnd_rounded);
                                DG1_std_in2=std(DG1_in2_array_nrmRnd_rounded);
                                DG1_std_sum=std(DG1_out_sum_array);
                                DG1_std_mlt=std(DG1_out_mlt_array);
                                
                                DG1_rmu_in1 = mean(DG1_in1_array_nrmRnd_rounded); % in miu fqrgh dare ba miu ke sakhtim chon bad az ine ke round shode
                                DG1_rmu_in2 = mean(DG1_in2_array_nrmRnd_rounded);
                                DG1_miu_sum = mean(DG1_out_sum_array);
                                DG1_miu_mlt = mean(DG1_out_mlt_array);
                                
                                DG1_indx_col = DG1_indx_col+1;
                                %display
                                if (mod(DG1_indx_col,10) ==0); % har 10 ta yebar neshun bedim
                                    DG1_indx_col
                                end
                                
                                %% STORE MIU & STDs into ARRAY & MATRIX
                                %miu store in vectors
                                DG1_rmu_in1_vec(DG1_indx_col) = DG1_rmu_in1;
                                DG1_rmu_in2_vec(DG1_indx_col) = DG1_rmu_in2;
                                DG1_rmu_sum_vec(DG1_indx_col) = DG1_miu_sum;
                                DG1_rmu_mlt_vec(DG1_indx_col) = DG1_miu_mlt;
                                %std
                                DG1_std_in1_vec(DG1_indx_col) = DG1_std_in1;
                                DG1_std_in2_vec(DG1_indx_col) = DG1_std_in2;
                                DG1_std_sum_vec(DG1_indx_col) = DG1_std_sum;
                                DG1_std_mlt_vec(DG1_indx_col) = DG1_std_mlt;
                                
                                %indexing based on the power of values 2^N
                                DG1_sts_sum_mtx(DG1_sig_in2_exp,DG1_sig_in1_exp) = DG1_std_sum;
                                DG1_sts_mlt_mtx(DG1_sig_in2_exp,DG1_sig_in1_exp) = DG1_std_mlt;
                                
                                %% PRINT to FILE
                                % Miu & Sigma print
                                fprintf(DG1_mat_msm_file,'m %12d %12d\n',DG1_miu_in1,DG1_miu_in2); % miu in marhale
                                fprintf(DG1_mat_msm_file,'p%12d %12d\n',DG1_sig_in1,DG1_sig_in2); % ba ina sakhtim vali badia darumade
                                fprintf(DG1_mat_msm_file,'s\ns** [Sigma_A=%12d Sigma_B=%12d]\n',DG1_sig_in1,DG1_sig_in2); % ba ina sakhtim vali badia darumade
                                fprintf(DG1_mat_msm_file,'s== [ s_A=%10.2f s_B=%10.2f s_Sum=%10.2f s_Mult=%10.2f]\n',DG1_std_in1,DG1_std_in2,DG1_std_sum,DG1_std_mlt); % in daghigheshe
                                fprintf(DG1_mat_msm_file,'s~~ [std_A=%12d std_B=%12d std_Sum=%12d std_Mult=%12d]\ns\n',round(DG1_std_in1),round(DG1_std_in2),round(DG1_std_sum),round(DG1_std_mlt)); % in round shodashe
                                
                                %100K ta minvisim
                                for i = 1:INT_sample_cnt
                                    fprintf(DG1_mat_msm_file,'d%12d %12d %12d %12d\n',DG1_in1_array_nrmRnd_rounded(i),DG1_in2_array_nrmRnd_rounded(i),DG1_out_sum_array(i),DG1_out_mlt_array(i));
                                end
                                
                            end
                            
                            
                        end
                    end
                end
                
            end
        end
    end
    
    %%size correction
    DG1_rmu_in1_vec = DG1_rmu_in1_vec(1:DG1_indx_col);
    DG1_rmu_in2_vec = DG1_rmu_in2_vec(1:DG1_indx_col);
    DG1_rmu_sum_vec = DG1_rmu_sum_vec(1:DG1_indx_col);
    DG1_rmu_mlt_vec = DG1_rmu_mlt_vec(1:DG1_indx_col);
    %std
    DG1_std_in1_vec = DG1_std_in1_vec(1:DG1_indx_col);
    DG1_std_in2_vec = DG1_std_in2_vec(1:DG1_indx_col);
    DG1_std_sum_vec = DG1_std_sum_vec(1:DG1_indx_col);
    DG1_std_mlt_vec = DG1_std_mlt_vec(1:DG1_indx_col);
    
end

% if we should read from existing vectors of DATA
if (DG1_in1_type_read ==1 && DG1_in2_type_read ==1)
    
    for DG1col = 1:DG1_indx_col
        
        %fprintf('MSG (log2) miu is: %12d, S_a=%12d, S_b=%12d\n',miu,c,k);
        fprintf('MSG (log2) miu is: %12d, S_a=%12d\n',DG1_bas_miu_exp,DG1_sig_in2_exp);
        
        %% Original DATA
        % adada inja generate mishe
        
        
        %inja  khunde mishe az dade haye monitor shode
        DG1_in1_read_array = DG1_DATA_in1_read_vec(:,DG1_indx_col);
        DG1_in2_read_array = DG1_DATA_in2_read_vec(:,DG1_indx_col);
        DG1_out_sum_array = DG1_in1_read_array + DG1_in2_read_array;%sum e daghigh az input haye round shode
        DG1_out_mlt_array = DG1_in1_read_array .* DG1_in2_read_array;
        
        %%
        % inaro darim mikhunim dge! pas sig o std yekie o az ru datas fagat
        DG1_sig_in1 =std(DG1_in1_read_array);
        DG1_sig_in2 =std(DG1_in2_read_array);
        
        DG1_miu_in1 = mean(DG1_in1_read_array);
        DG1_miu_in2 = mean(DG1_in2_read_array);
        
        
        %std hayi ke khode matlab be das miare
        DG1_std_in1=std(DG1_in1_read_array);
        DG1_std_in2=std(DG1_in2_read_array);
        DG1_std_sum=std(DG1_out_sum_array);
        DG1_std_mlt=std(DG1_out_mlt_array);
        
        DG1_rmu_in1 = mean(DG1_in1_read_array); % in miu fqrgh dare ba miu ke sakhtim chon bad az ine ke round shode
        DG1_rmu_in2 = mean(DG1_in2_read_array);
        DG1_miu_sum = mean(DG1_out_sum_array);
        DG1_miu_mlt = mean(DG1_out_mlt_array);
        
        
        %display
        if (mod(DG1_indx_col,10) ==0); % har 10 ta yebar neshun bedim
            disp(DG1_indx_col);
        end
        
        %% STORE MIU & STDs into ARRAY & MATRIX
        %miu store in vectors
        DG1_rmu_in1_vec(DG1_indx_col) = DG1_rmu_in1;
        DG1_rmu_in2_vec(DG1_indx_col) = DG1_rmu_in2;
        DG1_rmu_sum_vec(DG1_indx_col) = DG1_miu_sum;
        DG1_rmu_mlt_vec(DG1_indx_col) = DG1_miu_mlt;
        %std
        DG1_std_in1_vec(DG1_indx_col) = DG1_std_in1;
        DG1_std_in2_vec(DG1_indx_col) = DG1_std_in2;
        DG1_std_sum_vec(DG1_indx_col) = DG1_std_sum;
        DG1_std_mlt_vec(DG1_indx_col) = DG1_std_mlt;
        
        %indexing based on the power of values 2^N
        DG1_sts_sum_mtx(DG1_sig_in2_exp,DG1_sig_in1_exp) = DG1_std_sum;
        DG1_sts_mlt_mtx(DG1_sig_in2_exp,DG1_sig_in1_exp) = DG1_std_mlt;
        
        %% PRINT to FILE
        % Miu & Sigma print
        fprintf(DG1_mat_msm_file,'m %12d %12d\n',DG1_miu_in1,DG1_miu_in2); % miu in marhale
        fprintf(DG1_mat_msm_file,'p%12d %12d\n',DG1_sig_in1,DG1_sig_in2); % ba ina sakhtim vali badia darumade
        fprintf(DG1_mat_msm_file,'s\ns** [Sigma_A=%12d Sigma_B=%12d]\n',DG1_sig_in1,DG1_sig_in2); % ba ina sakhtim vali badia darumade
        fprintf(DG1_mat_msm_file,'s== [ s_A=%10.2f s_B=%10.2f s_Sum=%10.2f s_Mult=%10.2f]\n',DG1_std_in1,DG1_std_in2,DG1_std_sum,DG1_std_mlt); % in daghigheshe
        fprintf(DG1_mat_msm_file,'s~~ [std_A=%12d std_B=%12d std_Sum=%12d std_Mult=%12d]\ns\n',round(DG1_std_in1),round(DG1_std_in2),round(DG1_std_sum),round(DG1_std_mlt)); % in round shodashe
        
        %100K ta minvisim
        for i = 1:INT_sample_cnt
            fprintf(DG1_mat_msm_file,'d%12d %12d %12d %12d\n',DG1_in1_array_nrmRnd_rounded(i),DG1_in2_array_nrmRnd_rounded(i),DG1_out_sum_array(i),DG1_out_mlt_array(i));
        end
    end
end

%%
%Plot
if 0 % age khastim figure ro bekeshe ke nemikhaym filan
    figure
    
    subplot(1,3,1)
    hold on
    surf(log2(DG1_sts_sum_mtx))
    %surf1 = INT_max_sig_itt_exp*ones(INT_max_sig_itt_exp,INT_max_sig_itt_exp);
    %mesh(surf1);
    hold off
    
    subplot(1,3,2)
    hold on
    surf(log2(DG1_sts_mlt_mtx))
    %surf1 = INT_max_sig_itt_exp*ones(INT_max_sig_itt_exp,INT_max_sig_itt_exp);
    %mesh(surf1);
    hold off
end


fclose(DG1_mat_msm_file);


if saveFlag
    save (DG1_inP_path);
end