---
title: 『算法』排序
date: 2018-7-6
categories: 数据结构与算法
tags: [算法,排序]
keywords:  
mathjax: true
description: "七大排序算法"
---
<!-- TOC -->

- [1. 希尔排序(shellSort)](#1-希尔排序shellsort)
- [2. 堆排序(heapSort)](#2-堆排序heapsort)
    - [2.1. 建堆](#21-建堆)
    - [2.2. 访问最元](#22-访问最元)
    - [2.3. 取出最元](#23-取出最元)
    - [2.4. 堆排序](#24-堆排序)
- [3. 快速排序(quickSort)](#3-快速排序quicksort)
    - [3.1. partition的实现](#31-partition的实现)
    - [3.2. 选择枢纽元](#32-选择枢纽元)
    - [3.3. 快速排序的性能](#33-快速排序的性能)
        - [3.3.1. 最坏情况](#331-最坏情况)
        - [3.3.2. 最佳情况](#332-最佳情况)
        - [3.3.3. 平衡的划分](#333-平衡的划分)
    - [3.4. 期望运行时间](#34-期望运行时间)
    - [3.5. 堆栈深度](#35-堆栈深度)
    - [3.6. 测试](#36-测试)
- [4. 计数排序(countSort)](#4-计数排序countsort)
- [5. 基数排序(radixSort)](#5-基数排序radixsort)
    - [5.1. 原理](#51-原理)
    - [5.2. 实现](#52-实现)
    - [5.3. 扩展](#53-扩展)
    - [5.4. 测试](#54-测试)
- [6. 桶排序(bucketSort)](#6-桶排序bucketsort)
- [7. 选择问题(select)](#7-选择问题select)

<!-- /TOC -->


![](https://upload-images.jianshu.io/upload_images/7130568-4a45706be7eb399f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

排序的本质就是减少逆序数, 根据是否进行比较,可以分为如下两类.
* 比较排序

如希尔排序,堆排序, 快速排序, 合并排序等
可以证明 比较排序的下界 是 ![](https://latex.codecogs.com/gif.latex?\Omega(nlogn))

* 非比较排序

如 计数排序, 桶排序, 基数排序 不依靠比较来进行排序的, 可以达到 线性时间的复杂度


<a id="markdown-1-希尔排序shellsort" name="1-希尔排序shellsort"></a>
# 1. 希尔排序(shellSort)
希尔排序是选择排序的改进, 通过在较远的距离进行交换, 可以更快的减少逆序数. 这个距离即增量, 由自己选择一组, 从大到小进行, 而且最后一个增量必须是  1. 要选得到好的性能, 一般选择![](https://latex.codecogs.com/gif.latex?2^k-1)
```pythonn
def shellSort(s,inc = None):
    if inc is None: inc = [1,3,5,7,11,13,17,19]
    num = len(s)
    inc.sort(reverse=True)
    for i in inc:
        for j in range(i,num):
            cur = j
            while cur>=i and s[j] > s[cur-i]:
                s[cur] = s[cur-i]
                cur-=i
            s[cur] = s[j]
    return s
```
可以证明 希尔排序时间复杂度可以达到![](https://latex.codecogs.com/gif.latex?O(n^{\frac{4}{3}}))
<a id="markdown-2-堆排序heapsort" name="2-堆排序heapsort"></a>
# 2. 堆排序(heapSort)
<a id="markdown-21-建堆" name="21-建堆"></a>
## 2.1. 建堆
是将一个数组(列表) heapify 的过程. 方法就是对每一个结点, 都自底向上的比较,然后操作,这个过程称为 上浮.
粗略的计算, 每个结点上浮的比较次数的上界是 层数, 即 logn, 则 n 个结点, 总的比较次数为 nlogn
但是可以发现, 不同高度 h 的结点比较的次数不同, 上界实际上应该是 ![](https://latex.codecogs.com/gif.latex?O(h)),每层结点数上界 ![](https://latex.codecogs.com/gif.latex?\lfloor&space;2^h&space;\rfloor)
则 总比较次数为 
![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;\sum_{h=1}^{\lfloor{log_2&space;n}\rfloor}&space;O(h)\lceil&space;2^{h}&space;\rceil&space;&&space;=&space;\sum_{h=0}^{&space;{log_2&space;n}-1}&space;O(h\frac{n}{2^h})\\&space;&&space;=&space;n*O(\sum_{h=0}^{log_2&space;n}\frac{h}{2^h})&space;\\&space;&&space;=&space;n*O(1)&space;\\&space;&&space;=&space;O(n)&space;\end{aligned}&space;)
<a id="markdown-22-访问最元" name="22-访问最元"></a>
## 2.2. 访问最元
最大堆对应最大元,最小堆对于最小元, 可以 ![](https://latex.codecogs.com/gif.latex?O(1)) 内实现
<a id="markdown-23-取出最元" name="23-取出最元"></a>
## 2.3. 取出最元
最大堆取最大元,最小堆取最小元,由于元素取出了, 要进行调整.
从堆顶开始, 依次和其两个孩子比较, 如果是最大堆, 就将此结点(父亲)的值赋为较大的孩子的值,最小堆反之.
然后对那个孩子进行同样的操作,一直到达堆底,即最下面的一层. 这个过程称为 下滤.
最后将最后一个元素与最下面一层那个元素(与上一层交换的)交换, 再删除最后一个元素.
时间复杂度为 ![](https://latex.codecogs.com/gif.latex?O(logn))
<a id="markdown-24-堆排序" namie="24-堆排序"></a>
## 2.4. 堆排序
建立堆之后, 一直进行 `取出最元`操作, 即得有序序列


代码
```python
from functools import partial
class heap:
    def __init__(self,lst,reverse = False):
        self.data= heapify(lst,reverse)
        self.cmp = partial(lambda i,j,r:cmp(self.data[i],self.data[j],r),r=  reverse)
    def getTop(self):
        return self.data[0]
    def __getitem__(self,idx):
        return self.data[idx]
    def __bool__(self):
        return self.data != []
    def popTop(self):
        ret = self.data[0]
        n = len(self.data)
        cur = 1
        while cur * 2<=n:
            chd = cur-1
            r_idx = cur*2
            l_idx = r_idx-1
            if r_idx==n:
                self.data[chd] = self.data[l_idx]
                break
            j = l_idx if self.cmp(l_idx,r_idx)<0 else r_idx
            self.data[chd] = self.data[j]
            cur = j+1
        self.data[cur-1] = self.data[-1]
        self.data.pop()
        return ret

    def addNode(self,val):
        self.data.append(val)
        self.data = one_heapify(len(self.data)-1)


def cmp(n1,n2,reverse=False):
    fac = -1 if reverse else 1
    if n1 < n2: return -fac
    elif n1 > n2: return fac
    return 0

def heapify(lst,reverse = False):
    for i in range(len(lst)):
        lst = one_heapify(lst,i,reverse)
    return lst
def one_heapify(lst,cur,reverse = False):
    cur +=1
    while cur>1:
        chd = cur-1
        prt = cur//2-1
        if cmp(lst[prt],lst[chd],reverse)<0:
            break
        lst[prt],lst[chd] = lst[chd], lst[prt]
        cur = prt+1
    return lst
def heapSort(lst,reverse = False):
    lst = lst.copy()
    hp = heap(lst,reverse)
    ret = []
    while hp:
        ret.append(hp.popTop())
    return ret


if __name__ == '__main__':
    from random import randint
    n = randint(10,20)
    lst = [randint(0,100) for i in range(n)]
    print('random    : ', lst)
    print('small-heap: ', heapify(lst))
    print('big-heap  : ', heapify(lst,True))
    print('ascend    : ', heapSort(lst))
    print('descend   : ', heapSort(lst,True))
```
<a id="markdown-3-快速排序quicksort" name="3-快速排序quicksort"></a>
# 3. 快速排序(quickSort)
```python
def quickSort(lst):
    def _sort(a,b):
        if a>=b:return 
        CHOOSE PIVOT #选取适当的枢纽元, 一般是三数取中值
        pos = partition(a,b)
        _sort(a,pos-1)
        _sort(pos+1,b)
    _sort(0,len(lst))
```
快排大体结构就是这样,使用分治的思想, 在原地进行排列.
关键就在于选择枢纽元.

这里的 partition 就是根据枢纽元,分别将 大于,小于或等于的枢纽元的元素放在列表两边, 分割开.
<a id="markdown-31-partition的实现" name="31-partition的实现"></a>
## 3.1. partition的实现
partition 有不同的实现. 下面列出两种
* 第一种实现

```python
def partition(a,b):
    pivot = lst[a]
    while a!=b:
        while a<b and lst[b]>pivot: b-=1
        if a<b:
            lst[a] = lst[b]
            a+=1
        while a<b and lst[a]<pivot: a+=1
        if a<b:
            lst[b] = lst[a]
            b-=1
    lst[a] = pivot
    return a
```
* 第二种实现

```python
def partition(a,b):
    pivot = lst[b]
    j = a-1
    for i in range(a,b):
        if lst[i]<=pivot:
            j+=1
            if i!=j: lst[i], lst[j] = lst[j], lst[i]
    lst[j+1],lst[b] = lst[b],lst[j+1]
    return j+1
```

第二种是算法导论上的,可以发现,第二种交换赋值的次数比第一种要多,而且如果序列的逆序数较大,第二种一次交换减少的逆序数很少, 而第一种就比较多(交换的两个元素相距较远)
然后我用随机数测试了一下, 确实是第一种较快, 特别是要排序的序列较长时,如在 5000 个元素时, 第一种要比第二种快几倍, Amazing!

完整代码
```python 
def quickSort(lst):
    '''A optimized version of Hoare partition'''
    def partition(a,b):
        pivot = lst[a]
        while a!=b:
            while a<b and lst[b]>pivot: b-=1
            if a<b:
                lst[a] = lst[b]
                a+=1
            while a<b and lst[a]<pivot: a+=1
            if a<b:
                lst[b] = lst[a]
                b-=1
        lst[a] = pivot
        return a
    def  _sort(a,b):
        if a>=b:return 
        mid = (a+b)//2
        # 三数取中值置于第一个作为 pivot
        if (lst[a]<lst[mid]) ^ (lst[b]<lst[mid]): lst[a],lst[mid] = lst[mid],lst[a]  # lst[mid] 为中值
        if (lst[a]<lst[b]) ^ (lst[b]>lst[mid]): lst[a],lst[b] = lst[b],lst[a] # lst[b] 为中值
        i = partition(a,b)
        _sort(a,i-1)
        _sort(i+1,b)
    _sort(0,len(lst)-1)
    return lst
```
<a id="markdown-32-选择枢纽元" name="32-选择枢纽元"></a>
## 3.2. 选择枢纽元
* 端点或中点
* 随机
* 三数取中(两端点以及中点)
* 五数取中


<a id="markdown-33-快速排序的性能" name="33-快速排序的性能"></a>
## 3.3. 快速排序的性能
快速排序性能取决于划分的对称性(即枢纽元的选择), 以及partition 的实现. 如果每次划分很对称(大概在当前序列的中位数为枢纽元), 则与合并算法一样快, 但是如果不对称,在渐近上就和插入算法一样慢
<a id="markdown-331-最坏情况" name="331-最坏情况"></a>
### 3.3.1. 最坏情况
试想,如果每次划分两个区域分别包含 n-1, 1则易知时间复杂度为 ![](https://latex.codecogs.com/gif.latex?\Theta(n^2)), 此外, 如果输入序序列已经排好序,且枢纽元没选好, 比如选的端点, 则同样是这样复杂, 而此时插入排序只需 ![](https://latex.codecogs.com/gif.latex?O(n)).

<a id="markdown-332-最佳情况" name="332-最佳情况"></a>
### 3.3.2. 最佳情况
有 ![](https://latex.codecogs.com/gif.latex?T(n)&space;=&space;2T(\frac{n}{2})+\Theta(n))
则由主方法为![](https://latex.codecogs.com/gif.latex?O(nlogn)) 
<a id="markdown-333-平衡的划分" name="333-平衡的划分"></a>
### 3.3.3. 平衡的划分
如果每次 9:1, ![](https://latex.codecogs.com/gif.latex?T(n)&space;=&space;T(\frac{9n}{10})+T(\frac{n}{10})+\Theta(n))
用递归树求得在渐近上仍然是 ![](https://latex.codecogs.com/gif.latex?O(nlogn))
所以任何比值 k:1, 都有如上的渐近时间复杂度

然而每次划分是不可能完全相同的


<a id="markdown-34-期望运行时间" name="34-期望运行时间"></a>
## 3.4. 期望运行时间
对于 randomized-quicksort, 即随机选择枢纽元
设 n 个元素, 从小到大记为 ![](https://latex.codecogs.com/gif.latex?z_1,z_2,\ldots,z_n),指示器变量 ![](https://latex.codecogs.com/gif.latex?X_{ij})表示 ![](https://latex.codecogs.com/gif.latex?z_i,z_j)是否进行比较
即 
![](https://latex.codecogs.com/gif.latex?&space;X_{ij}&space;=&space;\begin{cases}&space;1,\quad&space;z_i,z_j\text{Making-Comparisons}\\&space;0,\quad&space;z_i,z_j\text{No-comparison}&space;\end{cases}&space;)
考察比较次数, 可以发现两个元素进行比较, 一定是一个是枢纽元的情况, 两个元素间不可能进行两次比较.
所有总的比较次数不超过,![](https://latex.codecogs.com/gif.latex?\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}X_{ij})
求均值

![](https://latex.codecogs.com/gif.latex?E(\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}X_{ij})=\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}E(X_{ij})=\sum_{i=1}^{n-1}\sum_{j=i+1}^{n}P(z_i,z_j\text{Making-Comparisons}))

再分析,![](https://latex.codecogs.com/gif.latex?z_i,z_j) 在![](https://latex.codecogs.com/gif.latex?Z_{ij}&space;=&space;\{z_i,z_{i+1},\ldots,z_j\})中, 如果集合中的非此两元素,![](https://latex.codecogs.com/gif.latex?z_k,&space;i<&space;k<&space;j)作为了枢纽元, 则![](https://latex.codecogs.com/gif.latex?z_k)将集合划分{z_i,z_{i+1},\ldots,z_{k-1}},{z_{k+1},\ldots,z_j}, 这两个集合中的元素都不会再和对方中的元素进行比较, 
所以要使 ![](https://latex.codecogs.com/gif.latex?z_i,z_j)进行比较, 则两者之一(只能是一个,即互斥)是 ![](https://latex.codecogs.com/gif.latex?Z_{ij})上的枢纽元
则

![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;P(z_i,z_j\text{Making-Comparisons})&space;&&space;=&space;P(z_i,z_j\text{As}Z_{ij}\text{Hub-element})&space;\\&space;&&space;=&space;P(z_j\text{As}Z_{ij}\text{Hub-element})+P(z_i\text{As}Z_{ij}\text{Hub-element})\\&space;&&space;=&space;\frac{1}{j-i+1}+\frac{1}{j-i+1}&space;\\&space;&&space;=&space;\frac{2}{j-i+1}\\&space;\end{aligned}&space;)
注意第二步是因为两事件互斥才可以直接概率相加

然后就可以将此概率代入求期望比较次数了,
为 ![](https://latex.codecogs.com/gif.latex?O(nlogn)) (由于是 O, 放缩一下就行)
<a id="markdown-35-堆栈深度" name="35-堆栈深度"></a>
## 3.5. 堆栈深度
考察快速排序的堆栈深度,可以从递归树思考,实际上的堆栈变化过程就是前序访问二叉树, 所以深度为 ![](https://latex.codecogs.com/gif.latex?O(logn))
为了减少深度, 可以进行 尾递归优化, 将函数返回前的递归通过迭代完成
```python
QUICKSORT(A,a,b)
    while a<b:
        #partition and sort left subarray
        pos = partition(a,b)
        QUICKSORT(A,a,pos-1)
        a = pos+1
```
<a id="markdown-36-测试" name="36-测试"></a>
## 3.6. 测试
这是上面三个版本的简单测试结果,
前面测试的是各函数用的时间, 后面打印出来的是体现正确性,用的另外的序列了
![test.jpg](https://upload-images.jianshu.io/upload_images/7130568-236aee14b7b29d7a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



<a id="markdown-4-计数排序countsort" name="4-计数排序countsort"></a>
# 4. 计数排序(countSort)
需要知道元素的取值范围, 而且应该是有限的, 最好范围不大

不过需要额外的存储空间.
<mark>计算排序是稳定的: 具有相同值的元素在输出中是原来的相对顺序.</mark>
```python
def countSort(lst,mn,mx):
    mark = [0]*(mx-mn+1)
    for i in lst:
        mark[i-mn]+=1
    ret =[]
    for n,i in enumerate(mark):
        for j in range(i):
            ret.append(n+mn)
    return ret
```

<a id="markdown-5-基数排序radixsort" name="5-基数排序radixsort"></a>
# 5. 基数排序(radixSort)
<a id="markdown-51-原理" name="51-原理"></a>
## 5.1. 原理
由我们平时的直觉, 我们比较两个数时, 是从最高位比较起, 一位一位比较, 直到不相等时就能判断大小,或者相等(位数比完了).

基数排序有点不一样, 它是从低位比到高位, 这样才能把相同位有相同值的不同数排序.
对于 n 个数, 最高 d 位, 用下面的实现, 可时间复杂度为 ![](https://latex.codecogs.com/gif.latex?\Theta((n+d)*d))

<a id="markdown-52-实现" name="52-实现"></a>
## 5.2. 实现
下面是一个整数版本的基数排序,比较容易实现
```python
def radixSort(lst,radix=10):
    ls = [[] for i in range(radix)]
    mx = max(lst)
    weight =  1
    while mx >= weight:
        for i in lst:
            ls[(i // weight)%radix].append(i)
        weight *= radix
        lst =  sum(ls,[])
        ls = [[] for  i in range(radix)]
    return lst
```
<a id="markdown-53-扩展" name="53-扩展"></a>
## 5.3. 扩展
注意到如果有负数,要使用计数排序或者 基数排序,每个数需要加上最小值的相反数, 再排序, 最后再减去, 如果有浮点数, 就需要先乘以一个数, 使所有数变为整数.
 我想过用 str 得到一个数的各位, 不过 str 可能比较慢. str 的实现应该也是先算术计算, 再生成 str 对象, 对于基数排序, 生成str 对象是多余的.


<a id="markdown-54-测试" name="54-测试"></a>
## 5.4. 测试
下面是 基数排序与快速排序的比较,测试代码
```python
from time import time
from random import randint
def timer(funcs,span,num=1000000):
    lst = [randint(0,span) for i in range(num)]
    print('range({}), {} items'.format(span,num))
    for func in funcs:
        data = lst.copy()
        t = time()
        func(data)
        t = time()-t
        print('{}: {}s'.format(func.__name__,t))

if __name__ == '__main__':
    timer([quickSort,radixSort],1000000000,100000)
    timer([quickSort,radixSort],1000000000000,10000)
    timer([quickSort,radixSort],10000,100000)
```
![radixSort vs quickSort](https://upload-images.jianshu.io/upload_images/7130568-60e532a24fa09883.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-6-桶排序bucketsort" name="6-桶排序bucketsort"></a>
# 6. 桶排序(bucketSort)
适用于均匀分布的序列

设有 n 个元素, 则设立 n 个桶
将各元素通过数值线性映射到桶地址,
类似 hash 链表.
然后在每个桶内, 进行插入排序(![](https://latex.codecogs.com/gif.latex?O(n_i^2)))
最后合并所有桶.
这里的特点是 n 个桶实现了 ![](https://latex.codecogs.com/gif.latex?\Theta(n))的时间复杂度, 但是耗费的空间 为 ![](https://latex.codecogs.com/gif.latex?\Theta(n))

证明
* 线性映射部分: ![](https://latex.codecogs.com/gif.latex?\Theta(n))
* 桶合并部分: ![](https://latex.codecogs.com/gif.latex?\Theta(n))
* 桶内插入排序部分: 设每个桶内的元素数为随机变量 ![](https://latex.codecogs.com/gif.latex?n_i), 易知 ![](https://latex.codecogs.com/gif.latex?n_i&space;\sim&space;B(n,\frac{1}{n})) 记 ![](https://latex.codecogs.com/gif.latex?p=\frac{1}{n})


![](https://latex.codecogs.com/gif.latex?&space;\begin{aligned}&space;E(\sum_{i=1}^{n}n_i^2)&space;&=\sum_{i=1}^{n}E(n_i^2)&space;\\&space;&=\sum_{i=1}^{n}(&space;Var(n_i)+E^2(n_i)&space;)&space;\\&space;&=&space;\sum_{i=1}^{n}(&space;np(1-p)+&space;(np)^2&space;)\\&space;&=&space;\sum_{i=1}^{n}(&space;2-\frac{1}{n}&space;)\\&space;&=&space;2n-1&space;\end{aligned}&space;)
将以上各部分加起来即得时间复杂度 ![](https://latex.codecogs.com/gif.latex?\Theta(n))



<a id="markdown-7-选择问题select" name="7-选择问题select"></a>
# 7. 选择问题(select)
输入个序列 lst, 以及一个数 i, 输出 lst 中 第 i 小的数,即从小到大排列第 i

解决方法
* 全部排序, 取第 i 个, ![](https://latex.codecogs.com/gif.latex?O(nlogn))
* 长度为 i 的队列(这是得到 lst 中 前

i 个元素的方法) 仍然 ![](https://latex.codecogs.com/gif.latex?O(nlogn))
* randomized-select(仿造快排) 平均情况![](https://latex.codecogs.com/gif.latex?O(n)),最坏情况同上(快排), ![](https://latex.codecogs.com/gif.latex?\Theta(n^2))

```python
from random import randint
def select(lst,i):
    lst = lst.copy()
    def partition(a,b):
        pivot = lst[a]
        while a<b:
            while a<b and lst[b]>pivot: b-=1
            if a<b:
                lst[a] = lst[b]
                a+=1
            while a<b and lst[a]<pivot: a+=1
            if a<b:
                lst[b] = lst[a]
                b-=1
        lst[a]= pivot
        return a

    def _select(a,b):
        if a>=b: return lst[a]
        # randomized select
        n = randint(a,b)
        lst[a],lst[n] = lst[n],lst[a]
        pos = partition(a,b)
        if pos>i:
            return _select(a,pos-1)
        elif pos<i:
            return _select(pos+1,b)
        else:return lst[pos]
    return _select(0,len(lst)-1)
```

**[github地址](https://github.com/mbinary/algorithm-in-python.git)**
