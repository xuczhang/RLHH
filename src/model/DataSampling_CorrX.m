function [] = DataSampling_CorrX( p, k, cr, bNoise, idx)

    %% Initialize the constant
    %p = 100; % feature dimension
    %k = 1;
    %cr = 0.1; % corruption ratio (from 0.1 to 1.2)
    %bNoise = 1;

    n = 1000*k; % authetic sample number in training data
    n_o = int16(cr*n); % corruption sample number(from 100 to 1200)
    nt = n; % test sample number


    %% Generate the training sample data
    % sample w by unit norm vector in p dimension
    w = rand(p, 1);
    w_norm = norm(w);
    w = w/w_norm;

    % sample x by normal distribution with mu=0 and cov=I_p
    X_mu = zeros(p, 1);
    X_cov = eye(p);
    Xtr_a = mvnrnd(X_mu, X_cov, n)'; %authetic data

    % sample noise eplison for outliers
    e_mu = zeros(n, 1);
    e_cov = eye(n) * 0.1;
    e_a = mvnrnd(e_mu, e_cov)';

    % generate the authentic samples by y_i = <w, x_i> + v_i
    if bNoise
        ytr_a = Xtr_a'*w + e_a;
    else
        ytr_a = Xtr_a'*w;
    end

    %% Generate Training Outlier Data
    % sample corruption vector b as b_i ~ U(-5|y*|_inf, 5|y*|_inf)
    b_range = 5*norm(ytr_a, inf);
    b = -b_range + 2*b_range*rand(n_o,1);

    % sample noise eplison for outliers
    e_mu = zeros(n_o, 1);
    e_cov = eye(n_o) * 0.01;
    e_o = mvnrnd(e_mu, e_cov)';

    % generate outlier y
    % 1) gen x_o from uniform distribution [-10, 10]
    Xtr_o = mvnrnd(X_mu, X_cov, n_o)';

    % 2) gen ytr_o = sign(<-beta, x_o>)
    %y_o = sigmf(X_o'*-w, [1 0]);
    if bNoise
        ytr_o = Xtr_o'*w + b + e_o;
    else
        ytr_o = Xtr_o'*w + b;
    end

    Xtr = [Xtr_a, Xtr_o];
    ytr = [ytr_a; ytr_o];

    %% Generate the testing sample data
    Xte = mvnrnd(X_mu, X_cov, nt)';
    yte = Xte'*w;

    %z = -ytr_all.*(Xtr_all'*w);
    %t = ytr_all - sigmf(Xtr_all'*w, [1 0]);

    %% Save the results into the output file
    str_noise = '';
    if ~bNoise
        str_noise = 'nn_';
    end
    data_file = strcat('D:/Dataset/RLHH/', num2str(k), 'K_', 'p', num2str(p), '_', str_noise, num2str(n_o), '_', num2str(idx), '.mat');
    save(data_file, 'Xtr', 'ytr', 'w', 'Xte', 'yte');
end

