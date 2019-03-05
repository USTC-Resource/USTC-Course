''' mbinary
#########################################################################
# File : directed.py
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-04-26  10:33
# Description:
#########################################################################
'''

from collections import Iterable,deque
class vertex:
    def __init__(self,mark,val=None ,firstEdge = None):
        self.mark = mark
        self.val = val
        self.firstEdge = firstEdge
        self.isVisited = False
    def __str__(self):
        if '0'<=self.mark[0]<='9':return 'v'+str(self.mark)
        return str(self.mark)
    def __repr__(self):
        li=[]
        arc= self.firstEdge
        while arc!=None:
            li.append(arc)
            arc= arc.outNextEdge
        return str(self)+ '  to:'+str([str(i.inArrow) for i in li])
class edge:
    def __init__(self,outArrow,inArrow,outNextEdge = None,inNextEdge = None, weight = 1): 
        self.weight = weight
        self.inNextEdge = inNextEdge 
        self.outNextEdge = outNextEdge
        self.outArrow = outArrow
        self.inArrow=inArrow
        self.isVisited = False
    def __str__(self):
        return '--'+str(self.weight)+'-->'
    def __repr__(self):
        return str(self)
class graph:
    def __init__(self): 
        self.vertexs = {}
        self.edges = {}
    def __getitem__(self,i): 
        return self.vertexs[i]
    def __setitem__(selfi,x):
        self.vertexs[i]= x
    def __iter__(self):
        return iter(self.vertexs.values())
    def __bool__(self):
        return len(self.vertexs)!=0
    def addVertex(self,vertexs):
        '''vertexs is a iterable or just a mark that marks the vertex,whichc can be every imutable type'''
        if not isinstance(vertexs,Iterable):vertexs=[vertexs]
        for i in vertexs:
            if  not isinstance(i,vertex) and  i not in self.vertexs:self.vertexs[i]= vertex(i)
            if isinstance(i,vertex) and  i not in self.vertexs:self.vertexs[i.mark]= i
    def isConnected(self,v,u):
        v = self.__getVertex(v)
        u = self.__getVertex(u)
        arc= v.firstEdge
        while arc!=None:
            if arc.inArrow==u:return True
            arc = arc.inNextEdge
        return False
    def __getVertex(self,v):
        if not isinstance(v,vertex):
            if v not in self.vertexs:
                self.vertexs[v]=vertex(v)
            return self.vertexs[v]
        return v
    def addEdge(self,v,u,weight = 1):
        v = self.__getVertex(v)
        u = self.__getVertex(u)
        arc = v.firstEdge
        while arc!=None:         #examine that if v,u have been already connected
            if arc.inArrow==u: return
            arc= arc.outNextEdge
        newEdge = edge(v,u,v.firstEdge,u.firstEdge,weight)
        self.edges[(v.mark,u.mark)] = newEdge
        v.firstEdge = newEdge
    def delEdge(self,v,u):
        if not isinstance(v,vertex):v= self.vertexs[v]
        if not isinstance(u,vertex):u= self.vertexs[u]
        self._unrelated(v,u)
        del self.edges[(v.mark,u.mark)]
    def _unrelated(self,v,u):
        if v.firstEdge==None:return 
        if v.firstEdge.inArrow == u:
            v.firstEdge =v.firstEdge.outNextEdge
        else:
            arc = v.firstEdge
            while arc.outNextEdge!=None:
                 if arc.outNextEdge.inArrow ==u:
                     arc.outNextEdge = arc.outNextEdge.outNextEdge
                     break
    def revisit(self):
        for i in self.vertexs:
            self.vertexs[i].isVisited=False
        for i in self.edges:
            self.edges[i].isVisited=False
    def __str__(self):
        arcs= list(self.edges.keys())
        arcs=[str(i[0])+'--->'+str(i[1])+'  weight:'+str(self.edges[i].weight) for i in arcs]
        s= '\n'.join(arcs)
        return s
    def __repr__(self):
        return str(self)
    def notIn(self,v):
        if (isinstance(v,vertex) and  v.mark not in self.vertexs) or v not in self.vertexs:
            return True
        return False
    def visitPath(self,v,u):
        '''bfs'''
        if self.notIn(v) or  self.notIn(u):
            return  None,None
        v = self.__getVertex(v)
        u = self.__getVertex(u)
        if v.firstEdge==None:return None,None
        q=deque([v.firstEdge])
        isFind=False
        vs,es=[],[]
        while len(q)!=0:
            vs,es=[],[]
            arc= q.popleft()
            if arc.outNextEdge!=None and not arc.outNextEdge.isVisited:q.append(arc.outNextEdge)
            while arc!=None:
                if arc.isVisited:break
                arc.isVisited=True
                es.append(arc)
                vs.append(arc.inArrow)
                arc.outArrow.isVisited=True
                if arc.inArrow==u:
                     isFind=True
                     break
                arc = arc.inArrow.firstEdge
                # very important  , avoid circle travel
                while arc.inArrow.isVisited and arc.outNextEdge:arc = arc.outNextEdge
            if isFind:break
        else:return None,None
        '''
        se = [str(i) for i in es]
        sv = [str(i)  for i in vs]
        print(str(v),end='')
        for i,j in zip(se,sv):
            print(i,j,end='')
        '''
        return vs,es
    def hasVertex(self,mark):
        return mark in self.vertexs
    def display(self):
        print('vertexs')
        for i in self.vertexs:
            print(self.vertexs[i].__repr__())
        print('edges')
        for i in self.edges:
            arc=self.edges[i]
            print(str(arc.outArrow)+str(arc)+str(arc.inArrow))

