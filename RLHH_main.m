n_o = 500;

%data_file = strcat('./data/RL_data_nn_', num2str(n_o), '.mat');
data_file = strcat('./data/', num2str(n_o), '.mat');
data = load(data_file);
Xtr = data.Xtr;
ytr = data.ytr;
w_truth = data.w;
Xte = data.Xte;
yte = data.yte;

%% Test different data sets
[w, S] = RLHH(Xtr, ytr, 1);
w_truth_norm = norm(w_truth);
w_norm = norm(w);

y_pred = Xte'*w;

fprintf('[%d] - |w-w*|: %f\n', n_o, norm(w_truth-w));
