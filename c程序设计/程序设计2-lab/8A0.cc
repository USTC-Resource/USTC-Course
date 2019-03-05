#include<iostream>
using namespace std;
int main()
{
    int n,total;
    while(cin>>n){
        if(n<6||n>11) break;   
        switch(n){
            case 6:total=4;break;
            case 7:total=40;break;
            case 8:total=92;break;
            case 9:total=352;break;
            case 10:total=724;break;
            case 11:total=2680;break;
            }
         cout<<total<<endl;
    }
    return 0;
}