''' mbinary
#########################################################################
# File : binaryTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:07
# Description:
#########################################################################
'''

from functools import total_ordering

@total_ordering
class node:
    def __init__(self,val,left=None,right=None,freq = 1):
        self.val=val
        self.left=left
        self.right=right
        self.freq = freq
    def __lt__(self,nd):
        return self.val<nd.val
    def __eq__(self,nd):
        return self.val==nd.val
    def __repr__(self):
        return 'node({})'.format(self.val)
    
class binaryTree:
    def __init__(self):
        self.root=None
    def add(self,val):
        def _add(nd,newNode):
            if nd<newNode:
                if nd.right is None:nd.right = newNode
                else:_add(nd.right,newNode)
            elif nd>newNode:
                if nd.left is None:nd.left = newNode
                else : _add(nd.left,newNode)
            else:nd.freq +=1
        _add(self.root,node(val))
    def find(self,val):
        prt= self._findPrt(self.root,node(val),None)
        if prt.left and prt.left.val==val:
            return prt.left
        elif  prt.right and prt.right.val==val:return prt.right
        else :return None
    def _findPrt(self,nd,tgt,prt):
        if nd==tgt or nd is None:return prt
        elif nd<tgt:return self._findPrt(nd.right,tgt,nd)
        else:return self._findPrt(nd.left,tgt,nd)
    def delete(self,val):
        prt= self._findPrt(self.root,node(val),None)
        if prt.left and prt.left.val==val:
            l=prt.left
            if l.left is None:prt.left = l.right
            elif l.right is None : prt.left = l.left
            else:
                nd = l.left
                while nd.right is not None:nd = nd.right
                nd.right = l.right
                prt.left = l.left
        elif  prt.right and prt.right.val==val:
            r=prt.right
            if r.right is None:prt.right = r.right
            elif r.right is None : prt.right = r.left
            else:
                nd = r.left
                while nd.right is not None:nd = nd.right
                nd.right = r.right
                prt.left = r.left

    def preOrder(self):
        def _p(nd):
            if nd is not None:
                print(nd)
                _p(nd.left)
                _p(nd.right)
        _p(self.root)
if __name__=="__main__":
    t = binaryTree()
    for i in range(10):
        t.add((i-4)**2)
    t.preOrder()
