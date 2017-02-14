n_o = 1200;

%data_file = strcat('./data/RL_data_nn_', num2str(n_o), '.mat');
data_file = strcat('./data/RL_data_', num2str(n_o), '.mat');
data = load(data_file);
Xtr = data.Xtr;
ytr = data.ytr;
w_truth = data.w;
Xte = data.Xte;
yte = data.yte;

%% Test Comparison Methods
STOPPING_TIME = -2 ;
maxTime = 8;
w = SolveDALM_CBM(Xtr', ytr, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', w_truth, 'maxtime', maxTime, 'maxiteration', 1e6);
%w = SolveHomotopy(Xtr', ytr, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', w_truth, 'maxtime', maxTime, 'maxiteration', 1e6);
%w = SolveHomotopy_CBM(Xtr', ytr, 'stoppingCriterion', STOPPING_TIME, 'groundtruth', w_truth, 'maxtime', maxTime, 'maxiteration', 1e6);

y_pred = Xte'*w;

fprintf('[%d] - |w-w*|: %f\n', n_o, norm(w_truth-w));