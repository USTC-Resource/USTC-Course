#include<stdio.h>
int main()
{
    int n;
    scanf("%d",&n);
    int i,j,k,sum=0;
    for(i=0;i<=n;++i)
        for(j=0;j<=n;++j){
            if((i+j)%2==0){
                for(k=0;k<=n;++k){
                    if((j+k)%3==0&&(i+j+k)%5==0){
                        if(i+j+k>sum) sum=i+k+j;
                    }
                }
            }
        }       
     printf("%d\n",sum);
     return 0;
}