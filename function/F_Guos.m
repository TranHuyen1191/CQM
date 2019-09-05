function [QoE] = F_Guos(MOS_seg)
    alpha= 0.68; 
    beta= 0.33;
    QoE = max(min(alpha*median(MOS_seg) + beta*min(MOS_seg),5),1);
end