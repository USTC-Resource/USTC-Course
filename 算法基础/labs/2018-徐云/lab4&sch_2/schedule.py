'''
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
        return self.sum<r.sum
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
            if best>cost:
                best= cost
                rst = [st.tolist() for st in lsts]
        else:
            for cur in set(lsts): # 每次机器时间相同的机器是等同的, 可以剪枝
                if best>cur.sum+works[i]: # 初解 剪枝,  剪去很多
                    cur.append(works[i])
                    backtrackSearch(i+1,lsts)
                    cur.pop()
    def findInitial(i,lst):
        '''利用贪心算法寻找初解, 贪心策略: 每次添加一个任务到 当前机器时间最小的机器'''
        nonlocal best
        if i==n:
            cost = max(lst)
            if best>cost:best = cost
        else:
            mn = lst[0]
            idx = 0
            visited=set()
            for j,cur in enumerate(lst):
                if cur not in visited:
                    visited.add(cur)
                    if mn>cur:
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
