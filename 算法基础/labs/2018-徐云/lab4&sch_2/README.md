
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <title> 中国科学技术大学课程资源</title>
</head>
# 中国科学技术大学课程资源

<div>
  <h2>
    <a href="../index.html">&nbsp;&nbsp;<i class="fas fa-backward"></i>&nbsp;</a>
    :/<a href="../../../../index.html"><i class="fas fa-home"></i></a>/<a href="../../../index.html">算法基础</a>/<a href="../../index.html">labs</a>/<a href="../index.html">2018-徐云</a>/<a href="index.html">lab4&sch_2</a>
  </h2>
</div>

## 说明
- 列表根据拼音排序
- 点击 Files 的链接下载二进制文件
- 或者打开文本文件(markdown 文件经过渲染)

<h2> Directories &nbsp; <a href="https://download-directory.github.io/?url=https://github.com/USTC-Resource/USTC-Course/tree/master/算法基础/labs/2018-徐云/lab4&sch_2" style="color:red;text-decoration:underline;" target="_black"><i class="fas fa-download"></i></a></h2>

<ul><li><i class="fas fa-meh"></i>&nbsp;None</li></ul>

## Files
<ul><li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/算法基础/labs/2018-徐云/lab4&sch_2/schedule.py"><i class="fas fa-file-code"></i>&nbsp;schedule.py---(3.29K)</a></li>
<li><a href="https://raw.githubusercontent.com/USTC-Resource/USTC-Course/master/算法基础/labs/2018-徐云/lab4&sch_2/work_dispatch.py"><i class="fas fa-file-code"></i>&nbsp;work_dispatch.py---(1.09K)</a></li></ul>

---
<div style="text-decration:underline;display:inline">
  <a href="https://github.com/USTC-Resource/USTC-Course.git" target="_blank" rel="external"><i class="fab fa-github"></i>&nbsp; GitHub</a>
  <a href="mailto:&#122;huheqin1@gmail.com?subject=反馈与建议" style="float:right" target="_blank" rel="external"><i class="fas fa-envelope"></i>&nbsp; Feedback</a>
</div>
---

<h1 style="color:red;text-align:center;">Read Me</h1>

<h2 id="lab1">lab1</h2>
<pre class="codehilite"><code class="language-python">#设有n件工作要分配给n个人去完成，将工作i分配给第j个人所需费用为 。试设计一个算法，为每个人分配1件不同的工作，并使总费 用达到最小。

def dispatch(mat):
    '''mat: matrix of c_ij'''
    def _util(i,arrange,cost):
        ''' for i-th  work'''
        nonlocal total,used,rst
        if i==n:
            total=cost
            rst = arrange.copy() # copy is needed
        else:
            for j in range(n):
                if not used[j] and( total is None or cost+mat[i][j]&lt;total):
                    used[j]=True
                    arrange[i] = j
                    _util(i+1,arrange,cost+mat[i][j])
                    used[j]=False
    total = None
    rst = None
    n = len(mat)
    used = [False for i in range(n)]
    _util(0,[-1]*n,0)
    return total,rst

import random

def test_dispatch(n=10):
    mat = [[random.randint(1,100) for i in range(n)] for i in range(n)]
    print('work matrix: c_ij: work_i and person_j')
    for i in range(n):
        print(mat[i])
    print('result: ',end='')
    print(dispatch(mat))
test_dispatch()    

'''result
work matrix: c_ij: work_i and person_j
[89, 77, 97, 33, 97, 73, 73, 21, 10, 83]
[49, 68, 23, 35, 94, 88, 18, 17, 65, 75]
[38, 76, 68, 13, 94, 22, 19, 49, 35, 71]
[35, 78, 96, 88, 17, 61, 4, 19, 91, 93]
[84, 79, 91, 35, 65, 77, 6, 47, 83, 61]
[57, 14, 33, 100, 1, 100, 42, 83, 94, 51]
[100, 10, 46, 48, 72, 42, 15, 75, 23, 85]
[41, 4, 93, 86, 7, 50, 98, 38, 29, 6]
[7, 51, 59, 69, 65, 48, 27, 69, 91, 23]
[82, 53, 58, 80, 83, 19, 38, 78, 83, 77]
result: (114, [8, 2, 3, 7, 6, 4, 1, 9, 0, 5])
'''
</code></pre>

