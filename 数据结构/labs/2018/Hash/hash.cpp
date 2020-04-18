//
// Created by petergu on 12/18/18.
//
#include <iostream>
#include <fstream>
#include <cmath>
#include "../Lib/linklist.hpp"

using namespace std;

const int PRIME = 5003;
const int HASH_LEN = 5003;

// Assume Elements are phone numbers like 150-xxxx-xxxx
class Elem{
public:
    Elem(){
        number = -1;
    }
    explicit Elem(long long number){
        this->number = number;
    }
    long long GetKey() const{
        return ((number % 10000) * (number % 10000) + (number / 10000 % 10000) * (number / 10000 % 10000)) % PRIME;
    }
    long long number;
};

class LinearHash{
public:
    LinearHash(){
        hash = new Elem[HASH_LEN];
        for(int i = 0; i < HASH_LEN; i++)
            hash[i] = Elem();
    }
    ~LinearHash(){
        delete hash;
    }
    int NextAddr(int key0, int cnt) const{
//        cout << "Collision." << endl;
        return key0 + cnt + (key0 + cnt >= HASH_LEN ? -HASH_LEN : 0);
    }
    // 1: found
    // 2: inserted
    // -1: not found
    // -2: table full and cannot insert
    int BaseSearch(Elem elem, bool insert, int& cmp){
        int key0 = elem.GetKey();
        int key = key0;
        int cnt = 1;
        while(hash[key].number != -1 && elem.number != hash[key].number){
            key = NextAddr(key0, ++cnt);
            if(cnt > HASH_LEN){
                if(insert)
                    return -2;
                else
                    return -1;
            }
        }
        cmp = cnt;
        if(hash[key].number == elem.number)
            return 1;
        else if(insert){
            hash[key] = elem;
            return 2;
        }
        else
            return -1;
    }
    bool Search(Elem elem){
        int dum = 0;
        int stat = BaseSearch(elem, false, dum);
        return stat > 0;
    }
    bool Insert(Elem elem){
        int dum = 0;
        int stat = BaseSearch(elem, true, dum);
        return stat > 0;
    }
    int CompareTimes(Elem elem){
        int cmp = -1;
        BaseSearch(elem, false, cmp);
        return cmp;
    }
    int CompareTimes(int key0){
        int cnt = 1;
        int key = key0;
        while(hash[key].number != -1){
            key = NextAddr(key0, ++cnt);
            if(cnt > HASH_LEN)
                break;
        }
        return cnt;
    }
    double AverageCmpTimesFailed(){
        int times = 0;
        for(int i = 0; i < HASH_LEN; i++)
            times += CompareTimes(i);
        return times * 1.0 / HASH_LEN;
    }
    double AverageCmpTimesSuccess(){
        long long times = 0;
        int elems = 0;
        for(int i = 0; i < HASH_LEN; i++){
            if(hash[i].number != -1) {
                times += CompareTimes(hash[i]);
                elems++;
            }
        }
        if (elems == 0)
            return -1.0;
        return times * 1.0 / elems;
    }
    void Print() const{
        cout << "------" << endl;
        for(int i = 0; i < HASH_LEN; i++)
            if (hash[i].number != -1)
                cout << i << ": " << hash[i].number << endl;
        cout << "------" << endl;
    }
    Elem* hash;
};

