% ---------------------------------------------------------------------
% 8.1.2.3
function vidQualChangeRate = F_Cal_vidQualChangeRate(O22)
    vidQualChangeRate = 0;
    T = length(O22);
    for i = 2:T
        diff = O22(i) - O22(i-1);
        if diff > 0.2 || diff < -0.2
            vidQualChangeRate = vidQualChangeRate + 1;
        end
    end
    vidQualChangeRate = vidQualChangeRate / T;
end
