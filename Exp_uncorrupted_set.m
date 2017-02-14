k = 4;
p = 100;
bNoise = 1;

u = 1000*k;
dup_num = 10;

cr = 1.2;
if bNoise == 1
    noise_str = ''; 
else
    noise_str = 'nn_';
end
n_o = int16(cr*u);

TORRENT0_f1 = 0;
TORRENT25_f1 = 0;
TORRENT50_f1 = 0;
TORRENT80_f1 = 0;
RLHH_f1 = 0;

S_truth = [ones(u, 1) ; zeros(n_o, 1)];

fprintf('=== cr:%f ===\n', cr);
for idx = 1:1:dup_num

    data_file = strcat('D:/Dataset/RLHH/', num2str(k), 'K_', 'p', num2str(p), '_', noise_str, num2str(n_o), '_', num2str(idx), '.mat');
    data = load(data_file);
    Xtr = data.Xtr;
    ytr = data.ytr;
    w_truth = data.w;

    % TORRENT80
    [TORRENT80_w, TORRENT80_S] = Baseline_TORRENT( Xtr, ytr, 1.8*cr);
    S_TORR80 = zeros(u+n_o, 1);
    S_TORR80(TORRENT80_S) = 1;
    stat_TORR80 = confusionmatStats(S_truth, S_TORR80);
    TORRENT80_f1 = TORRENT80_f1 + stat_TORR80.Fscore(2);    
    
    % TORRENT50
    [TORRENT50_w, TORRENT50_S] = Baseline_TORRENT( Xtr, ytr, 1.5*cr);
    S_TORR50 = zeros(u+n_o, 1);
    S_TORR50(TORRENT50_S) = 1;
    stat_TORR50 = confusionmatStats(S_truth, S_TORR50);
    TORRENT50_f1 = TORRENT50_f1 + stat_TORR50.Fscore(2);
    
    
    % TORRENT25
    [TORRENT25_w, TORRENT25_S] = Baseline_TORRENT( Xtr, ytr, 1.25*cr);
    S_TORR25 = zeros(u+n_o, 1);
    S_TORR25(TORRENT25_S) = 1;
    stat_TORR25 = confusionmatStats(S_truth, S_TORR25);
    TORRENT25_f1 = TORRENT25_f1 + stat_TORR25.Fscore(2);
    
    
    % RLHH
    [RLHH_w, RLHH_S] = RLHH(Xtr, ytr);
    S_RLHH = zeros(u+n_o, 1);
    S_RLHH(RLHH_S) = 1;
    stat_RLHH = confusionmatStats(S_truth, S_RLHH);
    RLHH_f1 = RLHH_f1 + stat_RLHH.Fscore(2);
    
    
    % TORRENT0
    [TORRENT0_w, TORRENT0_S] = Baseline_TORRENT( Xtr, ytr, cr);
    S_TORR0 = zeros(u+n_o, 1);
    S_TORR0(TORRENT0_S) = 1;
    stat_TORR0 = confusionmatStats(S_truth, S_TORR0);
    TORRENT0_f1 = TORRENT0_f1 + stat_TORR0.Fscore(2);   

end

fprintf('TORR80: %.3f\n', TORRENT80_f1/dup_num);
fprintf('TORR50: %.3f\n', TORRENT50_f1/dup_num);
fprintf('TORR25: %.3f\n', TORRENT25_f1/dup_num);
fprintf('RLHH: %.3f\n', RLHH_f1/dup_num);
fprintf('TORR0: %.3f\n', TORRENT0_f1/dup_num);

result_path = 'D:/Dropbox/PHD/projects/RobustLR/src/RLHH/result/';
file_output = strcat(result_path, 'beta_', num2str(k), 'K_', 'p', num2str(p), '_', noise_str);
file_output = file_output(1:end-1);
save(file_output, 'OLS_result', 'DALM_result', 'HOMO_result', 'TORRENT0_result', 'TORRENT25_result', 'TORRENT50_result', 'RLHH_result');
