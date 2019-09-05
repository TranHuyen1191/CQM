function rf_score = F_Cal_rfPred(O21, O22, stallLen, startTime, T)
    if length(stallLen) && length(startTime) 
        if startTime(1) == 0 
            initDelayDur = stallLen(1);
        else
            initDelayDur = 0;
        end
    else
        initDelayDur = 0;
    end
    rebuf_stats = F_get_rebuf_stats(stallLen, startTime, T); %without initial delay
    %rebuf_stats = stallCountWithoutInitial, len_rebuf, stallFeq,len_rebuf_per_length, time_of_last_rebuf
    rebuf_stats(2) = 1.0 * initDelayDur / 3.0 + rebuf_stats(2); % stallDur
    rebuf_stats(4) = 1.0 * initDelayDur / T / 3.0 + rebuf_stats(4); %stallRatio

    O21_rounded = round(O21, 3);
    O22_rounded = round(O22, 3);
    sec_moses_feature_video = F_scale_moses(O22_rounded, 3);
    sec_moses_feature_audio = F_scale_moses(O21_rounded, 2);
    sec_mos_stat = prctile(O22_rounded, [1, 5, 10]); %PercentilePvScore

    features = [rebuf_stats, sec_moses_feature_video, sec_mos_stat, sec_moses_feature_audio,T];
    rf_score = F_execute_trees(features);
 end