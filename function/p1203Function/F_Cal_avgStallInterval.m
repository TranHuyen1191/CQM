% ---------------------------------------------------------------------
% 8.1.1.2
function avgStallInterval = F_Cal_avgStallInterval(startTime)
    avgStallInterval = 0;
    numStalls = length(startTime);
    if numStalls > 1
        avgStallInterval = sum(startTime(2:numStalls)-startTime(1:numStalls-1))/(numStalls-1);
    end
end
