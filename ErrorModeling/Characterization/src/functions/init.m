%intitalization
%{
% Set parameters for simulation,
%
% Sigma range 2^1-to-2^x
% Number of samples
% Path to save files
% Hardware specification (#bits)
% Other
%
% 1 SEC
%}

INT_sample_cnt          = 100000;  % min 5-7K samples for better sigma evaluation in matlab - zire in std(X) khatash ok nis

INT_max_sig_itt_exp     = 15       % itterate sigma up to %15 %-- inja random mikonim dada --% az -2^15 ta +2^15 mirim chon 2 ta ezaf mikone mishe 15x17,!!
INT_bgn_sig_itt_exp     = 5;       % az che sigmayi shoru kone be shomordan
INT_DG1_sig_step_in1    = 1;       % sigma step for in1 generation
INT_DG1_sig_step_in2    = 1;       % # for loop in2
INT_DG1_miu_step        = 1;       % #for loop in1 and in2

INT_sig_same_in1_in2    = 1;       % AGE BEKHAYM 'B' sigmahayi ke 'A' dararo begire be khodesh
INT_miu_in_zero         = 0;       % miu sefr bashe vase a o b - 1 bashe roshan e 0 bashe khamush

INT_DC1_num_GMM         = 5;       % #components - ba 6 ta run kardim dagfe pish
INT_fit_maxIter         = 500;     % tu har fit chand bar itteration kone khode fitgmdist()
INT_DC1_HD_th           = 0.12;    % in mige ke kamtarin HD ke ma ghabul mikonim age balatar bood be andaze maxtry loop mizanim
INT_DC1_HD_maxtry       = 25;      % in mige kolan chandta loop mojaz bude ke tekrar konim HD behtar biabim! avali momkene b andaze payini tul bekeshe! - ghablan ba 30 test kardim, ama avg 4 bud! pas 5 bar mikonimesh
INT_DC1_cnvrged_maxtry  = 500;     % in mige cheghad loop bezane ta converged bebine. ta abad k nemishe vase!
INT_DC1_HD_uppertry     = 1;       % enghad zoor bezan ta fit koni. in bara jahayie ke taghriban fit e behtar peyda nemishe o vakht talaf kardane bishtar
INT_DC1_HD_std_log_th   = 9;       % yani sigma az 9 be bad shod, be andazeye upperTy taralsh kon peyfa koni ( mamulan hamun 1 bare avali yani)
INT_DC1_find_best_GMM   = 1;       % in roshan bashe az num_GMM ta max_GMM yeki yeki ziad mikone ta zamani ke HD_th meet she
INT_DC1_max_GMM         = 12;      % age bekhaym tu har while loop e aval, be ezaye har loop yedune bezarim ru number componentatmun.
INT_DC1_sclng_fac       = 10;      % bin ha chandta chanda bere bala. age 10 bashe => 1,10,20,30,...
INT_DC1_smpl_covrg_wrst = 0.8;     % che ghesmat az DATA hayi ke tolid mikonim (100K) range ro pushesh mide ? az 0.8 ta 0.98 coverage darim
INT_DC1_smpl_per_bin    = 30;      % tu har bin chand ta dade bashe. migim hudud 30 ta hade aghal bashe tu har bin

%paths
INT_inP_path            = '/data/tmp/out_MAT/initP.mat';
INT_DIR_path            = '/data/tmp/out_MAT';  % unjayi ke darim save mikonim khorujiaro
INT_DG1_path_mat_msm    = '/in_data.txt';       % file name of 1 level propagation
INT_DG2_path_mat_msm    = '/in_data_reg.txt';   % file name for more than 1 level propagation
INT_DC1_path_msm_mat    = '/out_ETAIIM32_Matlab.txt';
INT_DC2_path_msm_mat    = '/out_ETAIIM32_Matlab_reg.txt';
INT_SRC_path            = '/data/git/repos/ErrorModeling/Characterization/Files/src';

addpath(genpath(INT_SRC_path));


%% **G1** BENCHMARK monitored:
%XXX_read =>
%**DG1_DATA_in1_read_vec
%**DG1_DATA_in2_read_vec
%**DG2_DATA_in2_read_vec = be ina bayad array dade berizi age mikhay az ru


INT_DG1_in1_type_read   = 0;       % read from monitored nodes in a benchmark
INT_DG1_in2_type_read   = 0;       % read from monitored nodes in a benchmark
INT_DG2_in2_type_read   = 0;       % age gharar bud az dade hayi ke yeja monitor kardim bekhunim


%% **G2** GENERATE RANDOM NUMBERS

INT_DG2_num_bit_trnc    = 8;       % age bekhaym 8 bit truncate she+
% one of these parameters should be 1! if both are 1 => 2nd has priority
INT_DG2_in2_type_trnc   = 0;       % if we want to have B = trunc[rand(std(A))]
INT_DG2_in2_type_rand   = 1;       % olaviat dare be balayi chon after balayie
INT_DG1_in1_type_rand   = 1;       % generate
INT_DG1_in2_type_rand   = 1;       % generate

%%

INT_HWS_bits            = 32;      % bara 32 biti
INT_reg_max_sig = INT_max_sig_itt_exp;   %regression maximum sigma to look up   %-1; % 14*14 ro nega kone vase regression


%%
%extras
INT_input_err           = 1;       % sigma of input error injected
INT_DG1_sig_bias        = 0;       % agar mikhastim hame sigmaharo simulate nakonim, ino mizarim ke masaln 3 ta kamtar o bishtar az chizi ke set kardim vase avali ro simulate konim

saveFlag =1;                       %loadFlag =1; ham ke chon khunde nashe nemibinim, fayde nadare!
save (INT_inP_path);               % nemishe esmesho avaz kard chon mikhaym be hame begim az inja bekhunan beran jolo
