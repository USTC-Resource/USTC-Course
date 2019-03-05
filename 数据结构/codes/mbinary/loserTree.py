''' mbinary
#########################################################################
# File : loserTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''

from winnerTree import winnerTree
class loserTree:
    '''if i<=lowExt    p = (i+offset)//2
       else           p = (i+n-1-lowExt)//2
        s is the num of the full subtree node
        p is the index of tree
        i is the index of players
        offset is a num 2^k-1 just bigger than n
        lowExt is the double node num of the lowest layer of the tree
    '''
    def __init__(self,players,reverse=False):
        self.n=len(players)
        self.tree = [0]*self.n
        players.insert(0,0)
        self.players=players
        self.reverse=reverse
        self.getNum() 
        self.tree[0] = self.initTree(1)
        self.dir=None
    def getNum(self):
        i=1
        while 2*i< self.n:i=i*2
        if 2*i ==self. n:
            self.lowExt=0
            self.s = 2*i-1
        else:
            self.lowExt = (self.n-i)*2
            self.s = i-1
        self.offset = 2*i-1
    def treeToArray(self,p):
        return 2*p-self.offset if p>self.s else 2*p+self.lowExt-self.n+1
    def arrayToTree(self,i):
        return (i+self.offset)//2 if i<=self.lowExt else (i-self.lowExt+ self.n-1)//2
    def win(self,a,b):
        return a<b if self.reverse else a>b
    def initTree(self,p):
        if p>=self.n:
            delta = p%2  #!!! good job  notice delta mark the lchild or rchlid
            return self.players[self.treeToArray(p//2)+delta]
        l = self.initTree(2*p)
        r = self.initTree(2*p+1)
        if self.win(r,l):
            self.tree[p] = l
            self.dir = 'r'
            return r
        else :
            self.tree[p] = r
            self.dir = 'l'
            return l
    def getWinIdx(self,idx=1):
        while 2*idx<self.n:
            idx = 2*idx if self.tree[idx].dir == 'l' else idx*2+1
        return self.treeToArray(idx)
    def winner(self):
        i = self.getWinIdx()
        i = i+1 if self.players[i] !=self.tree[0] else i
        return self.tree[0],i
    def getOppo(self,i,x,p):
        oppo=None
        if 2*p<self.n:oppo=self.tree[2*p]
        elif i<=self.lowExt:oppo=self.players[i-1+i%2*2]
        else:
            lpl= self.players[2*p+self.lowExt-self.n+1]
            oppo = lpl if lpl!=x else self.players[2*p+self.lowExt-self.n+2]
        return oppo
    def update(self,i,x):
        ''' i is 1-indexed  which is the num of player
            and x is the new val of the player '''
        self.players[i]=x
        p = self.arrayToTree(i)
        oppo =self.getOppo(i,x,p)
        self.tree[p],winner = x , oppo if self.win(oppo,x) else oppo,x
        p=p//2
        while p:
            l = self.tree[p*2]
            r = None
            if 2*p+1<self.n:r=self.tree[p*2+1]   #notice this !!!
            else:r = self.players[2*p+self.lowExt-self.n+1]
            self.tree[p] = l if self.win(l,r) else r
            p=p//2
    # to do  update-func  the change of every node's dir and loser       
        
if __name__ =='__main__':
    s= [4,1,6,7,9,5234,0,2,7,4,123]
    t = winnerTree(s)
    for i in s:
        val,idx=t.winner()
        print(val,idx)
        t.update(idx,-1)


'''
[0, 4, 1, 6, 7, 9, 5234, 0, 2, 123] [0, 5234, 9, 5234, 6, 9, 5234, 123, 4]
5234 6
123 9
9 5
7 4
6 3
4 1
2 8
1 2
0 7
-1 1
'''
