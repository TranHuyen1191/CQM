% ---------------------------------------------------------------------
% 8.1.2.1
function [negativeBias] = F_Cal_negativeBias(O34,O35_baseline)     
    c1 = 1.87403625;
    c2 = 7.85416481;
    c23 = 0.01853820;
    O34_diff = O34;
    T = length(O34);
    for t= 1:T
        w_diff = F_exponential(1, c1, 0, c2, T-t); % Eq. 5
        O34_diff(t) = (O34(t) - O35_baseline) * w_diff; % Eq. 4
    end
    %%%%% WRONG %%%%%
    neg_perc = prctile(O34_diff, 10); % Eq. 6
    negativeBias = max(0, -neg_perc) * c23; % Eq. 7
end
