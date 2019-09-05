function [F_SQ, F_SV, F_It] = F_extract_histogram(SQ,Dur_inter)
    %% Parameters of histogram (boundaries)
    SQ_Bo_Amp       = [  0.50   1.50   2.50   3.50   4.50   5.50 ]; % 5 bins
    SQ_Bo_Gra       = [ -4.50  -3.50  -2.50  -1.50  -0.50   4.50 ]; % 5 bins
    Bo_Inter        = [  0.00   0.25   0.50   1.00   2.00   3.00  1000]; % 6 bins

    %% Calculate segment quality gradients
    No_seg   = length(SQ);   %Number of segment
    No_sw    = length(SQ)-1; %Number of switches
    No_inter = length(find(Dur_inter>0)); % Number of interruptions
    Gra_seg  = [];
    if(No_seg > 1)
        Start_SQ = SQ(1:length(SQ)-1);
        for i=2 : No_seg
            Gra_seg(i-1) = SQ(i) - SQ(i-1);
        end
    end
    %% Calculate histogram
    if No_seg > 0
        [SQ_Bincount,~]  = histc(SQ,SQ_Bo_Amp);
        F_SQ             = SQ_Bincount(1:5)/No_seg;
    else
        F_SQ = zeros(1,5);
    end
    if No_sw > 0
        SV_Bincount = histcounts2(Gra_seg,Start_SQ,SQ_Bo_Gra,SQ_Bo_Amp);
        F_SV        = SV_Bincount/(No_sw+No_inter);
    else
        F_SV         = zeros(5,5);
    end
    It_Bincount = zeros(1,length(Bo_Inter)-1);
    F_It        = zeros(1,length(Bo_Inter)-1);
    if No_inter >= 1
        for i = 1:length(Dur_inter)
            for b = 1:length(Bo_Inter)-1
                if Dur_inter(i) > Bo_Inter(b) && Dur_inter(i)<= Bo_Inter(b+1)
                    It_Bincount(b) = It_Bincount(b) +1;
                end
            end
        end
        F_It = It_Bincount/(No_sw+No_inter);
    end
end
