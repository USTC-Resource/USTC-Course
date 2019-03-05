''' mbinary
#########################################################################
# File : winnerTree.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:06
# Description:
#########################################################################
'''

class winnerTree:
    '''if i<lowExt    p = (i+offset)//2
       else           p = (i+n-1-lowExt)//2
       offset is a num 2^k-1 just bigger than n
        p is the index of tree
        i is the index of players
        lowExt is the double node num of the lowest layer of the tree
    '''
    def __init__(self,players,reverse=False):
        self.n=len(players)
        self.tree = [0]*self.n
        players.insert(0,0)
        self.players=players
        self.reverse=reverse
        self.getNum() 
        self.initTree(1)
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
        self.tree[p] = l if self.win(l,r) else r
        return self.tree[p]
    def winner(self):
        idx = 1
        while 2*idx<self.n:
            idx = 2*idx if self.tree[2*idx] == self.tree[idx] else idx*2+1
        num = self.treeToArray(idx)
        num = num+1 if self.players[num] !=self.tree[1] else num
        return self.tree[1],num
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
        self.tree[p] = x if self.win(x,oppo) else oppo
        p=p//2
        while p:
            l = self.tree[p*2]
            r = None
            if 2*p+1<self.n:r=self.tree[p*2+1]   #notice this !!!
            else:r = self.players[2*p+self.lowExt-self.n+1]
            self.tree[p] = l if self.win(l,r) else r
            p=p//2
        
            
        
if __name__ =='__main__':
    s= [4,1,6,7,9,5234,0,2,7,4,123]
    t = winnerTree(s)
    print(t.players,t.tree)
    for i in s:
        val,idx=t.winner()
        print(val,idx)
        t.update(idx,-1)


'''
[0, 4, 1, 6, 7, 9, 5234, 0, 2, 7, 4, 123] [0, 5234, 5234, 123, 7, 5234, 7, 123, 4, 7, 5234]
5234 6
123 11
9 5
7 4
7 9
6 3
4 1
4 10
2 8
1 2
'''
