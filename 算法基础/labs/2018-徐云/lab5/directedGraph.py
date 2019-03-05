''' mbinary
#########################################################################
# File : directedGraph.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-12-04  10:43
# Description: 
    #########################################################################
    '''
import multiprocessing as MP
from collections import deque
from time import time
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-p','--parallel',help="use parallel algorithm",action='store_true')
parser.add_argument('-o','--output',help="output all edge",action='store_true')
parser.add_argument('-s','--sep',help="file format for seperate character",default=" ")
parser.add_argument('-n','--nedge',help="generate n edges randomly (including duplicate edges)")
parser.add_argument('-f','--file',help="input file")

args = parser.parse_args()

FILE = args.file
OUTPUT = args.output
PARA = args.parallel
NEDGE = args.nedge
SEP = args.sep

class DG:
    def __init__(self):
        self.nodes={}
    def addEdge(self,inKey,outKey):
        '''unique edges'''
        if inKey in self.nodes:
            self.nodes[inKey][outKey]=None
        else:
            self.nodes[inKey] = {outKey:None}
    def addEdge2(self,inKey,outKey):
        if inKey in self.nodes:
            self.nodes[inKey].add(outKey)
        else:
            self.nodes[inKey]=set([outKey])
    def display(self):
        print('edges: ')
        for i in self.nodes:
            for j in self.nodes[i]:
                print(i,'->',j)
    def bfs(self):
        '''broad first search'''
        self.dq =deque()
        self.visited = set()
        self.edgeNum = 0
        for inNode in self.nodes:
            if inNode not in self.visited:
                self.dq.append(inNode)
                self.visited.add(inNode)
            while self.dq:
                cur = self.dq.popleft()
                self.edgeNum +=len(self.nodes[cur])
                for nd in self.nodes[cur]:
                    if nd not in self.visited:
                        if nd in self.nodes:
                            self.dq.append(nd)
                        self.visited.add(nd)
        print('visited {} nodes, {} edges'.format(len(self.visited),self.edgeNum))
    def pbfs(self):
        '''parallel bfs'''
        self.visited = {}
        self.edgeNum = 0
        pool = MP.Pool(processes=MP.cpu_count())
        cur=[]
        for inNode in self.nodes:
            if inNode not in self.visited:
                cur.append(inNode)
                self.visited[inNode]=None
            while cur:
                self.edgeNum+=sum(len(self.nodes[i]) for i in cur if i in self.nodes)
                lsts= pool.map(self.vis,cur)
                li = sum(lsts,[])
                dic  = {i:None for i in li}
                self.visited.update(dic)
                cur = list(dic.keys())
        print('visited {} nodes, {} edges'.format(len(self.visited),self.edgeNum))
    def vis(self,nd):
        li = []
        if nd in self.nodes:
            for i in self.nodes[nd]:
                if i not in self.visited:
                    li.append(i)
        return li

def vis_f(line,sep=SEP):
    a,b = line.split(sep)
    return int(a),int(b)

def readData(fileName,sep=' '):
    with open(fileName) as f:
        for line in f:# this read method is the best
            yield vis_f(line)

def pread(fileName,sep=' '):
    with open(fileName) as fp:
        lines = fp.readlines()
    n = len(lines)
    cores = MP.cpu_count()
    pool = MP.Pool(processes=cores)
    yield from pool.map(vis_f,lines)

from random import randint
def genData(n=100,upper=None):
    if upper is None:upper = round(0.3*n)
    for i in range(n):
        yield randint(0,upper),randint(0,upper)

if __name__=='__main__':
    dg = DG()
    t = time()
    if NEDGE:
        n = int(NEDGE)
        for a,b in genData(n):
            dg.addEdge2(a,b)
    elif FILE:
        for a,b in readData(FILE,SEP):
        #for a,b in pread(FILE,SEP):
            dg.addEdge2(a,b)
    dt = time()-t
    print('creating graph costs time: {:.4f}s'.format(dt))
    if OUTPUT:
        dg.display()
    t = time()
    if PARA:dg.pbfs()
    else: dg.bfs()
    dt = time()-t
    print('cost time: {:.4f}s'.format(dt))
