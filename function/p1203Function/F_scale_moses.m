function mos_samples = F_scale_moses(sec_mos, num_splits)
    mos_samples = [];
    total_duration = length(sec_mos);
    split_duration = 1.0 * total_duration / num_splits;
    previous_mos = 0;
    previous_time = 0;
    for i = 1:total_duration
        if previous_time + 1 >= split_duration
            mos = ((previous_time * previous_mos) + (split_duration - previous_time) * sec_mos(i)) / split_duration;
            mos_samples = [mos_samples mos];
            previous_mos = sec_mos(i);
            previous_time = previous_time + 1 - split_duration;
        else
            previous_mos = ((previous_mos * previous_time) + sec_mos(i) * 1) / (previous_time + 1);
            previous_time = previous_time +1;
        end
    end
    while(length(mos_samples) < num_splits)
        mos_samples = [mos_samples previous_mos];
    end
end
    