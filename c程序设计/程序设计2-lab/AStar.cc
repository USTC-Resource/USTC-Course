//the AStar algorithm

#include<stdio.h>
#include<string.h>
#include<malloc.h>
#define ALL 362880

int fac[9]={1,1,2,6,24,120,720,5040,40320};

//0 for not appeared, 1 for appeared in future, 2 for passed
char flag[ALL];

//  if a num 's position of the target state is  row & cur state  col ,
// then the "distance" --h  is table[row][col]
char table[9][9]={
    0,1,2,1,2,3,2,3,4,
    1,0,1,2,1,2,3,2,3,
    2,1,0,3,2,1,4,3,2,
    1,2,3,0,1,2,1,2,3,
    2,1,2,1,0,1,2,1,2,
    3,2,1,2,1,0,3,2,1,
    2,3,4,1,2,3,0,1,2,
    3,2,3,2,1,2,1,0,1,
    4,3,2,3,2,1,2,1,0,
};
class node
{
  public:
      //f = g + h is the evaluation func
    int g;    //steps
    int h;   // the evaluated distance
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
    head -> h = 0;
    for(int i = 0; i<9;++i){
            head->h += table[8 - (s[i]-'0')][i];
    }
    head ->last = -1;
    for(int i = 0; i<9;++i){
        if(s[i] == '0'){
            head -> zero = i;
        }
        head->s[i] = s[i];
    }
}

// arrange a new state
void putIn(node *n)
{
    int f = n -> g + n -> h;
    node *tmp = head;
    for(;tmp<=tail; ++tmp){
        if(f < tmp -> g+ tmp -> h)
            break;
    }
    node *p ;
    for(p = tail;p>tmp;--p){
        *p = *(p-1);
    }
    *p = *n;
    ++tail;
}

//choose the smaller f of a state
void updt(node *n)
{
    node *tmp ;
    for(tmp = head; tmp < tail ;++tmp){
        if(strcmp(tmp -> s,n -> s) == 0){
            tmp -> g = n -> g;
            tmp -> last = n-> last;
            break;
        }
    }
    node *mid = new node();  //new  return a pointer ! Remember!
    for(node * i = tmp; i> head && (i->g +i->h < (i-1)->g + (i-1)->h); --i){
        *mid = *i;
        *i = * (i-1);
        *(i-1) = *mid;
    }
    delete mid;
}

int move()
{
    while(head!=tail){
        node *tmp = head;
        ++head;
        if(cantor(tmp->s) == ALL)
            return tmp -> g;
        flag[cantor(tmp -> s)] = 2;
        int dir[4] = {-3,1,3,-1};
        if(tmp -> last!= -1)
            dir[tmp-> last] = 0;
        if(tmp -> zero < 3) dir[0] = 0;
        if(tmp -> zero > 5) dir[2] = 0;
        if((tmp -> zero) %3 == 0) dir[3] = 0;
        if((tmp -> zero) %3 == 2) dir[1] = 0;
        for(int i = 0; i < 4;++i){
            if(dir[i] != 0){
                node *cur = new node();
                *cur = *tmp;
                int p = cur ->zero;
                cur -> zero = p + dir[i];
                cur -> s[p] = cur -> s[p+dir[i]];
                cur -> s[p+dir[i]] = '0';
                int pn = cantor(cur -> s);
                if(flag[pn] < 2){
                    cur -> g += 1;
                    cur->last = (2+i)%4;  //һβܷ,ƶ2+i%4
                    int delta = table[8 - cur -> s[p] + '0'][p] + table[8][cur -> zero] \
                                - table[8 - cur -> s[p] + '0'][cur -> zero] - table[8][p];
                    cur -> h += delta;
                    if(flag[pn] == 0) {
                        flag[pn] = 1;
                        putIn(cur);
                    }
                    else  updt(cur);
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
