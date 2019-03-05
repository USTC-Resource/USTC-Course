''' mbinary
#########################################################################
# File : leftHeap.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''

from functools import total_ordering
@total_ordering

class node:
    def __init__(self,val,freq=1,s=1,left=None,right=None):
        self.val=val
        self.freq=freq
        self.s=s
        if left is None or right is None:
            self.left = left if left is not None else right
            self.right =None
        else:
            if left.s<right.s:
                left,right =right, left
            self.left=left
            self.right=right
            self.s+=self.right.s
    def __eq__(self,nd):
        return self.val==nd.val
    def __lt__(self,nd):
        return self.val<nd.val
    def __repr__(self):
        return 'node(val=%d,freq=%d,s=%d)'%(self.val,self.freq,self.s)

class leftHeap:
    def __init__(self,root=None):
        self.root=root
    def __bool__(self):
        return self.root is not None
    @staticmethod
    def _merge(root,t):  #-> int
        if root is None:return t
        if t is None:return root
        if root<t:
            root,t=t,root
        root.right = leftHeap._merge(root.right,t)
        if root.left is None or root.right is None:
            root.s=1
            if root.left is None:
                root.left,root.right = root.right,None
        else:
            if root.left.s<root.right.s:
                root.left,root.right = root.right,root.left
            root.s = root.right.s+1
        return root
    def insert(self,nd):
        if not isinstance(nd,node):nd = node(nd)
        if self.root is None:
            self.root=nd
            return
        if self.root==nd:
            self.root.freq+=1
            return
        prt =self. _findPrt(self.root,nd,None)
        if prt is None:
            self.root=leftHeap._merge(self.root,nd)
        else :
            if prt.left==nd:
                prt.left.freq+=1
            else:prt.right.freq+=1
    def remove(self,nd):
        if not isinstance(nd,node):nd = node(nd)
        if self.root==nd:
            self.root=leftHeap._merge(self.root.left,self.root.right)
        else:
            prt = self._findPrt(self.root,nd,None)
            if prt is not None:
                if prt.left==nd:
                    prt.left=leftHeap._merge(prt.left.left,prt.left.right)
                else:
                    prt.right=leftHeap._merge(prt.right.left,prt.right.right)
    def find(self,nd):
        if not isinstance(nd,node):nd = node(nd)
        prt = self._findPrt(self.root,nd,self.root)
        if prt is None or prt==nd:return prt
        elif prt.left==nd:return prt.left
        else:return prt.right
    def _findPrt(self,root,nd,parent):
        if not isinstance(nd,node):nd = node(nd)
        if root is None or root<nd:return None
        if root==nd:return parent
        l=self._findPrt(root.left,nd,root)
        return  l if l is not None else self._findPrt(root.right,nd,root)
    def getTop(self):
        return self.root
    def pop(self):
        nd = self.root
        self.remove(self.root.val)
        return nd
    def levelTraverse(self):
        li = [(self.root,0)]
        cur=0
        while li:
            nd,lv = li.pop(0)
            if cur<lv:
                cur=lv
                print()
                print(nd,end=' ')
            else:print(nd,end=' ')
            if nd.left is not None:li.append((nd.left,lv+1))
            if nd.right is not None:li.append((nd.right,lv+1))
            
    

if __name__ == '__main__':
    lh = leftHeap()
    data = [(i-3)**2 for i in range(20)]
    for i in data:
        lh . insert(i)
    lh.levelTraverse()
    print()
    for i in data:
        print(lh.getTop())
        if lh.find(i) is not None:lh.remove(i)
'''
data = [(i-10)**2 for i in range(20)]
node(100,freq=1,s=3) 
node(81,freq=2,s=3) node(64,freq=2,s=2) 
node(16,freq=2,s=2) node(25,freq=2,s=2) node(49,freq=2,s=1) node(36,freq=2,s=1) 
node(9,freq=2,s=1) node(4,freq=2,s=1) node(1,freq=2,s=1) node(0,freq=1,s=1) 
node(100,freq=1,s=3)
node(81,freq=2,s=3)
node(64,freq=2,s=2)
node(49,freq=2,s=1)
node(36,freq=2,s=3)
node(25,freq=2,s=2)
node(16,freq=2,s=2)
node(9,freq=2,s=1)
node(4,freq=2,s=2)
node(1,freq=2,s=1)
node(0,freq=1,s=1)
None
None
None
None
None
None
None
None
None
'''

'''
data = [(i-3)**2 for i in range(20)]
node(256,freq=1,s=1) 
node(225,freq=1,s=1) 
node(196,freq=1,s=1) 
node(169,freq=1,s=1) 
node(144,freq=1,s=1) 
node(121,freq=1,s=1) 
node(100,freq=1,s=1) 
node(81,freq=1,s=1) 
node(64,freq=1,s=1) 
node(49,freq=1,s=1) 
node(36,freq=1,s=1) 
node(25,freq=1,s=1) 
node(16,freq=1,s=1) 
node(9,freq=2,s=2) 
node(4,freq=2,s=1) node(1,freq=2,s=1) 
node(0,freq=1,s=1) 
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
node(256,freq=1,s=1)
'''