class LinkHash{
public:
    LinkHash(){
        hash = new Linklist<Elem>*[HASH_LEN];
        for(int i = 0; i < HASH_LEN; i++)
            hash[i] = new Linklist<Elem>();
    }
    ~LinkHash(){
        for(int i = 0; i < HASH_LEN; i++)
            delete hash[i];
        delete hash;
    }
    int BaseSearch(Elem elem, bool insert, int& cmp){
        int key0 = elem.GetKey();
        int cnt = 1;
        Node<Elem>* p;
        p = hash[key0]->head->next;
        while(p && elem.number != p->data.number){
            p = p->next;
            cnt++;
        }
        cmp = cnt;
        if(!p){
            if(insert){
                Status stat = hash[key0]->ListInsert(1, elem);
                if(stat != OK)
                    return -2;
                return 2;
            }
            else
                return -1;
        }
        else
            return 1;
    }
    bool Search(Elem elem){
        int dum = 0;
        int stat = BaseSearch(elem, false, dum);
        return stat > 0;
    }
    bool Insert(Elem elem){
        int dum = 0;
        int stat = BaseSearch(elem, true, dum);
        return stat > 0;
    }
    int CompareTimes(Elem elem){
        int cmp = -1;
        BaseSearch(elem, false, cmp);
        return cmp;
    }
//    int CompareTimes(int key0){
//        int cnt = 1;
//        Node<Elem>* p;
//        p = hash[key0]->head->next;
//        while(p && key0 != p->data.number){
//            p = p->next;
//            cnt++;
//        }
//        return cnt;
//    }
    double AverageCmpTimesFailed(){
        int times = 0;
        for(int i = 0; i < HASH_LEN; i++){
            times += hash[i]->length == 0 ? 1 : hash[i]->length;
        }
        return times * 1.0 / HASH_LEN;
    }
    double AverageCmpTimesSuccess(){
        long long times = 0;
        int elems = 0;
        for(int i = 0; i < HASH_LEN; i++){
            Node<Elem>* p = hash[i]->head->next;
            if(p != nullptr) {
//                times += CompareTimes(p->data);
                times += hash[i]->length * (1 + hash[i]->length) / 2;
                elems += hash[i]->length;
            }
        }
        if (elems == 0)
            return -1.0;
        return times * 1.0 / elems;
    }
    Linklist<Elem>** hash;
};

int main(int argc, char** argv)
{
    LinearHash ht1;
    LinkHash ht2;
    ifstream fin;
    fin.open("../rand.out");
    long long phone = -1;
    Elem elem;
    int number = 9000;
    double alpha = number * 1.0 / HASH_LEN;
    for(int i = 0; i < number; i++){
        fin >> phone;
        elem = Elem(phone);
        bool stat1 = ht1.Insert(elem);
        bool stat2 = ht2.Insert(elem);
//        cout << ht1.CompareTimes(elem) << endl;
        if(!stat1)
            cout << "Error inserting into ht1" << endl;
        if(!stat2)
            cout << "Error inserting into ht2" << endl;
    }
    fin.close();
    cout << "Finding test" << endl;
    cout << ht1.Search(Elem(18865352160)) << endl;
    cout << ht1.Search(Elem(13664038822)) << endl;
    cout << ht1.Search(Elem(15800000000)) << endl;
    cout << ht1.Search(Elem(13699068352)) << endl;
    cout << ht1.CompareTimes(Elem(18865352160)) << endl;
    cout << ht1.CompareTimes(Elem(13664038822)) << endl;
    cout << ht1.CompareTimes(Elem(15800000000)) << endl;
    cout << ht1.CompareTimes(Elem(13699068352)) << endl;
    cout << endl;
    cout << ht2.Search(Elem(18865352160)) << endl;
    cout << ht2.Search(Elem(13664038822)) << endl;
    cout << ht2.Search(Elem(15800000000)) << endl;
    cout << ht2.Search(Elem(13699068352)) << endl;
    cout << ht2.CompareTimes(Elem(18865352160)) << endl;
    cout << ht2.CompareTimes(Elem(13664038822)) << endl;
    cout << ht2.CompareTimes(Elem(15800000000)) << endl;
    cout << ht2.CompareTimes(Elem(13699068352)) << endl;
    cout << endl;
//    ht1.Print();
    cout << "Statistics: " << endl;
    cout << "ht1: " << endl;
    cout << "elements: " << number << endl;
    cout << "alpha: " << alpha << endl;
    cout << "avg. cmp. times succeeded: " << ht1.AverageCmpTimesSuccess() << endl;
    cout << "cmp. times succeeded theory: " << .5 * (1 + 1 / (1 - alpha)) << endl;
    cout << "avg. cmp. times failed: " << ht1.AverageCmpTimesFailed() << endl;
    cout << "cmp. times failed theory: " << .5 * (1 + 1 / ((1 - alpha) * (1 - alpha))) << endl;

    cout << "ht2: " << endl;
    cout << "elements: " << number << endl;
    cout << "alpha: " << alpha << endl;
    cout << "avg. cmp. times succeeded: " << ht2.AverageCmpTimesSuccess() << endl;
    cout << "cmp. times succeeded theory: " << 1 + alpha / 2 << endl;
    cout << "avg. cmp. times failed: " << ht2.AverageCmpTimesFailed() << endl;
    cout << "cmp. times failed theory: " << alpha + exp(-alpha) << endl;
    return 0;
}
