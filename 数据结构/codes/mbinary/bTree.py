class node:
    def __init__(self,keys=None,isLeaf = True,children=None):
        if keys is None:keys=[]
        if children is None: children =[]
        self.keys = keys
        self.isLeaf =  isLeaf
        self.children = []
    def __getitem__(self,i):
        return self.keys[i]
    def __delitem__(self,i):
        del self.keys[i]
    def __setitem__(self,i,k):
        self.keys[i] = k
    def __len__(self):
        return len(self.keys)
    def __repr__(self):
        return str(self.keys)
    def __str__(self):
        children = ','.join([str(nd.keys) for nd in self.children])
        return f'keys:     {self.keys}\nchildren: {children}\nisLeaf:   {self.isLeaf}'
    def getChd(self,i):
        return self.children[i]
    def delChd(self,i):
        del self.children[i]
    def setChd(self,i,chd):
        self.children[i] = chd
    def getChildren(self,begin=0,end=None):
        if end is None:return self.children[begin:]
        return self.children[begin:end]
    def findKey(self,key):
        for i,k in enumerate(self.keys):
            if k>=key:
                return i
        return len(self)
    def update(self,keys=None,isLeaf=None,children=None):
        if keys is not None:self.keys = keys
        if children is not None:self.children = children
        if isLeaf is not None: self.isLeaf = isLeaf
    def insert(self,i,key=None,nd=None):
        if key is not None:self.keys.insert(i,key)
        if not self.isLeaf and nd is not None: self.children.insert(i,nd)
    def isLeafNode(self):return self.isLeaf
    def split(self,prt,t):
        # form new two nodes
        k = self[t-1]
        nd1 = node()
        nd2 = node()
        nd1.keys,nd2.keys = self[:t-1], self[t:] # note that t is 1 bigger than  key index
        nd1.isLeaf = nd2.isLeaf = self.isLeaf
        if not self.isLeaf: 
            # note that  children index is one bigger than key index, and all children included
            nd1.children, nd2.children = self.children[0:t], self.children[t:] 
        # connect them to parent
        idx = prt.findKey(k)
        if prt.children !=[]: prt.children.remove(self) # remove the original node
        prt.insert(idx,k,nd2)
        prt.insert(idx,nd = nd1)
        return prt


