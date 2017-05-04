function tau = HTSearch(res, old_tau)
    [sort_r, sort_ri] = sort(res);    
    %plot(sort_r, 'o', 'MarkerSize',2, 'MarkerEdgeColor','blue');
    n = size(res, 1);
    
    thres_arr = [];
    for tau = old_tau:-1:1
    %for tau = n:-1:1
        tau_ratio = 0.5;
        [constrained, thres_val] = constaint(tau, tau_ratio, sort_r);
        
        if constrained
            break;
        end
        thres_arr = [thres_arr thres_val];
    end
    
    %plot(thres_arr, 'o', 'MarkerSize',1, 'MarkerEdgeColor','blue');
    
    if tau == 1
        tau = old_tau;
        fprintf('Error: no index found!!!\n');
    end

    
end

function [constrained, thres_val] = constaint(tau, tau_ratio, sort_r)
    n = size(sort_r, 1);
    r_n = sort_r(n);
    %tau_ratio = 
    magic_point = floor(tau_ratio*tau);
    %magic_point = floor(tau - n/2);
    [tau_o, tau_o_res] = cal_mean_tau(magic_point, sort_r);
    res_k = sort_r(tau);
    
    thres_val = res_k*tau_o/(tau*tau_o_res);
    %thres = (tau_mean_res+(tau-tau_mean)/(n-tau_mean)*(r_n-tau_mean_res));
    
    % method1: r_tau <= delta^1/2 * tau/tau' * r_tau', where delta is a
    % parameter to adjust the r_tau threshold
    %thres = sqrt(thres_ratio*tau*tau_mean_res/tau_mean);
    thres = 2*tau*tau_o_res/tau_o;
    %thres_2 = (r_n + tau_o_res)/2;
    
    constrained = 0;
    if res_k <= thres
        constrained = 1;
    end
   
end

% return the mean tau number for 
function [tau_mean, tau_res] = cal_mean_tau(thres_k, sort_r)
    tau_res = sqrt(norm(sort_r(1:thres_k))^2/thres_k);
    [a, tau_mean] = min(abs(sort_r-tau_res));
    %thres = sqrt(p* norm(sort_r(1:k))^2);
end
