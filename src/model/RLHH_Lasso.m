function [ w, S ] = RLHH_Lasso( X, y)
%RLH Summary of this function goes here
%   Detailed explanation goes here
lambda = 0.5;
p = size(X, 1);
n = size(X, 2);
w = zeros(p, 1);
S = 1:n;
S = S';
%k = n-n_o;
res = zeros(n,1);
tau = n;
MAX_ITER = 100;
MIN_THRES = 1e-3;
for iter=1:MAX_ITER
    res_old = res;
    tau_old = tau;
    
    w = lasso(X(:,S)', y(S), 'Lambda', 0.01);
    %[w, FitInfo] = lasso(X(:,S)', y(S));
    res = update_res(X, y, w);    

    %tau = HT_ParamSearch_2(res, tau_old);
    tau = HTSearch_2(res, tau_old);
    
    %outlier_k = HT_ParamSearch(res);
    %outlier_k = 1000;
    %fprintf('outlier_idx=%d\n', outlier_k);
    S = HT(res, tau);

    if(iter == MAX_ITER)
        fprintf('Max Iteration Reached!!!');
    end
    
    %%fprintf('res=%f\n', norm(res(S)-res_old(S)));
    s = size(S, 1);
    fprintf('res=%f tau=%d res_diff=%f\n', norm(res(S))/s, tau, norm(res(S)-res_old(S))/s);
    if norm(res(S)-res_old(S))/s <= MIN_THRES
    %if norm(res(S))/n <= MIN_THRES
        %fprintf('Finished!!!');
        break;
    end
end
 
end

function res = update_res(X, y, w)    
    n = size(y, 1);
    res = zeros(n, 1);
    for i = 1:n
        X_i = X(:,i);
        y_i = y(i);
        res(i) = abs(y_i - X_i'*w);
    end
end

function w = update_w(X, y, S)    
    y_S = y(S);
    X_S = X(:,S);
    w = inv(X_S*X_S')*X_S*y_S;
end


function S = HT(res, k)
    [m mi] = sort(res);    
    S = mi(1:k);
end

