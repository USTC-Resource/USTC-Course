#include<stdio.h>
#include<string.h>
#include<malloc.h>
#define ALL 362880

int fac[9]={1,1,2,6,24,120,720,5040,40320};

//0 for not appeared, 1 for appeared in future, 2 for passed
char flag[ALL];


class node
{
  public:
      //f = g + h is the evaluation func
    int g;    //steps
    int zero;
    char s[9];
    char last;
};
node states[ALL];
node *head = states;
node *tail;

//notice how to get cantor func
int cantor(char *s)
{
    int sum = 1;
    for(int i = 0;i<9;++i){
        int n = 0;
        for(int j= i+1;j < 9 ;++j){
            if(s[j] < s[i]){
                ++ n;
            }
        }
        sum += n * fac[8-i];
    }
    return sum;
}
void init(char *s)
{
    memset(states,0,sizeof(node)*ALL);
    memset(flag,0,sizeof(flag));
    flag[cantor(s)] = 1;
    tail = head+1;
    head -> g = 0;
    head ->last = -1;
    for(int i = 0; i<9;++i){
        if(s[i] == '0'){
            head -> zero = i;
        }
        head->s[i] = s[i];
    }
}

int move()
{
    while(head!=tail){
        node *tmp = head;
        ++head;
        if(cantor(tmp->s) == ALL)
            return tmp -> g;
        flag[cantor(tmp -> s)] = 1;
        int dir[4] = {-3,1,3,-1};
        if(tmp -> last!= -1)
            dir[tmp-> last] = 0;
        if(tmp -> zero < 3) dir[0] = 0;
        if(tmp -> zero > 5) dir[2] = 0;
        if((tmp -> zero) %3 == 0) dir[3] = 0;
        if((tmp -> zero) %3 == 2) dir[1] = 0;
        for(int i = 0; i < 4;++i){
            if(dir[i] != 0){
                *tail = * tmp;
                int p = tail ->zero;
                tail -> zero = p + dir[i];
                tail -> s[p] = tmp -> s[p+dir[i]];
                tail -> s[p+dir[i]] = '0';
                int pn = cantor(tail -> s);
                if(flag[pn] == 0){
                    tail -> g += 1;
                    tail->last = (2+i)%4;  //һβܷ,ƶ2+i%4
                    ++tail;
                    flag[pn] = 1;
                }
            }
        }
    }
}
char readChar()
{
    char c =' ';
    while (c==' ' || c== '\n')
        c=getchar();
    return c;
}
int main(void)
{
   // char s[10] = "876543210";
    char s[9];
    for(int i = 0 ;i<9;++i){
        s[i] = readChar();
    }
    init(s);
    printf("%d\n",move());
    return 0;
}
