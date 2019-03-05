/* mbinary
#########################################################################
# File : polynomial.cpp
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-05-19  23:07
# Description:
#########################################################################
*/

#include<cstdlib> 
#include<cstdio>
#include<cstring>
#include<cmath>
#include<malloc.h>
#include<map>
using namespace std;

#if defined(__linux__)
    #define LINUX true 
#elif defined(_WIN32)
    #define LINUX false
#endif


bool  isZero(double a)
{
    if((a<0.00001)&&-a<0.00001)
        return true;
    return false;
}
class node
{
    friend class polynomial;
    double coefficient;
    double index;
};
class polynomial
{
    int SIZE;
    int n;
    node* p;
  public:
    polynomial(int sz=50);
    polynomial(const polynomial & );
    ~polynomial();
    double cal(double);
    void getData();
    void display();
    polynomial operator=(const polynomial &);
    polynomial  operator+(const polynomial &);
    polynomial  operator-(const polynomial &);
    polynomial  operator*(const polynomial &);
};
polynomial::polynomial(int sz):n(0),SIZE(sz)
{
    p = (node*) new node[SIZE];
    memset(p,0,sizeof(p));
}
polynomial::~polynomial()
{
    delete p;
}
double polynomial::cal(double x)
{
    double rst=0;
    for(int i =0;i<n;++i){
        rst += pow(x,p[i].index)*p[i].coefficient;
    }
    return rst;
}
polynomial::polynomial(const polynomial &a)
{
    p = (node*) new node[50];
    memset(p,0,sizeof(p));
    n = a.n;
    for(int i = 0;i<a.n;++i){
        p[i].index = a.p[i].index;
        p[i].coefficient = a.p[i].coefficient;
    }
}
polynomial polynomial::operator=(const polynomial& a)
{
    n = a.n;
    for(int i = 0;i<a.n;++i){
        p[i].index = a.p[i].index;
        p[i].coefficient = a.p[i].coefficient;
    }
    return *this;
}
void polynomial::display()
{
    node * tmp = p;
    if(n == 0){
        printf("0\n");
        return;
    }
   // char *fmt = ("x");  printf(fmt,...);
    for(int i = n-1;i>=0;--i){
        double t = tmp[i].coefficient;
        double idx = tmp[i].index;
        if(isZero(idx)){
            printf("%+g",t);
            continue;
        }
        if(isZero(t-1)) printf("+");
        else if(isZero(t+1))printf("-");
        else printf("%+g",t);
        printf("x");
        if(!isZero(idx-1)) printf("^%g",idx);
    }
    printf("\n");
}
void polynomial::getData()
{
    printf("Please input data . \n");
    printf("For every item,Coefficient first .Use space to separate,EOF to end\n");
    map<double,double> mp;
    double idx;
    double coef;
    while(scanf("%lf%lf",&coef,&idx)!=EOF){
        if(isZero(coef)) continue;
        if(mp.count(idx) == 0){
            mp[idx] = coef;
        }
        else{
            mp[idx] += coef;
            if(isZero(mp[idx])){
                mp.erase(idx);
            }
        }
    }
    if(mp.size()>SIZE){
        SIZE *=2;
        p = (node*)realloc(p,sizeof(node)*SIZE) ;
    }
    for(map<double,double>::iterator it = mp.begin();it!=mp.end();++it){
        p[n].index = it->first;
        p[n++].coefficient = it->second;
    }
}
polynomial polynomial::operator+(const polynomial & a)
{
    polynomial rst ;
    int p1 = 0,p2 = 0,p3 = 0;
    double exp1 = p[p1].index;
    double exp2 = a.p[p2].index;
    while(p1<n && p2<a.n){
        while(p1<n &&exp1<exp2){
             rst.p[p3].index = exp1;
             rst.p[p3].coefficient = p[p1].coefficient;
             ++p1,++p3;
             exp1 = p[p1].index;;
        }
        while(p2<a.n &&exp1>exp2){
             rst.p[p3].index = exp2;
             rst.p[p3].coefficient = a.p[p2].coefficient;
             ++p2,++p3;
             exp2 = a.p[p2].index;;
        }
        if(isZero(exp1-exp2)){
            double tmp= p[p1].coefficient + a.p[p2].coefficient;
            if(isZero(tmp)){
                ++p1,++p2;
            }
            else{
                rst.p[p3].index = p[p1].index;
                rst.p[p3].coefficient = tmp;
                ++p1,++p2,++p3;
            }
        }
    }
    if(p1 == n){
        while(p2<a.n){
            rst.p[p3].index = a.p[p2].index;
            rst.p[p3].coefficient =  a.p[p2].coefficient;
            ++p2,++p3;
        }
    }
    else{
        while(p1<n){
            rst.p[p3].index = p[p1].index;
            rst.p[p3].coefficient = p[p1].coefficient;
            ++p1,++p3;
        }
    }
    rst.n = p3;
    return rst;
}
polynomial polynomial::operator-(const polynomial & a)
{
    polynomial rst(a) ;
    int i = 0;
    while(i<rst.n){
        rst.p[i].coefficient = -rst.p[i].coefficient;
        ++i;
    }
    return (*this + rst);
}
polynomial polynomial::operator*(const polynomial & a)
{
    map<double,double> mp;
    for(int i = 0;i<n;++i){
        double idx = p[i].index;
        double coef = p[i].coefficient;
        for(int j = 0;j<a.n;++j){
            double index = idx+a.p[j].index;
            if(mp.count(index)==0){
                mp[index] = coef*a.p[j].coefficient;
            }
            else{
                mp[index] += coef*a.p[j].coefficient;
                if(isZero(mp[index])){
                    mp.erase(index);
                }
            }
        }
    }
    int sz =50;
    while(mp.size()>sz){
        sz *=2;
    }
    polynomial rst(sz);
    for(map<double,double>::iterator it = mp.begin();it!=mp.end();++it){
        rst.p[rst.n].index = it->first;
        rst.p[rst.n++].coefficient = it->second;
    }
    return rst;
}
int num = 0;
polynomial  pl[30];
void menu()
{
    printf("**********OPERATIONS***********\n");
    printf("*****0.   create          *****\n");
    printf("*****1.   add +           *****\n");
    printf("*****2.   sub -           *****\n");
    printf("*****3.   mul *           *****\n");
    printf("*****4.   display         *****\n");
    printf("*****5.   menu            *****\n");
    printf("*****6.   clear screen    *****\n");
    printf("*****7.   exit            *****\n");
    printf("*****8.   copy            *****\n");
    printf("*****9.   display all     *****\n");
    printf("*****10.  cal val         *****\n");
    printf("**********OPERATIONS***********\n");
}
void loop()
{
    int op;
    while(scanf("%d",&op)!=EOF){
            if(op == 0){
                pl[num].getData();
                ++num;
                printf("You've created polynomial %d:\n",num);
                pl[num-1].display();
            }
            else if(op==1||op==2||op==3){
                if(num<2){
                    printf("Oops! you've got less two polynomial\nPlease choose another operation\n");
                    continue;
                }
                printf("input two nums of the two polynomial to be operated.eg: 1 2\n");
                int t1=100,t2=100;
                while(1){
                    scanf("%d%d",&t1,&t2);
                    if(t1>num||t2>num||t1<0||t2<0){
                        printf("wrong num ,please input again\n");
                    }
                    else break;
                }
                printf("the rst is:\n");
                t1 -=1,t2-=1;
                if(op == 1){
                    (pl[t1]+pl[t2]).display();
                }
                else if(op == 2){
                    (pl[t1]-pl[t2]).display();
                }
                else (pl[t1]*pl[t2]).display();
            }
            else if(op == 4){
                printf("input a polynomial's num to display it\n");
                int tmp;
                scanf("%d",&tmp);
                if(tmp>num){
                    printf("wrong num");
                }
                else{
                    printf("info of polynomial %d\n",tmp);
                    pl[tmp-1].display();
                }
            }
            else if(op == 9){
                for(int i = 0;i<num;++i){
                    printf("polynomial %d : ",i+1);
                    pl[i].display();
                }
            }
            else if(op == 5){
                menu();
            }
            else if(op == 6){
                if(LINUX) system("clear");
                else system("cls");
                menu();
            }
            else if(op == 10){
                double x;
                int t;
                printf("choose a polynomial\n");
                scanf("%d",&t);
                if(t>num||t<0){
                    printf("wrong num\n");
                }
                else {
                    printf("input a value\n");
                    scanf("%lf",&x);
                    pl[t-1].display();
                    printf("%g\n",pl[t-1].cal(x));
                }
            }
            else if(op == 8){
                if(num == 0){
                    printf("you have'nt any polynomial tp copy\n");
                    continue;
                }
                int n = num+1;
                while(n>num){
                    printf("input the  number of an existing polynomial you want to copy\n");
                    scanf("%d",&n);
                }
                (pl[num] = pl[n-1]);
                printf("You've copyed this polynomial:\n");
                pl[num++].display();
            }
            else exit(0);
            printf("select an operation\n");
    }
}
int main(void)
{
    menu();
    loop();
    return 0;
}
