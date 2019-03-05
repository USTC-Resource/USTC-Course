''' mbinary
#########################################################################
# File : trie.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''

class node:
    def __init__(self,val = None):
        self.val = val
        self.isKey = False
        self.children = {}
    def __getitem__(self,i):
        return self.children[i]
    def __iter__(self):
        return iter(self.children.keys())
    def __setitem__(self,i,x):
        self.children[i] = x
    def __bool__(self):
        return self.children!={}
    def __str__(self):
        return 'val: '+str(self.val)+'\nchildren: '+' '.join(self.children.keys())
    def __repr__(self):
        return str(self)
    
class Trie(object):

    def __init__(self):
        self.root=node('')
        self.dic ={'insert':self.insert,'startsWith':self.startsWith,'search':self.search}
 
    def insert(self, word):
        """
        Inserts a word into the trie.
        :type word: str
        :rtype: void
        """
        if not word:return 
        nd = self.root
        for i in word:
            if i in nd:
                nd = nd[i]
            else:
                newNode= node(i)
                nd[i] = newNode
                nd = newNode
        else:nd.isKey = True
    def search(self, word,matchAll='.'):
        """support matchall function  eg,  'p.d' matchs 'pad' , 'pid'
        """
        self.matchAll = '.'
        return self._search(self.root,word)
    def _search(self,nd,word):
        for idx,i in enumerate(word):
            if i==self.matchAll :
                for j in nd:
                    bl =self._search(nd[j],word[idx+1:])
                    if bl:return True
                else:return False
            if i  in nd:
                nd = nd[i]
            else:return False
        else:return nd.isKey
    def startsWith(self, prefix):
        """
        Returns if there is any word in the trie that starts with the given prefix.
        :type prefix: str
        :rtype: bool
        """
        nd = self.root
        for i in prefix:
            if i in  nd:
                nd= nd[i]
            else:return False
        return True
    def display(self):
        print('preOrderTraverse  data of the Trie')
        self.preOrder(self.root,'')
    def preOrder(self,root,s):
        s=s+root.val
        if  root.isKey:
            print(s)
        for i in root:
            self.preOrder(root[i],s)
    
if __name__=='__main__':
    t = Trie()
    op = ["insert","insert","insert","insert","insert","insert","search","search","search","search","search","search","search","search","search","startsWith","startsWith","startsWith","startsWith","startsWith","startsWith","startsWith","startsWith","startsWith"]
    data = [["app"],["apple"],["beer"],["add"],["jam"],["rental"],["apps"],["app"],["ad"],["applepie"],["rest"],["jan"],["rent"],["beer"],["jam"],["apps"],["app"],["ad"],["applepie"],["rest"],["jan"],["rent"],["beer"],["jam"]]
    rsts = [None,None,None,None,None,None,False,True,False,False,False,False,False,True,True,False,True,True,False,False,False,True,True,True]
    
    for i,datum,rst in zip(op,data,rsts):
        if t.dic[i](datum[0]) != rst:print(i,datum[0],rst)
    t.display()
