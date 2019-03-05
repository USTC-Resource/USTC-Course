#include<stdio.h>
#include<string.h>
#include<math.h>
#define MAXLENGTH 9
#define MAXANT 200000
#define MAXCANNON 20
#define debug false
#define MAX 6

bool mp[MAXLENGTH][MAXLENGTH];
int n,m,time,leftTime,hormoneMap[MAXLENGTH][MAXLENGTH];
int dx[4] = {0,1,0,-1},dy[4] = {1,0,-1,0};
int alive[MAX] = {-1,-1,-1,-1,-1,-1};

class ant
{
    friend class cannon;
    int hp,curHp,x,y,num,dir,act ;
public:
    static int curN,getCake,total;
    void born();
    void move();
    void info();
    void die();
    void hormone();
    bool isDead();
    bool isHome();
    void grow();
    //void sort();
    // bool operator<(const ant &a)const{return a.act>act;};
    bool isIntersect(int,int,int,int);
} ants[MAXANT];
int ant::curN = 0 ;
int ant::total = 0;
int ant::getCake = -1;

void ant::grow()
{
    ++act;
}
void ant::die()
{
    --curN;
    mp[x][y] = false;
}
bool ant::isHome()
{
    return x == 0&&y == 0;
}
bool ant::isDead()
{
    return curHp < 0;
}
void ant::born()
{
    if(curN == 6 || mp[0][0]) return ;
    ++ curN;
    num = total ++;
    for(int i = 0; i<MAX; ++i)
        if(alive[i] == -1)
        {
            alive[i] = num;
            break;
        }
    x = y = 0;
    mp[x][y] = true;
    dir = -1;
    act = 1;
    curHp = hp = (int)(4*pow(1.1,num/6+1));
}
void ant::info()
{
    printf("%d %d %d %d %d\n",act - 1,num/6+1,curHp,x,y);
}
void ant::hormone()
{
    if(getCake == num)
        hormoneMap[x][y] +=5;
    else
        hormoneMap[x][y] +=2;
}
void ant::move()
{
    bool canMove[4] = {true,true,true,true};
    if(dir != -1)
    {
        canMove[(dir+2)%4] = false;
    }
    int hormone = -1;
    bool stay = true;
    for(int i = 0; i<4; ++i)
    {
        if(canMove[i])
        {
            int tx = x + dx[i],ty = y + dy[i];   //wrongly type dx  ,and waste a lot of time
            if(tx<0||tx>n||ty<0||ty>m||mp[tx][ty] )
            {
                canMove[i]  = false;
                continue;
            }
            if(hormoneMap[tx][ty]>hormone)
            {
                hormone = hormoneMap[tx][ty];
                stay = false;
                dir = i;
            }
        }
    }
    if(stay)
    {
        dir = -1;
        if(getCake == -1&&x==n&&y==m)
        {
            getCake = num;
            curHp += hp/2;
            if(curHp>hp)curHp = hp;
        }
        return;
    }
    if(act%5 == 0)
    {
        dir = (dir+3)%4;
        while(!canMove[dir])
            dir = (dir+3)%4;
    }
    mp[x][y]=false;
    x+=dx[dir],y+=dy[dir];
    mp[x][y] = true;
    if(getCake == -1&&x==n&&y==m)
    {
        getCake = num;
        curHp += hp/2;
        if(curHp>hp)curHp = hp;
    }
}
void show()
{
    //ants[0].sort();
    printf("%d\n",ant::curN);
    for(int i =0; i<ant::total; ++i)
        if(!ants[i].isDead())
            ants[i].info();
}
bool ant::isIntersect(int r1,int c1,int r2,int c2)
{
    if((x - r1)*(x - r2) > 0 || (y - c1)*(y - c2) >0)
        return false;
    float slope = (r1- r2)/(float)(c1-c2);
    float sum = slope*(y - c1 ) + r1 - x;
    sum = sum > 0 ? sum : -sum;
    if(sum / sqrt(1 + pow(slope,2))>0.5) return false;
    return true;
}

class cannon
{
    int x,y;
public:
    static int num,power,span;
    void attack();
    void focus();
    void pos();
    float dis(int,int);
} cannons[MAXCANNON];

int cannon::num = 0;
int cannon::power = 0;
int cannon::span = 0;
void cannon::pos()
{
    scanf("%d%d",&x,&y);
    mp[x][y] = true;
}
float cannon::dis(int r,int c)
{
    return sqrt(pow(r-x,2)+pow(c-y,2));
}
bool in(int i)
{
    for(int k = 0; k <MAX; ++k)if(alive[k] == i)
            return true;
    return false;
}
void cannon::attack()
{
    int target = -1;
    float minD = MAXLENGTH *2;
    for(int i = 0; i<ant::total; ++i)
    {
        if(in(i))    //Ϊ! ants[i].isDead(), wrong, waste lots of time
        {
            float d = dis(ants[i].x,ants[i].y);
            if(d <= span&&d < minD)
            {
                minD = d;
                target = i;
            }
        }
    }
    if(debug)printf("cannon x%d y%d  d %f  target:%d\n",x,y,minD,target);
    if(target!=-1)ants[target].curHp -= power;
}
void cannon::focus()
{
    int tx = ants[ant::getCake].x, ty = ants[ant::getCake].y;
    float d = dis(tx,ty);
    if(d > span) this -> attack();
    else
    {
        for(int i = 0; i < MAX; ++i)
        {
            if(alive[i] != -1)
            {
                if(ants[alive[i]].isIntersect(x,y,tx,ty))
                    ants[alive[i]].curHp -= power;
            }
        }
    }
}
int init()
{
    scanf("%d%d",&n,&m);
    scanf("%d%d%d",&cannon::num,&cannon::power,&cannon::span);
    memset(mp,0,sizeof(mp));
    memset(hormoneMap,0,sizeof(hormoneMap));
    for(int i=0; i<cannon::num; ++i)
    {
        cannons[i].pos();
    }
    scanf("%d",&time);
    leftTime = time;
}
int _1s()
{
    if(debug)
    {
        show();
    }
    int tl = ant::total;
    ants[tl].born();
    for(int i = 0; i<MAX; ++i)
    {
        if(alive[i]!=-1)
        {
            ants[alive[i]].hormone();
        }
    }
    for(int i = 0; i<ant::total; ++i)
    {
        if(!ants[i].isDead())
        {
            ants[i].move();
        }
    }
    for(int i = 0; i< cannon::num; ++i)
    {
        if(ant::getCake !=-1) cannons[i].focus();
        else cannons[i].attack();
    }
    if(ant::getCake != -1)
    {
        if( ants[ant::getCake].isDead() )
            ant::getCake = -1;
        else if(ants[ant::getCake].isHome())
            return 1;
    }
    for(int i = 0; i<MAX; ++i)
    {
        if(alive[i] != -1 &&ants[alive[i]].isDead())
        {
            ants[alive[i]].die();
            alive[i] = -1;
        }
        else ants[alive[i]].grow();
    }
    for(int i = 0; i<=n; ++i)
        for(int j = 0; j<= m; ++j)
            if(hormoneMap[i][j] > 0) --hormoneMap[i][j];
    return 0;
}
int main(void)
{
    init();
    while(--leftTime >=0)
    {
        if(debug)printf("%dth s\n",time - leftTime);
        if(_1s() == 1)
        {
            printf("Game over after %d seconds\n",time - leftTime);
            show();
            return 0;
        }
    }
    printf("The game is going on\n");
    show();
    return 0;
}
