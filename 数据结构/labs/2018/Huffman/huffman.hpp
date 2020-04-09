#ifndef HUFFMAN_HPP
#define HUFFMAN_HPP
#include <iostream>
#include <cstdlib>
using namespace std;
typedef unsigned int Weight;
//const MaxTreeSize = 10;
//Maybe this Nodesize cannot be changed
const int NodeSize = 8 * sizeof(char);
class HTNode{
public:
    HTNode(){
        weight = 0;
        parent = 0;
        lchild = 0;
        rchild = 0;
    }
    Weight weight;
    int parent;
    int lchild;
    int rchild;
};
class HuffmanTree{
public:
    HuffmanTree(){
        tree = nullptr;
        size = 0;
    }

    explicit HuffmanTree(int tsize){
        tree = new HTNode[tsize];
        size = tsize;
    }
    ~HuffmanTree(){
        delete tree;
    }
    //Select two elements with least weight from the first n nodes (tree[0] to tree[n-1])
    void SelectMin(int len, int& idx1, int& idx2) const {
        //If I set the maxes initially 0, then int the following code >= must be used instead of >
        unsigned int min1 = UINT32_MAX;
        int min1idx = -1;
        unsigned int min2 = UINT32_MAX;
        int min2idx = -1;
        for(int i = 0; i < len; i++){
            if(tree[i].parent == 0) {
                if(tree[i].weight <= min1){
                    min2 = min1;
                    min2idx = min1idx;
                    min1 = tree[i].weight;
                    min1idx = i;
                }
                else if(tree[i].weight <= min2){
                    min2 = tree[i].weight;
                    min2idx = i;
                }
            }
        }
        idx1 = min1idx;
        idx2 = min2idx;
    }
    //This should be run only after weight of the first n nodes are decided (tree size 2*n-1)
    void BuildTree(){
        int idx1 = -1, idx2 = -1;
        for(int i = (size + 1) / 2; i < size; i++){
            SelectMin(i, idx1, idx2);
//            cout << idx1 << " " << idx2 << endl;
            tree[idx1].parent = i;
            tree[idx2].parent = i;
            tree[i].lchild = idx1;
            tree[i].rchild = idx2;
            tree[i].weight = tree[idx1].weight + tree[idx2].weight;
        }
    }
    void PrintTree(){
        cout << "Huffman Tree" << endl;
        cout << "Size: " << size << endl;
        for(int i = 0; i < size; i++){
            cout << char(i) << '\t' << tree[i].weight << '\t' << \
                 tree[i].parent << '\t' << tree[i].lchild << '\t' << tree[i].rchild << endl;
        }
    }
    HTNode* tree;
    int size;
};
class HuffmanCode{
public:
    HuffmanCode(){
        code = nullptr;
        len = nullptr;
        size = 0;
    }
    explicit HuffmanCode(int tsize){
        code = new bool*[tsize];
        len = new int[tsize];
        for(int i = 0; i < tsize; i++){
            code[i] = nullptr;
            len[i] = -1;
        }
        size = tsize;
    }
    ~HuffmanCode(){
        for(int i = 0; i < size; i++)
                delete code[i];
        delete code;
        delete len;
    }
    //Generate huffman code using a huffman tree
    void GenerateCode(const HuffmanTree& tree){
        for(int i = 0; i < this->size; i++){
            delete code[i];
//            code[i] = nullptr;
        }
        int num = (tree.size + 1) / 2;
        auto buf = new bool[num];
        for(int i = 0; i < num; i++){
            int start = num;
            int node = i;
            int father = tree.tree[i].parent;
            for(; father; node = father, father = tree.tree[father].parent){
                buf[--start] = tree.tree[father].lchild != node;
//                if(tree.tree[father].lchild == node)
//                    buf[--start] = false;
//                else
//                    buf[--start] = true;
            }
            len[i] = num - start;
//            cout << "..." << len[i] << endl;
//            cout << code[i] << endl;
//            cout << "..." << len[i] << endl;
            bool* t = new bool[len[i]];
            code[i] = t;
//            code[i] = new bool[len[i]];
//            cout << "..." << len[i] << endl;
            for(int j = 0; j < len[i]; j++)
                code[i][j] = buf[j + start];
        }
        delete buf;
    }
    void PrintCode(){
        cout << "Huffman Code" << endl;
        cout << "Size: " << size << endl;
        for(int i = 0; i < size; i++){
            cout << i << "(" << char(i) << ")" << ": ";
            for(int j = 0; j < len[i]; j++)
                cout << code[i][j] ? "0" : "1";
            cout << endl;
        }
        cout << "End printing." << endl;
    }
    bool** code;
    int* len;
    int size;
};
#endif
