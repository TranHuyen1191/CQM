# ITU-T-P.1203-Implementation
This source code is a re-implementation in the MATLAB language of the software in https://github.com/itu-p1203/itu-p1203/.

Note that it is not an offical source code of ITU-T Recommendation P.1203. 

## How to use
### Input 
O21: One-dimensional array of segment audio quality values in the range [1,5]
O22: One-dimensional array of segment video quality values in the range [1,5] 
I23: Two-dimensional array of stalling events (including both initial delay and interruptions)
	
### Output
O46: Predicted quality value 
O35: Perceptual coding indication (without the impacts of stalling events)
O34: Segment audiovisual quality values of the segments 
O23: Perceptual stalling indication

## Example
A session of 5 seconds has 5 segments. The segment video quality values are [1,2,3,4,5]. 
And the segment audio quality values are [5,4,3,2,1]. 
In addition, there are two stalling events as follows. 
1. Initial delay: 
	Starting time: 0s 		Length: 5s
2. Interruption:    
	Starting time: 2s 		Length: 3s

To obtain the output, you can use the following command. 
	``` 
	[O46,O35,O34,O23] = ITUT_P1203_function([1 2 3 4 5],[5 4 3 2 1],[[0 5];[2 3]])
	```

## Authors

* **Tran Huyen** - *The University of Aizu, Japan*

## Acknowledgments

If you use this source code in your research, you must cite:

1. Include the link to this repository
2. Include the link https://github.com/itu-p1203/itu-p1203/
2. Cite the following publications:

   Raake, A., Garcia, M.-N., Robitza, W., List, P., Göring, S., Feiten, B. (2017). A bitstream-based, scalable video-quality model for HTTP adaptive streaming: ITU-T P.1203.1. In 2017 Ninth International Conference on Quality of Multimedia Experience (QoMEX). Erfurt.

        @inproceedings{Raake2017,
        address = {Erfurt},
        author = {Raake, Alexander and Garcia, Marie-Neige and Robitza, Werner and List, Peter and Göring, Steve and Feiten, Bernhard},
        booktitle = {Ninth International Conference on Quality of Multimedia Experience (QoMEX)},
        doi = {10.1109/QoMEX.2017.7965631},
        isbn = {978-1-5386-4024-1},
        month = {May},
        publisher = {IEEE},
        title = {{A bitstream-based, scalable video-quality model for HTTP adaptive streaming: ITU-T P.1203.1}},
        url = {http://ieeexplore.ieee.org/document/7965631/},
        year = {2017}
        }

    Robitza, W., Göring, S., Raake, A., Lindegren, D., Heikkilä, G., Gustafsson, J., List, P., Feiten, B., Wüstenhagen, U., Garcia, M.-N., Yamagishi, K., Broom, S. (2018). HTTP Adaptive Streaming QoE Estimation with ITU-T Rec. P.1203 – Open Databases and Software. In 9th ACM Multimedia Systems Conference. Amsterdam.

        @inproceedings{Robitza2018,
        address = {Amsterdam},
        author = {Robitza, Werner and Göring, Steve and Raake, Alexander and Lindegren, David and Heikkilä, Gunnar and Gustafsson, Jörgen and List, Peter and Feiten, Bernhard and Wüstenhagen, Ulf and Garcia, Marie-Neige and Yamagishi, Kazuhisa and Broom, Simon},
        booktitle = {9th ACM Multimedia Systems Conference},
        doi = {10.1145/3204949.3208124},
        isbn = {9781450351928},
        title = {{HTTP Adaptive Streaming QoE Estimation with ITU-T Rec. P.1203 – Open Databases and Software}},
        year = {2018}
        }

## License

Permission is hereby granted, free of charge, to use the software for non-commercial research purposes.

Any other use of the software, including commercial use, merging, publishing, distributing, sublicensing, and/or selling copies of the Software, is forbidden.

For a commercial license, you must contact the respective rights holders of the standards ITU-T Rec. P.1203, ITU-T Rec. P.1203.1, ITU-T Rec. P.1203.2, and ITU-T Rec. P.1203.3. See https://www.itu.int/en/ITU-T/ipr/Pages/default.aspx for more information.
 
