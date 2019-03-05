#include<iostream>
using namespace std;
int nextArrangement(int a[],int n)   //n个皇后
{
    int i;
    for(i=n;i>1&&a[i]<a[i-1];--i);
    if(i==1) return 0;
    int j;
    for(j=n;a[i-1]>a[j];--j);
    int tmp=a[i-1];
    a[i-1]=a[j];
    a[j]=tmp;
    for(int p=i,q=n;p<q;++p,--q){
        int tmp=a[p];
        a[p]=a[q];
        a[q]=tmp;
    }
    return 1;
}
int isOk(int a[],int n)
{
    for(int i=1;i<n;++i)
       for(int j=i+1;j<=n;++j)
          if((j-i)==(a[i]<a[j]?a[j]-a[i]:a[i]-a[j])) return 0;
    return 1;      
}
int main()
{
    int n;
    while(cin>>n){
        int total=0;
        if(n<6||n>11) break;
        int a[n+1];
        for(int i=1;i<=n;++i) a[i]=i;
        while(nextArrangement(a,n))
            if(isOk(a,n)) ++total;
        cout<<total<<endl;
    }
    return 0;
}