function idx = HT_ParamSearch(res, old_tau)
    [sort_r, sort_ri] = sort(res);    
    %plot(sort_r, 'o', 'MarkerSize',2, 'MarkerEdgeColor','blue');
    n = size(res, 1);
    param_score = zeros(n, 1);
    for k = 1:n
        m_k = sort_r(k);
        m_n = sort_r(n);
        
        param_score(k) = ((m_k+1)/(k)) / ((m_n-m_k)/(n-k));
        %param_score(k) = ((m_k)/(k)) / ((m_n-m_k)/(n-k));
        %param_score(k) = ((m_k+sort_r(n))/(k)) / ((m_n-m_k)/(n-k));
                
        % Option 2: use the angle between k1 and k2
        %param_score(k) = atan((m_k)/(k)) - atan((m_n-m_k)/(n-k));
                
        %fprintf('[%d]val=%f\n', k, m1_sum/m2_sum);
        %fprintf('[%d]val=%f, %f\n', k, mean(m1), mean(m2));
    end
    %plot(2:1300, test(2:1300));
    
    idx = -1;
    %plot(100:n-200, param_score(100:n-200));
    %plot(1:n, param_score);
    %plot(3000:5000, param_score(3000:5000));
    min_score = min(param_score);
    param_score = param_score/min_score;
    [sort_s, sort_si] = sort(param_score);
    
    for k = 1:n
        cur_tau = sort_si(k);
        tau_ratio = 0.5;
        
        %thres = cal_thres(tau, tau_ratio, thres_ratio, sort_r);
        
        constrained = constaint_2(cur_tau, tau_ratio, sort_r, old_tau);
        
        if constrained
            idx = cur_tau;
            break;
        end

    end
    
    if idx == -1
        fprintf('Error: no index found!!!\n');
    end

    
end

function constrained = constaint_0(tau, tau_ratio, sort_r, old_tau)
    n = size(sort_r, 1);
    r_n = sort_r(n);
    tau_s = floor(tau_ratio*tau);
    [tau_o, tau_o_res] = cal_mean_tau(tau_s, sort_r);
    res_k = sort_r(tau);
    %thres = (tau_mean_res+(tau-tau_mean)/(n-tau_mean)*(r_n-tau_mean_res));
    
    % method1: r_tau <= delta^1/2 * tau/tau' * r_tau', where delta is a
    % parameter to adjust the r_tau threshold
    %thres = sqrt(thres_ratio*tau*tau_mean_res/tau_mean);
    thres_ratio = 2;
    thres_1 = thres_ratio*tau*tau_o_res/tau_o;
    thres_2 = (r_n + tau_o_res)/2;

    thres = min(thres_1, thres_2);
    
    constrained = 0;
    if res_k <= thres
        constrained = 1;
    end
   
end

function constrained = constaint_1(tau, tau_ratio, sort_r)
    n = size(sort_r, 1);
    r_n = sort_r(n);
    tau_s = floor(tau_ratio*tau);
    [tau_o, tau_o_res] = cal_mean_tau(tau_s, sort_r);
    
    %thres = (tau_mean_res+(tau-tau_mean)/(n-tau_mean)*(r_n-tau_mean_res));
    
    % method1: r_tau <= delta^1/2 * tau/tau' * r_tau', where delta is a
    % parameter to adjust the r_tau threshold
    %thres = sqrt(thres_ratio*tau*tau_mean_res/tau_mean);
    
    up_thres = (n+2*tau_o)/2;
    down_thres = (n-2*tau_o)/2;
    %down_thres =0;
    
    constrained = 0;
    if tau <= up_thres
        constrained = 1;
    end
   
end

function constrained = constaint_2(tau, tau_ratio, sort_r, old_tau)
    n = size(sort_r, 1);
    tau_s = floor(tau_ratio*tau);
    [tau_o, tau_o_res] = cal_mean_tau(tau_s, sort_r);
    
    constrained = 0;
    %down_thres =0;
    tau_o_thres = 1/4;
    %tau_o_thres = 1/4;
    
    if tau <= (n+2*tau_o)/2 && tau_o <=tau_o_thres*n
    %if tau <= old_tau && tau_o <=tau_o_thres*n
        constrained = 1;
    end
   
end

% return the mean tau number for 
function [tau_mean, tau_res] = cal_mean_tau(thres_k, sort_r)
    tau_res = sqrt(norm(sort_r(1:thres_k))^2/thres_k);
    [a, tau_mean] = min(abs(sort_r-tau_res));
    %thres = sqrt(p* norm(sort_r(1:k))^2);
end

