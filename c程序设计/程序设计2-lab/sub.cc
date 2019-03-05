#include<stdio.h>
#include<string.h>
#define length 100
int a[length+1],b[length+1],diff[length+1];
void add(int a[],int b[],int sum[])
{
    memset(sum,0,length);
    int i,j,k;
    for(i = length;a[i]==0&&i>=0;--i);
    for(j = length;b[j]==0&&j>=0;--j);
    int max = i>j?i:j;
    for(k = 0;k<=max;++k){
        int tmp = a[k]+b[k];
        if(tmp>10){
            sum[k+1] = tmp/10;
            sum[k] = tmp%10;
        }
        else sum[k] = tmp;
    }
}
int noLessThan(int a[],int b[])
{
    int i,j;
    for(i = length;a[i]==0&&i>=0;--i);
    for(j = length;b[j]==0&&j>=0;--j);
    if(i<j) return 0;
    else if(i==j){
       while(i>=0&&a[i]>=b[i])--i;
       if(i<0) return 0;
    }
    return 1;
}
void jiewei(int a[])
{
    int i;
    for(i = length;a[i]==0&&i>=0;--i);
    for(int j=0;j<=i;++j)
        if(a[j]<0){
            a[j]+=10;
            a[j+1]-=1;
        }
}
void sub(int a[], int b[],int diff[])
{
    int i,j,k;
    for(i = length;a[i]==0&&i>=0;--i);
    for(j = length;b[j]==0&&j>=0;--j);
    for(k = 0;k<=i;++k)
         diff[k]=a[k]-b[k];
    jiewei(diff);
}
void getData(int p[])
{
    char c[length+1];
    int i,k;
    gets(c);
    for(k = 0,i = strlen(c)-1;i>=0;++k,--i)
        p[k] = c[i]-'0';
}
void print(int p[],int maxLength)
{
    int i;
    for(i = maxLength;p[i]==0&&i>=0;--i);
    for(int j = i;j>=0;--j)   printf("%d",p[j]);
    if(p[i]==0)printf("0");
    printf("\n");
}
int main(void)
{
    getData(a);
    getData(b);
    if(noLessThan(a,b))
        sub(a,b,diff);
    else{
         int i;
         sub(b,a,diff);
         for( i=length;i>=0&&diff[i]==0;--i);
         diff[i]=-diff[i];
    }
    print(diff,length);
    return 0;
}