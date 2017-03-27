p = 100;
bNoise = 1;
cr = 0.1;
dup_num = 10;


OLS_result = [];
DALM_result = [];
HOMO_result = [];
TORRENT0_result = [];
TORRENT25_result = [];
TORRENT50_result = [];
RLHH_result = [];

for k = 1:1:10

    if bNoise == 1
        noise_str = ''; 
    else
        noise_str = 'nn_';
    end
    n = 1000*k;
    n_o = int16(cr*n);
    
    OLS_time = 0;
    DALM_time = 0;
    HOMO_time = 0;
    TORRENT0_time = 0;
    TORRENT25_time = 0;
    TORRENT50_time = 0;
    RLHH_time = 0;
    
    for idx = 1:1:dup_num
            
        data_file = strcat('D:/Dataset/RLHH/', num2str(k), 'K_', 'p', num2str(p), '_', noise_str, num2str(n_o), '_', num2str(idx), '.mat');
        data = load(data_file);
        Xtr = data.Xtr;
        ytr = data.ytr;
        w_truth = data.w;
        Xte = data.Xte;
        yte = data.yte;

        %% Test different methods
        fprintf('=== [%d] / %d ===\n', k, idx);

        
        % Ordinary Least Square
        tic;
        OLS_w = regress(ytr, Xtr');
        elapsedTime = toc;
        OLS_time = OLS_time + elapsedTime;
        
        % DALM Method
        tic;
        STOPPING_TIME = -2 ;
        maxTime = 8;
        DALM_w = Baseline_DALM_CBM(Xtr', ytr, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', w_truth, 'maxtime', maxTime, 'maxiteration', 1e6);
        elapsedTime = toc;
        DALM_time = DALM_time + elapsedTime;

        % Homotopy Method
        tic;
        HOMO_w = Baseline_Homotopy_CBM(Xtr', ytr, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', w_truth, 'maxtime', maxTime, 'maxiteration', 1e6);
        elapsedTime = toc;
        HOMO_time = HOMO_time + elapsedTime;
        
        % TORRENT
        tic;
        TORRENT0_w = Baseline_TORRENT( Xtr, ytr, cr);
        elapsedTime = toc;
        TORRENT0_time = TORRENT0_time + elapsedTime;
        
        % TORRENT25
        tic;
        TORRENT25_w = Baseline_TORRENT( Xtr, ytr, cr);
        elapsedTime = toc;
        TORRENT25_time = TORRENT25_time + elapsedTime;
        
        % TORRENT50
        tic;
        TORRENT50_w = Baseline_TORRENT( Xtr, ytr, cr);
        elapsedTime = toc;
        TORRENT50_time = TORRENT50_time + elapsedTime;
        
        % RLHH
        tic;
        [RLHH_w, S] = RLHH(Xtr, ytr, 1);
        elapsedTime = toc;
        RLHH_time = RLHH_time + elapsedTime;
        
    
    end
    OLS_result = [OLS_result OLS_time/dup_num];
    DALM_result = [DALM_result DALM_time/dup_num];
    HOMO_result = [HOMO_result HOMO_time/dup_num];
    TORRENT0_result = [TORRENT0_result TORRENT0_time/dup_num];
    TORRENT25_result = [TORRENT25_result TORRENT25_time/dup_num];
    TORRENT50_result = [TORRENT50_result TORRENT50_time/dup_num];
    RLHH_result = [RLHH_result RLHH_time/dup_num];
    
    %fprintf('[%d] - |w-w*|: %f outlier_idx:%d \n', n_o, total_error/21, size(S, 1));
    %fprintf('[%d] - |w-w*|: %f outlier_idx:%d \n', n_o, norm(w_truth-TORRENT_w), size(S, 1));
end
result_path = 'D:/Dropbox/PHD/projects/RobustLR/src/RLHH/result/';
file_output = strcat(result_path, 'runtime_cr', num2str(cr*100), '_', 'p', num2str(p), '_', noise_str);
file_output = file_output(1:end-1);
save(file_output, 'OLS_result', 'DALM_result', 'HOMO_result', 'TORRENT0_result', 'TORRENT25_result', 'TORRENT50_result', 'RLHH_result');
