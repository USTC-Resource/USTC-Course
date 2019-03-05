/* mbinary
#########################################################################
# File : map.cc
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-04-26  10:33
# Description:
#########################################################################
*/

#include<stdio.h>
bool  isZero(float a)
{
    return a<0.00001&&-a<0.00001;
}
template<class,class> class map;
 //notice that if you declare a class template,declare the class first like this.
template<class t1,class t2>
class pair
{
    friend class map<t1,t2>;
    pair<t1,t2> *next;
  public:
    t1 first;
    t2 second;

};
template<class t1,class t2>
class map
{
    int n;
    pair<t1,t2> head;
    int cur;
    pair<t1,t2> *last_visit;
  public:
    map();
    ~map();
    bool has(t1);
    void erase(t1);
    t2& operator[](t1);
    pair<t1,t2> &locate(int index = -1);
    int size();
};
template<class t1,class t2>
map<t1,t2>::map(){
    n=0;
    cur=-1;
    last_visit= &head;
    head.next=NULL;
    head.first = head.second = 0;
}
template<class t1,class t2>
map<t1,t2>::~map()
{
    pair<t1,t2> *p,*q=&head;
    while(q!=NULL){
        p=q->next;
        delete q;
        q=p;
    }
}
template<class t1,class t2>
bool map<t1,t2>::has(t1 key)
{
    pair<t1,t2> *p = head.next;
    for(int i = 0;i<n&&p->first<=key;++i){
        if(isZero(p->first-key)) return 1;
        p=p->next;
    }
    return 0;
}
template<class t1,class t2>
pair<t1,t2>& map<t1,t2>::locate(int index)
{
    if(index>=n||index<0){
        printf("the index is out of range\n");
        return head;
    }
    if(cur>index){
        last_visit = &head;
        cur = -1;
    }
    while(cur<index){
        last_visit = last_visit->next;
        ++cur;
    }
    return *last_visit;
}
template<class t1,class t2>
int map<t1,t2>::size()
{
    return n;
}
template<class t1,class t2>
t2&  map<t1,t2>::operator[](t1 key)
{
    pair<t1,t2> * p=&head;
    while(p->next!=NULL){
        if(isZero(p->next->first-key)) return p->next->second;
        else if(p->next->first>key){break;}
        p=p->next;
    }
    cur=-1;
    last_visit= &head;
    pair<t1,t2> *tmp = new pair<t1,t2>;
    tmp ->next = p->next;
    tmp->first = key;
    p->next = tmp;
    ++n;
    return tmp->second;
}
template<class t1,class t2>
void map<t1,t2>::erase(t1 key)
{
    pair<t1,t2> *p = &head;
    while(p->next!=NULL){
        if(isZero(p->next->first-key)){
            pair<t1,t2> *q = p->next;
            p->next = p->next->next;
            delete q;
            --n;
            break;
        }
        p=p->next;
    }
    cur=-1;
    last_visit= &head;
}


int main()
{
    map<double,float> b;
    for(int i = 0;i<40;++i){
        b[i] = i;
        if(i%3){
            b[i] = 1;
        }
        if(i%2){
            b.erase(i);
        }

    }
    for(int i = 0;i<b.size();++i){
        printf("item %d   %g:%g\n",i,b.locate(i).first,b.locate(i).second);
    }
    return 0;
}
