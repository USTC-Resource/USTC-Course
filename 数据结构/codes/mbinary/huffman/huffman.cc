/* mbinary
#########################################################################
# File : huffman.cc
# Author: mbinary
# Mail: zhuheqin1@gmail.com
# Blog: https://mbinary.xyz
# Github: https://github.com/mbinary
# Created Time: 2018-04-25  22:32
# Description:
#########################################################################
*/

#include<math.h>
#include<stdio.h>
#include<iostream>
#include<algorithm>
#include<map>
#include<unistd.h>
#include<iomanip>
#include<string>
#include<vector>
#include<queue>
#include<sys/time.h>
#define numDigit 10
#define nameLength 50
#define  starNum  80
using namespace std;

void cat(string s)
{
    FILE* f=fopen(s.c_str(),"rb");
    cout<<"file content"<<endl;
    while(!feof(f)){
        cout<<fgetc(f);
    }
    cout<<endl;
}
string uniFileName(string file)
{
    FILE * check = fopen(file.c_str(),"rb");
    if(check){
        char c;
        cout<<"the file "<<file<<" already exists! continue?  [Y/n]:"<<flush;
        c=cin.get();
        if(c=='n')exit(0);
        int p,q;
        p= file.find('(');
        q=file.rfind('.');
        if(q==string::npos)q=file.size();
        if(p==string::npos)p=q;
        string name=file.substr(0,p),suffix=file.substr(q,file.size());
        int n=0;
        while(true){
            char s[3];
            n+=1;
            snprintf(s,3,"%d",n);
            file=(name+"("+s+")"+suffix);
            FILE* f=fopen(file.c_str(),"rb");
            if(!f)break;
            else fclose(f);
        }
    }
    return file;
}
template<class t1, class t2>
void mapprint(map<t1,t2> &f)
{
    for(class map<t1,t2>::iterator i = f.begin();i!=f.end();++i)
        cout<<i->first<<") : "<<i->second<<endl;
}
template<typename ky,typename wt>
class node
{
  public:
    ky key;
    wt val;
    bool visited;
    node * left,*right;
    node(const node &a){val = a.val;key= a.key;visited = a.visited;left= a.left;right=a.right;}
    node(ky k=0,wt v=0):key(k),val(v),visited(false),left(NULL),right(NULL){};
    bool operator<(const node<ky,wt> & a)const{return val>a.val;};
};
template<typename ky,typename wt>
class huffman
{
private:
    node<ky,wt> root;
    string res;
public:
    long total(){return root.val;}
    map<ky,string> encode_map;
    map<string,ky> decode_map;
    huffman(map<ky,wt>& mp);
    void display();
    string  encode(string,long &);
    string  decode(string,long&);
    void preOrder(node<ky,wt>*,string);
};
template<typename ky,typename wt>
huffman<ky,wt>::huffman(map<ky,wt>& mp)
{
    if(mp.empty()){
        cout<<"Error! No data!"<<endl;
        root=NULL;
        return ;
    }
    priority_queue<node<ky,wt> > hp;
    for(typename map<ky,wt>::iterator i=mp.begin();i!=mp.end();++i){
        hp.push( node<ky,wt>(i->first,i->second));
    }
    int n =hp.size();
    if(n==1){
        root = hp.top();
        return;
    }
    while(--n>=1){
        node<ky,wt> *a = new node<ky,wt>(hp.top());
        hp.pop();
        node<ky,wt> *b = new node<ky,wt>(hp.top());
        hp.pop();
        node<ky,wt> * tmp = new node<ky,wt>(0,a->val+b->val);
        tmp->left = a,tmp->right = b;
        hp.push(*tmp);
    }
    root = hp.top();
    preOrder(&root,string());
}
template<typename ky,typename wt>
void huffman<ky,wt>::preOrder(node<ky, wt>* nd,string s)
{
    if(nd->left == NULL){
        encode_map[nd->key] =s;
        decode_map[s] = nd->key;
        delete nd;
        return ;
    }
    preOrder(nd->left,s+'0');
    preOrder(nd->right,s+'1');
    delete nd;
}
template<typename ky,typename wt>
string  huffman<ky,wt>::decode(string zipfile_name,long &charNum)
{
    string uniFileName(string);
    FILE * src = fopen(zipfile_name.c_str(),"rb");
    char file_name[nameLength];
    fgets(file_name,nameLength,src);
    int ct=-1;
    while(file_name[++ct]!='\n');
    int pos = zipfile_name.find('.');
    if(pos==string::npos)pos=zipfile_name.size();
    string name(zipfile_name.substr(0,pos)) ,suffix(file_name,file_name+ct),file(name+suffix);
    file=uniFileName(file);
    cout<<"extracting compressed file :"<<zipfile_name<<endl;
    FILE * f = fopen(file.c_str(),"wb");
    char t[numDigit];
    fgets(t,numDigit,src);
    int sz=atoi(t);
    char code[sz];
    fread(code,sz,1,src);
    int idx=0;
    for(int i =0;i<sz;++i ){
        if(code[i]==' '){
            decode_map[string(code+idx,code+i)]=code[++i];
            idx=i+1;
        }
    }
    for(int i=0;i<starNum;++i)cout<<"@";
    cout<<endl;
    char c;
    long cur=charNum,gap=charNum/starNum;
    while(cur){
        c=fgetc(src);
        if(!((--cur)%gap))cout<<"@"<<flush;
        for(int i =0;i<8;++i){
            if(c&(1<<i))res.append(1,'1');
            else res.append(1,'0');
            if(decode_map.count(res)!=0){
                fputc(decode_map[res],f);
                res.clear();
            }
        }
    }
    cout<<endl;
    c=fgetc(src);
    int dgt=fgetc(src);
    cout<<feof(f);
    if((int)dgt!=-1 ){
        for(int i =0;i<dgt;++i){
            if(c&(1<<i))res.append(1,'1');
            else res.append(1,'0');
            if(decode_map.count(res)!=0){
                fputc(decode_map[res],f);
                res.clear();
                break;
            }
        }
    }
    fclose(src);
    fclose(f);
    cout<<"get "<<file <<" successfully"<<endl;
    return file;
}
template<typename ky,typename wt>
string huffman<ky,wt>::encode(string file_name,long &charNum)
{
    charNum=0;
    string uniFileName(string);
    int pos =file_name.rfind('.');
    if(pos==string::npos)pos=file_name.size();
    string zipfile = file_name.substr(0,pos)+string(".zzip");
    zipfile = uniFileName(zipfile);
    cout<<"generating zip file :"<<zipfile<<endl;
    FILE * dst = fopen(zipfile.c_str(),"wb");
    FILE * f = fopen(file_name.c_str(),"rb");
    fputs(file_name.substr(pos).c_str(),dst);
    fputc('\n',dst);
    string data;
    for(class map<string,ky>::iterator i=decode_map.begin();i!=decode_map.end() ;++i ){
        data.append((i->first));
        data.append(" ");
        data+=(i->second);
    }
    int data_size = data.size();  // calculate the size of the code_data
    char sz[numDigit];
    snprintf(sz,numDigit,"%d",data_size);
    int ct=0;
    for(;sz[ct];++ct)fputc(sz[ct],dst);
    fputc('\n',dst);
    fwrite(data.c_str(),data_size,1,dst);
    int  sum=0,digit=0,num;
    string code8;
    for(int i=0;i<starNum;++i)cout<<"@";
    cout<<endl;
    long gap=root.val/starNum,cur=0;
    while(!feof(f)){
        code8=encode_map[fgetc(f)];
        if(!((++cur)%gap))cout<<"@";
        for(int i=0;i<code8.size();++i){
            if(code8[i]=='1')sum += 1<<(digit);   //mistake  if(tmp[j])
            ++digit;
            if(digit==8){
                ++charNum;
                fputc(sum,dst);
                digit=sum=0;
            }
        }
    }
    cout<<endl;
    if(digit!=0){   //mark
        fputc(sum,dst);
        fputc(digit,dst);
    }
    fclose(f);
    fclose(dst);
    cout<<"compress "<<file_name <<" successfully"<<endl;
    return zipfile;
}
template<typename ky,typename wt>
void huffman<ky,wt>::display()
{
    cout<<"the encoding map,huffman codes are as bellow:"<<endl;
    for (typename map<ky,string>::iterator i=encode_map.begin();i!=encode_map.end() ;++i )
        cout<<i->first<<"("<<(int)i->first<<"):"<<i->second<<endl;
}
bool handle_one(string file_name,vector<long> &origin,vector<long> &compressed)
{
    int name_length = file_name.size();
    FILE *src=fopen(file_name.c_str(),"rb");
    cout<<"opening "<<file_name<<"..."<<endl;
    if(!src){
        cout<<"Path Error! Opening "<<file_name<<" Failed"<<endl;
        origin.push_back(0);
        compressed.push_back(0);
        return false;
    }
    char cur;
    map<char,long> mp;
    while(!feof(src)){
        fread(&cur,sizeof(char),1,src);
        if(mp.count(cur)){
            mp[cur]+=1;
        }
        else mp[cur]=1;
    }
    fclose(src);
    huffman<char,long> hf(mp);
    long sz;
    string s(hf.encode(file_name,sz));
    origin.push_back(hf.total()),compressed.push_back(sz);
    cout<<"\ncontinue to uncompress? [Y/n]"<<endl;
    char c=cin.get();
    if(c=='n')return true;
    hf.decode(s,sz);
    return true;
}
bool isSep(char c)
{
    return c==' '||c=='\n'||c=='\t'||c==',';
}
void splitToVec(char * s,vector<string>& v)
{
    int i=0,last=0;
    for(;s[i];++i){
        if(isSep(s[i])){
            v.push_back(string(s+last,s+i));
            while(s[++i]&&isSep(s[i]));
            last=i;
        }
    }
    if(s[last])v.push_back(string(s+last,s+i));
}
bool lenStr(string &a,string &b)
{
    return a.size()<b.size();
}
void go(vector<string> & names)
{
    vector<long> originSize,compressedSize;
    vector<int> deltaTime;
    double last;
    vector<bool> indicator;
    bool bl;
    for(vector<string>::iterator i=names.begin();i!=names.end();++i){
        struct timeval tv;
        gettimeofday(&tv,NULL);
            last=tv.tv_sec;
        bl=handle_one(*i,originSize,compressedSize);
        indicator.push_back(bl);
        gettimeofday(&tv,NULL);
        deltaTime.push_back(tv.tv_sec-last);
    }
    cout<<"\nDealt file number  "<<originSize.size()<<fixed<<setprecision(2)<<endl;
    vector<string>::iterator p=max_element(names.begin(),names.end(),lenStr);
    int len = p->size()+2;
    for(int i =0;i<names.size();++i){
        if(! indicator[i]){continue;}
        cout<<names[i]<<string(len-names[i].size(),' ');
        cout<<deltaTime[i]<<"s  "<<compressedSize[i]/1024.0<<"KB/"<<originSize[i]/1024.0<<"KB :";
        cout<<compressedSize[i]*100.0/originSize[i]<<"%"<<endl;
    }
    cout<<endl;
    system("pause");
}
int main(int argv,char ** argc)
{
    //char cwd[50];
    //cout<<getcwd(cwd,50)<<endl;
    vector<string> names;
    string file;
    if(argv>1){
        for(int i=1;i<argv;++i){
            names.push_back(argc[i]);
        }
        go(names);
        names.clear();
    }
    char mk;
    while(1){
        char s[201];
        cout<<"Input file names separated by space "<<endl;
        if(cin.peek()=='\n')names.push_back(file);
        else {
            cin.getline(s,200);
            splitToVec(s,names);
        }
        cout<<endl;
        go(names);
        cout<<"Continue?  [Y/n]:"<<flush;
        mk= cin.get();
        if(mk=='n')break;
        names.clear();
    }
    return 0;
}
