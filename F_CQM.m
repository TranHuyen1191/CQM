function CQM = F_CQM(iniD,SQArr,SPArr,SDArr,wqModel,sizeWArr,weight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% String pvsId     : Index of session                                                                                         %%%%
%%%% Int    iniD      : Initial duration                                                                                         %%%%
%%%% Array  SQArr     : Array of segment quality values                                                                          %%%%
%%%% Array  SPArr     : Array of stalling positions                                                                              %%%%
%%%% Array  SDArr     : Array of stalling durations                                                                              %%%%
%%%% Array  sizeWArr  : Array of Window sizes corresponding to the last, average, maximum, and minimun window quality values     %%%%
%%%% Int    wqModel   : Window quality model 1: Tran's; 2: Guo's; 3: Vriendt's; 4: Yin's 5: p1203                                %%%%
%%%% Array  weight    : Weights of the last, average, maximum, and minimun window quality values                                          %%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Array  CQM       : Array of cumulative quality values                                                                       %%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% Example %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% CQM= F_CQM(5,[5*ones(1,60),2*ones(1,20),3*ones(1,40)],[10,20],[5,10])                                                       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismac; slash = '/'; else slash = '\'; end;
addpath(genpath([pwd slash 'CQMFunction']))
addpath(genpath([pwd slash 'p1203Function']))
if nargin <= 4 
    wqModel     = 1; 
    sizeWArr    = [50, 60, 50, 50]; 
    weight      = [0.31 	0.37 	0.01 	0.31 ];  
elseif nargin == 5
    sizeWArr    = [50, 60, 50, 50];
    weight      = [0.31 	0.37 	0.01 	0.31 ];  
end
WQArr     = [];
noSeg     = size(SQArr,2); % Number of segments
noPar     = 4; % Number of window quality statistics
idxW      = 0; % Window index
LB        = 0; % Lower boundary of the instant window
UB        = 0; % Upper boundary of the instant window
MaxWSize = max(sizeWArr);
for idxSeg = 1:noSeg % Segment index
    for cntPar = 1:noPar
        instW_iniD    = 0; % Initial delay of the instant window
        instW_noRB    = 0; % Number of rebufferings in the instant window
        instW_spArr   = []; % Stalling positions; unit: segments
        instW_sdArr   = []; % Stalling durations; unit: seconds
        instW_I23     = []; % Input of P1203
        sizeW = sizeWArr(cntPar);
        %if idxSeg < sizeW 
        if idxSeg < MaxWSize 
            LB   = 1;      % Lower boundary of the instant window
            UB   = idxSeg; % Upper boundary of the instant window
            idxW = 0;
        else
            LB   = idxSeg - sizeW + 1;
            UB   = idxSeg;
            idxW = idxSeg - sizeW + 1;
        end    
        instW_SVQArr   = SQArr(LB:UB); % Segment video quality values in the instant window
        if wqModel == 5
            instW_SAQArr   = 5*ones(1,size(instW_SVQArr,2)); % Segment audio quality values in the instant window
        end
        if idxW <= 1 && iniD > 0 % not enough a window or the first window 
            instW_iniD = iniD; 
            instW_I23 = [0 iniD];
        end
        for idxRB = 1 : size(SPArr,2) % Determine stallings occuring in the instant window
            if ((SPArr(idxRB) > LB) && (SPArr(idxRB) <= UB))
                instW_noRB              = instW_noRB + 1;
                instW_spArr(instW_noRB) = SPArr(idxRB)-LB+1;
                instW_sdArr(instW_noRB) = SDArr(idxRB);
                instW_I23               = [instW_I23; instW_spArr(instW_noRB) instW_sdArr(instW_noRB)];
            end
        end
        switch wqModel %% Calculate instant window quality value
            case 1 % 1: Tran's  
                [instWQ] = F_Tran(instW_SVQArr,instW_sdArr,instW_iniD);
            case 2 % 2: Guo's 
                [instWQ] = F_Guos(instW_SVQArr);
            case 3 % 3: Vriendt's
                [instWQ] = F_Vriendts(instW_SVQArr);
            case 4 % 4: Yin's
                [instWQ] = F_Yins(instW_SVQArr,instW_sdArr,instW_iniD);
            case 5 % 5: p1203
                [instWQ,O35, O34,O23] = F_P1203(instW_SAQArr,instW_SVQArr,instW_I23);    
        end
        %% Calculate statistics of the window quality values
        if idxW <=1 % not enough a window
            switch cntPar 
                case 1 
                    instW_las   = instWQ;
                case 2 
                    instW_ave   = instWQ;
                case 3 
                    instW_max   = instWQ;
                case 4 
                    instW_min   = instWQ;
            end
        else
            switch cntPar 
                case 1 
                    instW_las   = instWQ;
                case 2 
                    instW_ave   = (instW_ave * (idxSeg - sizeW) + instWQ)/(idxSeg - sizeW + 1);
                case 3 
                    instW_max   = max(instW_max,instWQ);
                case 4 
                    instW_min   = min(instW_min,instWQ);
            end
        end
    end
    CQM(idxSeg) = max(min(weight(1)*instW_las+weight(2)*instW_ave+weight(3)*instW_max+weight(4)*instW_min,5),1);
    %%%% Debug
    instWQARR(idxSeg)=instWQ;
    if idxSeg ==  noSeg
        instWQARR_except50S=instWQARR(50:idxSeg);  
    end
end
