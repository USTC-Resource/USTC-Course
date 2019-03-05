#include<stdio.h>
int mth[12]={31,28,31,30,31,30,31,31,30,31,30,31};
int main(){
    int a,b,c,d,diff=0;
    scanf("%d%d%d%d",&a,&b,&c,&d);
    if(a==c)  diff=d-b;
    else{
        while(a<c)
            diff+=mth[a++-1];
        diff-=b-d;
        }        
    printf("%d\n",diff);
    return 0;
}