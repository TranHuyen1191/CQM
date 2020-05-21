# CQM: Cumulative quality model for HTTP Adaptive Streaming
* This source code is an implementation in MATLAB of our cumulative quality model (CQM).
* Note that window quality can be obtained by different existing models for overall quality 
* If you use the ITU-P1203 model as the window quality model, please see the requirements in https://github.com/itu-p1203/itu-p1203/


## How to use 
### F_CQM.m      : Function to calculate predicted cumulative quality values from CQM model
#### Input 
- iniD      : Initial duration (seconds)
- SQArr     : One-dimensional array of segment quality values in the range [1,5] (MOS)
- SPArr     : One-dimensional array of stalling positions (seconds)
- SDArr     : One-dimensional array of stalling durations (seconds)
- wqModel   : Window quality model 1: Tran's; 2: Guo's; 3: Vriendt's; 4: Yin's 5: p1203 (default: 1)
- sizeWArr  : Array of Window Sizes corresponding to the last, average, maximum, and minimun window quality values (seconds) (default: [50, 60, 50, 50])
- weight    : Weights of the last, minimun, and average window quality values (default:[0.31 0.37 0.01 0.31]) 

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

* **Huyen Tran** - *The University of Aizu, Japan* - tranhuyen1191@gmail.com
* If you have any questions or comments, please feel free to contact me.  

## Acknowledgments

If you use this source code in your research, please cite the references below:

   Huyen T. T. Tran, Nam Pham Ngoc, Tobias Hoßfeld, Michael Seufert, Truong Cong Thang. Cumulative Quality Modeling for HTTP Adaptive Streaming. In https://arxiv.org/abs/1909.02772.


## License

Permission is hereby granted, free of charge, to use the software for non-commercial research purposes.

Any other use of the software, including commercial use, merging, publishing, distributing, sublicensing, and/or selling copies of the Software, is forbidden.
 
