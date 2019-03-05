#include<stdio.h>
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