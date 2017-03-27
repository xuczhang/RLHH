function [ w, S ] = RLHH( X, y)
%RLH Summary of this function goes here
%   Detailed explanation goes here
p = size(X, 1);
n = size(X, 2);
w = zeros(p, 1);
S = 1:n;
S = S';
%k = n-n_o;
res = zeros(n,1);
MAX_ITER = 100;
MIN_THRES = 1e-5;
for iter=1:MAX_ITER
    res_old = res;
    w = update_w(X, y, S);
    res = update_res(X, y, w);    

    outlier_k = HT_ParamSearch_constraint(res);
    %outlier_k = HT_ParamSearch(res);
    %outlier_k = 1000;
    %fprintf('outlier_idx=%d\n', outlier_k);
    S = HT(res, outlier_k);

    if(iter == MAX_ITER)
        fprintf('Max Iteration Reached!!!');
    end
    
    %%fprintf('res=%f\n', norm(res(S)-res_old(S)));
    
    %fprintf('res=%f\n', norm(res(S))/n);
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

% return the mean tau number for 
function [tau_mean, tau_res] = cal_mean_tau(thres_k, sort_r)
    tau_res = sqrt(norm(sort_r(1:thres_k))^2/thres_k);
    [a, tau_mean] = min(abs(sort_r-tau_res));
    %thres = sqrt(p* norm(sort_r(1:k))^2);
end

function thres = cal_thres(tau, tau_ratio, thres_ratio, sort_r)
    n = size(sort_r, 1);
    r_n = sort_r(n);
    tau_s = floor(tau_ratio*tau);
    [tau_mean, tau_mean_res] = cal_mean_tau(tau_s, sort_r);
    
    %thres = (tau_mean_res+(tau-tau_mean)/(n-tau_mean)*(r_n-tau_mean_res));
    
    % method1: r_tau <= delta^1/2 * tau/tau' * r_tau', where delta is a
    % parameter to adjust the r_tau threshold
    %thres = sqrt(thres_ratio*tau*tau_mean_res/tau_mean);
    thres_1 = thres_ratio*tau*tau_mean_res/tau_mean;
    thres_2 = (r_n + tau_mean_res)/2;
    thres = min(thres_1, thres_2);
   
end

% constraint
function idx = HT_ParamSearch_constraint(res)
    [sort_r, sort_ri] = sort(res);    
    %plot(sort_r, 'o', 'MarkerSize',2, 'MarkerEdgeColor','blue');
    n = size(res, 1);
    param_score = zeros(n, 1);
    for k = 1:n
        m_k = sort_r(k);
        m_n = sort_r(n);
        
        param_score(k) = ((m_k+1)/(k)) / ((m_n-m_k)/(n-k));
        %param_score(k) = ((m_k)/(k) + 1/5) / ((m_n-m_k)/(n-k) + 1); %best practise
        %param_score(k) = ((m_k)/(k)) / ((m_n-m_k)/(n-k));
        
        % Option 2: use the angle between k1 and k2
        %param_score(k) = atan((m_k)/(k)) - atan((m_n-m_k)/(n-k));
                
        %fprintf('[%d]val=%f\n', k, m1_sum/m2_sum);
        %fprintf('[%d]val=%f, %f\n', k, mean(m1), mean(m2));
    end
    %plot(2:1300, test(2:1300));
    
    idx = -1;
    plot(500:n-300, param_score(500:n-300));
    %plot(1:n, param_score);
    [sort_s, sort_si] = sort(param_score);
    for k = 1:n
        tau = sort_si(k);
        res_k = sort_r(tau);
  
        tau_ratio = 0.5;
        thres_ratio = 2;
        thres = cal_thres(tau, tau_ratio, thres_ratio, sort_r);
        if tau == 1000
            a =1;
        end
        
        if res_k <= thres
            idx = tau;
            break;
        end
    end
    
    if idx == -1
        fprintf('Error: no index found!!!\n');
    end

    
end

function idx = HT_ParamSearch(res)
    [m mi] = sort(res);    
    %plot(1:1500, m, 'o', 'MarkerSize',2, 'MarkerEdgeColor','blue');
    n = size(res, 1);
    param_score = zeros(n, 1);
    for k = 1:n
        m_k = m(k);
        m_1 = m(1);
        m_n = m(n);
        
        param_score(k) = ((m_k+1)/(k)) / ((m_n-m_k)/(n-k));
        %param_score(k) = ((m_k)/(k) + 1/5) / ((m_n-m_k)/(n-k) + 1);
        %param_score(k) = ((m_k)/(k)) / ((m_n-m_k)/(n-k));
        
        % Option 2: use the angle between k1 and k2
        %param_score(k) = atan((m_k)/(k)) - atan((m_n-m_k)/(n-k));
                
        %fprintf('[%d]val=%f\n', k, m1_sum/m2_sum);
        %fprintf('[%d]val=%f, %f\n', k, mean(m1), mean(m2));
    end
    %plot(2:1300, test(2:1300));
    
    
    bBound = 0;
    if bBound == 0
        % No bound
        plot(1:n, param_score);
        [a, b] = min(param_score);
        [sort_r sort_ri] = sort(res);
        idx = b;
    else
        % Bound g   
        g = 200;
        plot(g:n-g, param_score(g:n-g));
        [a, b] = min(param_score(g+1:n-g));
        idx = b + g;    
    end
    
end

function S = HT(res, k)
    [m mi] = sort(res);    
    S = mi(1:k);
end