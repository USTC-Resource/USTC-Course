#include<stdio.h>
#define type float
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
void once(type *array,int end,int num)
{
    for(int i=0;i!=num;++i){
        sort(array,end);
    }
    printf("the next %d arrangement is:\n",num);
    for(int i=0;i!=end;++i){
        printf("%.0f  ",array[i]);
    }        
    return ;
}
void run1()
{
    int total;
    scanf("%d",&total);
    if(total<=0){
        printf("input data error!Exit system\n");
        return;
    }
    for(int i=0;i!=total;++i){
        int end,num;
        scanf("%d%d",&end,&num);
        type array[end];
        for(int j=0;j!=end;++j)
            scanf("%f  ",array+j);
        once(array,end,num);
    }
    return;
}
void run2()
{
        int end,num;
        scanf("%d%d",&end,&num);
        type *array;
        for(int j=0;j!=end;++j)
            scanf("%f",array+j);
        once(array,end,num);
        return;
}
int main(void)
{
    run2();
    return 0;
}