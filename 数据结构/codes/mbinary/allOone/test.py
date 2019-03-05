''' mbinary
#########################################################################
# File : testAllOne.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:07
# Description:
#########################################################################
'''

from allOone import AllOne
from time import time
from  random import choice,sample,randint

class hashMap:
    def __init__(self):
        self.op = {"inc":self.inc,"dec":self.dec,"getMaxKey":self.getMaxKey,"getMinKey":self.getMinKey}
        self.mp={'':0}
    def inc(self,key,n=1):
        if key in self.mp:self.mp[key]+=n
        else:self.mp[key]=n
    def dec(self,key,n=1):
        if key not in self.mp:return
        if self.mp[key]<=n:del self.mp[key]
        else: self.mp[key]-=n
    def getMinKey(self):
        return min(list(self.mp.keys()),key=lambda key:self.mp[key])
    def getMaxKey(self):
        return max(list(self.mp.keys()),key=lambda key:self.mp[key])


op_origin = ['inc','dec','getMinKey','getMaxKey']#'getMinKey','getMaxKey','getMinKey','getMaxKey','getMinKey','getMaxKey','getMinKey','getMaxKey']
ch=list('qwertyuiopasdfghjklzxcvbnm')
keys =[ ''.join(sample(ch,i)) for j in range(10) for i in range(1,20,5)]

def testCase(n=1000):
    ops=[]
    data=[]
    for i in range(n):
        p = randint(0,len(op_origin)-1)
        ops.append(op_origin[p])
        if p<2:
            data.append([randint(1,5)])
        else:data.append([])
    return ops,data

def test(repeat=100):
    t1,t2=0,0
    for i in range(repeat):
        allOne = AllOne()
        hsmp = hashMap()
        ops,data = testCase()
        t1-=time()
        for op,datum in zip(ops,data):
            allOne.op[op](*datum)
        t1+=time()

        t2-=time()
        for op,datum in zip(ops,data):
            hsmp.op[op](*datum)
        t2+=time()
    return t1,t2


if __name__=='__main__':
    t1,t2= test()
    print(f'allOone: {t1}')
    print(f'hashmap: {t2}')
