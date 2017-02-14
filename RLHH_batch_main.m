k = 1;
bNoise = 0;

for n_o = 100*k:100*k:1200*k

    if bNoise == 1
        noise_str = ''; 
    else
        noise_str = 'nn_';
    end

    data_file = strcat('./data/', num2str(k), 'K_', noise_str, num2str(n_o), '.mat');
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

    fprintf('[%d] - |w-w*|: %f outlier_idx:%d \n', n_o, norm(w_truth-w), size(S, 1));
end
