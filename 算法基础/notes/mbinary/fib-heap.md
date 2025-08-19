---
title: 『数据结构』Fibonacci-heap
date: 2018-09-06  19:09
categories: 数据结构与算法
tags: [数据结构,斐波那契堆]
keywords:  数据结构,斐波那契堆
mathjax: true
description: "介绍 fibnacci heap 的原理"
---

<!-- TOC -->

- [1. 结构](#1-结构)
- [2. 势函数](#2-势函数)
- [3. 最大度数](#3-最大度数)
- [4. 操作](#4-操作)
    - [4.1. 创建一个斐波那契堆](#41-创建一个斐波那契堆)
    - [4.2. 插入一个结点](#42-插入一个结点)
    - [4.3. 寻找最小结点](#43-寻找最小结点)
    - [4.4. 合并两个斐波那契堆](#44-合并两个斐波那契堆)
    - [4.5. 抽取最小值](#45-抽取最小值)
    - [4.6. 关键字减值](#46-关键字减值)
    - [4.7. 删除结点](#47-删除结点)
- [5. 最大度数的证明](#5-最大度数的证明)

<!-- /TOC -->

![](https://upload-images.jianshu.io/upload_images/7130568-22531846a72b0d83.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-1-结构" name="1-结构"></a>
# 1. 结构
斐波那契堆是一系列具有最小堆序的有根树的集合, 同一代(层)结点由双向循环链表链接, **为了便于删除最小结点, 还需要维持链表为升序, 即nd<=nd.right(nd==nd.right时只有一个结点或为 None)**, 父子之间都有指向对方的指针.

结点有degree 属性, 记录孩子的个数, mark 属性用来标记(为了满足势函数, 达到摊还需求的)

还有一个最小值指针 H.min 指向最小根结点
![](https://upload-images.jianshu.io/upload_images/7130568-d4e8a85754fdbc14.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-2-势函数" name="2-势函数"></a>
# 2. 势函数
下面用势函数来分析摊还代价, 如果你不明白, 可以看[摊还分析](https://www.jianshu.com/p/052fbe9d92a4)

![](https://latex.codecogs.com/gif.latex?\Phi(H)&space;=&space;t(H)&space;+&space;2m(h))
t 是根链表中树的数目,m(H) 表示被标记的结点数

最初没有结点
<a id="markdown-3-最大度数" name="3-最大度数"></a>
# 3. 最大度数
结点的最大度数(即孩子数)![](https://latex.codecogs.com/gif.latex?D(n)\leqslant&space;\lfloor&space;lgn&space;\rfloor), 证明放在最后
<a id="markdown-4-操作" name="4-操作"></a>
# 4. 操作
<a id="markdown-41-创建一个斐波那契堆" name="41-创建一个斐波那契堆"></a>
## 4.1. 创建一个斐波那契堆
![](https://latex.codecogs.com/gif.latex?O(1))
<a id="markdown-42-插入一个结点" name="42-插入一个结点"></a>
## 4.2. 插入一个结点
```python
nd = new node
nd.prt = nd.chd = None
if H.min is None:
    creat H with nd
    H.min = nd
else:
    insert nd into  H's root list
    if H.min<nd: H.min = nd
H.n +=1
```
![](https://latex.codecogs.com/gif.latex?&space;\Delta&space;\Phi&space;=&space;\Delta&space;t(H)&space;+&space;2\Delta&space;m(H)&space;=&space;1+0&space;=&space;1&space;)
摊还代价为![](https://latex.codecogs.com/gif.latex?O(1))
<a id="markdown-43-寻找最小结点" name="43-寻找最小结点"></a>
## 4.3. 寻找最小结点
直接用 H.min, ![](https://latex.codecogs.com/gif.latex?O(1))
<a id="markdown-44-合并两个斐波那契堆" name="44-合并两个斐波那契堆"></a>
## 4.4. 合并两个斐波那契堆
```python
def union(H1,H2):
    if H1.min ==None or (H1.min and H2.min and H1.min>H2.min):
        H1.min = H2.min
    link H2.rootList to H1.rootList 
    return H1
```
易知 ![](https://latex.codecogs.com/gif.latex?\Delta&space;\Phi&space;=&space;0)
<a id="markdown-45-抽取最小值" name="45-抽取最小值"></a>
## 4.5. 抽取最小值
抽取最小值, 一定是在根结点, 然后将此根结点的所有子树的根放在 根结点双向循环链表中, 之后还要进行**树的合并. 以使每个根结点的度不同,**
```python
def extract-min(H):
    z = H.min
    if z!=None:
        for chd of z:
            link chd to H.rootList
            chd.prt = None
        remove z from the rootList of H
        if z==z.right:
            H.min = None
        else:
            H.min = z.right
            consolidate(H)
        H.n -=1
    return z
```
consolidate 函数使用一个 辅助数组degree来记录所有根结点(不超过lgn)对应的度数, degree[i] = nd 表示.有且只有一个结点 nd 的度数为 i.
```python
def consolidate(H):
    initialize degree  with None
    for nd in H.rootList:
        d = nd.degree
        while degree[d] !=None:
            nd2 = degree[d]
            if nd2.degree < nd.degree:
                nd2,nd = nd,nd2

            make nd2 child of nd  
            nd.degree = d+1
            nd.mark = False # to balace the potential 

            remove nd2 from H.rootList
            degree[d] = None
            d+=1
        else: degree[d] = nd
    for i in degree:
        if i!=None: 
            link i to H.rootList
            if H.min ==None: H.min = i
            else if H.min>i: H.min = i
```
时间复杂度为![](https://latex.codecogs.com/gif.latex?O(lgn)) 即数组移动的长度, 而最多有 lgn个元素

<a id="markdown-46-关键字减值" name="46-关键字减值"></a>
## 4.6. 关键字减值
```python
def decrease-key(H,x,k):
    if k>x.key: error 
    x.key = k
    y=x.p
    if y!=None and x.key < y.key:
        cut(H,x,y)
        cascading-cut(H,y)
    if x.key < H.min.key:
      H.min = x
def cut(H,x,y):
    remove x from the child list of y, decrementing y.degree
    add x to H.rootList
    x.prt = None
     x.mark = False

def cascading-cut(H,y):
    z- y,prt
    if z !=None:
        if y.mark ==False:y.mark = True
        else:
            cut(H,y,z)
            cascading-cut(H,z)
```
![](https://upload-images.jianshu.io/upload_images/7130568-0a29221f8a1fbfbb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-47-删除结点" name="47-删除结点"></a>
## 4.7. 删除结点
```python
decrease(H,nd, MIN)
extract-min(H)
```

<a id="markdown-5-最大度数的证明" name="5-最大度数的证明"></a>
# 5. 最大度数的证明
这也是`斐波那契`这个名字的由来,
![](https://latex.codecogs.com/gif.latex?D(n)\leqslant&space;\lfloor&space;lgn&space;\rfloor)
![](https://upload-images.jianshu.io/upload_images/7130568-c9e0cd3be4e98c4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
