''' mbinary
#########################################################################
# File : binaryHeap.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''


from collections import Iterable           
class node:
    def __init__(self,val,freq=1):
        self.val=val
        self.freq = freq
    def __eq__(self,a):
        return self.val == a.val 
    def __lt__(self,a):
        return self.val<a.val
    def __le__(self,a):
        return self.val<=a.val
    def __gt__(self,a):
        return self.val>a.val
    def __ge__(self,a):
        return self.val>=a.val
    def __ne__(self,a):
        return not self == a
class binaryHeap:
    def __init__(self,s=None,sortByFrequency = False,reverse=False):
        self.sortByFrequency=sortByFrequency
        self.reverse = reverse
        self.data = [node(0)]  # make index begin with 1
        if s==None:return 
        if not isinstance(s,Iterable):s = [s]
        for i in s:
            self.insert(i)
    def __bool__(self):
        return len(self)!=1
    def _cmp(self,a,b):
        if self.sortByFrequency:
            if self.reverse:return a.freq>b.freq
            else:return a.freq<b.freq
        else:
            if self.reverse:return a>b
            else:return a<b
    def insert(self,k):
        if not  isinstance(k,node): k = node(k)
        for j in range(self.data[0].val):
            i = self.data[j+1]
            if i==k:
                i.freq+=1
                if self.sortByFrequency:
                    idx = self.percolateDown(j+1)
                    self.percolateUp(idx)
                return 
        self.data.append(k)
        self.data[0].val += 1
        self.percolateUp()
    def percolateUp(self,n=None):
        if n ==None:n=self.data[0].val
        tmp = self.data[n]
        while n!=1 and self._cmp(tmp,self.data[n//2]):
            self.data[n] = self.data[n//2]
            n = n//2
        self.data[n] = tmp
    def deleteTop(self):
        tmp = self.data[1]
        i = self.percolateDown(1)
        self.data[i] = self.data[-1]
        self.data[0].val-= 1
        del self.data[-1]
        return tmp
    def percolateDown(self,i):
        tmp = self.data[i]
        while self.data[0].val>=2*i+1:
                if self._cmp(self.data[i*2],self.data[2*i+1]):
                    self.data[i] = self.data[2*i]
                    i = 2*i
                else:
                    self.data[i] = self.data[2*i+1]
                    i = 2*i+1
        self.data[i] = tmp
        return i
    def __len__(self):
        return self.data[0].val
    def Nth(self,n=1):
        tmp = []
        for i in range(n):
            tmp.append(self.deleteTop())
        for i in tmp:
            self.insert(i)
        return tmp[-1]
    def display(self):
        val =self.data[0].val+1
        if self.sortByFrequency:
            info='heapSort by Frequency:'
        else:info = 'heapSort by Value:'
        if self.reverse:
            info +=' From big to small'
        else:info +=' From small to big'
        print('*'*15)
        print(info)
        print('total items:%d\nval\tfreq'%(val-1))
        fmt = '{}\t{}'
        for i in range(1,val):
            print(fmt.format(self.data[i].val,self.data[i].freq))
        print('*'*15)
class Test:
    def topKFrequent(self, words, k):
        hp = binaryHeap(sortByFrequency = True,reverse=True)
        for i in words:
            hp.insert(i)
        hp.display()
        n = len(hp)
        mp = {}
        while hp:
            top = hp.deleteTop()
            if top.freq in mp:
                mp[top.freq].append(top.val)
            else:
                mp[top.freq] = [top.val]
        for i in mp:
            mp[i].sort()
        key = sorted(mp.keys(),reverse = True)
        rst = []
        count = 0
        for i in key: 
            for j in mp[i]:
                rst.append(j)
                count+=1
                if count == k:return rst
if __name__ == '__main__':
    s=["plpaboutit","jnoqzdute","sfvkdqf","mjc","nkpllqzjzp","foqqenbey","ssnanizsav","nkpllqzjzp","sfvkdqf","isnjmy","pnqsz","hhqpvvt","fvvdtpnzx","jkqonvenhx","cyxwlef","hhqpvvt","fvvdtpnzx","plpaboutit","sfvkdqf","mjc","fvvdtpnzx","bwumsj","foqqenbey","isnjmy","nkpllqzjzp","hhqpvvt","foqqenbey","fvvdtpnzx","bwumsj","hhqpvvt","fvvdtpnzx","jkqonvenhx","jnoqzdute","foqqenbey","jnoqzdute","foqqenbey","hhqpvvt","ssnanizsav","mjc","foqqenbey","bwumsj","ssnanizsav","fvvdtpnzx","nkpllqzjzp","jkqonvenhx","hhqpvvt","mjc","isnjmy","bwumsj","pnqsz","hhqpvvt","nkpllqzjzp","jnoqzdute","pnqsz","nkpllqzjzp","jnoqzdute","foqqenbey","nkpllqzjzp","hhqpvvt","fvvdtpnzx","plpaboutit","jnoqzdute","sfvkdqf","fvvdtpnzx","jkqonvenhx","jnoqzdute","nkpllqzjzp","jnoqzdute","fvvdtpnzx","jkqonvenhx","hhqpvvt","isnjmy","jkqonvenhx","ssnanizsav","jnoqzdute","jkqonvenhx","fvvdtpnzx","hhqpvvt","bwumsj","nkpllqzjzp","bwumsj","jkqonvenhx","jnoqzdute","pnqsz","foqqenbey","sfvkdqf","sfvkdqf"]
    test = Test()
    print(test.topKFrequent(s,5))
