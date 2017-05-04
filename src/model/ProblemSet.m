p = 200;
k = 4;
bNoise = 1;
idx = 1;
cr = 0.5;

n = 1000*k;
n_o = int16(cr*n);

if bNoise == 1
    noise_str = ''; 
else
    noise_str = 'nn_';
end
    
%data_file = strcat('./data/RL_data_nn_', num2str(n_o), '.mat');
%data_file = strcat('./data/', num2str(n_o), '.mat');
data_file = strcat('D:/Dataset/RLHH/', num2str(k), 'K_', 'p', num2str(p), '_', noise_str, num2str(n_o), '_', num2str(idx), '.mat');
data = load(data_file);
Xtr = data.Xtr;
ytr = data.ytr;
w_truth = data.w;

for cr = 0.1:0.1:1
    [ w, S ] = Baseline_TORRENT( Xtr, ytr, cr);
    ytr_S = ytr(S);
    Xtr_S = Xtr(:,S);
    s = size(S, 1);
    ss = s.^3;
    %obj_value = norm(ytr_S-Xtr_S'*w)/ss;
    obj_value = norm(ytr_S-Xtr_S'*w)-0.001*s;
    %disp(obj_value);
    fprintf('[%d] %g\n', s, obj_value);
    
end
