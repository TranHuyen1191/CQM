% ---------------------------------------------------------------------
% 3.2.2
function [O21,O22] = F_preprocess(O21,O22)
    O21_len = length(O21);
    O22_len = length(O22);
    if iscolumn(O21)
        O21 = O21';
    end
    if iscolumn(O22)
        O22 = O22';
    end
    if O22_len == 0 % if O22 is empty
        error('No video quality scores!!!');
    end

    if O21_len == 0 % if O21 is empty
        T = O22_len;
        warning('No audio quality scores. Assuming that constant high quality audio.');
        O21 = 5*ones(1,T);
    else
        % O21_len != O22_len
        T = min(O21_len,O22_len);
        O21 = O21(1:T);
        O22 = O22(1:T);
    end
end
