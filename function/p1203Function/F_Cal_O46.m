% ---------------------------------------------------------------------
% 8.4 and 8.5
function [O46,O23] = F_Cal_O46(startTime,stallLen,O21,O22,O35)   
    T  = length(O22);
    s1 = 9.35158684;
    s2 = 0.91890815;
    s3 = 11.0567558; 
    [totalStallLen,numStalls] = F_Cal_totalStallLen(startTime,T,stallLen); % 8.1.1.1
    avgStallInterval = F_Cal_avgStallInterval(startTime); % 8.1.1.2
    stalling_impact = exp(- numStalls / s1) *...
        exp(- totalStallLen / T / s2) * ...
        exp(- avgStallInterval / T / s3); % Eq. 29
    O23 = 1 + 4 * stalling_impact ;%Eq. 31
    mos = 1.0 + (O35 - 1.0) * stalling_impact; % Eq. 28
    rf_score = F_Cal_rfPred(O21, O22, stallLen, startTime, T);
    O46 = 0.75 * max(min(mos, 5), 1) + 0.25 * rf_score; % Eq. 28
end