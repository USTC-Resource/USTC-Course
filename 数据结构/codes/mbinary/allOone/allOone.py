''' mbinary
#########################################################################
# File : allOoneDS.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:07
# Description:
#########################################################################
'''

class node:
    def __init__(self,val=None,data_mp=None,pre=None,next=None):
        self.val=val
        self.data_mp = {} if data_mp is None else data_mp
        self.pre=pre
        self.next=next
    def __lt__(self,nd):
        return  self.val<nd.val
    def getOne(self):
        if not self.data_mp:
            return ''
        else:return list(self.data_mp.items())[0][0]
    def __getitem__(self,key):
        return self.data_mp[key]
    def __iter__(self):
        return iter(self.data_mp)
    def __delitem__(self,key):
        del self.data_mp[key]
    def __setitem__(self,key,val):
        self.data_mp[key]= val
    def isEmpty(self):
        return self.data_mp=={}
    def __repr__(self):
        return 'node({},{})'.format(self.val,self.data_mp)
class doubleLinkedList:
    def __init__(self):
        self.head=  self.tail = node(0)
        self.head.next = self.head
        self.head.pre = self.head
        self.chain_mp={0:self.head}
    def __str__(self):
        li = list(self.chain_mp.values())
        li = [str(i) for i in li]
        return  'min:{}, max:{}\n'.format(self.head.val,self.tail.val)   \
               + '\n'.join(li)
    def getMax(self):
        return self.tail.getOne()
    def getMin(self):
        return self.head.getOne()
    def addIncNode(self,val):
        # when adding a node,inc 1, so it's guranted that node(val-1)  exists
        self.chain_mp[val].pre= self.chain_mp[val-1]   
        self.chain_mp[val].next= self.chain_mp[val-1].next
        self.chain_mp[val-1].next.pre = self.chain_mp[val-1].next = self.chain_mp[val]
    def addDecNode(self,val):
        # when adding a node,dec 1, so it's guranted that node(val+1)  exists
        self.chain_mp[val].next= self.chain_mp[val+1]   
        self.chain_mp[val].pre= self.chain_mp[val+1].pre
        self.chain_mp[val+1].pre.next = self.chain_mp[val+1].pre = self.chain_mp[val]
    def addNode(self,val,dec=False):
        self.chain_mp[val] = node(val)
        if dec:self.addDecNode(val)
        else:self.addIncNode(val)
        if self.tail.val<val:self.tail = self.chain_mp[val]
        if self.head.val>val or self.head.val==0:self.head= self.chain_mp[val]
    def delNode(self,val):
        self.chain_mp[val].next.pre = self.chain_mp[val].pre
        self.chain_mp[val].pre.next = self.chain_mp[val].next
        if self.tail.val==val:self.tail = self.chain_mp[val].pre
        if self.head.val==val:self.head = self.chain_mp[val].next
        del self.chain_mp[val]
    def incTo(self,key,val):  
        if val not in self.chain_mp: 
            self.addNode(val)
        self.chain_mp[val][key] = val
        if val!=1 :  # key in the pre node
            del self.chain_mp[val-1][key]
            #print(self.chain_mp[val-1])
            if self.chain_mp[val-1].isEmpty():
                #print('*'*20)
                self.delNode(val-1)
    def decTo(self,key,val):
        if val not in self.chain_mp:
            self.addNode(val,dec=True)
        # notice that the headnode(0) shouldn't add key
        if val!=0: self.chain_mp[val][key] = val  
        del self.chain_mp[val+1][key]
        if self.chain_mp[val+1].isEmpty():
            self.delNode(val+1)        
                
class AllOne:
    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.op = {"inc":self.inc,"dec":self.dec,"getMaxKey":self.getMaxKey,"getMinKey":self.getMinKey}
        self.mp = {}
        self.dll = doubleLinkedList()
    def __str__(self):
        return str(self.dll)
    def __getitem__(self,key):
        return self.mp[key]
    def __delitem__(self,key):
        del self.mp[key]
    def __setitem__(self,key,val):
        self.mp[key]= val
    def __iter__(self):
        return iter(self.mp)
    def inc(self, key,n=1):
        """
        Inserts a new key <Key> with value 1. Or increments an existing key by 1.
        :type key: str
        :rtype: void
        """
        if key in self:
            self[key]+=n
        else:self[key]=n
        for i in range(n): self.dll.incTo(key, self[key])
    def dec(self, key,n=1):
        """
        Decrements an existing key by 1. If Key's value is 1, remove it from the data structure.
        :type key: str
        :rtype: void
        """
        if key in self.mp:
            mn = min( self[key],n)
            for i in range(mn): self.dll.decTo(key, self[key]-i-1)
            if self[key] == n:
                del self[key]
            else:
                self[key] = self[key]-n
    def getMaxKey(self):
        """
        Returns one of the keys with maximal value.
        :rtype: str
        """
        return self.dll.getMax()

    def getMinKey(self):
        """
        Returns one of the keys with Minimal value.
        :rtype: str
        """
        return self.dll.getMin()




if __name__ == '__main__':
    ops=["inc","inc","inc","inc","inc","dec","dec","getMaxKey","getMinKey"]
    data=[["a"],["b"],["b"],["b"],["b"],["b"],["b"],[],[]]
    obj = AllOne()
    for op,datum in zip(ops,data):
        print(obj.op[op](*datum))
        print(op,datum)
        print(obj)

'''
None
inc ['a']
min:1, max:1
node(0,{})
node(1,{'a': 1})
None
inc ['b']
min:1, max:1
node(0,{})
node(1,{'a': 1, 'b': 1})
None
inc ['b']
min:1, max:2
node(0,{})
node(1,{'a': 1})
node(2,{'b': 2})
None
inc ['b']
min:1, max:3
node(0,{})
node(1,{'a': 1})
node(3,{'b': 3})
None
inc ['b']
min:1, max:4
node(0,{})
node(1,{'a': 1})
node(4,{'b': 4})
None
dec ['b']
min:1, max:3
node(0,{})
node(1,{'a': 1})
node(3,{'b': 3})
None
dec ['b']
min:1, max:2
node(0,{})
node(1,{'a': 1})
node(2,{'b': 2})
b
getMaxKey []
min:1, max:2
node(0,{})
node(1,{'a': 1})
node(2,{'b': 2})
a
getMinKey []
min:1, max:2
node(0,{})
node(1,{'a': 1})
node(2,{'b': 2})
'''
