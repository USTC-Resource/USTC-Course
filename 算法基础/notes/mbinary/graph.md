---
title: 图算法
date: 2018-09-06  19:10
categories: 数据结构与算法
tags: [图,算法]
keywords: 图,算法 
mathjax: true
description: "算法导论上常用的图算法, 代码, 原理等"

---

<!-- TOC -->

- [1. 图](#1-图)
    - [1.1. 概念](#11-概念)
        - [1.1.1. 性质](#111-性质)
    - [1.2. 图的表示](#12-图的表示)
    - [1.3. 树](#13-树)
- [2. 图的搜索](#2-图的搜索)
    - [2.1. BFS](#21-bfs)
    - [2.2. DFS](#22-dfs)
        - [2.2.1. DFS 的性质](#221-dfs-的性质)
    - [2.3. 拓扑排序](#23-拓扑排序)
    - [2.4. 强连通分量](#24-强连通分量)
- [3. 最小生成树](#3-最小生成树)
    - [3.1. Kruskal 算法](#31-kruskal-算法)
    - [3.2. Prim 算法](#32-prim-算法)
- [4. 单源最短路](#4-单源最短路)
    - [4.1. 最短路的子路径也是最短路径](#41-最短路的子路径也是最短路径)
    - [4.2. 负权重的边](#42-负权重的边)
    - [4.3. 初始化](#43-初始化)
    - [4.4. 松弛操作](#44-松弛操作)
    - [4.5. 有向无环图的单源最短路问题](#45-有向无环图的单源最短路问题)
    - [4.6. Bellman-Ford 算法](#46-bellman-ford-算法)
    - [4.7. Dijkstra 算法](#47-dijkstra-算法)
- [5. 所有结点对的最短路问题](#5-所有结点对的最短路问题)
    - [5.1. 矩阵乘法](#51-矩阵乘法)
    - [5.2. Floyd-Warshall 算法](#52-floyd-warshall-算法)
    - [5.3. Johnson 算法](#53-johnson-算法)
- [6. 最大流](#6-最大流)
    - [6.1. 最大流最小截定理](#61-最大流最小截定理)
    - [6.2. 多个源,汇](#62-多个源汇)
    - [6.3. Ford-Fulkerson 方法](#63-ford-fulkerson-方法)
        - [6.3.1. 残存网络](#631-残存网络)
        - [6.3.2. 增广路径](#632-增广路径)
        - [6.3.3. 割](#633-割)
    - [6.4. 基本的 Ford-Fulkerson算法](#64-基本的-ford-fulkerson算法)
    - [6.5. TBD](#65-tbd)
- [7. 参考资料](#7-参考资料)

<!-- /TOC -->

<a id="markdown-1-图" name="1-图"></a>
# 1. 图
<a id="markdown-11-概念" name="11-概念"></a>
## 1.1. 概念
* 顶
* 顶点的度 d
* 边
* 相邻
* 重边
* 环
* 完全图: 所有顶都相邻
* 二分图: ![](https://latex.codecogs.com/gif.latex?V(G)&space;=&space;X&space;\cup&space;Y,&space;X\cap&space;Y&space;=&space;\varnothing), X中, Y 中任两顶不相邻
* 轨道
* 圈
<a id="markdown-111-性质" name="111-性质"></a>

### 1.1.1. 性质
* ![](https://latex.codecogs.com/gif.latex?\sum_{v\in&space;V}&space;d(v)&space;=&space;2|E|)
* G是二分图 ![](https://latex.codecogs.com/gif.latex?\Leftrightarrow) G无奇圈
* 树是无圈连通图
* 树中, ![](https://latex.codecogs.com/gif.latex?|E|&space;=&space;|V|&space;-1)
<a id="markdown-12-图的表示" name="12-图的表示"></a>

## 1.2. 图的表示
* 邻接矩阵
* 邻接链表
![](https://upload-images.jianshu.io/upload_images/7130568-57ce6db904992656.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-13-树" name="13-树"></a>
## 1.3. 树
无圈连通图, ![](https://latex.codecogs.com/gif.latex?E&space;=&space;V-1), 详细见[树](/tree.html), 

<a id="markdown-2-图的搜索" name="2-图的搜索"></a>
# 2. 图的搜索
Introduction to algorithm[^1]
<a id="markdown-21-bfs" name="21-bfs"></a>
## 2.1. BFS
```python
for v in V:
    v.d = MAX
    v.pre = None
    v.isFind = False
root. isFind = True
root.d = 0
que = [root]
while que !=[]:
    nd = que.pop(0)
    for v in Adj(nd):
        if not v.isFind :
            v.d = nd.d+1
            v.pre = nd
            v.isFind = True
            que.append(v)
```
时间复杂度 ![](https://latex.codecogs.com/gif.latex?O(V+E))
<a id="markdown-22-dfs" name="22-dfs"></a>
## 2.2. DFS
![](https://latex.codecogs.com/gif.latex?\Theta(V+E))
```python
def dfs(G):
    time = 0
    for v in V:
        v.pre = None
        v.isFind = False
    for v in V : # note this, 
        if not v.isFind:
            dfsVisit(v)
    def dfsVisit(G,u):
        time =time+1
        u.begin = time
        u.isFind = True
        for v in Adj(u):
            if not v.isFind:
                v.pre = u
                dfsVisit(G,v)
        time +=1
        u.end = time  
```
begin, end 分别是结点的发现时间与完成时间
<a id="markdown-221-dfs-的性质" name="221-dfs-的性质"></a>
### 2.2.1. DFS 的性质
* 其生成的前驱子图![](https://latex.codecogs.com/gif.latex?G_{pre}) 形成一个由多棵树构成的森林, 这是因为其与 dfsVisit 的递归调用树相对应
* 括号化结构
![](https://upload-images.jianshu.io/upload_images/7130568-ba62e68e5b883b6c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* 括号化定理:
    考察两个结点的发现时间与结束时间的区间 [u,begin,u.end] 与 [v.begin,v.end]
    * 如果两者没有交集, 则两个结点在两个不同的子树上(递归树)
    * 如果 u 的区间包含在 v 的区间, 则 u 是v 的后代

<a id="markdown-23-拓扑排序" name="23-拓扑排序"></a>
## 2.3. 拓扑排序
利用 DFS, 结点的完成时间的逆序就是拓扑排序

同一个图可能有不同的拓扑排序
<a id="markdown-24-强连通分量" name="24-强连通分量"></a>
## 2.4. 强连通分量
在有向图中, 强连通分量中的结点互达
定义 ![](https://latex.codecogs.com/gif.latex?Grev) 为 ![](https://latex.codecogs.com/gif.latex?G) 中所有边反向后的图

将图分解成强连通分量的算法
在 Grev 上根据 G 中结点的拓扑排序来 dfsVisit, 即
```python
compute Grev
initalization
for v in topo-sort(G.V):
    if not v.isFind: dfsVisit(Grev,v)
```
然后得到的DFS 森林(也是递归树森林)中每个树就是一个强连通分量

<a id="markdown-3-最小生成树" name="3-最小生成树"></a>
# 3. 最小生成树
利用了贪心算法, 
```python
Generate-Minimum-spanning-tree(G)
    A = []
    while len(A)!=len(G.V)-1:
        add a safe edge for A to A
    return A
```
<a id="markdown-31-kruskal-算法" name="31-kruskal-算法"></a>
## 3.1. Kruskal 算法
总体上, 从最开始 每个结点就是一颗树的森林中(不相交集合, 并查集), 逐渐添加不形成圈的(两个元素不再同一个集合),最小边权的边.
```python
edges=[]
for  edge as u,v in sorted(G.E):
    if find-set(u) != find-set(v):
        edges.append(edge)
        union(u,v)
return edges
```
如果并查集的实现采用了 按秩合并与路径压缩技巧, 则 find 与 union 的时间接近常数
所以时间复杂度在于排序边, 即 ![](https://latex.codecogs.com/gif.latex?O(ElgE)), 而 ![](https://latex.codecogs.com/gif.latex?E\lt&space;V^2), 所以 ![](https://latex.codecogs.com/gif.latex?lgE&space;=&space;O(lgV)), 时间复杂度为  ![](https://latex.codecogs.com/gif.latex?O(ElgV)) 
<a id="markdown-32-prim-算法" name="32-prim-算法"></a>
## 3.2. Prim 算法
用了 BFS, 类似 Dijkstra 算法
从根结点开始 BFS, 一直保持成一颗树
```python
for v in V: 
    v.minAdjEdge = MAX
    v.pre = None
root.minAdjEdge = 0
que = priority-queue (G.V)  # sort by minAdjEdge
while not que.isempty():
    u = que.extractMin()
    for v in Adj(u):
        if v in que and v.minAdjEdge>w(u,v):
            v.pre = u
            v.minAdjEdge = w(u,v)
```
* 建堆 ![](https://latex.codecogs.com/gif.latex?O(V)) `//note it's v, not vlgv`
* 主循环中
    * extractMin:  ![](https://latex.codecogs.com/gif.latex?O(VlgV))
    * in 操作 可以另设标志位, 在常数时间完成, 总共 ![](https://latex.codecogs.com/gif.latex?O(E))
    * 设置结点的 minAdjEdge, 需要![](https://latex.codecogs.com/gif.latex?O(lgv)), 循环 E 次,则 总共![](https://latex.codecogs.com/gif.latex?O(ElgV))

综上, 时间复杂度为![](https://latex.codecogs.com/gif.latex?O(ElgV))
如果使用的是 [斐波那契堆](/fib-heap.html), 在  设置 minAdjEdge时 调用 `decrease-key`, 这个操作摊还代价为 ![](https://latex.codecogs.com/gif.latex?O(1)), 所以时间复杂度可改进到 ![](https://latex.codecogs.com/gif.latex?O(E+VlgV))

<a id="markdown-4-单源最短路" name="4-单源最短路"></a>
# 4. 单源最短路
求一个结点到其他结点的最短路径, 可以用 Bellman-ford算法, 或者 Dijkstra算法.  
定义两个结点u,v间的最短路 
![](https://latex.codecogs.com/gif.latex?&space;\delta(u,v)&space;=&space;\begin{cases}&space;\min(w(path)),\quad&space;u\xrightarrow{path}&space;v\\&space;\infty,&space;\quad&space;u&space;rightarrow&space;v&space;\end{cases}&space;)
问题的变体
* 单目的地最短路问题: 可以将所有边反向转换成求单源最短路问题
* 单结点对的最短路径
* 所有结点对最短路路径

<a id="markdown-41-最短路的子路径也是最短路径" name="41-最短路的子路径也是最短路径"></a>
## 4.1. 最短路的子路径也是最短路径
![](https://latex.codecogs.com/gif.latex?p=(v_0,v_1,\ldots,v_k))为从结点![](https://latex.codecogs.com/gif.latex?v_0)到![](https://latex.codecogs.com/gif.latex?v_k)的一条最短路径,  对于任意![](https://latex.codecogs.com/gif.latex?0\le&space;i\le&space;j&space;\le&space;k), 记![](https://latex.codecogs.com/gif.latex?p_{ij}=(v_i,v_{i+1},\ldots,v_j))为 p 中 ![](https://latex.codecogs.com/gif.latex?v_i)到![](https://latex.codecogs.com/gif.latex?v_j)的子路径, 则 ![](https://latex.codecogs.com/gif.latex?p_{ij})为 ![](https://latex.codecogs.com/gif.latex?v_i)到![](https://latex.codecogs.com/gif.latex?v_j)的一条最短路径

<a id="markdown-42-负权重的边" name="42-负权重的边"></a>
## 4.2. 负权重的边
Dijkstra 算法不能处理负值边, 只能用 Bellman-Ford 算法, 
而且如果有负值圈, 则没有最短路,  bellman-ford算法也可以检测出来
<a id="markdown-43-初始化" name="43-初始化"></a>
## 4.3. 初始化
```python
def initialaize(G,s):
    for v in G.V:
        v.pre = None
        v.distance = MAX
    s.distance = 0
```
<a id="markdown-44-松弛操作" name="44-松弛操作"></a>
## 4.4. 松弛操作
```python
def relax(u,v,w):
    if v.distance > u.distance + w:
        v.distance = u.distance + w:
         v.pre = u
```
性质
* 三角不等式: ![](https://latex.codecogs.com/gif.latex?\delta(s,v)&space;\leqslant&space;\delta(s,u)&space;+&space;w(u,v))
* 上界: ![](https://latex.codecogs.com/gif.latex?v.distance&space;\geqslant&space;\delta(s,v))
* 收敛: 对于某些结点u,v  如果s->...->u->v是图G中的一条最短路径，并且在对边，进行松弛前任意时间有 ![](https://latex.codecogs.com/gif.latex?u.distance=\delta(s,u))则在之后的所有时间有 ![](https://latex.codecogs.com/gif.latex?v.distance=\delta(s,v))
* 路径松弛性质: 如果![](https://latex.codecogs.com/gif.latex?p=v_0&space;v_1&space;\ldots&space;v_k)是从源结点下v0到结点vk的一条最短路径，并且对p中的边所进行松弛的次序为![](https://latex.codecogs.com/gif.latex?(v_0,v_1),(v_1,v_2),&space;\ldots&space;,(v_{k-1},v_k)), 则 ![](https://latex.codecogs.com/gif.latex?v_k.distance&space;=&space;\delta(s,v_k))
该性质的成立与任何其他的松弛操作无关，即使这些松弛操作是与对p上的边所进行的松弛操作穿插进行的。

证明
![](https://upload-images.jianshu.io/upload_images/7130568-424a6929bd389825.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-45-有向无环图的单源最短路问题" name="45-有向无环图的单源最短路问题"></a>
## 4.5. 有向无环图的单源最短路问题
![](https://latex.codecogs.com/gif.latex?\Theta(V+E))
```python
def dag-shortest-path(G,s):
    initialize(G,s)
    for u in topo-sort(G.V):
        for v in Adj(v):
            relax(u,v,w(u,v))
```
<a id="markdown-46-bellman-ford-算法" name="46-bellman-ford-算法"></a>
## 4.6. Bellman-Ford 算法
![](https://latex.codecogs.com/gif.latex?O(VE))
```python
def bellman-ford(G,s):
    initialize(G,s)
    for ct in range(|V|-1): # v-1 times
        for u,v as edge in E:
            relax(u,v,w(u,v))
    for u,v as edge in E:
        if v.distance > u.distance + w(u,v):
            return False
    return True
```
第一个 for 循环就是进行松弛操作, 最后结果已经存储在 结点的distance 和 pre 属性中了, 第二个 for 循环利用三角不等式检查有不有负值圈.

下面是证明该算法的正确性![](https://upload-images.jianshu.io/upload_images/7130568-f84e00ac35aadc81.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-47-dijkstra-算法" name="47-dijkstra-算法"></a>
## 4.7. Dijkstra 算法
![](https://latex.codecogs.com/gif.latex?O(ElogV)), 要求不能有负值边

Dijkstra算法既类似于广度优先搜索（，也有点类似于计算最小生成树的Prim算法。它与广度优先搜索的类似点在于集合S对应的是广度优先搜索中的黑色结点集合：正如集合S中的结点的最短路径权重已经计算出来一样，在广度优先搜索中，黑色结点的正确的广度优先距离也已经计算出来。Dijkstra算法像Prim算法的地方是，两个算法都使用最小优先队列来寻找给定集合（Dijkstra算法中的S集合与Prim算法中逐步增长的树）之外的“最轻”结点，将该结点加入到集合里，并对位于集合外面的结点的权重进行相应调整。

```python
def dijkstra(G,s):
    initialize(G,s)
    paths=[]
    q = priority-queue(G.V) # sort by distance
    while not q.empty():
        u = q.extract-min()
        paths.append(u)
        for v in Adj(u):
            relax(u,v,w(u,v))
```

<a id="markdown-5-所有结点对的最短路问题" name="5-所有结点对的最短路问题"></a>
# 5. 所有结点对的最短路问题
<a id="markdown-51-矩阵乘法" name="51-矩阵乘法"></a>
## 5.1. 矩阵乘法
使用动态规划算法, 可以得到最短路径的结构
设 ![](https://latex.codecogs.com/gif.latex?l_{ij}^{(m)})为从结点i 到结点 j 的至多包含 m 条边的任意路径的最小权重,当m = 0, 此时i=j, 则 为0,
可以得到递归定义 
 ![](https://latex.codecogs.com/gif.latex?&space;l_{ij}^{(m)}&space;=\min(&space;l_{ij}^{(m-1)},&space;\min_{1\leqslant&space;k\leqslant&space;n}(&space;l_{ik}^{(m-1)}+w_{kj}))&space;=&space;\min_{1\leqslant&space;k\leqslant&space;n}(&space;l_{ik}^{(m-1)}+w_{kj}))&space;)
由于对于所有 j, 有 ![](https://latex.codecogs.com/gif.latex?w_{jj}=0),所以上式后面的等式成立.

由于是简单路径, 则包含的边最多为 |V|-1 条, 所以
![](https://latex.codecogs.com/gif.latex?&space;\delta(i,j)&space;=&space;l_{ij}^{(|V|-1)}&space;=&space;l_{ij}^{(|V|)}&space;=l_{ij}^{(|V|&space;+&space;1)}=&space;...&space;)
所以可以从自底向上计算, 如下
输入权值矩阵 ![](https://latex.codecogs.com/gif.latex?W(w_{ij})),&space;L^{(m-1)}),输出![](https://latex.codecogs.com/gif.latex?L^{(m)}),  其中 ![](https://latex.codecogs.com/gif.latex?L^{(1)}&space;=&space;W),
```python
def  f(L, W):
  n = L.rows
  L_new = new matrix(row=n ,col = n)
  for i in range(n):
      for j in range(n):
          L_new[i][j] = MAX
          for k in range(n):
              L_new[i][j] = min(L_new[i][j], L[i][k]+w[k][j])
  return L_new
```
可以看出该算法与矩阵乘法的关系 
![](https://latex.codecogs.com/gif.latex?L^{(m)}&space;=&space;W^m),
所以可以直接计算乘法, 每次计算一个乘积是 ![](https://latex.codecogs.com/gif.latex?O(V^3)), 计算 V 次, 所以总体 ![](https://latex.codecogs.com/gif.latex?O(V^4)), 使用矩阵快速幂可以将时间复杂度降低为![](https://latex.codecogs.com/gif.latex?O(V^3lgV))
```python
def f(W):
    L = W
    i = 1
    while i<W.rows:
        L = L*L
        i*=2
    return L
```
    
<a id="markdown-52-floyd-warshall-算法" name="52-floyd-warshall-算法"></a>
## 5.2. Floyd-Warshall 算法
同样要求可以存在负权边, 但不能有负值圈. 用动态规划算法:
设 ![](https://latex.codecogs.com/gif.latex?d_{ij}^{(k)}) 为 从 i 到 j 所有中间结点来自集合 ![](https://latex.codecogs.com/gif.latex?{\{1,2,\ldots,k\}}) 的一条最短路径的权重. 则有
![](https://latex.codecogs.com/gif.latex?&space;d_{ij}^{(k)}&space;=&space;\begin{cases}&space;w_{ij},\quad&space;k=0\\&space;min(d_{ij}^{(k-1)},d_{ik}^{(k-1)}+d_{kj}^{(k-1)}),\quad&space;k\geqslant&space;1&space;\end{cases}&space;)
而且为了找出路径, 需要记录前驱结点, 定义如下前驱矩阵 ![](https://latex.codecogs.com/gif.latex?\Pi), 设 ![](https://latex.codecogs.com/gif.latex?\pi_{ij}^{(k)}) 为 从 i 到 j 所有中间结点来自集合 ![](https://latex.codecogs.com/gif.latex?{\{1,2,\ldots,k\}}) 的最短路径上 j 的前驱结点
则
![](https://latex.codecogs.com/gif.latex?&space;\pi_{ij}^{(0)}&space;=&space;\begin{cases}&space;nil,\quad&space;i=j&space;\&space;or&space;\&space;w_{ij}=\infty&space;\\&space;i,&space;\quad&space;i&space;eq&space;j\&space;and&space;\&space;w_{ij}<\infty&space;\end{cases}&space;)
对 ![](https://latex.codecogs.com/gif.latex?k\geqslant&space;1)
![](https://latex.codecogs.com/gif.latex?&space;\pi_{ij}^{(k)}&space;=&space;\begin{cases}&space;\pi_{ij}^{(k-1)}&space;,\quad&space;d_{ij}^{(k-1)}\leqslant&space;d_{ik}^{(k-1)}+d_{kj}^{(k-1)}\\&space;\pi_{kj}^{(k-1)}&space;,\quad&space;otherwise&space;\end{cases}&space;)

由此得出此算法
```python
def floyd-warshall(W):
    n = len(W)
    D= W
    initialize pre
    for k in range(n):
        pre2 = pre.copy()
        for i in range(n):
            for j in range(n)
                if d[i][j] > d[i][k]+d[k][j]:
                    d[i][j] =d[i][k]+d[k][j]
                    pre2[i][j] = pre[k][j]
        pre = pre2
return d,pre
```
<a id="markdown-53-johnson-算法" name="53-johnson-算法"></a>
## 5.3. Johnson 算法
思路是通过重新赋予权重, 将图中负权边转换为正权,然后就可以用 dijkstra 算法(要求是正值边)来计算一个结点到其他所有结点的, 然后对所有结点用dijkstra 

1. 首先构造一个新图 G'
  先将G拷贝到G', 再添加一个新结点 s, 添加 G.V条边, s 到G中顶点的, 权赋值为 0
2. 用 Bellman-Ford 算法检查是否有负值圈, 如果没有, 同时求出 ![](https://latex.codecogs.com/gif.latex?\delta(s,v)&space;Recorded-as&space;h(v))
3. 求新的非负值权, w'(u,v) = w(u,v)+h(u)-h(v)
4. 对所有结点在 新的权矩阵w'上 用 Dijkstra 算法
![image.png](https://upload-images.jianshu.io/upload_images/7130568-6c2146ad64d692f3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```python
JOHNSON (G, u) 

s = newNode
G' = G.copy()
G'.addNode(s)
for v in G.V: G'.addArc(s,v,w=0)

if BELLMAN-FORD(G' , w, s) ==FALSE 
    error "the input graph contains a negative-weight cycle" 

for v in G'.V:
    # computed by the bellman-ford algorithm, delta(s,v) is the shortest distance from s to v
    h(v) = delta(s,v) 
for edge(u,v) in G'.E:
    w' = w(u,v)+h(u)-h(v)
d = matrix(n,n)
for u in G:
    dijkstra(G,w',u) # compute delta' for all v in G.V
    for v in G.V:
        d[u][v] = delta'(u,v) + h(v)-h(u)
return d
```
<a id="markdown-6-最大流" name="6-最大流"></a>
# 6. 最大流
G 是弱连通严格有向加权图, s为源, t 为汇, 每条边e容量 c(e), 由此定义了网络N(G,s,t,c(e)),
* 流函数 ![](https://latex.codecogs.com/gif.latex?f(e):E&space;\rightarrow&space;R)
![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;(1)\quad&space;&&space;0\leqslant&space;f(e)&space;\leqslant&space;c(e),\quad&space;e&space;\in&space;E\\&space;(2)\quad&space;&&space;\sum_{e\in&space;\alpha(v)}&space;f(e)=&space;\sum_{e\in&space;\beta(v)}f(e),\quad&space;v&space;\in&space;V-\{s,t\}&space;\end{aligned}&space;)
其中 ![](https://latex.codecogs.com/gif.latex?\alpha(v)) 是以 v 为头的边集, ![](https://latex.codecogs.com/gif.latex?\beta(v))是以 v 为尾的边集
* 流量: ![](https://latex.codecogs.com/gif.latex?F&space;=&space;\sum_{e\in&space;\alpha(t)}&space;f(e)-&space;\sum_{e\in&space;-\beta(t)}f(e),)
* 截![](https://latex.codecogs.com/gif.latex?(S,\overline&space;S)): ![](https://latex.codecogs.com/gif.latex?S\subset&space;V,s\in&space;S,&space;t\in&space;\overline&space;S&space;=V-S)
* 截量![](https://latex.codecogs.com/gif.latex?C(S)&space;=&space;\sum_{e\in(S,\overline&space;S)}c(e))
<a id="markdown-61-最大流最小截定理" name="61-最大流最小截定理"></a>
## 6.1. 最大流最小截定理
<<图论>> 王树禾[^2]
* 对于任一截![](https://latex.codecogs.com/gif.latex?(S,\overline&space;S)), 有 ![](https://latex.codecogs.com/gif.latex?F&space;=&space;\sum_{e\in&space;(S,\overline&space;S)}&space;f(e)-&space;\sum_{e\in(\overline&space;S,S)}f(e),)
![prove](https://upload-images.jianshu.io/upload_images/7130568-19bf6cc3c7d6ce06.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* ![](https://latex.codecogs.com/gif.latex?F\leqslant&space;C(S))
证明: 由上面定理
 ![](https://latex.codecogs.com/gif.latex?F&space;=&space;\sum_{e\in&space;(S,\overline&space;S)}&space;f(e)-&space;\sum_{e\in(\overline&space;S,S)}f(e),)
而 ![](https://latex.codecogs.com/gif.latex?0\leqslant&space;f(e)&space;\leqslant&space;c(e)), 则
![](https://latex.codecogs.com/gif.latex?F\leqslant&space;\sum_{e\in&space;(S,\overline&space;S)}&space;f(e)&space;\leqslant&space;\sum_{e\in&space;(S,\overline&space;S)}&space;c(e)&space;=&space;C(S))
* 最大流,最小截: 若![](https://latex.codecogs.com/gif.latex?F=&space;C(S)), 则F'是最大流量, C(S) 是最小截量
<a id="markdown-62-多个源汇" name="62-多个源汇"></a>
## 6.2. 多个源,汇
可以新增一个总的源,一个总的汇,
![](https://upload-images.jianshu.io/upload_images/7130568-3e9e87fdf9655883.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-63-ford-fulkerson-方法" name="63-ford-fulkerson-方法"></a>
## 6.3. Ford-Fulkerson 方法
由于其实现可以有不同的运行时间, 所以称其为方法, 而不是算法.
思路是 循环增加流的值, 在一个关联的"残存网络" 中寻找一条"增广路径", 然后对这些边进行修改流量. 重复直至残存网络上不再存在增高路径为止.
```python
def ford-fulkerson(G,s,t):
    initialize flow f to 0
    while exists an augmenting path p in residual network Gf:
        augment flow f along p
    return f
```
<a id="markdown-631-残存网络" name="631-残存网络"></a>
### 6.3.1. 残存网络
![](https://upload-images.jianshu.io/upload_images/7130568-c74a571b9121dbbf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-632-增广路径" name="632-增广路径"></a>
### 6.3.2. 增广路径
![](https://upload-images.jianshu.io/upload_images/7130568-b9e841cfa4d04b57.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<a id="markdown-633-割" name="633-割"></a>
### 6.3.3. 割
![](https://upload-images.jianshu.io/upload_images/7130568-74b065e86eb285b7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<a id="markdown-64-基本的-ford-fulkerson算法" name="64-基本的-ford-fulkerson算法"></a>
## 6.4. 基本的 Ford-Fulkerson算法
```python
def ford-fulkerson(G,s,t):
    for edge in G.E: edge.f = 0
    while exists path p:s->t  in Gf:
        cf(p) = min{cf(u,v):(u,v) is in p}
        for edge in p:
            if edge  in E:
                edge.f +=cf(p)
            else: reverse_edge.f -=cf(p)
```

<a id="markdown-65-tbd" name="65-tbd"></a>
## 6.5. TBD

<a id="markdown-7-参考资料" name="7-参考资料"></a>
# 7. 参考资料
[^1]: 算法导论
[^2]: 图论, 王树禾
