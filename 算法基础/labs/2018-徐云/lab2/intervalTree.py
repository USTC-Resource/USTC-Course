from redBlackTree import redBlackTree

from functools import total_ordering

@total_ordering
class node:
    def __init__(self,low,high,left=None,right=None,isBlack=False):
        self.val =  low   # self.val is the low
        self.high = high
        self.max = high
        self.left = left
        self.right = right
        self.parent=None
        self.isBlack = isBlack
    def __lt__(self,nd):
        return self.val < nd.val
    def __eq__(self,nd):
        return nd is not None and self.val == nd.val
    def setChild(self,nd,isLeft = True):
        if isLeft: self.left = nd
        else: self.right = nd
        if nd is not None: nd.parent = self
    def getChild(self,isLeft):
        if isLeft: return self.left
        else: return self.right
    def __bool__(self):
        return self.val is not None
    def __str__(self):
        color = 'B' if self.isBlack else 'R'
        return f'{color}[{self.val},{self.high}]-{self.max}'
    def __repr__(self):
        return f'intervalNode({self.val},{self.high},{self.max},isBlack={self.isBlack})'
    def overlap(self,low,high):
        return self.val<=high and self.high>=low
    def setMax(self):
        l = 0 if self.left is None else self.left.max
        r = 0 if self.right is None else self.right.max
        self.max = max(self.high, l, r)
        return self.max

class intervalTree(redBlackTree):
    def search(self,low,high):
        nd = self.root
        while nd is not None and not nd.overlap(low,high):
            if nd.left is not None and nd.left.max>=low:
                nd = nd.left
            else:nd = nd.right
        return nd
    def insert(self,nd):
        super(intervalTree,self).insert(nd)
        while nd is not None:
            nd.setMax()
            nd = nd.parent
    def delete(self,val):
        nd = self.find(val)
        if nd is not None:
            nd.max = 0
            tmp = nd.parent
            while tmp is not None:
                tmp.setMax()
                tmp = tmp.parent
            super(intervalTree,self).delete(val)
    def rotate(self,prt,chd):
        '''rotate prt, and return new prt, namyly the original chd'''
        super(intervalTree,self).rotate(prt,chd)
        prt.setMax()
        chd.setMax()
    def copyNode(self,src,des):
        des.val = src.val
        des.high = src.high
        des.setMax()



from random import randint, shuffle
def genNum(n =10,upper=10):
    nums ={}
    for i in range(n):
        while 1:
            d = randint(0,100)
            if d not in nums:
                nums[d] = (d,randint(d,d+upper))
                break
    return nums.values()

def buildTree(n=10,nums=None,visitor=None):
    #if nums is None or nums ==[]: nums = genNum(n)
    tree = intervalTree()
    print(f'build a red-black tree using {nums}')
    for i in nums:
        tree.insert(node(*i))
        if visitor:
            visitor(tree,i)
    return tree,nums
def testInsert(nums=None):
    def visitor(t,val):
        print('inserting', val)
        print(t)
    tree,nums = buildTree(visitor = visitor,nums=nums)
    print('-'*5+ 'in-order visit' + '-'*5)
    for i,j in enumerate(tree.sort()):
        print(f'{i+1}: {j}')
    return tree

def testSuc(nums=None):
    tree,nums = buildTree(nums=nums)
    for i in tree.sort():
        print(f'{i}\'s suc is {tree.getSuccessor(i)}')

def testDelete(nums=None):
    tree,nums = buildTree(nums = nums)
    print(tree)
    for i in nums:
        print(f'deleting {i}')
        tree.delete(i[0])
        print(tree)
    return tree

if __name__=='__main__':
    lst = [(0,3),(5,8),(6,10),(26,26),(25,30),(8,9),(19,20),(15,23),(16,21),(17,19)]
    #lst = None
    #testSuc(lst)
    tree = testInsert(lst)
    #tree,_= buildTree(lst)
    while 1:
        a =int( input('low:'))
        b =int( input('high:'))
        res = tree.search(a,b)
        print(res)
