#include<cstdio>
#include<cstdlib>
#include<iostream>
using namespace std;

struct peanut
{
    int x,y,value;
};
int m,n,k,t;
int mov(int now,peanut p[])
{
    int diff;
    diff=abs(p[now-1].x-p[now].x)+abs(p[now-1].y-p[now].y);
    return diff;
}

void sort(peanut p[])
{
   for (int i=1;i<t;i++)
     for (int j=i+1;j<=t;j++)
       if (p[i].value<p[j].value) 
       {
           swap(p[i].x,p[j].x);
           swap(p[i].y,p[j].y);
           swap(p[i].value,p[j].value);
       }
}

int main()
{
   cin>>m>>n>>k;
   t=0;
   struct peanut p[(m+1)*(n+1)];
   int i,j;
   for (i=1;i<=m;i++)  
    for (j=1;j<=n;j++)
     {
        cin>>p[++t].value;
        p[t].x=j; p[t].y=i;
        if (p[t].value==0) {t--;}
     }
   sort(p);
   int now=1,total=0;
   p[0].x=p[1].x;p[0].y=0; p[0].value=0; 
   while ((k>0)&&((k-mov(now,p))>p[now].y))
   {
       k-=mov(now,p);
       k--;
       total+=p[now].value;
       now++;
   }
   cout<<total;
   return 0;
}
/*#include<stdio.h>
struct fuck{
    int val;
    int x,y;
};
int main(void)
{
    int row,col,time;
    scanf("%d %d %d",&row,&col,&time);
    fuck pnt[row*col];
    int num=0;
    for(int i=1;i<=row;++i)
        for(int j=1;j<=col;++j){
            int tmp;
            scanf("%d",&tmp);
            if(tmp>0){
                 pnt[num].val=tmp;
                 pnt[num].x=i;
                 pnt[num++].y=j;
            }
        }
    int total=0, max,p,q,p2=0,q2;
    while(1){
        max=0;
        for(int i=1;i<num;++i)          
                if(max<pnt[i].val){
                    max=pnt[i].val;
                    p=pnt[i].x;
                    q=pnt[i].y;
                    pnt[i].val=0;
                }
        int tmp= p>p2?p-p2:p2-p;
        if(p2==0) q2=q;
        time-=(1+(q>q2?q-q2:q2-q)+tmp);        
        if(time>=tmp&&max!=0){
            total+=max;
            p2=p,q2=q;           
        }
        else{
            printf("%d\n",total);
            return 0;
        }
    }
}*/