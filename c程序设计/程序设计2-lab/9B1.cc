#include<cstdio>
#include<cstring>
const int MAXSIZE = 1e6;
const int HASHSIZE = 1e6 + 3;
const int mask = 1|2|4;
int hashTable[HASHSIZE];
int front,rear,cur;
void inline lookbit(int x){
    for(unsigned i = 1<<31;i;i>>=1)
        printf("%d",i&x?1:0);
    printf("\n");
}
struct A{
    int state,p;
    char dir;
}Q[MAXSIZE];
struct B{
    int state,nx;
}next[MAXSIZE];
inline int swap(int x, int dist){
    int l=x>>27;
    int t=0;
    t|=(((x>>(8-(l+dist))*3))&mask)<<(8-l)*3;
    x&=~(mask<<(8-l-dist)*3);
    t|=x;
    t&=~0U>>5;
    return t|((l+dist)<<27);
}
void printAns(int c,int s){
    if(Q[c].state != s){
        printAns(Q[c].p,s);
        putchar(Q[c].dir);
    }
}
inline int getHashNum(int x){
    return x % HASHSIZE;
}
bool trytoInsert(int x){
    int i = getHashNum(x);
    int l = hashTable[i];
    while(l != -1){
        if(next[l].state == x)
            return false;
        l = next[l].nx;
    }
    next[cur].nx = hashTable[i];
    next[cur].state = x;
    hashTable[i] = cur++;
    return true;
}

void bfs(int s,int t){
    register int temp;
    Q[rear++].state = s;
    while(front < rear){
        int x = Q[front++].state;
        if(x==t){
            printAns(front-1,s);
            return;
        }
        int z = x>>27;
        if(z/3>0){
            temp = swap(x, -3);
            if(trytoInsert(temp)){
                Q[rear].state = temp;
                Q[rear].dir = 'u';
                Q[rear++].p = front - 1;
            }
        }
        if(z/3<2){
            temp = swap(x, 3);
            if(trytoInsert(temp)){
                Q[rear].state = temp;
                Q[rear].dir = 'd';
                Q[rear++].p = front - 1;
            }
        }
        if(z%3>0){
            temp = swap(x, -1);
            if(trytoInsert(temp)){
                Q[rear].state = temp;
                Q[rear].dir = 'l';
                Q[rear++].p = front - 1;
            }
        }
        if(z%3<2){
            temp = swap(x, 1);
            if(trytoInsert(temp)){
                Q[rear].state = temp;
                Q[rear].dir = 'r';
                Q[rear++].p = front - 1;
            }
        }
    }
    printf("unsolvable\n");
}
int main(){
    memset(hashTable,-1,sizeof(hashTable));
    char str[2];
    int s = 0, t = 0, j = 24;
    for(int i = 0; i < 9; i++, j -= 3){
        scanf("%s",str);
        if(*str!='x'){
            s|=*str-'1'<<j;
        }else{
            s|=i<<27;
        }
    }

    j = 24;
    t|= 8<<27;
    for(int i = 0; i < 8; i++, j -= 3){
        t|=i<<j;
    }

    bfs(s,t);
    return 0;
}
