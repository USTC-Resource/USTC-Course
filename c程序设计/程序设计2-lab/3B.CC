#include<stdio.h>
#include<string.h>
char map[29];//映射关系,0--25为密码
int match()
{
    memset(map,0,sizeof(char)*26);
    char origin[104],code[104];
    gets(origin);
    gets(code);//code为原信息，origin为密码   
    for(int i=0;origin[i];++i){
        int tmp=origin[i]-'A';
        if(map[tmp]){
            if(map[tmp]!=code[i]) return 0;
        }
        else {
            map[tmp]=code[i];
        }
    }
    for(int i=0;i!=26;++i)
      if(!map[i]) return 0;
    return 1;
}
void run()
{
    char words[104];
    if(match()){    
        gets(words);  
        for(int i=0;words[i];++i)
            words[i]=map[words[i]-'A'];
        printf("%s\n",words);
        return ;
    }
    else{
        gets(words);
        printf("Failed\n");
    }
}

int main(void)
{
    run();
    return 0;
}