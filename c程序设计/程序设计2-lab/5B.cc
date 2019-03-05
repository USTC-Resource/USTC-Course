#include<stdio.h>
int data[5][4];
void analysis(int p,int q,int i,int j)
{
     data[i][2]+=p;
     data[i][3]+=q;
     data[j][2]+=q;
     data[j][3]+=p;
    if(p>q)
        data[i][1]+=3;
    else if(p==q){
        data[i][1]+=1;        
        data[j][1]+=1;    
       }
     else
          data[j][1]+=3;
}
void cmp(int i,int j)
{
    if(data[i][1]<data[j][1])
        data[i][0]+=1;
    else if(data[i][1]>data[j][1])
        data[j][0]+=1;
    else{
        int tmp=data[i][2]-data[i][3]-data[j][2]+data[j][3];
        if(tmp<0) data[i][0]+=1;
        else if(tmp>0) data[j][0]+=1;
        else{
            if(data[i][2]<data[j][2]) data[i][0]+=1;
            else if(data[i][2]>data[j][2]) data[j][0]+=1;
        }
    }
 }               
int main()
{
    for(int i=1;i!=5;++i)
        for(int j=1;j!=5;++j)
            data[i][j]=0;//initialize           
    int p,q;
    scanf("%d:%d",&p,&q);
    analysis(p,q,1,2);
    scanf("%d:%d",&p,&q);
    analysis(p,q,3,4);
    scanf("%d:%d",&p,&q);
    analysis(p,q,1,3);
    scanf("%d:%d",&p,&q);
    analysis(p,q,4,2);
    scanf("%d:%d",&p,&q);
    analysis(p,q,2,3);
    scanf("%d:%d",&p,&q);
    analysis(p,q,4,1);
    for(int i=1;i!=4;++i)
        for(int j=i+1;j!=5;++j)
            cmp(i,j);
    for(int i=1;i!=5;++i){
        printf("%d %d %+d %d %d %c\n",data[i][0]+1,data[i][1],data[i][2]-data[i][3],data[i][2],data[i][3],data[i][0]<2?'Y':'N');
    }
    return 0;
}