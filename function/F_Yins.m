function [QoE] = F_Yins(MOS_seg,Inter,IniDelay)
    gamma  = 1;
    Var(1) = 0.00;
    muy    = 3000;
    muy_s  = 3000;
    if(length(MOS_seg)>1)
       for i = 2:length(MOS_seg)
           Var(i) = abs(MOS_seg(i) - MOS_seg(i-1));
       end
   end
    QoE = max(min(mean(MOS_seg) - gamma*mean(Var) -muy*sum(Inter) - muy_s * IniDelay,5),1) ;
end