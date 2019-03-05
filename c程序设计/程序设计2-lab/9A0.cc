#include<stdio.h>
#define EPS 0.001
//曾因EPS  0.00001，精度太高，而比较失败，得注意
int isZero(float n)
{
    if(n<EPS&&-n<EPS) return 1;
    return 0;
}
int count(float a[],int n )
{
//   for(int p=0;p!=n;++p) printf("%.2f ",a[p]);
//   printf("@@%d\n",n);
    if(n==1){
        float tmp=a[0]-24;
        if(isZero(tmp) ) return 1;
        else  return 0;
    }
    for(int i=0;i!=n-1;++i)
        for(int j=i+1;j!=n;++j){
            float b[n-1];
            int num=0;
            for(int k=0;k!=n;++k){
                if(k!=i&&k!=j)
                    b[num++]=a[k];
            }
            b[num]=a[i]+a[j];     
            if(count(b,n-1) )return 1;
            b[num]=a[i]*a[j];
            if(count(b,n-1)) return 1;
            b[num]=a[i]-a[j];
            if(count(b,n-1) )return 1;
            b[num]=a[j]-a[i];
            if(count(b,n-1)) return 1;            
            if(! isZero(a[j])){
                b[num]=a[i]/a[j];
               if(count(b,n-1)) return 1;
            }
            if(! isZero(a[i])){
                b[num]=a[j]/a[i];
               if(count(b,n-1)) return 1;
            }
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
          if(count(a,4))
                printf("YES\n");
         else  printf("NO\n");    
      }
}