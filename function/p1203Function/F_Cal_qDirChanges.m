% ---------------------------------------------------------------------
% 8.1.2.4 and 8.1.2.5
function [qDirChangesTot,qDirChangesLongest] = F_Cal_qDirChanges(O22)
    QC              = [];
    T               = length(O22);
    kernel_size     = 5;
    matrix_kernel   = ones(1,kernel_size) / kernel_size; % 0.2 
    padding_begin   = O22(1) * ones(1,kernel_size - 1);
    padding_end     = O22(T) * ones(1,kernel_size - 1);
    padded_O22      = [padding_begin  O22  padding_end];
    matrix_filtered = conv(padded_O22, matrix_kernel, 'valid');
    %matrix_filtered = padded_O22;
    step_size = 3;
    for p = 1:step_size:length(matrix_filtered)-step_size 
        current_score = matrix_filtered(p);
        q = p+step_size;
        next_score = matrix_filtered(q);
        thresh = 0.2;
        if (next_score - current_score) > thresh
            QC = [QC 1];
        elseif -thresh < (next_score - current_score) &&  (next_score - current_score) < thresh
            QC = [QC 0];
        else
            QC = [QC -1];
        end 
    end
    lens = [];
    for cnt = 1:length(QC)
        val = QC(cnt);
        if val ~= 0
            if isempty(lens)
                lens =  [cnt-1, val];
            elseif lens(end,2) ~= val
                lens = [lens ;[cnt-1, val]];
            end
        end
    end
    if ~isempty(lens)
        lens = [[0,0]; lens];
        lens = [lens ; [length(QC), 0]];
        distances = lens(2:length(lens),1) - lens(1:length(lens)-1,1);
        longestPeriod = max(distances) * step_size;
    else
        longestPeriod = length(QC) * step_size;
    end
    qDirChangesLongest = longestPeriod;
    QC_nonzero =  QC(find(QC~=0));
    if ~isempty(QC_nonzero)
        qDirChangesTot = 1;
    else
        qDirChangesTot = 0;
    end
    for cnt3 = 1:length(QC_nonzero)-1
        if QC_nonzero(cnt3) ~= QC_nonzero(cnt3+1)
            qDirChangesTot = qDirChangesTot +1;
        end
    end
end