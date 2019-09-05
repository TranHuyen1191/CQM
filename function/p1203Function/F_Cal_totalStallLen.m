% ---------------------------------------------------------------------
% 8.1.1.1
% T: media length
% startTime: Stalling event start time
function [totalStallLen,numStalls] = F_Cal_totalStallLen(startTime,T,stallLen)
    totalStallLen   = 0;
    c_ref7          = 0.48412879;
    c_ref8          = 10;
    numStalls = length(stallLen);
    if(numStalls >0)
        for i = 1:numStalls
            stallPositionFromEnd(i) = T-startTime(i);
            w_stall(i) = F_exponential(1, c_ref7, 0, c_ref8,stallPositionFromEnd(i)); 
        end
        totalStallLen = sum(w_stall.*stallLen);
    else
        totalStallLen = 0;
    end
end