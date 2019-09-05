%% Example
%[O46,O35,O34,O23] = ITUT_P1203_function([1 2 3 4 5],[5 4 3 2 1],[[0 5];[2 3]])
%I23 = [startTime stallLen]
%I23 include initial delay
function [O46,O35, O34,O23] = ITUT_P1203_function(O21,O22,I23)
    if ismac
		bracket = '/'; 
	else 
		bracket = '\'; 
	end
    addpath(genpath([pwd bracket 'Decision_trees']))
	addpath(genpath([pwd bracket 'ITUT_function']))
    startTime   = [];
    stallLen    = [];
    NoRebuff    = size(I23,1);
    if NoRebuff >0
        for cnt_ = 1 : NoRebuff
            startTime(cnt_) = I23(cnt_,1);
            stallLen(cnt_)  = I23(cnt_,2);
        end
    end
    [O21,O22] = F_preprocess(O21,O22);
    [qDirChangesTot,qDirChangesLongest] = F_Cal_qDirChanges(O22); % 8.1.2.4 and 8.1.2.5
    [O34_, O35_] = F_Cal_O34O35(O21,O22,qDirChangesTot,qDirChangesLongest); % 8.2 and 8.3
    [O46_,O23_] = F_Cal_O46(startTime,stallLen,O21,O22,O35_);
    
    O46 = double(O46_);
    O35 = double(O35_); 
    O34 = double(O34_);
    O23 = double(O23_);
end