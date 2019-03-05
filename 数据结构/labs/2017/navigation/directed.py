from collections import deque
class vertex:
    def __init__(self,mark,val=None ,firstEdge = None):
        self.mark = mark
        self.val = val
        self.firstEdge = firstEdge
        self.isVisited = False
    def __str__(self):
        try:
            int(self.mark)
            return 'v'+str(self.mark)
        except:return str(self.mark)
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
    def addVertex(self,i):
        if  not (i,vertex) and  i not in self.vertexs:self.vertexs[i]= vertex(i)
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
    def reVisit(self):
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
    def minPath(self,v,u):
        '''dijstra'''
        self.reVisit()
        if self.notIn(v) or  self.notIn(u):
            return  [],0
        v = self.__getVertex(v)
        u = self.__getVertex(u)
        if v.firstEdge==None:return [],0
        q=deque([v])
        last = {i : None for i in self}
        distance={i : 1<<30 for i in self}
        distance[v]=0
        while len(q)!=0:
            cur= q.popleft()
            cur.isVisited = True
            arc = cur.firstEdge
            while arc!=None:
                to = arc.inArrow
                if not to.isVisited:
                    q.append(to)
                    if distance [to] > distance[cur]+arc.weight:
                        last[to]=cur
                        distance[to] =distance[cur]+arc.weight
                arc= arc.outNextEdge
        cur = u
        path=[]
        while cur!=None and cur!=v:
            path.append(cur.mark)
            cur=last[cur]
        if cur==None:return [], 0
        path.append(v.mark)
        return path[::-1],distance[u]
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
