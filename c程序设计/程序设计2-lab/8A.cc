#include<stdio.h>
#include<string.h>
char map[1000][1000];
void findone(int n,int i,int j)
{
    if(i<0||j<0||i>n-1||j>n-1)
        return ;
    if(map[i][j]=='.') return ;
    else{
        map[i][j]='.';
        findone(n,i-1,j);
        findone(n,i,1+j);
        findone(n,i,j-1);
         findone(n,i+1,j);
    }
}
int main()
{
    gets(map[0]);
    int n=strlen(map[0]); 
    for(int i=1;i<n;++i)  
        gets(map[i]);   
    int total=0;
    for(int i=0;i<n;++i)
        for(int j=0;j<n;++j)
            if(map[i][j]=='*') {
  //              printf("%d@%d\n",i,j);
                findone(n,i,j);
                ++total;
            }
     printf("%d\n",total);   
     return 0;
}   