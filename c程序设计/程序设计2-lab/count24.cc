#include<stdio.h>
#define EPS 0.01
int isZero(float n)
{
    if(n<0.01&&-n<0.01) return 1;
    return 0;
}
int count(float a[],int n)
{
    if(n==1&&isZero(a[0]-24)) return 1;
    if(n==1) return 0;
    for(int i=0;i!=n;++i)
        for(int j=0;j!=n;++j){
            int tmp=0;
            float b[n-1];
            for(int k=0;k!=n;++k)
                 if(k!=i&&k!=j) b[tmp++]=a[k];
            b[tmp]=a[i]+a[j];
            if(count(b,n-1)) return 1;
            b[tmp]=a[i]*a[j];
            if(count(b,n-1)) return 1;
            b[tmp]=a[i]-a[j];
            if(count(b,n-1)) return 1;
            b[tmp]=a[j]-a[i];
            if(count(b,n-1)) return 1;
            if(!isZero(a[j])){
                 b[tmp]=a[i]/a[j];
                 if(count(b,n-1)) return 1;
            }
            if(!isZero(a[i])){
                 b[tmp]=a[j]/a[i];
                 if(count(b,n-1)) return 1;
            }
        }
            return 0;
}
int main()
{
    float a[4];
    while(1){
        scanf("%f%f%f%f",&a[0],&a[1],&a[2],&a[3]);
        if(isZero(a[0])) break;
        if(count(a,4)) printf("YES\n");
        else printf("NO\n");
    }
    return 0;
}