from collections import deque
import directed
class vertex:
    def __init__(self,mark,val=None):
        self.mark = mark
        self.val = val
        self.edges = {}
        self.isVisited = False
    def __getitem__(self,adjVertexMark):
        return self.edges[adjVertexMark]
    def __delitem__(self,k):
        del self.edges[k]
    def __iter__(self):
        return iter(self.edges.values())
    def __str__(self):
        try:
            int(self.mark)
            return 'v'+str(self.mark)
        except:return str(self.mark)
    def __repr__(self):
        return str(self)
class edge:
    def __init__(self,adjVertexs, weight = 1):
        '''adjVertexs:tuple(v.mark,u.mark)'''
        self.weight = weight
        self.adjVertexs = adjVertexs
        self.isVisted = False
    def __add__(self,x):
        return self.weight +x
    def __radd__(self,x):
        return self+x
    def __getitem__(self,k):
        if k!=0 or k!=1:raise IndexError
        return self.adjVertexs[k]
    def __str__(self):
        return '--'+str(self.weight)+'--'
    def __repr__(self):
        return str(self)
    @property
    def v(self):
        return self.adjVertexs[0]
    @property
    def u(self):
        return self.adjVertexs[1]
class graph:
    def __init__(self): 
        self.vertexs = {}
        self.edges = {}
    def __getitem__(self,i): 
        return self.vertexs[i]
    def __setitem__(selfi,x):
        self.vertexs[i]= x
    def __iter__(self):
        return iter(self.vertexs)
    def __bool__(self):
        return len(self.vertexs)!=0
    def addVertex(self,v):
        if  not isinstance(v,vertex) and  v not in self.vertexs:self.vertexs[v]= vertex(v)
        if isinstance(v,vertex) and v not in self.vertexs:self.vertexs[v.mark]= v

    def __getVertex(self,v):
        if not isinstance(v,vertex):
            if v not in self.vertexs:
                self.vertexs[v]=vertex(v)
            return self.vertexs[v]
        return v
    def addEdge(self,v,u,weight = 1):
        v = self.__getVertex(v)
        u = self.__getVertex(u)
        for arc in v:
            if  u in arc.adjVertexs:return  #examine that if v,u have been already connected
        vertexs = (v,u)
        newEdge = edge (vertexs,weight)
        self.edges[vertexs] = newEdge
        v.edges[u] = newEdge
        u.edges[v] = newEdge        
    def delEdge(self,v,u):
        if not isinstance(v,vertex):v= self.vertexs[v]
        if not isinstance(u,vertex):u= self.vertexs[u]
        try:
            del v[u]
            del u[v]
        except:print("error!"+str(v)+','+str(u)+' arent adjacent now')
        del self.edges[(v,u)]       
    def reVisit(self):
        for i in self.vertexs.values():
            i.isVisited = False
        for i in self.edges.values():
            i.isVisited = False
    def __str__(self):
        arcs= list(self.edges.keys())
        arcs=[str(i[0])+str(self.edges[i])+str(i[1]) for i in arcs]
        s= '\n'.join(arcs)
        return s
    def __repr__(self):
        return str(self)
    def minPath(self,v,u):
        self.reVisit()
        v=self.__getVertex(v)
        u=self.__getVertex(u)
        q=deque([v])
        last={i:None for i in self.vertexs.values()}
        last[v] = 0
        ds={i:1<<30 for i in self.vertexs.values()}
        ds[v]=0
        while len(q)!=0:
            nd = q.popleft()
            nd.isVisited=True
            for edge  in nd:
                tgt=None
                if edge.v==nd:
                    tgt = edge.u
                else:tgt = edge.v
                tmp=ds[nd]+edge
                if ds[tgt] >tmp:
                    ds[tgt]=tmp
                    last[tgt] = nd
                if not tgt.isVisited:q.append(tgt)
        path=[]
        cur = u
        while cur !=None and cur.mark!=v.mark:
            path.append(cur.mark)
            cur = last[cur]
        if cur==None:return [],-1
        path.append(v.mark)
        return path[::-1],ds[u]
    def hasCircle(self):
        pass
    def display(self):
        print('vertexs')
        for i in self.vertexs:
            print(i,end=' ')
        print('')
        print('edges')
        for i in self.edges:
            arc=self.edges[i]
            print(str(arc.v)+str(arc)+str(arc.u))

def loop(dic):
    while True:
        print('input vertexs to get the min distance, input \'exit\' to exit')
        s=input().strip()
        if s=='exit':break
        s=s.split(' ')
        s=[dic[i] if '0'<=i[0]<='9' else i for i in s]
        a,b,c=s[0],s[1],None
        path,d = g.minPath(a,b)
        path2=None
        if len(s)==3:
            c=s[2]
            path2,d2=g.minPath(b,c)
            d+=d2
        if path==[] or path2==[] :
            if len(s)==3: print(a+' can\'t reach '+c+' via '+b)
            else: print(a+'  can\'t reach '+b)
            continue
        if path2!=None:path+=path2[1:]
        print('distance : ',d)
        print('path','-->'.join(path))


if __name__ =='__main__':
    s=input('1. undireted\n2. directed\n')
    flag=input('name vertex by 1. num(1-index) or 2. string?   ').strip()
    dic={}
    g = graph()
    if s=='2': g=directed.graph()
    v,e=input('input vertex num & edge num: ').strip().split(' ')
    v,e=int(v),int(e)
    if flag=='1':
        for i in range(v):
            tmp=str(i+1)
            dic[tmp]=tmp
            g.addVertex(tmp)
    else:
        print('input vertex name line by line')  
        for i in range(v):
            dic[str(i+1)]=input().strip()
            g.addVertex(dic[str(i+1)])
    print('input edge info line by line')        
    for i in range(e):
        li=input().strip().split(' ')
        a,b,w=li[0],li[1],1
        if len(li)==3:w=int(li[2])
        a,b=dic[a],dic[b]
        g.addEdge(a,b,w)
    print('you\'ve build graph :')
    g.display()
    loop(dic)
'''
6 6
1 2 5
1 3 1
2 6 1
2 5 1
4 5 2
3 4 1
1 5
'''

'''
6 10
NewYork
LA
BeiJing
HeFei
SiChuan
Paris
2 1
5 3
6 1
3 1
4 4
1 3
2 1
5 1
2 4
3 4
SiChuan NewYork
Paris HeFei
V4<---V3<---V2<---V1
3
V4<---V3<---V2
2
'''
