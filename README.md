# CQM: Cumulative quality model for HTTP Adaptive Streaming
* This source code is an implementation in the MATLAB language of our cumulative quality model (CQM).
* Note that this source code includes ITU-P1203 model which is used as a window quality model (https://github.com/itu-p1203/itu-p1203/)

## How to use 
### F_CQM.m      : Function to calculate predicted cumulative quality values from CQM model
#### Input 
- iniD      : Initial duration (seconds)
- SQArr     : One-dimensional array of segment quality values in the range [1,5] (MOS)
- SPArr     : One-dimensional array of stalling positions (seconds)
- SDArr     : One-dimensional array of stalling durations (seconds)
- wqModel   : Window quality model 1: Tran's; 2: Guo's; 3: Vriendt's; 4: Yin's 5: p1203 (default: 1)
- sizeW     : Window size (seconds) (default: 50)
- weight    : Weights of the last, minimun, and average window quality values (default: [0.31 0.29 0.40]) 

#### Output
- CQM: Array of predicted cumulative quality values  

#### Example
A 120-second long session has 120 segments. 
The quality of the 1st-60th segments is 5 MOS.
The quality of the 61st-80th segments is 2 MOS.
The quality of the 81st-120th segments is 4 MOS.
There are three stalling events as follows. 
1. Initial delay:    
	Starting time: 0s 		      Length: 2s
2. Interruption:    
	Starting time: 40s 		      Length: 2s
	
	Starting time: 60s 		      Length: 4s

To obtain the output, you can use the following command. 
  ```
  CQM= F_CQM(2,[5*ones(1,60),2*ones(1,20),4*ones(1,40)],[40,60],[2,4])
  ```

## Authors

* **Tran Huyen** - *The University of Aizu, Japan* - tranhuyen1191@gmail.com
* If you have any questions or comments, please feel free to contact me.  

## Acknowledgments

If you use this source code in your research, please cite the below references:
1. The link to this repository
2. The link https://github.com/itu-p1203/itu-p1203/
3. The following publications:

   [1] Huyen T. T. Tran, Nam Pham Ngoc, Tobias Hoßfeld, Michael Seufert, and Truong Cong Thang. Cumulative Quality Modeling for HTTP Adaptive Streaming. Submitted to IEEE Transactions on Broadcasting, 2019.
   
   [2] Raake, A., Garcia, M.-N., Robitza, W., List, P., Göring, S., Feiten, B. (2017). A bitstream-based, scalable video-quality model for HTTP adaptive streaming: ITU-T P.1203.1. In 2017 Ninth International Conference on Quality of Multimedia Experience (QoMEX). Erfurt.
   
   [3] Robitza, W., Göring, S., Raake, A., Lindegren, D., Heikkilä, G., Gustafsson, J., List, P., Feiten, B., Wüstenhagen, U., Garcia, M.-N., Yamagishi, K., Broom, S. (2018). HTTP Adaptive Streaming QoE Estimation with ITU-T Rec. P.1203 – Open Databases and Software. In 9th ACM Multimedia Systems Conference. Amsterdam.


## License

Permission is hereby granted, free of charge, to use the software for non-commercial research purposes.

Any other use of the software, including commercial use, merging, publishing, distributing, sublicensing, and/or selling copies of the Software, is forbidden.

For a commercial license, you must contact the respective rights holders of the standards ITU-T Rec. P.1203, ITU-T Rec. P.1203.1, ITU-T Rec. P.1203.2, and ITU-T Rec. P.1203.3. See https://www.itu.int/en/ITU-T/ipr/Pages/default.aspx for more information.
 
