% ---------------------------------------------------------------------
% 8.2 and 8.3
function [O34, O35] = F_Cal_O34O35(O21,O22,qDirChangesTot,qDirChangesLongest)
    digitsOld = digits(10000); %Increase Precision of Numeric Calculations
    O35_denominator = 0;
    O35_numerator = 0;
    av1 = -0.00069084;
    av2 = 0.15374283;
    av3 = 0.97153861;
    av4 = 0.02461776;
    t1 = 0.00666620027943848;
    t2 = 0.0000404018840273729;
    t3 = 0.156497800436237;
    t4 = 0.143179744942738;
    t5 = 0.0238641564518876;
    T = length(O22);
    O34 = vpa(zeros(1,T));
    vid_qual_spread = max(O22) - min(O22); % 8.1.2.2
    vid_qual_change_rate = F_Cal_vidQualChangeRate(O22); % 8.1.2.3
    for t = 1:T
        O34(t) = vpa(max(min(av1 + av2 * O21(t) + av3 * O22(t) + av4 * O21(t) * O22(t),5),1)); %Eq.17
        temp = O34(t);
        w1 = vpa(t1 + t2 * exp(((t-1) / T) / t3));   %Eq. 20
        w2 = t4 - t5 * temp;                %Eq. 21
        O35_numerator = O35_numerator+ w1 * w2 * temp;
        O35_denominator = O35_denominator + w1 * w2;
    end
    O35_baseline = O35_numerator / O35_denominator;
    negative_bias = F_Cal_negativeBias(O34,O35_baseline);
    
    comp1 = 0.67756080;
    comp2 = -8.05533303;
    osc_test = ((qDirChangesLongest / T) < 0.25) && (qDirChangesLongest < 30); %Eq. 24
    if osc_test
        q_diff = max(0.0, 1 + log10(vid_qual_spread + 0.001)); %Eq. 27
        osc_comp = max(0.0, min(q_diff * exp(comp1 * qDirChangesTot + comp2), 1.5)); % Eq. 23
    else
        osc_comp = 0;% Eq. 23
    end
    
    comp3 = 0.17332553;
    comp4 = -0.01035647;
    adapt_test = (qDirChangesLongest / T) < 0.25; % Eq. 26
    if adapt_test
        adapt_comp = max(0.0, min(comp3 * vid_qual_spread * vid_qual_change_rate + comp4, 0.5)); %Eq. 26
    else
        adapt_comp = 0;
    end
    O35 = O35_baseline - negative_bias - osc_comp - adapt_comp; % Eq. 18
end