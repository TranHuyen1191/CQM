function [QoE] = F_Vriendts(MOS_seg)
    alpha= 1.00; 
    beta= 0.32;
    gamma= 0.00;
    No_sw = 0.00;
    if(length(MOS_seg)>1)
       for i=2: length(MOS_seg)
           if MOS_seg(i) ~= MOS_seg(i-1)
            No_sw = No_sw+1;
           end
       end
   end
    QoE = alpha*mean(MOS_seg) - beta*std(MOS_seg,1) - gamma*No_sw;
end