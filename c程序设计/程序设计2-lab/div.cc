#include<stdio.h>
#include<string.h>
#define LENGTH 100
int a[LENGTH+1],b[LENGTH+1],rst[LENGTH+1];
    
void getData(int a[])
{
    char s[LENGTH+1];
    scanf("%s",s);
    for(int i=strlen(s)-1,k=0;i>=0;++k,--i)
        a[k]=s[i]-'0';
}
void print(int a[],int n=LENGTH)
{
    int i;
    for(i=n;a[i]==0&&i>=0;--i);
    for(int j=i;j>=0;--j)
        printf("%d",a[j]);
    printf("\n");
}
int noLessThan(int a[],int b[],int n)
{
    int i,j;
    for(int i=LENGTH;a[i]==0&&i!=0;--i);
    for(int j=LENGTH;b[j]==0&&j!=0;--j);
        printf("%d@%d\n",i,j+n);
    if(i<j+n) return 0;
    else if(i==j+n){
        while(j>=0&&a[j+n]==b[j]) --j;
        if(a[j+n]<b[j]) return 0;
    }
    return 1;
}
void sub(int a[],int b[],int n)
{
    int j;
    for(int j=LENGTH;b[j]==0&&j!=0;--j);
    for(int i=0;i<=j;++i)
        a[i+n]-=b[i];
    for(int i=0;i<=j;++i){
        int tmp=a[i],delta=0;
        while(tmp<0){
            a[i+delta]=tmp+10;
            ++delta;
            tmp=a[i+delta]-=1;
        }
    }
}

int div(int a[],int b[],int rst[])
{
    int j;
    for( j=LENGTH;b[j]==0&&j!=0;--j);
    while(noLessThan(a,b,0)){
         int i;
         for( i=LENGTH;a[i]==0&&i!=0;--i);
         int n=i-j, delta=0;
         while(a[i+delta]==b[i+delta])--delta;
         if(a[i+delta]<b[i+delta]) --n;
         while(noLessThan(a,b,n)){
             sub(a,b,n);
             rst[n]+=1;
         }
    }
}         

int main()
{
    memset(a,0,sizeof(a));
    memset(b,0,sizeof(b));
    memset(rst,0,sizeof(rst));
    getData(a);
    getData(b);
  /*  if(!noLessThan(a,b,0)) rst[0]=0;
    else div(a,b,rst);
    print(rst);
    print(a);   */
    printf("%d",noLessThan(a,b,0));
    return 0;
}   