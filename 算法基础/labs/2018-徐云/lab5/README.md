实验五：图搜索BFS算法及存储优化

实验要求：
1.	模拟数据集
自己随机生成有向图，边数的规模为10，100，1000，10000，100000；
进行BFS搜索，记录程序完成时间和所需内存空间大小。

2.	真实数据集
https://pan.baidu.com/s/1pvfphiywjSXohO-bSnL1HA
数据集说明：均为twitter真实数据集，数据集规模如下：
twitter_small: Nodes 81306, Edges 1768149, 有向图；
(2420766行数据, 有重复边), (max node: 568770231)

twitter_large: Nodes 11316811, Edges 85331846, 有向图。
进行BFS搜索，设计存储优化方案和加速方案，记录程序时间和内存空间大小。

实验说明：
1）编程语言和实验平台不限，可考虑并行（i.e., GPU/OpenMP/MapReduce）；
2）至少需完成模拟数据集和twitter_small数据集的实验，twitter_large数据集为加分题。
