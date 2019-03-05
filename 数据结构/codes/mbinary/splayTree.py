''' mbinary
#########################################################################
# File : splayTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''

from collections import deque,Iterable
# use isinstance(obj,Iterable)  to judge if an obj is iterable
class node:
    def __init__(self,val = None,left=None,right=None,parent=None):
        self.val = val
        if val :self.freq = 1
        else :self.freq = 0
        self.left = left
        self.right = right
        self.parent = parent   
    def getChild(self,s=0):
        if isinstance(s,int):s =[s]
        last = self
        for i in s:
            if not last:return None
            if i == 0: last = last.left
            else:last = last.right
        return last
    def setChild(self,child,s=0):
        if isinstance(s,Iterable):
            i = s[0]
            del s[0]
            if i == 0:self.left.setChild(child,s)
            else:self.right.setChild(child,s)
        elif s:self.right = child
        else:self.left = child
class splayTree:
    def __init__(self,s=[]):
        s = list(s)
        self.root = None
        s = sorted(s,reverse = True)
        for i in s:
            self.insert(self.root,i)
    def insert(self,k):
        if not self.root :self.root = node(k)
        else:self._insert(self.root,k)
    def _insert(self,root,k):
        if root.val == k :
            root.freq +=1
        elif root.val<k:
            if not root.right:
                root.right = node(k)
                root.right.parent = root
            else:self._insert(root.right,k)
        else:
            if not root.left:
                root.left = node(k)
                root.left.parent = root
            else:self._insert(root.left,k)
    def _zigzagRotate(self,i,j,root,parent,grand):
        parent.setChild(root.getChild(i),j)
        root.setChild(parent,i)
        grand.setChild(root.getChild(j),i)
        root.setChild(grand,j)
        if  root.parent:root.parent = grand.parent
        parent.parent = root
        grand.parent = root
    def _lineRotate(self,i,root,parent,grand):
        grand.setChild(parent.getChild(i^1),i)
        parent.setChild(grand,i^1)
        parent.setChild(root.getChild(i^1),i)
        root.setChild(parent,i^1)
        if  root.parent:root.parent = grand.parent
        parent.parent = root 
        grand.parent = parent
    def _rotate(self,root):
        if root == self.root:return 
        if root.parent == self.root:
            for i in range(2):
                if root.parent.getChild(i) == root:
                    root.parent.parent = root
                    root.parent.setChild(root.getChild(i^1),i)
                    root.parent = None
                    root.setChild(self.root,i^1)
                    self.root = root
        else:
            grand = root.parent.parent
            parent = root.parent
            if grand == self.root:
                    self.root = root
                    root.parent = None
            else:
                for i in range(2):
                    if grand.parent.getChild(i)  == grand:
                        grand.parent.setChild(root,i)
            for i in range(2):
                for j in range(2):
                    if i!=j and grand.getChild([i,j]) == root:
                        self._zigzagRotate(i,j,root,parent,grand)
                    elif i==j and grand.getChild([i,i]) == root:
                        self._lineRotate(i,root,parent,grand)
        self._rotate(root)
    def _find(self,root,k):
        if not root:return 0
        if root.val > k:
            return self._find(root.left,k)
        elif root.val<k:
            return self._find(root.right,k)
        else:
            self._rotate(root)
            return root.freq
    def _maxmin(self,root,i=0):
        if not root:return None
        if root.getChild(i):
            return self._maxmin(root.getChild(i))
        return root
    def Max(self):
        return self._maxmin(self.root,1)
    def Min(self):
        return self._maxmin(self.root,0)
    def remove(self,k):
        tmp = self.find(k)
        if not tmp:raise ValueError
        else:
            if self.root.left:
                r = self.root.right
                self.root = self.root.left
                self.root.parent = None
                Max = self.Max()
                Max.right= r
                if r:
                    r.parent = Max
            else:
                self.root = self.root.right
    def find(self,k):
        return self._find(self.root,k)
    def levelTraverse(self):
        q = deque()
        q.append((self.root,0))
        rst = []
        while q:
            tmp,n= q.popleft()
            rst.append(tmp)
            if tmp.left:q.append((tmp.left,n+1))
            if tmp.right:q.append((tmp.right,n+1))
        return rst
    def display(self):
        data = self.levelTraverse()
        for i in data:
            print (i.val,end=' ')
        print('')

if __name__ == '__main__':
    a = splayTree()
    a.insert(5)
    a.insert(1)
    a.insert(4)
    a.insert(3)
    a.insert(2)
    a.insert(7)
    a.insert(8)
    a.insert(2)
    print('initial:5,1,4,2,7,8,2')
    a.display()
    tmp = a.find(2)
    print("after find(2):%d"%tmp)
    a.display()
    print("remove(4)")
    a.remove(4)
    a.display()
