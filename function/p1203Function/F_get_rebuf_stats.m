function [rebuf_stats] = F_get_rebuf_stats(stallLen, startTime, T)
    if isempty(startTime) || (length(startTime) == 1 && startTime(1) == 0)
        rebuf_stats =  [0, 0, 0, 0, T];
    else
        events = [];
        for index = 1:length(startTime)
            b = startTime(index);
            if b ~= 0
                events = [events;[b, stallLen(index)]];
            end
        end
        num_rebuf = size(events,1);
        len_rebuf = sum(events(:,2));
        stallFeq = 1.0 * num_rebuf / T;
        len_rebuf_per_length = 1.0 * len_rebuf / T;
        time_of_last_rebuf = T - events(end,1);
        rebuf_stats = [num_rebuf, len_rebuf, stallFeq, len_rebuf_per_length, time_of_last_rebuf];
    end
end