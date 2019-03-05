#include<stdio.h>
#define EPS 0.01
//曾因EPS  0.00001，精度太高，而比较失败，得注意
int isZero(float n)
{
    if(n<EPS&&-n<EPS) return 1;
    return 0;
}
/*注意!!!如果没有return 语句，返回int的函数默认返回非0值*/
int count(float a[],int n )
{
   for(int p=0;p!=n;++p) printf("%.2f ",a[p]);
       printf("@@%d\n",n);
    if(n==1&&isZero(a[0]-24))  return 1;
    else if(n==1)  return 0;
    for(int i=0;i!=n-1;++i)
        for(int j=i+1;j!=n;++j){
            float b[n-1];
            int num=0;
            for(int k=0;k!=n;++k){
                if(k!=i&&k!=j)
                    b[num++]=a[k];
            }
            b[num]=a[i]+a[j];     
            if(count(b,num+1) )return 1;
            b[num]=a[i]*a[j];
            if(count(b,num+1)) return 1;
            b[num]=a[i]-a[j];
            if(count(b,num+1) )return 1;
            b[num]=a[j]-a[i];
            if(count(b,num+1)) return 1;            
            if(! isZero(a[j])){
                b[num]=a[i]/a[j];
               if(count(b,num+1)) return 1;
            }
            if(! isZero(a[i])){
                b[num]=a[j]/a[i];
               if(count(b,num+1)) return 1;
            }
     }
     return 0;
}
int oprt(float a,float b,float r[][6],int i)
{
    if(!isZero(b))  r[i][1]=a/b;
    if(!isZero(a))  r[i][0]=b/a;
    r[i][4]=a+b;
    r[i][2]=a*b;
    r[i][3]=a+b;
    r[i][5]=a-b;
}
    
int count2(float a[])
{
    int n=4;
    for(int i=0;i!=n-1;++i)
        for(int j=i+1;j!=n;++j){
            float b[2]={0,0};
            int num=1;
            for(int k=0;k!=n;++k){
                if(k!=i&&k!=j)
                    b[num--]=a[k];
            }
            float r[2][6];
            float rst[36][6];
            for(int i=0;i!=36;++i)
                rst[i][0]=rst[i][1]=0;
            oprt(b[0],b[1],r,0);
            oprt(a[i],a[j],r,1);
            int pn=0;
            for(int i=0;i!=6;++i)
                for(int j=0;j!=6;++j){
                    oprt(r[0][i],r[1][j],rst,pn);
                    ++pn;
                }
           for(int i=0;i!=36;++i)
              for(int j=0;j!=6;++j)
                  if(isZero(rst[i][j]-24))  return 1;          
           }        
         return 0;
}
int main()
{
    while(1){
        float a[4];
        scanf("%f%f%f%f",&a[0],&a[1],&a[2],&a[3]);
        if(isZero(a[0])&&isZero(a[1])&&isZero(a[2])&&isZero(a[3]))
            break;
          int i;
          if(count(a,4)||count2(a))
                printf("YES\n");
         else  printf("NO\n");    
      }
}