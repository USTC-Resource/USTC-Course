''' mbinary
#########################################################################
# File : hashTable.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-07-08  16:39
# Description:
#########################################################################
'''

class item:
    def __init__(self,key,val,nextItem=None):
        self.key = key
        self.val = val
        self.next = nextItem
    def to(self,it):
        self.next = it
    def __eq__(self,it):
        '''using  keyword <in> '''
        return self.key == it.key
    def __bool__(self):
        return self.key is not None
    def __str__(self):
        li = []
        nd = self
        while nd:
            li.append(f'({nd.key}:{nd.val})')
            nd = nd.next
        return ' -> '.join(li)
    def __repr__(self):
        return f'item({self.key},{self.val})'
class hashTable:
    def __init__(self,size=100):
        self.size = size
        self.slots=[item(None,None) for i in range(self.size)]
    def __setitem__(self,key,val):
        nd = self.slots[self.myhash(key)]
        while nd.next:
            if nd.key ==key:
                if nd.val!=val: nd.val=val
                return
            nd  = nd.next
        nd.next = item(key,val)

    def myhash(self,key):
        if isinstance(key,str):
            key = sum(ord(i) for i in key)
        if not isinstance(key,int):
            key = hash(key)
        return key % self.size
    def __iter__(self):
        '''when using keyword <in>, such as ' if key in dic',
            the dic's  __iter__ method will be called,(if hasn't, calls __getitem__
            then  ~iterate~  dic's keys to compare whether one equls to the key
        '''
        for nd in self.slots:
            nd = nd.next
            while nd :
                yield nd.key
                nd = nd.next
    def __getitem__(self,key):
        nd =self.slots[ self.myhash(key)].next
        while nd:
            if nd.key==key:
                return nd.val
            nd = nd.next
        raise Exception(f'[KeyError]: {self.__class__.__name__} has no key {key}')

    def __delitem__(self,key):
        '''note that None item and item(None,None) differ with each other,
            which means you should take care of them and correctly cop with None item
            especially when deleting items
        '''
        n = self.myhash(key)
        nd = self.slots[n].next
        if nd.key == key:
            if nd.next is None:
                self.slots[n] =  item(None,None) # be careful
            else:self.slots[n] = nd.next
            return
        while nd:
            if nd.next is None: break  # necessary
            if nd.next.key ==key:
                nd.next = nd.next.next
            nd = nd.next
    def __str__(self):
        li = ['\n\n'+'-'*5+'hashTable'+'-'*5]
        for i,nd in enumerate(self.slots):
            li.append(f'{i}: '+str(nd.next))
        return '\n'.join(li)
        

if __name__ =='__main__':
    from random import randint
    dic = hashTable(16)
    n = 100
    li = [1,2,5,40,324,123,6,22,18,34,50]
    print(f'build hashTable using {li}')
    for i in li:
        dic[i] = '$'+str(i)
    print(dic)
    for i in [1,34,45,123]:
        if i in dic:
            print(f'{i} in dic, deleting it')
            del dic[i]
        else:
            print(f'{i} not in dic, ignore it')
    print(dic)
    print(f'dic[2] is {dic[2]}')
    try:
        dic[-1]
    except Exception as e:
        print(e)
