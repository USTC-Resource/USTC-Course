#include<stdio.h>
#include<math.h>
bool isIntersect(int x,int y)
    {
        int r1 = 2,c1 =0,r2=1,c2 = 3;
        if((x - r1)*(x - r2) > 0 || (y - c1)*(y - c2) >0)
            return false;
        float slope = (r1- r2)/(float)(c1-c2);
        float sum = slope*(y - c1 ) + r1 - x;
        sum = sum > 0 ? sum : -sum;
        if(sum / sqrt(1 + pow(slope,2))>0.5) return false;
        return true;
    }
    int main()
    {
        for(int i = 0;i<4;++i)
            for(int j = 0;j<4;++j)
                printf("i:%d,j:%d  rst:%d\n",i,j,isIntersect(i,j));
        return 0;
    }
