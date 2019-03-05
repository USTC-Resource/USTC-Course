#include<stdio.h>
#include<string.h>
#define LENGTH 100
void jinwei(int a[])
{
    int i;
    for(i=LENGTH*2;a[i]==0&&i!=0;--i);
    for(int j=0;j<=i;++j){
        int sum=a[j];
        int delta=0;
        a[j]=sum%10;
        while(sum!=0){            
            sum/=10;
            ++delta;
            a[j+delta]+=sum%10;
        }
    }
}
void mul(int a[],int b[],int rst[])
{
    int i,j;
    for(i=LENGTH;a[i]==0&&i!=0;--i);
    for(j=LENGTH;b[j]==0&&j!=0;--j);
    for(int k=0;k<=i;++k){
        for(int p=0;p<=j;++p)
            rst[k+p]+=a[k]*b[p];
    }
    jinwei(rst);
}
void print(int a[],int n=LENGTH)
{
    int i;
    for(i=n;a[i]==0&&i>=0;--i);
    for(int j=i;j>=0;--j)
        printf("%d",a[j]);
    printf("\n");
}
int main()
{
    int a[LENGTH+1],b[LENGTH+1],rst[LENGTH*2+1];
    char sa[LENGTH+1],sb[LENGTH+1];
    while( scanf("%s %s",sa,sb)!=EOF){
    int enda,endb;
    if(sa[0]=='-')enda=1;
    else enda=0;
    if(sb[0]=='-') endb=1;
    else endb=0;
    for(int i=strlen(sa)-1,k=0;i>=enda;++k,--i)
        a[k]=sa[i]-'0';
    for(int i=strlen(sb)-1,k=0;i>=endb;++k,--i)
        b[k]=sb[i]-'0';
    if(enda!=endb) printf("-");
    memset(a,0,sizeof(a));
    memset(b,0,sizeof(b));
    memset(rst,0,sizeof(rst));
    mul(a,b,rst);
    print(a);
    print(b);
    print(rst,2*LENGTH);
   }
    return 0;
}