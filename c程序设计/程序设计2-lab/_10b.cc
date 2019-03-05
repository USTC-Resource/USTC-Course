#include<cstdio>
#include<iostream>
#include<cstring>
#include<cmath>
#include<algorithm>
using namespace std;
int n,m,s,tur_d,r,T,born;
int in[11][11];
int xx[4]={0,1,0,-1},yy[4]={1,0,-1,0};
bool getcake,mp[11][11];
struct tur{int x,y;}tur[31];
struct ant{int lev,hp,age,x,y,lx,ly,mx;bool live,cake;}a[11];
struct point{int x,y;};
struct line{point a,b;}l;
point sub(point a,point b){point t;t.x=a.x-b.x;t.y=a.y-b.y;return t;}
int cmul(point a,point b){return a.x*b.y-a.y*b.x;}
int turn(point a,point b,point c){return cmul(sub(b,a),sub(c,a));}
int sqr(int x){return x*x;}
double caldis(int x1,int y1,int x2,int y2)
{return sqrt(sqr(x1-x2)+sqr(y1-y2));}
int cdis(int x,int y)
{return sqr(tur[x].x-a[y].x)+sqr(tur[x].y-a[y].y);}
double getdis(int x,int y)
{return sqrt(cdis(x,y));}
bool cmp(ant a,ant b){return a.age>b.age;}
void bornint(int k)
{
    int l=born/6+1;
    a[k].lev=l;
    a[k].hp=a[k].mx=int(4*pow(1.1,l));
    a[k].age=0;a[k].live=1;
    a[k].x=a[k].y=a[k].lx=a[k].ly=0;
    mp[0][0]=1;
    born++;
}
bool jud(int x,int y,int lx,int ly)
{
   if(mp[x][y]||x<0||y<0||x>n||y>m)return 0;
   if(x==lx&&y==ly)return 0;
   return 1;
}
void move(int k,int dir)
{
    int x=a[k].x,y=a[k].y;
    if(dir==-1){a[k].lx=x;a[k].ly=y;return;}
    int nowx=x+xx[dir],nowy=y+yy[dir];
    mp[x][y]=0;mp[nowx][nowy]=1;
    a[k].lx=x;a[k].ly=y;a[k].x=nowx;a[k].y=nowy;
}
void spmove(int k,int dir)
{
    int x=a[k].x,y=a[k].y,lx=a[k].lx,ly=a[k].ly;
    for(int i=(dir-1+4)%4;;i=(i-1+4)%4)
    {
        int nowx=x+xx[i],nowy=y+yy[i];
        if(jud(nowx,nowy,lx,ly))
           {move(k,i);return;}
    }
}
void premove(int k)
{
    int x=a[k].x,y=a[k].y,lx=a[k].lx,ly=a[k].ly;
    int mx=-0x7fffffff,dir=-1;
    for(int i=0;i<4;i++)
    {
       int nowx=x+xx[i],nowy=y+yy[i];
       if(jud(nowx,nowy,lx,ly)&&mx<in[nowx][nowy])
          mx=in[nowx][nowy];
    }
    for(int i=0;i<4;i++)
    {
       int nowx=x+xx[i],nowy=y+yy[i];
       if(jud(nowx,nowy,lx,ly)&&(mx==in[nowx][nowy])){dir=i;break;}
    }
    if((a[k].age+1)%5!=0||dir==-1)move(k,dir);
    else spmove(k,dir);
}
bool cross(int x,int y)
{
    double d=caldis(l.a.x,l.a.y,l.b.x,l.b.y);
    if(x==l.a.x&&y==l.a.y||x==l.b.x&&y==l.b.y)return 1;
    int x1=min(l.a.x,l.b.x),x2=max(l.a.x,l.b.x);
    int y1=min(l.a.y,l.b.y),y2=max(l.a.y,l.b.y);
    if(x<x1||x>x2|y<y1||y>y2)return 0;
    point p;p.x=x;p.y=y;
    if(fabs(turn(l.a,l.b,p))/d<=0.5)return 1;
    return 0;
}
void print();
void attack(int k)
{
    print();
    int tmp=-1,dis=0x7fffffff;
    for(int i=1;i<=6;i++)if(a[i].live)
    {
        int d=cdis(k,i);
        if(d<=r*r)
        {
            if(a[i].cake)tmp=i;
            else if(!a[tmp].cake&&d<dis)
            {dis=d;tmp=i;}
        }
    }
    if(tmp==-1)return;
    l.a.x=tur[k].x;l.a.y=tur[k].y;
    l.b.x=a[tmp].x;l.b.y=a[tmp].y;
    for(int i=1;i<=6;i++)
       if(a[i].live)
       {
           if(cross(a[i].x,a[i].y))
               a[i].hp-=tur_d;
       }
}
bool solve(int t)
{
    if(!mp[0][0])
       for(int i=1;i<=6;i++)
          if(!a[i].live)
             {bornint(i);break;}
    sort(a+1,a+7,cmp);
    for(int i=1;i<=6;i++)if(a[i].live)
       {
           int x=a[i].x,y=a[i].y;
           if(a[i].cake)in[x][y]+=5;
           else in[x][y]+=2;
       }
    for(int i=1;i<=6;i++)if(a[i].live)
       premove(i);
    if(!getcake)
       for(int i=1;i<=6;i++)if(a[i].live)
              if(a[i].x==n&&a[i].y==m)
              {
                 a[i].cake=1;
                 getcake=1;
                 a[i].hp=min(a[i].mx,a[i].hp+a[i].mx/2);
              }
    for(int i=1;i<=s;i++)attack(i);
    for(int i=1;i<=6;i++)if(a[i].live)
          if(a[i].hp<0)
          {
              mp[a[i].x][a[i].y]=0;
              a[i].live=0;
              if(a[i].cake)a[i].cake=getcake=0;
          }
    if(getcake)
       for(int i=1;i<=6;i++)if(a[i].live)
          if(a[i].x==0&&a[i].y==0&&a[i].cake)return 1;
    for(int i=0;i<=n;i++)
       for(int j=0;j<=m;j++)
          if(in[i][j]>0)in[i][j]--;
    for(int i=1;i<=6;i++)if(a[i].live)
          a[i].age++;
    return 0;
}
void ini()
{
    scanf("%d%d",&n,&m);
    scanf("%d%d%d",&s,&tur_d,&r);
    for(int i=1;i<=s;i++)
    {
       scanf("%d%d",&tur[i].x,&tur[i].y);
       mp[tur[i].x][tur[i].y]=1;
    }
    scanf("%d",&T);
}
void print()
{
    int cot=0;
    sort(a+1,a+7,cmp);
    for(int i=1;i<=6;i++)if(a[i].live)cot++;
    printf("%d\n",cot);
    for(int i=1;i<=6;i++)
       if(a[i].live)
          printf("%d %d %d %d %d\n",a[i].age,a[i].lev,a[i].hp,a[i].x,a[i].y);
    }
int main()
{
    ini();
    for(int i=1;i<=T;i++)
        if(solve(i))
        {
            printf("Game over after %d seconds\n",i);
            print();
            return 0;
        }
    printf("The game is going on\n");
    print();
    return 0;
}
