#include<stdio.h>
#include<string.h>
#define length 30
int a[length+1],b[length+1],product[2*length+1];

void jinwei(int p[],int n)
{
    int tmp = p[n],i = 0;
    p[n] = tmp%10;
    while((tmp/=10)!=0){
        p[n+(++i)]+= tmp%10;
    }
    p[n+(++i)]+= tmp%10;
}
void mul(int a[],int  b[],int product[])
{
    int i,j;
    for(i = length;a[i]==0&&i>=0;--i);
    for(j = length;b[j]==0&&j>=0;--j);
    memset(product,0,sizeof(int)*2*length);
    for(int k = 0;k<=j;++k){
        for(int p = 0;p<=i;++p){
            product[p+k]+=b[k]*a[p];
        }
    }
    for(i = 2*length;product[i]==0&&i>=0;--i);
    for(j = 0;j<=i;++j)
        jinwei(product,j);
}
void getData(char *s)
{
    int k,i;
    for(k = 0,i = strlen(s)-1;i>0&&s[i]!=' ';++k,--i)
        a[k] = s[i]-'0';
    for(k = 0,i--;i>=0;++k,--i)
        b[k] = s[i]-'0';
}
void print(int p[],int maxLength)
{
    int i;
    for(i = maxLength;p[i]==0&&i>=0;--i);
    for(int j = i;j>=0;--j)   printf("%d",p[j]);
    if(p[i]==0)printf("0");
}
int main(void)
{
    char s[61];
    memset(s,0,sizeof(s));
    while(scanf("%s",s)!=EOF){
    getData(s);
    memset(s,0,sizeof(s));
    mul(a,b,product);
    print(product,2*length);
    printf("\n");
    }
    return 0;
}