<h2 id="lab2">lab2</h2>
<pre class="codehilite"><code class="language-python">'''
设有n个任务由k个可并行工作的机器来完成，完成任务i需要时间为 。试设计一个算法找出完成这n个任务的最佳调度，使完成全部任务的时间最早。
'''
from time import time
from functools import total_ordering
@total_ordering
class record:
    def __init__(self,nums=None):
        if nums is None:
            nums=[]
        self.nums=nums
        self.sum = sum(nums)
    def append(self,x):
        self.nums.append(x)
        self.sum+=x
    def pop(self):
        x = self.nums.pop()
        self.sum-=x
        return x
    def __repr__(self):
        return repr(self.nums)
    def __lt__(self,r):
        return self.sum&lt;r.sum
    def __eq__(self,r):
        return self.sum==r.sum
    def tolist(self):
        return self.nums.copy()
    def __hash__(self):
        return self.sum
def schedule(works,k):
    def backtrackSearch(i,lsts):
        nonlocal best,rst
        if i==n:
            cost = max(r.sum for r in lsts )
            if best&gt;cost:
                best= cost
                rst = [st.tolist() for st in lsts]
        else:
            for cur in set(lsts):
                if best&gt;cur.sum+works[i]:
                    cur.append(works[i])
                    backtrackSearch(i+1,lsts)
                    cur.pop()
    def findInitial(i,lst):
        nonlocal best
        if i==n:
            cost = max(lst)
            if best&gt;cost:best = cost
        else:
            mn = lst[0]
            idx = 0
            visited=set()
            for j,cur in enumerate(lst):
                if cur not in visited:
                    visited.add(cur)
                    if mn&gt;cur:
                        mn = cur
                        idx = j
            lst[idx]+=works[i]
            findInitial(i+1,lst)
            lst[idx]-=works[i]


    n = len(works)
    print()
    print('machine Num:',k)
    print('works      :',works)
    rst =  None
    works.sort(reverse=True) # key step
    best = sum(works[:n-k+1])
    t = time()
    findInitial(0,[0]*k) # key step
    t1 = time()-t
    print('init  solution: {}    cost time {:.6f}s'.format(best,t1))
    t = time()
    backtrackSearch(0,[record() for i in range(k)])
    t2 = time()-t
    print('final solution: {}    cost time {:.6f}s'.format(best,t2))
    print('schedule  plan:',rst)
    return best,rst

if __name__=='__main__':
    from random import randint
    schedule([47,20,28,44,21,45,30,39,28,33],3)
    schedule([98,84,50,23,32,99,22,76,72,61,81,39,76,54,37],5)
    schedule([39,39,23,45,100,69,21,81,39,55,20,86,34,53,58,99,36,45,46],8)

'''
machine Num: 19
works       : [39, 39, 23, 45, 100, 69, 21, 81, 39, 55, 20, 86, 34, 53, 58, 99, 36, 45, 46]

works  经过逆序排序
init  solution: 135    cost time 0.000196s
final solution: 126    cost time 0.022922s
schedule  plan: [[100, 21], [99, 23], [86, 39], [81, 45], [69, 53], [58, 45, 20], [55, 36, 34], [46, 39, 39]]

works 没有经过排序
init  solution: 168    cost time 0.000179s
final solution: 126    cost time 10.646307s
schedule  plan: [[39, 86], [39, 34, 53], [23, 99], [45, 39, 36], [100, 20], [69, 55], [21, 58, 46], [81, 45]]
'''
</code></pre>
