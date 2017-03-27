%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = 2000;
k = 1;
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
Xte = data.Xte;
yte = data.yte;

%% Test different data sets
[w, S] = RLHH(Xtr, ytr);
w_truth_norm = norm(w_truth);
w_norm = norm(w);

y_pred = Xte'*w;

fprintf('[%d] - |w-w*|: %f\n', n_o, norm(w_truth-w));