class Solution(object):
    def calcEquation(self, equations, values, queries):
        """
        :type equations: List[List[str]]
        :type values: List[float]
        :type queries: List[List[str]]
        :rtype: List[float]
        """
        rst =[]
        g= graph()
        for edge,wt in zip(equations,values):
            g.addEdge(edge[0],edge[1],wt)
            g.addEdge(edge[1],edge[0],1/wt)###### to serach quickly but sacrifacing some space
        g.display()
        for i in queries:
            if i[0]==i[1]:
                if i[0] in g.vertexs:rst.append(1.0)
                else:rst.append(-1.0)
                continue
            _,path = g.visitPath(i[0],i[1])
            if path==None:
                if not path:rst.append(-1.0)
            else:
                mul = 1
                for i in path:mul*=i.weight
                rst.append(mul)
            g.revisit()
        return rst
            
        
if __name__=='__main__':
    equations = [["a","b"],["e","f"],["b","e"]]
    values = [3.4,1.4,2.3]
    queries = [["b","a"],["a","f"],["f","f"],["e","e"],["c","c"],["a","c"],["f","e"]]
    sol = Solution()
    ret=sol.calcEquation( equations, values, queries)
    print(ret)

    '''
        [0.29411764705882354, 10.947999999999999, 1.0, 1.0, -1.0, -1.0, 0.7142857142857143]
    '''

    
    ''' 
    equations = [ ["a", "b"], ["b", "c"] ]
    values = [2.0, 3.0]
    queries = [ ["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"] ]
    sol = Solution()
    ret=sol.calcEquation( equations, values, queries)
    print(ret)
    '''

    '''
    [6.0, 0.5, -1.0, -1.0, -1.0]
    '''

    '''
    g = graph()
    g.addEdge(1,2)
    g.addEdge(2,1)
    g.addEdge(3,1)
    g.addEdge(1,4)
    g.addEdge(3,2)
    g.addEdge(2,4)
    g.addVertex(6)
    g.addEdge(4,6)
    g.delEdge(1,2)
    g.display()
    g.visitPath(3,6)

 
   '''
    '''
    vertexs
    v1  to:['v4']
    v2  to:['v4', 'v1']
    v3  to:['v2', 'v1']
    v4  to:['v6']
    v6  to:[]
    edges
    v2--1-->v1
    v3--1-->v1
    v1--1-->v4
    v3--1-->v2
    v2--1-->v4
    v4--1-->v6
    >>> 
    '''
