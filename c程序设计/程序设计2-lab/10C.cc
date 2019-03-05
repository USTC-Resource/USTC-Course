#include<stdio.h>
#define MAX  2000
int a[MAX][MAX];
int n ,m;
int check(int row,int col,int p,int q)
{
    int r = p + row,c = q +col;
    for(int i=row;i<r-1;++i){
       if(a[i][col]==a[i+1][col])
            return 0;
  //  printf("%d@col",i);
    }
    for(int i=row;i<r;++i)
        for(int j=col;j<c-1;++j)
            if(a[i][j]==a[i][j+1])
                return 0;
   return 1;
}
int hasSubMatrix(int p,int q)
 {
    for(int drow=0;drow<=n-p;++drow)
        for(int dcol=0;dcol<=m-q;++dcol)
          if(check(drow,dcol,p,q))
            return 1;
    return 0;
}
int main(void)
{
    scanf("%d%d",&n,&m);
    for(int i=0;i<n;++i)
        for(int j=0;j<m;++j)
            scanf("%d",&a[i][j]);
    int maxRectangle=0,maxSquare=0;
    for(int i=n;i>0;--i)
        for(int j=m;j>0;--j)
            if(hasSubMatrix(i,j)){
                if(i*j>maxRectangle)
                   maxRectangle=i*j;
            }
     int up = n>m?m:n;
     for( int  i = up;i>0;--i)
        if(hasSubMatrix(i,i)){
                maxSquare=i*i;
                break;
        }
     printf("%d\n%d\n",maxSquare,maxRectangle);
    // printf("%d",check(0,0,a,n,m));
     return 0;
}
