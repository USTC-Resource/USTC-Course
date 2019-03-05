''' mbinary
#########################################################################
# File : redBlackTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-07-14  16:15
# Description:
#########################################################################
'''
from functools import total_ordering
from random import randint, shuffle

@total_ordering
class node:
    def __init__(self,val,left=None,right=None,isBlack=False):
        self.val =val
        self.left = left
        self.right = right
        self.parent= None
        self.isBlack  = isBlack
    def __lt__(self,nd):
        return self.val < nd.val
    def __eq__(self,nd):
        return nd is not None and self.val == nd.val
    def setChild(self,nd,isLeft):
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
        val = '-' if self.parent==None else self.parent.val
        return f'{color}-{self.val}'
    def __repr__(self):
        return f'node({self.val},isBlack={self.isBlack})'
class redBlackTree:
    def __init__(self,unique=False):
        '''if unique is True, all node'vals are unique, else there may be equal vals'''
        self.root = None
        self.unique = unique

    @staticmethod
    def checkBlack(nd):
        return nd is None or nd.isBlack
    @staticmethod
    def setBlack(nd,isBlack):
        if nd is not None:
            if isBlack is None or isBlack:
                nd.isBlack = True
            else:nd.isBlack = False
    def setRoot(self,nd):
        if nd is not None: nd.parent=None
        self.root= nd
    def find(self,val):
        nd = self.root
        while nd:
            if nd.val ==val:
                return nd
            else:
                nd = nd.getChild(nd.val>val)
    def getSuccessor(self,nd):
        if nd:
            if nd.right:
                nd = nd.right
                while nd.left:
                    nd = nd.left
                return nd
            else:
                while nd.parent is not None and nd.parent.right is nd:
                    nd = nd.parent
                return None if nd is self.root else nd.parent
    def rotate(self,prt,chd):
        '''rotate prt with the center of chd''' 
        if self.root is prt:
            self.setRoot(chd)
        else:
            prt.parent.setChild(chd, prt.parent.left is prt)
        isLeftChd = prt.left is chd
        prt.setChild(chd.getChild(not isLeftChd), isLeftChd)
        chd.setChild(prt,not isLeftChd)

    def insert(self,nd):
        if nd.isBlack: nd.isBlack = False

        if self.root is None:
            self.setRoot(nd)
            self.root.isBlack = True
        else:
            parent = self.root
            while parent:
                if parent == nd : return None
                isLeft = parent > nd
                chd  = parent.getChild(isLeft)
                if chd is None:
                    parent.setChild(nd,isLeft)
                    break
                else:
                    parent = chd
            self.fixUpInsert(parent,nd)
    def fixUpInsert(self,parent,nd):
        ''' adjust color and level,  there are two red nodes: the new one and its parent'''
        while not self.checkBlack(parent):
            grand = parent.parent
            isLeftPrt = grand.left is parent
            uncle = grand.getChild(not isLeftPrt)
            if not self.checkBlack(uncle):
                # case 1:  new node's uncle is red
                self.setBlack(grand, False)
                self.setBlack(grand.left, True)
                self.setBlack(grand.right, True)
                nd = grand
                parent = nd.parent
            else:
                # case 2: new node's uncle is black(including nil leaf)
                isLeftNode = parent.left is nd
                if isLeftNode ^ isLeftPrt:
                    # case 2.1 the new node is inserted in left-right or right-left form
                    #         grand               grand
                    #     parent        or            parent
                    #          nd                   nd
                    self.rotate(parent,nd)    #parent rotate
                    nd,parent = parent,nd
                # case 3  (case 2.2) the new node is inserted in left-left or right-right form
                #         grand               grand
                #      parent        or            parent
                #     nd                                nd

                self.setBlack(grand, False)
                self.setBlack(parent, True)
                self.rotate(grand,parent)
        self.setBlack(self.root,True)

    def copyNode(self,src,des):
        '''when deleting a node which has two kids, 
            copy its succesor's data to his position
            data exclude left, right , isBlack
        '''
        des.val = src.val
    def delete(self,val):
        '''delete node in a binary search tree'''
        if isinstance(val,node): val = val.val
        nd = self.find(val)
        if nd is None: return
        self._delete(nd)
    def _delete(self,nd):
        y = None
        if nd.left and nd.right:
            y= self.getSuccessor(nd)
        else:
            y = nd
        py = y.parent
        x = y.left if y.left else y.right
        if py is None:
            self.setRoot(x)
        else:
            py.setChild(x,py.left is y)
        if y != nd:
            self.copyNode(y,nd)
        if self.checkBlack(y): self.fixUpDel(py,x)
 
    def fixUpDel(self,prt,chd):
        ''' adjust colors and rotate '''
        while self.root != chd and self.checkBlack(chd):
            isLeft =prt.left is chd
            brother = prt.getChild(not isLeft)
            # brother is black
            lb = self.checkBlack(brother.getChild(isLeft))
            rb = self.checkBlack(brother.getChild(not isLeft))
            if  not self.checkBlack(brother):
                # case 1: brother is red.   converted to  case 2,3,4

                self.setBlack(prt,False)
                self.setBlack(brother,True)
                self.rotate(prt,brother)

            elif lb and rb: 
                # case 2: brother is black and two kids are black. 
                # conveted to the begin case
                self.setBlack(brother,False)
                chd = prt
                prt= chd.parent
            else:
                if  rb:
                    # case 3: brother is black and left kid is red and right child is black
                    # rotate bro to make g w wl wr in one line
                    # uncle's son is nephew, and niece for uncle's daughter
                    nephew = brother.getChild(isLeft)
                    self.setBlack(nephew,True)
                    self.setBlack(brother,False)

                    # brother (not isLeft) rotate
                    self.rotate(brother,nephew)
                    brother = nephew

                # case 4: brother is black and right child is red
                brother.isBlack = prt.isBlack
                self.setBlack(prt,True)
                self.setBlack(brother.getChild(not isLeft),True)

                self.rotate(prt,brother)
                chd = self.root
        self.setBlack(chd,True)

    def sort(self,reverse = False):
        ''' return a generator of sorted data'''
        def inOrder(root):
            if root is None:return
            if reverse:
                yield from inOrder(root.right)
            else:
                yield from inOrder(root.left)
            yield root
            if reverse:
                yield from inOrder(root.left)
            else:
                yield from inOrder(root.right)
        yield from inOrder(self.root)

    def display(self):
        def getHeight(nd):
            if nd is None:return 0
            return max(getHeight(nd.left),getHeight(nd.right)) +1
        def levelVisit(root):
            from collections import deque
            lst = deque([root])
            level = []
            h = getHeight(root)
            ct = lv = 0
            while 1:
                ct+=1
                nd = lst.popleft()
                if ct >= 2**lv:
                    lv+=1
                    if lv>h:break
                    level.append([])
                level[-1].append(str(nd))
                if nd is not None:
                    lst += [nd.left,nd.right]
                else:
                    lst +=[None,None]
            return level
        def addBlank(lines):
            width = 1+len(str(self.root))
            sep = ' '*width
            n = len(lines)
            for i,oneline in enumerate(lines):
                k  = 2**(n-i) -1
                new = [sep*((k-1)//2)]
                for s in oneline:
                    new.append(s.ljust(width))
                    new.append(sep*k)
                lines[i] = new
            return lines

        lines = levelVisit(self.root)
        lines = addBlank(lines)
        li = [''.join(line) for line in lines]
        length = 10 if li==[] else max(len(i) for i in li)//2
        begin ='\n'+ 'red-black-tree'.rjust(length+14,'-')  + '-'*(length)
        end = '-'*(length*2+14)+'\n'
        return  '\n'.join([begin,*li,end])
    def __str__(self):
        return self.display()


def genNum(n =10):
    nums =[]
    for i in range(n):
        while 1:
            d = randint(0,100)
            if d not in nums:
                nums.append(d)
                break
    return nums

def buildTree(n=10,nums=None,visitor=None):
    if nums is None or nums ==[]: nums = genNum(n)
    rbtree = redBlackTree()
    print(f'build a red-black tree using {nums}')
    for i in nums:
        rbtree.insert(node(i))
        print(rbtree)
        if visitor:
            visitor(rbtree,i)
    return rbtree,nums
def testInsert(nums=None):
    def visitor(t,val):
        print('inserting', val)
        print(t)
    rbtree,nums = buildTree(visitor = visitor,nums=nums)
    print('-'*5+ 'in-order visit' + '-'*5)
    for i,j in enumerate(rbtree.sort()):
        print(f'{i+1}: {j}')

def testSuc(nums=None):
    rbtree,nums = buildTree(nums=nums)
    for i in rbtree.sort():
        print(f'{i}\'s suc is {rbtree.getSuccessor(i)}')

def testDelete(nums=None):
    rbtree,nums = buildTree(nums = nums)
    print(rbtree)
    for i in sorted(nums):
        print(f'deleting {i}')
        rbtree.delete(i)
        print(rbtree)

if __name__=='__main__':
    lst =[45, 30, 64, 36, 95, 38, 76, 34, 50, 1]
    lst = [0,3,5,6,26,25,8,19,15,16,17]
    #testSuc(lst)
    #testInsert(lst)
    testDelete()
