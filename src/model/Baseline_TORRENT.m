function [ w, S ] = Baseline_TORRENT( X, y, cr)
%RLH Summary of this function goes here
%   Detailed explanation goes here
p = size(X, 1);
n = size(X, 2);
w = zeros(p, 1);
S = 1:n;
S = S';
n_o = int16(n/(1+cr) * cr);
k = n-n_o;
res = zeros(n,1);
MAX_ITER = 100;
MIN_THRES = 1e-5;
for iter=1:MAX_ITER
    res_old = res;
    w = update_w(X, y, S);
    res = update_res(X, y, w);    
    S = HT(res, k);
    if(iter == MAX_ITER)
        %fprintf('Max Iteration Reached!!!');
    end
    
    %%fprintf('res=%f\n', norm(res(S)-res_old(S)));
    if norm(res(S)-res_old(S))/n <= MIN_THRES
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