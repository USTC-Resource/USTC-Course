---
title: 『数据结构』红黑树(red-black tree)
date: 2018-07-12  19:58
categories: 数据结构与算法
tags: [数据结构,红黑树]
keywords:  
mathjax: true
description: "红黑树的原理与实现, 包括插入, 删除, 以及数据结构的扩张"
---
<!-- TOC -->

- [1. 定义与性质](#1-定义与性质)
    - [1.1. 数据域](#11-数据域)
    - [1.2. 红黑性质](#12-红黑性质)
    - [1.3. 黑高度](#13-黑高度)
- [2. 旋转](#2-旋转)
- [3. 插入](#3-插入)
    - [3.1. 二叉查找树的插入](#31-二叉查找树的插入)
    - [3.2. 颜色调整与旋转](#32-颜色调整与旋转)
        - [3.2.1. 问题](#321-问题)
        - [3.2.2. 情况](#322-情况)
            - [3.2.2.1. case1:  x 的叔叔是红色的](#3221-case1--x-的叔叔是红色的)
            - [3.2.2.2. case2: x 的叔叔是黑色, x,p(x), p(p(x)),方向为 left-right 或者 right-left](#3222-case2-x-的叔叔是黑色-xpx-ppx方向为-left-right-或者-right-left)
            - [3.2.2.3. case3: x 的叔叔是黑色, x,p(x), p(p(x)),方向为 left-left 或者 right-right](#3223-case3-x-的叔叔是黑色-xpx-ppx方向为-left-left-或者-right-right)
        - [3.2.3. 总体解决方案](#323-总体解决方案)
- [4. 删除](#4-删除)
    - [4.1. 二叉查找树删除结点](#41-二叉查找树删除结点)
    - [4.2. 调整颜色与旋转](#42-调整颜色与旋转)
- [5. 数据结构的扩张](#5-数据结构的扩张)
    - [5.1. 平衡树的扩张](#51-平衡树的扩张)
- [6. python 代码](#6-python-代码)
- [7. 参考](#7-参考)

<!-- /TOC -->


<a id="markdown-1-定义与性质" name="1-定义与性质"></a>
# 1. 定义与性质
红黑树是一种平衡的二叉查找树
<a id="markdown-11-数据域" name="11-数据域"></a>
## 1.1. 数据域
每个结点有 5 个数据域 
* color: red or black
* key: keyword
* left: pointer to left child
* right:pointer to right child
* p: pointer to nil leaf

<a id="markdown-12-红黑性质" name="12-红黑性质"></a>
## 1.2. 红黑性质
满足下面的 `红黑性质` 的二叉查找树就是红黑树:
* 每个结点或是红色或是黑色
* 根是黑
* nil leaf 是 黑
* 红结点的孩子是黑
* 从每个结点出发,通过子孙到达叶子结点的各条路径上 黑结点数相等

如,叶子结点 是 nil, 即不存储任何东西, 为了编程方便,相对的,存有数据的结点称为内结点
![](https://upload-images.jianshu.io/upload_images/7130568-95927d3ca6cc524d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

为了节省空间, 可以如下实现, 只需要一个 nil 结点
![nil leaf](https://upload-images.jianshu.io/upload_images/7130568-f8dbd241fbc55ee5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-13-黑高度" name="13-黑高度"></a>
## 1.3. 黑高度
从某个结点 x 到叶结点的黑色结点数,称为此结点的黑高度, 记为 ![](https://latex.codecogs.com/gif.latex?h_b(x))
树的黑高度是根的黑高度

>1. 以 x 为 根的子树至少包含 ![](https://latex.codecogs.com/gif.latex?2^{h_b(x)}-1)个结点
>2. 一颗有 n 个内结点的红黑树高度至多为![](https://latex.codecogs.com/gif.latex?2lg(n+1))

可用归纳法证明1
证明 2:
设树高 h
由红黑性质4, 根结点到叶子路径上的黑结点数至少 ![](https://latex.codecogs.com/gif.latex?\frac{h}{2}),即 ![](https://latex.codecogs.com/gif.latex?h_b(root)\geqslant&space;\frac{h}{2})
再由1, 
![](https://latex.codecogs.com/gif.latex?n&space;\geqslant&space;2^{h_b(x)}&space;-1&space;\geqslant&space;2^{\frac{h}{2}}&space;-1)

即 ![](https://latex.codecogs.com/gif.latex?h\leqslant&space;2lg(n+1))

<a id="markdown-2-旋转" name="2-旋转"></a>
# 2. 旋转
由于上面证明的红黑树高为 ![](https://latex.codecogs.com/gif.latex?O(logn)),红黑树的 insert, delete, search 等操作都是, ![](https://latex.codecogs.com/gif.latex?O(logn)).
进行了 insert, delete 后可能破坏红黑性质, 可以通过旋转来保持.


下面是对结点 x 进行 左旋与右旋.
注意进行左旋时, 右孩子不是 nil(要用来作为旋转后 x 的双亲), 同理 右旋的结点的左孩子不是nil
![左旋与右旋](https://upload-images.jianshu.io/upload_images/7130568-d31b65b547ff2e7c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
总结起来就是: 父亲旋转,顺时针就是右旋,逆时针就是左旋, 旋转的结果是儿子成为原来父亲的新父亲, 即旋转的结点下降一层, 它的一个儿子上升一层.

<a id="markdown-3-插入" name="3-插入"></a>
# 3. 插入
插入的过程: 
* 先同二叉查找树那样插入, 做为叶子(不为空)
* 然后将新结点的 左右孩子设为 nil , 颜色设为红色
* 最后再进行颜色调整以及旋转(维持红黑性质)

这是算法导论[^1]上的算法
```python
RB-INSERT(T, z)  
 y ← nil[T]                        // 新建节点“y”，将y设为空节点。
 x ← root[T]                       // 设“红黑树T”的根节点为“x”
 while x ≠ nil[T]                  // 找出要插入的节点“z”在二叉树T中的位置“y”
     do y ← x                      
        if key[z] < key[x]  
           then x ← left[x]  
           else x ← right[x]  
 p[z] ← y                          // 设置 “z的父亲” 为 “y”
 if y = nil[T]                     
    then root[T] ← z               // 情况1：若y是空节点，则将z设为根
    else if key[z] < key[y]        
            then left[y] ← z       // 情况2：若“z所包含的值” < “y所包含的值”，则将z设为“y的左孩子”
            else right[y] ← z      // 情况3：(“z所包含的值” >= “y所包含的值”)将z设为“y的右孩子” 
 left[z] ← nil[T]                  // z的左孩子设为空
 right[z] ← nil[T]                 // z的右孩子设为空。至此，已经完成将“节点z插入到二叉树”中了。
 color[z] ← RED                    // 将z着色为“红色”
 RB-INSERT-FIXUP(T, z)             // 通过RB-INSERT-FIXUP对红黑树的节点进行颜色修改以及旋转，让树T仍然是一颗红黑树
```
<a id="markdown-31-二叉查找树的插入" name="31-二叉查找树的插入"></a>
## 3.1. 二叉查找树的插入
可以用python 实现如下
```python
    def insert(self,nd):
        if  not isinstance(nd,node):
            nd = node(nd)
        elif nd.isBlack: nd.isBlack = False

        if self.root is None:
            self.root = nd
            self.root.isBlack = True
        else:
            parent = self.root
            while parent:
                if parent == nd : return None
                if parent>nd:
                    if parent.left :
                        parent = parent.left
                    else:
                        parent.left  = nd
                        break
                else:
                    if parent.right:
                        parent = parent.right
                    else:
                        parent.right = nd
                        break
            self.fixUpInsert(parent,nd)
```
<a id="markdown-32-颜色调整与旋转" name="32-颜色调整与旋转"></a>
## 3.2. 颜色调整与旋转
<a id="markdown-321-问题" name="321-问题"></a>
### 3.2.1. 问题
在插入后,可以发现后破坏的红黑性质只有以下两条(且互斥)

1. root 是红 (这可以直接将root 颜色设为黑调整)
2. 红结点的孩子是黑

所以下面介绍如何保持 红结点的孩子是黑 , 即插入结点的双亲结点是红的情况.

下面记  结点 x 的 双亲为 p(x), 新插入的结点为 x, 记 uncle 结点 为 u(x)

由于 p(x) 是红色,  而根结点是黑色, 所以 p(x)不是根, p(p(x))存在
<a id="markdown-322-情况" name="322-情况"></a>
### 3.2.2. 情况

有如下三种情况

![](https://upload-images.jianshu.io/upload_images/7130568-04e77807cb660277.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

每种情况的解决方案如下

<a id="markdown-3221-case1--x-的叔叔是红色的" name="3221-case1--x-的叔叔是红色的"></a>
#### 3.2.2.1. case1:  x 的叔叔是红色的
这里只需改变颜色, 将 p(x)变为 黑, p(p(x))变为红, u(x) 变为黑色 (x为右孩子同样)
![](https://upload-images.jianshu.io/upload_images/7130568-a884903d8fed7e7b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<a id="markdown-3222-case2-x-的叔叔是黑色-xpx-ppx方向为-left-right-或者-right-left" name="3222-case2-x-的叔叔是黑色-xpx-ppx方向为-left-right-或者-right-left"></a>
#### 3.2.2.2. case2: x 的叔叔是黑色, x,p(x), p(p(x)),方向为 left-right 或者 right-left
即 x,p(x), p(p(x)) 成折线状
<a id="markdown-3223-case3-x-的叔叔是黑色-xpx-ppx方向为-left-left-或者-right-right" name="3223-case3-x-的叔叔是黑色-xpx-ppx方向为-left-left-或者-right-right"></a>
#### 3.2.2.3. case3: x 的叔叔是黑色, x,p(x), p(p(x)),方向为 left-left 或者 right-right
即 x,p(x), p(p(x)) 成直线状

![](https://upload-images.jianshu.io/upload_images/7130568-4b86ce66ddff0e08.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


当 x 为右孩子时, 通过旋转变成p(x) 的双亲, 然后相当于 新插入 p(x)作为左孩子, 再进行转换.

即将新结点的双亲向上一层旋转,颜色变为黑色, 而新节点的祖父向下一层, 颜色变为红色

<a id="markdown-323-总体解决方案" name="323-总体解决方案"></a>
### 3.2.3. 总体解决方案
我最开始也没有弄清楚, 有点绕晕的感觉, 后来仔细读了书上伪代码, 然后才发现就是一个状态机, 画出来就一目了然了.

![](https://upload-images.jianshu.io/upload_images/7130568-53dd71e22a315242.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)






现在算是知其然了, 那么怎样知其所以然呢? 即 为什么要分类这三个 case, 不重不漏了吗?

其实也简单, 只是太繁琐.
就是将各种情况枚举出来, 一一分析即可. 我最开始试过, 但是太多,写在代码里很容易写着写着就混了.
而算法导论上分成这三个case , 很简洁, 只是归纳了一下而已. 如果想看看枚举情况的图与说明,可以参考[^2] .



算法导论上的伪代码
```python
RB-INSERT-FIXUP(T, z)
while color[p[z]] = RED                                                  // 若“当前节点(z)的父节点是红色”，则进行以下处理。
    do if p[z] = left[p[p[z]]]                                           // 若“z的父节点”是“z的祖父节点的左孩子”，则进行以下处理。
          then y ← right[p[p[z]]]                                        // 将y设置为“z的叔叔节点(z的祖父节点的右孩子)”
               if color[y] = RED                                         // Case 1条件：叔叔是红色
                  then color[p[z]] ← BLACK                    ▹ Case 1   //  (01) 将“父节点”设为黑色。
                       color[y] ← BLACK                       ▹ Case 1   //  (02) 将“叔叔节点”设为黑色。
                       color[p[p[z]]] ← RED                   ▹ Case 1   //  (03) 将“祖父节点”设为“红色”。
                       z ← p[p[z]]                            ▹ Case 1   //  (04) 将“祖父节点”设为“当前节点”(红色节点)
                  else if z = right[p[z]]                                // Case 2条件：叔叔是黑色，且当前节点是右孩子
                          then z ← p[z]                       ▹ Case 2   //  (01) 将“父节点”作为“新的当前节点”。
                               LEFT-ROTATE(T, z)              ▹ Case 2   //  (02) 以“新的当前节点”为支点进行左旋。
                          color[p[z]] ← BLACK                 ▹ Case 3   // Case 3条件：叔叔是黑色，且当前节点是左孩子。(01) 将“父节点”设为“黑色”。
                          color[p[p[z]]] ← RED                ▹ Case 3   //  (02) 将“祖父节点”设为“红色”。
                          RIGHT-ROTATE(T, p[p[z]])            ▹ Case 3   //  (03) 以“祖父节点”为支点进行右旋。
       else (same as then clause with "right" and "left" exchanged)      // 若“z的父节点”是“z的祖父节点的右孩子”，将上面的操作中“right”和“left”交换位置，然后依次执行。
color[root[T]] ← BLACK
```
我用python 实现如下. 由于左右方向不同, 如果向上面伪代码那样实现, fixup 代码就会有两份类似的(即 right left 互换),  为了减少代码冗余, 我就定义了 `setChild`, `getChild` 函数, 传递左或是右孩子这个方向的数据(代码中是isLeft), 所以下面的就是完整功能的 fixup, 可以减少一般的代码量, haha😄,
(下文 删除结点同理)

其实阅读代码也简单, 可以直接当成 isLeft 取真值.
```python
    def fixUpInsert(self,parent,nd):
        ''' adjust color and level,  there are two red nodes: the new one and its parent'''
        while not self.checkBlack(parent):
            grand = self.getParent(parent)
            isLeftPrt = grand.left is parent 
            uncle = grand.getChild(not isLeftPrt)
            if not self.checkBlack(uncle):
                # case 1:  new node's uncle is red
                self.setBlack(grand, False)
                self.setBlack(grand.left, True)
                self.setBlack(grand.right, True)
                nd = grand
                parent = self.getParent(nd)
            else:
                # case 2: new node's uncle is black(including nil leaf)
                isLeftNode = parent.left is nd
                if isLeftNode ^ isLeftPrt:
                    # case 2.1 the new node is inserted in left-right or right-left form
                    #         grand               grand
                    #     parent        or            parent
                    #          nd                   nd
                    parent.setChild(nd.getChild(isLeftPrt),not isLeftPrt)
                    nd.setChild(parent,isLeftPrt)
                    grand.setChild(nd,isLeftPrt)
                    nd,parent = parent,nd
                # case 2.2 the new node is inserted in left-left or right-right form
                #         grand               grand
                #      parent        or            parent
                #     nd                                nd
                grand.setChild(parent.getChild(not isLeftPrt),isLeftPrt)
                parent.setChild(grand,not isLeftPrt)
                self.setBlack(grand, False)
                self.setBlack(parent, True)
                self.transferParent(grand,parent)
        self.setBlack(self.root,True)
```


<a id="markdown-4-删除" name="4-删除"></a>
# 4. 删除


算法导论上的算法

写的很简练👍
![rb-delete](https://upload-images.jianshu.io/upload_images/7130568-688842ec88c4a598.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<a id="markdown-41-二叉查找树删除结点" name="41-二叉查找树删除结点"></a>
## 4.1. 二叉查找树删除结点
下面  z 是要删除的结点,  y 是 其后继或者是它自己, x 是 y 的一个孩子(如果 y 的孩子为 nil,则为 nli, 否则 y 只有一个非 nil 孩子, 为 x)   

* 当 z 孩子全是 nil (y==z): 直接让其双亲对应的孩子为 nil
* 当 z 只有一个非 nil 孩子 x  (y==z): 
    1. 如果 z 为根, 则让 x 为根.   
    2. 让 y 的双亲连接到 x
* 当 z 有两个非nil孩子(y!=z): 复制其后继 y 的内容到 z (除了指针,颜色) ,  将其后继 y 的孩子(最多只有一个 非 nil ,不然就不是后继了)连接到其后继的双亲, 删除 其后继y, 

即[^3]  如果要删除有两个孩子的结点 z , 则找到它的后继y(前趋同理), 可以推断 y 一定没有左孩子, 右孩子可能有,可能没有. 也就是最多一个孩子.
所以将 y 的值复制到 x 位置, 现在相当于删除 y 处的结点.
这样就化为 删除的结点最多一个孩子的情况.


![](http://upload-images.jianshu.io/upload_images/7130568-87ab28beaec30567?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<a id="markdown-42-调整颜色与旋转" name="42-调整颜色与旋转"></a>
## 4.2. 调整颜色与旋转
 可以发现只有当 y 是黑色,才进行颜色调整以及旋转(维持红黑性质), 因为如果删除的是红色, 不会影响黑高度, 所有红黑性质都不会破坏
伪代码如下, (我的python代码见文末)
![](https://upload-images.jianshu.io/upload_images/7130568-ed40ae4776709377.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果被删除的结点 y 是黑色的, 有三种破坏红黑性质的情况
1. y是根, 则 y 的一个红色孩子成为新根
2. 进行删除结点过程中, p(y) 的孩子有 x, 两者都是红色
3. 删除 y 导致包含y 的路径上的黑结点 少 1个

修复3的思路:
如果可能,在兄弟一支,通过旋转,改变颜色修复
否则, 将红结点一直向上推(因为当前路径上少了一个黑结点,向上推的过程中使红结点所在的子树都少一个黑结点), 直到到达树根, 那么全部路径都少一个黑结点, 3就修复了, 这时只需将根设为黑就修复了  1

代码中的 while 循环的目的是将额外的黑色沿树上移,直到
* x 指向一个红黑结点
* x 指向根,这时可以简单地消除额外的黑色
* 颜色修改与旋转

在 while 中, x 总是指向具有双重黑色的那个非根结点, 在第 2 行中要判断 x 是其双亲的左右孩子
w 表示 x 的相抵. w 不能为 nil(因为 x 是双重黑色)

算法中的四种情况如图所示
![](https://upload-images.jianshu.io/upload_images/7130568-f367bcb131c9719b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

即
* x 的兄弟 w 是红色的
![](https://upload-images.jianshu.io/upload_images/7130568-cd139202bdc5406f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
* x 的兄弟 w 是黑色的, w的两个孩子都是黑色的

* x 的兄弟 w 是黑色的, w 的左孩子是红,右孩子是黑
* x 的兄弟 w 是黑色的, w 的孩子是红色的

>>注意上面都是先考虑的左边, 右边可以对称地处理.

同插入一样, 为了便于理解, 可以作出状态机.
而且这些情形都是归纳化简了的, 你也可以枚举列出基本的全部情形.

![](https://upload-images.jianshu.io/upload_images/7130568-005e2a7d55860559.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<a id="markdown-5-数据结构的扩张" name="5-数据结构的扩张"></a>
# 5. 数据结构的扩张
<a id="markdown-51-平衡树的扩张" name="51-平衡树的扩张"></a>
## 5.1. 平衡树的扩张
通过在平衡树(如红黑树上的每个结点 加上 一个数据域 size (表示以此结点为根的子树的结点数.) 可以使`获得第 i 大的数` 的时间复杂度为 ![](https://latex.codecogs.com/gif.latex?O(logn))

在 ![](https://latex.codecogs.com/gif.latex?O(n)) 时间内建立, python代码如下
```python
def setSize(root):
    if root is None:return 0
    root.size = setSize(root.left) + setSize(root.right)+1
```
在![](https://latex.codecogs.com/gif.latex?O(logn))时间查找,
```python
def find(root,i):
    r =  root.left.size +1
    if r==i:
        return root
    if r > i:
        return find(root.left,i)
    else:
        return find(root.right,i-r)
```



<a id="markdown-6-python-代码" name="6-python-代码"></a>
# 6. python 代码

**[github地址](https://github.com/mbinary/algorithm-in-python.git)**

我用了 setChild, getChild 来简化代码量, 其他的基本上是按照算法导论上的伪代码提到的case 来实现的. 然后display 只是测试的时候,为了方便调试而层序遍历打印出来

效果如下
![](https://upload-images.jianshu.io/upload_images/7130568-721e18cc44dec604.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```python
''' mbinary
#########################################################################
# File : redBlackTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.github.io
# Github: https://github.com/mbinary
# Created Time: 2018-07-14  16:15
# Description:
#########################################################################
'''
from functools import total_ordering
from random import randint, shuffle

@total_ordering
class node:
    def __init__(self,val,left=None,right=None,isBlack=False):
        self.val =val
        self.left = left
        self.right = right
        self.parent= None
        self.isBlack  = isBlack
    def __lt__(self,nd):
        return self.val < nd.val
    def __eq__(self,nd):
        return nd is not None and self.val == nd.val
    def setChild(self,nd,isLeft):
        if isLeft: self.left = nd
        else: self.right = nd
        if nd is not None: nd.parent = self

    def getChild(self,isLeft):
        if isLeft: return self.left
        else: return self.right
    def __bool__(self):
        return self.val is not None
    def __str__(self):
        color = 'B' if self.isBlack else 'R'
        val = '-' if self.parent==None else self.parent.val
        return f'{color}-{self.val}'
    def __repr__(self):
        return f'node({self.val},isBlack={self.isBlack})'
class redBlackTree:
    def __init__(self,unique=False):
        '''if unique is True, all node'vals are unique, else there may be equal vals'''
        self.root = None
        self.unique = unique

    @staticmethod
    def checkBlack(nd):
        return nd is None or nd.isBlack
    @staticmethod
    def setBlack(nd,isBlack):
        if nd is not None:
            if isBlack is None or isBlack:
                nd.isBlack = True
            else:nd.isBlack = False
    def setRoot(self,nd):
        if nd is not None: nd.parent=None
        self.root= nd
    def find(self,val):
        nd = self.root
        while nd:
            if nd.val ==val:
                return nd
            else:
                nd = nd.getChild(nd.val>val)
    def getSuccessor(self,nd):
        if nd:
            if nd.right:
                nd = nd.right
                while nd.left:
                    nd = nd.left
                return nd
            else:
                while nd.parent is not None and nd.parent.right is nd:
                    nd = nd.parent
                return None if nd is self.root else nd.parent
    def rotate(self,prt,chd):
        '''rotate prt with the center of chd'''
        if self.root is prt:
            self.setRoot(chd)
        else:
            prt.parent.setChild(chd, prt.parent.left is prt)
        isLeftChd = prt.left is chd
        prt.setChild(chd.getChild(not isLeftChd), isLeftChd)
        chd.setChild(prt,not isLeftChd)

    def insert(self,nd):
        if nd.isBlack: nd.isBlack = False

        if self.root is None:
            self.setRoot(nd)
            self.root.isBlack = True
        else:
            parent = self.root
            while parent:
                if parent == nd : return None
                isLeft = parent > nd
                chd  = parent.getChild(isLeft)
                if chd is None:
                    parent.setChild(nd,isLeft)
                    break
                else:
                    parent = chd
            self.fixUpInsert(parent,nd)
    def fixUpInsert(self,parent,nd):
        ''' adjust color and level,  there are two red nodes: the new one and its parent'''
        while not self.checkBlack(parent):
            grand = parent.parent
            isLeftPrt = grand.left is parent
            uncle = grand.getChild(not isLeftPrt)
            if not self.checkBlack(uncle):
                # case 1:  new node's uncle is red
                self.setBlack(grand, False)
                self.setBlack(grand.left, True)
                self.setBlack(grand.right, True)
                nd = grand
                parent = nd.parent
            else:
                # case 2: new node's uncle is black(including nil leaf)
                isLeftNode = parent.left is nd
                if isLeftNode ^ isLeftPrt:
                    # case 2.1 the new node is inserted in left-right or right-left form
                    #         grand               grand
                    #     parent        or            parent
                    #          nd                   nd
                    self.rotate(parent,nd)    #parent rotate
                    nd,parent = parent,nd
                # case 3  (case 2.2) the new node is inserted in left-left or right-right form
                #         grand               grand
                #      parent        or            parent
                #     nd                                nd

                self.setBlack(grand, False)
                self.setBlack(parent, True)
                self.rotate(grand,parent)
        self.setBlack(self.root,True)

    def copyNode(self,src,des):
        '''when deleting a node which has two kids,
            copy its succesor's data to his position
            data exclude left, right , isBlack
        '''
        des.val = src.val
    def delete(self,val):
        '''delete node in a binary search tree'''
        if isinstance(val,node): val = val.val
        nd = self.find(val)
        if nd is None: return
        self._delete(nd)
    def _delete(self,nd):
        y = None
        if nd.left and nd.right:
            y= self.getSuccessor(nd)
        else:
            y = nd
        py = y.parent
        x = y.left if y.left else y.right
        if py is None:
            self.setRoot(x)
        else:
            py.setChild(x,py.left is y)
        if y != nd:
            self.copyNode(y,nd)
        if self.checkBlack(y): self.fixUpDel(py,x)

    def fixUpDel(self,prt,chd):
        ''' adjust colors and rotate '''
        while self.root != chd and self.checkBlack(chd):
            isLeft =prt.left is chd
            brother = prt.getChild(not isLeft)
            # brother is black
            lb = self.checkBlack(brother.getChild(isLeft))
            rb = self.checkBlack(brother.getChild(not isLeft))
            if  not self.checkBlack(brother):
                # case 1: brother is red.   converted to  case 2,3,4

                self.setBlack(prt,False)
                self.setBlack(brother,True)
                self.rotate(prt,brother)

            elif lb and rb:
                # case 2: brother is black and two kids are black.
                # conveted to the begin case
                self.setBlack(brother,False)
                chd = prt
                prt= chd.parent
            else:
                if  rb:
                    # case 3: brother is black and left kid is red and right child is black
                    # rotate bro to make g w wl wr in one line
                    # uncle's son is nephew, and niece for uncle's daughter
                    nephew = brother.getChild(isLeft)
                    self.setBlack(nephew,True)
                    self.setBlack(brother,False)

                    # brother (not isLeft) rotate
                    self.rotate(brother,nephew)
                    brother = nephew

                # case 4: brother is black and right child is red
                brother.isBlack = prt.isBlack
                self.setBlack(prt,True)
                self.setBlack(brother.getChild(not isLeft),True)

                self.rotate(prt,brother)
                chd = self.root
        self.setBlack(chd,True)

    def sort(self,reverse = False):
        ''' return a generator of sorted data'''
        def inOrder(root):
            if root is None:return
            if reverse:
                yield from inOrder(root.right)
            else:
                yield from inOrder(root.left)
            yield root
            if reverse:
                yield from inOrder(root.left)
            else:
                yield from inOrder(root.right)
        yield from inOrder(self.root)

    def display(self):
        def getHeight(nd):
            if nd is None:return 0
            return max(getHeight(nd.left),getHeight(nd.right)) +1
        def levelVisit(root):
            from collections import deque
            lst = deque([root])
            level = []
            h = getHeight(root)
            ct = lv = 0
            while 1:
                ct+=1
                nd = lst.popleft()
                if ct >= 2**lv:
                    lv+=1
                    if lv>h:break
                    level.append([])
                level[-1].append(str(nd))
                if nd is not None:
                    lst += [nd.left,nd.right]
                else:
                    lst +=[None,None]
            return level
        def addBlank(lines):
            width = 1+len(str(self.root))
            sep = ' '*width
            n = len(lines)
            for i,oneline in enumerate(lines):
                k  = 2**(n-i) -1
                new = [sep*((k-1)//2)]
                for s in oneline:
                    new.append(s.ljust(width))
                    new.append(sep*k)
                lines[i] = new
            return lines

        lines = levelVisit(self.root)
        lines = addBlank(lines)
        li = [''.join(line) for line in lines]
        length = 10 if li==[] else max(len(i) for i in li)//2
        begin ='\n'+ 'red-black-tree'.rjust(length+14,'-')  + '-'*(length)
        end = '-'*(length*2+14)+'\n'
        return  '\n'.join([begin,*li,end])
    def __str__(self):
        return self.display()


```
测试代码
```python

def genNum(n =10):
    nums =[]
    for i in range(n):
        while 1:
            d = randint(0,100)
            if d not in nums:
                nums.append(d)
                break
    return nums

def buildTree(n=10,nums=None,visitor=None):
    if nums is None or nums ==[]: nums = genNum(n)
    rbtree = redBlackTree()
    print(f'build a red-black tree using {nums}')
    for i in nums:
        rbtree.insert(node(i))
        if visitor:
            visitor(rbtree,i)
    return rbtree,nums
def testInsert(nums=None):
    def visitor(t,val):
        print('inserting', val)
        print(t)
    rbtree,nums = buildTree(visitor = visitor,nums=nums)
    print('-'*5+ 'in-order visit' + '-'*5)
    for i,j in enumerate(rbtree.sort()):
        print(f'{i+1}: {j}')

def testSuc(nums=None):
    rbtree,nums = buildTree(nums=nums)
    for i in rbtree.sort():
        print(f'{i}\'s suc is {rbtree.getSuccessor(i)}')

def testDelete(nums=None):
    rbtree,nums = buildTree(nums = nums)
    print(rbtree)
    for i in sorted(nums):
        print(f'deleting {i}')
        rbtree.delete(i)
        print(rbtree)

if __name__=='__main__':
    lst =[45, 30, 64, 36, 95, 38, 76, 34, 50, 1]
    lst = [0,3,5,6,26,25,8,19,15,16,17]
    #testSuc(lst)
    #testInsert(lst)
    testDelete()
```

**下面是利用红黑树进行扩展成区间树的代码**

```python
from redBlackTree import redBlackTree

from functools import total_ordering

@total_ordering
class node:
    def __init__(self,low,high,left=None,right=None,isBlack=False):
        self.val =  low   # self.val is the low
        self.high = high
        self.max = high
        self.left = left
        self.right = right
        self.parent=None
        self.isBlack = isBlack
    def __lt__(self,nd):
        return self.val < nd.val
    def __eq__(self,nd):
        return nd is not None and self.val == nd.val
    def setChild(self,nd,isLeft = True):
        if isLeft: self.left = nd
        else: self.right = nd
        if nd is not None: nd.parent = self
    def getChild(self,isLeft):
        if isLeft: return self.left
        else: return self.right
    def __bool__(self):
        return self.val is not None
    def __str__(self):
        color = 'B' if self.isBlack else 'R'
        return f'{color}[{self.val},{self.high}]-{self.max}'
    def __repr__(self):
        return f'intervalNode({self.val},{self.high},{self.max},isBlack={self.isBlack})'
    def overlap(self,low,high):
        return self.val<=high and self.high>=low
    def setMax(self):
        l = 0 if self.left is None else self.left.max
        r = 0 if self.right is None else self.right.max
        self.max = max(self.high, l, r)
        return self.max

class intervalTree(redBlackTree):
    def search(self,low,high):
        nd = self.root
        while nd is not None and not nd.overlap(low,high):
            if nd.left is not None and nd.left.max>=low:
                nd = nd.left
            else:nd = nd.right
        return nd
    def insert(self,nd):
        super(intervalTree,self).insert(nd)
        while nd is not None:
            nd.setMax()
            nd = nd.parent
    def delete(self,val):
        nd = self.find(val)
        if nd is not None:
            nd.max = 0
            tmp = nd.parent
            while tmp is not None:
                tmp.setMax()
                tmp = tmp.parent
            super(intervalTree,self).delete(val)
    def rotate(self,prt,chd):
        '''rotate prt, and return new prt, namyly the original chd'''
        super(intervalTree,self).rotate(prt,chd)
        prt.setMax()
        chd.setMax()
    def copyNode(self,src,des):
        des.val = src.val
        des.high = src.high
        des.setMax()



from random import randint, shuffle
def genNum(n =10,upper=10):
    nums ={}
    for i in range(n):
        while 1:
            d = randint(0,100)
            if d not in nums:
                nums[d] = (d,randint(d,d+upper))
                break
    return nums.values()

def buildTree(n=10,nums=None,visitor=None):
    #if nums is None or nums ==[]: nums = genNum(n)
    tree = intervalTree()
    print(f'build a red-black tree using {nums}')
    for i in nums:
        tree.insert(node(*i))
        if visitor:
            visitor(tree,i)
    return tree,nums
def testInsert(nums=None):
    def visitor(t,val):
        print('inserting', val)
        print(t)
    tree,nums = buildTree(visitor = visitor,nums=nums)
    print('-'*5+ 'in-order visit' + '-'*5)
    for i,j in enumerate(tree.sort()):
        print(f'{i+1}: {j}')
    return tree

def testSuc(nums=None):
    tree,nums = buildTree(nums=nums)
    for i in tree.sort():
        print(f'{i}\'s suc is {tree.getSuccessor(i)}')

def testDelete(nums=None):
    tree,nums = buildTree(nums = nums)
    print(tree)
    for i in nums:
        print(f'deleting {i}')
        tree.delete(i[0])
        print(tree)
    return tree

if __name__=='__main__':
    lst = [(0,3),(5,8),(6,10),(26,26),(25,30),(8,9),(19,20),(15,23),(16,21),(17,19)]
    #lst = None
    #testSuc(lst)
    tree = testInsert(lst)
    #tree,_= buildTree(lst)
    while 1:
        a =int( input('low:'))
        b =int( input('high:'))
        res = tree.search(a,b)
        print(res)from redBlackTree import redBlackTree

```

<a id="markdown-7-参考" name="7-参考"></a>
# 7. 参考
[^1]: 算法导论

[^2]: https://www.jianshu.com/p/a5514510f5b9?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
[^3]: https://www.jianshu.com/p/0b68b992f688?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
