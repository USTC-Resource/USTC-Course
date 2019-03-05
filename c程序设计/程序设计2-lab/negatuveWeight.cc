#include<stdio.h>
#include<math.h>
#define ABS(n)  n<0?-n:n
int sum;
void parse(int n)
{
     if(n<0){
            int i;
            for(i=0;wgt<-n;i+=2)  wgt*=4;
            if(wgt==-n) sum+=pow(10,i)*11;
            else {
                int tmp=pow(10,i);     
                sum+=tmp;
                parse(n+tmp);
                }
     }     
     else{
         
int main()
{
    int n;
    while(scanf("%d",&n)!=EOF){
        sum=0;
        int wgt=1;
       
        }
        printf("%d\n",sum);
    }
    return 0;
}