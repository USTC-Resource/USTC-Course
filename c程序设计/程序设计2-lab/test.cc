
#include<stdio.h>
#include<string.h>
#include<malloc.h>
#define ALL 362880
#define type char
int fac[9]={1,1,2,6,24,120,720,5040,40320};
int cantor(char *s)
{
    int sum = 1;
    for(int i = 0;i<9;++i){
        int tmp = s[i]-'0';
        int n = 0;
        for(int j= i+1;j < 9 ;++j){
            if(s[j]-'0' < tmp){
                ++ n;
            }
        }
        sum += n * fac[8-i];
    }
    return sum;
}

void sort(type *array,int end)
{
    int index;
    for(index=end-1;index!=0;--index)
        if(array[index-1]<array[index]) break;
    if(index == 0){
        for(int i=0,j=end-1;i<j;++i,--j){
            type tmp=array[i];
            array[i]=array[j];
            array[j]=tmp;
        }
        return;
    }
    for(int i=end-1;1;--i){
        if(array[index-1]<array[i]){
            type tmp=array[i];
            array[i]=array[index-1];
            array[index-1]=tmp;
            break;
        }
    }
    for(int i=index,j=end-1;i<j;++i,--j){
        type tmp=array[i];
        array[i]=array[j];
        array[j]=tmp;
    }
    return;
}

int main()
{
    char s[] = "012345678";
    while(strcmp(s,"876543210" )!= 0){
            printf("%d\n",cantor(s));
            sort(s,9);
    }
    return 0;
}
