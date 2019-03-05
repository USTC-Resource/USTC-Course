/* mbinary
#########################################################################
# File : graph.cc
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-04-26  10:33
# Description:
#########################################################################
*/

#include<iostream>
#include<vector>
#include<algorithm>
#include<list>
bool LOG=false;

using namespace std;

class edge;
class vertex
{
    friend ostream &operator<<(ostream&,const vertex *);
        friend ostream &operator<<(ostream&,const edge *);
    friend class graph;
    friend class edge;
public:
    vertex(int n,edge* arc = NULL):val(n),firstEdge(arc){isVisited=false;}
    ~vertex(){if(LOG)cout<<"V"<<val+1<<" is dead "<<endl;}
private:
    bool isVisited;
    int val ;
    edge* firstEdge;

};

class edge
{
    friend ostream &operator<<(ostream&,const edge *);
    friend ostream &operator<<(ostream&,const vertex *);
    friend class graph;
    friend class vertex;
public:
    edge(vertex * vo,vertex *vi,int w=1,edge *next=NULL):\
            out(vo),in(vi),weight(w),nextEdge(next){isVisited=false;}
    ~edge(){}
private:
    bool isVisited;
    int weight;
    vertex * in,*out;
    edge* nextEdge;
};
class graph
{
private:
    int vNum,eNum;
    vector<vertex*> vs;
    vector<edge*> es;
    bool weighted;
    bool directed;
public:
    graph():vNum(0),eNum(0),weighted(false),directed(false){}
    graph(int ,int,bool,bool);
    ~graph();
    void getData();
    void display();
    int minPath(int , int );
    void  reVisitVertex(){for (int i=0;i<vNum ;vs[i++]->isVisited=false )    ;}
    void  reVisitEdge(){for (int i=0;i<eNum ;es[i++]->isVisited=false )    ;}
};
graph::graph(int  n,int m,bool weighted,bool directed)\
            :vNum(n),eNum(m),weighted(weighted),directed(directed)
{
    cin.ignore(1);
    for (int i=0;i<vNum ;++i ) vs.push_back(new vertex(i))   ;
    int a,b,w=1;
    for (int i=0;i<eNum ;++i ){
        cin >>a >>b;
        --a,--b;
        if(weighted)cin>>w;
        edge *arc=new  edge (vs[a],vs[b],w,vs[a]->firstEdge);
        vs[a]->firstEdge = arc;
        es.push_back(arc);
    }
}
ostream& operator<<(ostream& os,const vertex* v)
{
    os<<"V"<<v->val+1<<"  -->";
    edge *arc= v->firstEdge;
    while(arc){
        os<<"  V"<<arc->in->val+1;
        arc=arc->nextEdge;
    }
    return os;
}
ostream& operator<<(ostream& os,const edge* e)
{
    os<<"V"<<e->out->val+1<<"--"<<e->weight<<"-->"<<e->in->val+1;
    return os;
}
graph::~graph()
{
    for (int i=0;i<vNum ;++i ){
        edge *arc = vs[i]->firstEdge;
        while(arc){
            edge *p=arc;
            arc=arc->nextEdge;
            delete p;
        }
        delete vs[i];
    }
}
void graph::display()
{
    cout<<"-----VERTEXS-----"<<endl;
    for(int i = 0;i<vs.size();cout<<vs[i]<<endl,++i);
    cout<<"------EDGES------"<<endl;
    for (int i=0;i<eNum ;cout<<es[i]<<endl,++i )    ;
}
int graph::minPath(int v,int u)
{
    vertex *p= vs[v-1],*q= vs[u-1];
    vector<vertex*> last;   // can't initialize  with n NULL ptr
    for (int i=0;i<vNum ;last.push_back(NULL),++i )    ;
    vector<int> distnace(vNum,-1);
    distnace[p->val] = 0;
    list<vertex*> que;
    que.push_back(p);
    while(!que.empty()){
        vertex * cur = que.front();
        que.pop_front();
        cur->isVisited = true;
        edge *arc  = cur->firstEdge;
        while(arc){
            vertex  * tmp=arc->in;
            if(! tmp->isVisited){
                que.push_back(tmp);
                int sum = arc->weight+distnace[arc->out->val];
                if(distnace[tmp->val]==-1){
                    distnace[tmp->val]= sum;
                    last[tmp->val] = arc->out;
                }
                else if(distnace[tmp->val]>sum){
                    distnace[tmp->val] = sum;
                    last[tmp->val] = arc->out;
                }
            }
            arc = arc->nextEdge;
        }
    }
    cout<<"path V"<<v<<" to V"<<u<<"\n";
    vertex *cur = q;
    while(cur&& last[cur->val]!=p ){
        cout<<"V"<<cur->val+1<<"<--";
        cur = last[cur->val];
    }
    reVisitVertex();
    if(! cur) {
        cout.clear();
        cout<<"there isn't path from V"<<v<<" to V"<<u<<endl;
        return -1;
    }
    cout<<endl;
    return distnace[u-1];
}
int main()
{
    int n,m ;
    bool weighted,directed;
    cout<<"weighted ? [y/N] :";
    if(cin.get()=='y') weighted = true;
    else weighted=false;
    cin.ignore(1);
    cout<<"directed ? [y/N] :";
    if(cin.get()=='y') directed= true;
    else directed= false;
    cout<<"input vertex num and edge num"<<endl;
    cin>>n>>m;
    graph g=graph(n,m,weighted,directed);
    g.display();
    return 0;
}