class bTree:
    def __init__(self,degree=2):
        self.root = node()
        self.degree=degree
        self.nodeNum = 1
        self.keyNum = 0
    def search(self,key,withpath=False):
        nd = self.root
        fathers = []
        while True:
            i = nd.findKey(key)
            if i==len(nd): fathers.append((nd,i-1,i))
            else: fathers.append((nd,i,i))
            if i<len(nd) and nd[i]==key:
                if withpath:return nd,i,fathers
                else:return nd,i
            if nd.isLeafNode(): 
                if withpath:return None,None,None
                else:return None,None
            nd = nd.getChd(i)
    def insert(self,key):
        if len(self.root)== self.degree*2-1:
            self.root = self.root.split(node(isLeaf=False),self.degree)
            self.nodeNum +=2
        nd = self.root
        while True:
            idx = nd.findKey(key)
            if idx<len(nd) and nd[idx] == key:return
            if nd.isLeafNode():
                nd.insert(idx,key)
                self.keyNum+=1
                return
            else:
                chd = nd.getChd(idx)
                if len(chd)== self.degree*2-1: #ensure its keys won't excess when its chd split and u
                    nd = chd.split(nd,self.degree)
                    self.nodeNum +=1
                else:
                    nd = chd
    def delete(self,key):#to do
        '''search the key, delete it , and form down to up to rebalance it '''
        nd,idx ,fathers= self.search(key,withpath=True)
        if nd is None : return
        del nd[idx]
        self.keyNum-=1
        if not nd.isLeafNode():
            chd = nd.getChd(idx) # find the predecessor key
            while not  chd.isLeafNode():
                fathers.append((chd,len(chd)-1,len(chd)))
                chd = chd.getChd(-1)
            fathers.append((chd,len(chd)-1,len(chd)))
            nd.insert(idx,chd[-1])
            del chd[-1]
        if len(fathers)>1:self.rebalance(fathers)
    def rebalance(self,fathers):
        nd,keyIdx,chdIdx = fathers.pop()
        while len(nd)<self.degree-1: # rebalance tree from down to up
            prt,keyIdx,chdIdx = fathers[-1]
            lbro = [] if chdIdx==0 else prt.getChd(chdIdx-1)
            rbro = [] if chdIdx==len(prt) else prt.getChd(chdIdx+1)
            if len(lbro)<self.degree and len(rbro)<self.degree:  # merge two deficient nodes
                beforeNode,afterNode = None,None
                if lbro ==[]:
                    keyIdx = chdIdx
                    beforeNode,afterNode = nd,rbro
                else:
                    beforeNode,afterNode = lbro,nd
                    keyIdx = chdIdx-1      # important, when choosing 
                keys = beforeNode[:]+[prt[keyIdx]]+afterNode[:]
                children = beforeNode.getChildren() + afterNode.getChildren()
                isLeaf = beforeNode.isLeafNode()
                prt.delChd(keyIdx+1)
                del prt[keyIdx]
                nd.update(keys,isLeaf,children)
                prt.children[keyIdx]=nd
                self.nodeNum -=1
            elif len(lbro)>=self.degree:  # rotate  when only one sibling is deficient
                keyIdx = chdIdx-1
                nd.insert(0,prt[keyIdx])    # rotate keys
                prt[keyIdx] =  lbro[-1]
                del lbro[-1]
                if not nd.isLeafNode():     # if not leaf, move children
                    nd.insert(0,nd=lbro.getChd(-1))
                    lbro.delChd(-1)
            else:
                keyIdx = chdIdx
                nd.insert(len(nd),prt[keyIdx])    # rotate keys
                prt[keyIdx] =  rbro[0]
                del rbro[0]
                if not nd.isLeafNode():     # if not leaf, move children
                    #note that insert(-1,ele) will make the ele be the last second one
                    nd.insert(len(nd),nd=rbro.getChd(0))
                    rbro.delChd(0)
            if len(fathers)==1:
                if len(self.root)==0: 
                    self.root = nd
                    self.nodeNum -=1
                break
            nd,i,j = fathers.pop()
    def __str__(self):
        head= '\n'+'-'*30+'B  Tree'+'-'*30
        tail= '-'*30+'the end'+'-'*30+'\n'
        lst = [[head],[f'node num: {self.nodeNum},  key num: {self.keyNum}']]
        cur = []
        ndNum =0
        ndTotal= 1
        que = [self.root]
        while que!=[]:
            nd = que.pop(0)
            cur.append(repr(nd))
            ndNum+=1
            que+=nd.getChildren()
            if ndNum==ndTotal:
                lst.append(cur)
                cur = []
                ndNum = 0
                ndTotal =len(que) 
        lst.append([tail])
        lst = [','.join(li) for li in lst]
        return '\n'.join(lst)
    def __iter__(self,nd = None):
        if nd is None: nd = self.root
        que = [nd]
        while que !=[]:
            nd = que.pop(0)
            yield nd
            if nd.isLeafNode():continue
            for i in range(len(nd)+1):
                que.append(nd.getChd(i))


if __name__ =='__main__':
    bt = bTree()
    from random import shuffle,sample
    n = 20
    lst = [i for i in range(n)]
    shuffle(lst)
    test= sample(lst,len(lst)//4)
    print(f'building b-tree with  {lst}')
    for i in lst:
        bt.insert(i)
        #print(f'inserting {i})
        #print(bt)
    print(bt)
    print(f'serching {test}')
    for i in test:
        nd,idx = bt.search(i)
        print(f'node: {repr(nd)}[{idx}]== {i}')
    for i in test:
        print(f'deleting {i}')
        bt.delete(i)
        print(bt)
