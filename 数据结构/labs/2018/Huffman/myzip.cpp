#include "huffman.hpp"
#include <iostream>
#include <sstream>
#include <fstream>
#include <cstdlib>
#include <cstdarg>
#include <cxxopts.hpp>
#include <ctime>
using namespace std;

/*
 * My simple compression software using Huffman tree
 * part of the argv parsing code copied from jarro2783/cxxopts
 */

//Thanks stack overflow for this judging function
#include <sys/stat.h>
// Function: fileExists
/**
    Check if a file exists
@param[in] filename - the name of the file to check

@return    true if the file exists, else false

*/
bool fileExists(const std::string& filename)
{
    struct stat buf;
    if (stat(filename.c_str(), &buf) != -1)
    {
        return true;
    }
    return false;
}

string ifile;
string ofile;
//blocksize and NodeSize count in bit
//blocksize should be larger than NodeSize
int blocksize;
bool iscompress;
bool isverbose = false;
unsigned int filesize = 0;

const char* MagicString = "Myzip file v1.0";
const char* Delimeter = "Below are main compressed data";
const int defaultbs = 1024;
const int TreeSize = 2 * (1u << (unsigned)NodeSize) - 1;
const int CodeSize = (1u << (unsigned)NodeSize);
//const int BufRate = 10;
//int BufSize = BufRate * max(defaultbs, CodeSize);

void exitprogram(int status, const char* msg, ...)
{
	char sfinal[500];
	va_list ap;
	va_start(ap, msg);
	vsnprintf(sfinal, 500, msg, ap);
	cout << sfinal << endl;
	cout << "Program now exit." << endl;
	exit(status);
}
void verboselog(const char* s, ...)
{
	if(isverbose){
		char sfinal[500];
		va_list ap;
		va_start(ap, s);
		vsnprintf(sfinal, 500, s, ap);
		cout << sfinal << endl;
	}
}
//Parsing argv using cxxopts, results are saved in global variables, the program may exit 
//if error parsing or incorrect commandline
void parsing_cmdline(int argc, char* argv[]){
	try{
		cxxopts::Options options("myzip", "A simple file compressing program, by ustcpetergu");
		options.add_options("Available")
			("v,verbose", "Being verbose")
			("c,compress", "Compress file")
			("x,extract", "Extract compressed file")
            ("F,force", "Overwrite existing file")
			("f,file", "Specify input or output file name", cxxopts::value<string>())
			("h,help", "Show help")
			;
		auto result = options.parse(argc, argv);
		if(result.count("h")){
			cout << options.help({"", "Available"}) << endl;
			exitprogram(0, "Help shown.");
		}
		isverbose = (bool)result.count("v");
		if(!(result.count("c") ^ result.count("x")))
			exitprogram(-1, "You must specify one option, compress or extract? Or show help?");
		if(result.count("c")){
			iscompress = true;
			verboselog("Compress.");
		}
		else{
			verboselog("Extract.");
			iscompress = false;
		}
		string ff = result["f"].as<string>();
		if(result.count("f")){
			if(iscompress){
				ifile = ff;
				ofile = ifile + ".huff";
			}
			else{
				if(ff.length() <= 5 || ff.substr(ff.length() - 5, 5) != ".huff")
					exitprogram(-1, "The file should have extention .huff");
                ifile = ff;
				ofile = ff.substr(0, ff.length() - 5) + ".decompressed";
			}
		}
		else
			exitprogram(-1, "You must select a file.");
		if (fileExists(ofile)) {
            if (result.count("F") != 0)
                verboselog("Overwrite existing file");
            else
                exitprogram(-1, "File exist, use -F to overwrite");
		}
		verboselog("Input file: %s", ifile.c_str());
		verboselog("Output file: %s", ofile.c_str());
		if(!result.count("bs")){
			blocksize = defaultbs;
			verboselog("Use default blocksize %d.", blocksize);
		}
		else
			blocksize = result["bs"].as<int>() * 8;
	} catch(const cxxopts::OptionException& e){
		std::cout << "Error parsing options: " << e.what() << std::endl;
		exit(-2);
	}
}
void GetWeight(HuffmanTree& tree)
{
    ifstream fin;
    fin.open(ifile, ios::in | ios::binary);
    if(fin.fail())
        exitprogram(-2, "Error opening input file");
    filesize = 0;
    char chr;
    fin.get(chr);
    while(!fin.eof()){
        tree.tree[(unsigned char)chr].weight++;
        filesize++;
        fin.get(chr);
    }
    fin.close();
    verboselog("File read for the first time.");
    verboselog("File size: %u chars", filesize);
}
void WriteCompressed(const HuffmanTree& tree, const HuffmanCode& code)
{
    verboselog("Writing compresse file...");
    ifstream fin;
    fin.open(ifile, ios::in | ios::binary);
    if(fin.fail())
        exitprogram(-2, "Error opening input file");
    ofstream fout;
    fout.open(ofile, ios::out | ios::binary);
    if(fout.fail())
        exitprogram(-2, "Error writing output file");
    //Write magic information
    fout.write(MagicString, strlen(MagicString));
    //Write the Huffman tree
    fout.write((char*)&tree.size, sizeof(tree.size));
    for(int i = 0; i < tree.size; i++){
        fout.write((char*)&tree.tree[i].weight, sizeof(tree.tree[i].weight));
        fout.write((char*)&tree.tree[i].parent, sizeof(tree.tree[i].parent));
        fout.write((char*)&tree.tree[i].lchild, sizeof(tree.tree[i].lchild));
        fout.write((char*)&tree.tree[i].rchild, sizeof(tree.tree[i].rchild));
    }
    //Write file size (counted by char)
    fout.write((char*)&filesize, sizeof(filesize));
    //Write Delimiter
    fout.write(Delimeter, strlen(Delimeter));
    char chr;
    char outchr;
    string buf;
    string outstr;
    long len;
    unsigned int bit = 0;
    fin.get(chr);
    buf.clear();
    outstr.clear();
    while(!fin.eof()) {
        for(int i = 0; i < code.len[(unsigned char)chr]; i++)
            buf += code.code[(unsigned char)chr][i] ? "1" : "0";
        len = buf.length();
        if(len > NodeSize * blocksize) {
            outstr.clear();
            int cnt = 0;
            for(cnt = 0; cnt + NodeSize - 1 < len; cnt += NodeSize) {
                outchr = 0;
                for(int i = 0; i < NodeSize; i++){
                    if(buf[cnt + i] == '0')
                        bit = 0;
                    else
                        bit = 1;
                    outchr += bit << (unsigned)(NodeSize - 1 - i);
                }
                outstr += outchr;
            }
            fout << outstr;
            buf = buf.substr(cnt, len - cnt);
        }
        fin.get(chr);
    }
    len = buf.length();
    if(len)
        for(long i = len; i < NodeSize * (len / NodeSize + 1); i++)
            buf += "0";
    outstr.clear();
    len = buf.length();
    for(int cnt = 0; cnt + NodeSize - 1 < len; cnt += NodeSize) {
        outchr = 0;
        for(int i = 0; i < NodeSize; i++){
            if(buf[cnt + i] == '0')
                bit = 0;
            else
                bit = 1;
            outchr += bit << (unsigned)(NodeSize - 1 - i);
        }
        outstr += outchr;
    }
    fout << outstr;
    fin.close();
    fout.close();
    verboselog("File compressed");
}
void Decompress(HuffmanTree& tree)
{
    verboselog("Start decompressing...");
    ifstream fin;
    fin.open(ifile, ios::in | ios::binary);
    if(fin.fail())
        exitprogram(-2, "Error opening input file");
    ofstream fout;
    fout.open(ofile, ios::out | ios::binary);
    if(fout.fail())
        exitprogram(-2, "Error writing output file");
    char* flag;
    flag = new char[strlen(MagicString)];
    flag[strlen(MagicString)] = 0;
    fin.read(flag, strlen(MagicString));
    if(strcmp(flag, MagicString) != 0)
        exitprogram(-3, "The file seems not Myzip compressed");
    delete flag;
    delete tree.tree;
    tree.size = 0;
    fin.read((char*)&tree.size, sizeof(tree.size));
    tree.tree = new HTNode[tree.size];
    for(int i = 0; i < tree.size; i++){
        fin.read((char*)&tree.tree[i].weight, sizeof(tree.tree[i].weight));
        fin.read((char*)&tree.tree[i].parent, sizeof(tree.tree[i].parent));
        fin.read((char*)&tree.tree[i].lchild, sizeof(tree.tree[i].lchild));
        fin.read((char*)&tree.tree[i].rchild, sizeof(tree.tree[i].rchild));
    }
    fin.read((char*)&filesize, sizeof(filesize));
    verboselog("File size: %d chars", filesize);
    flag = new char[strlen(Delimeter)];
    flag[strlen(Delimeter)] = 0;
    fin.read(flag, strlen(Delimeter));
    if(strcmp(flag, Delimeter) != 0)
        exitprogram(-4, "File seems corrupted");
    delete flag;
    verboselog("File info read successfully, start decompressing");
    unsigned int cnt = 0;
    char chr;
    string buf;
    int node;
    //node point at the tree root
    node = tree.size - 1;
    fin.get(chr);
    while(!fin.eof() && cnt < filesize) {
        unsigned int bit = 1u << (unsigned)(NodeSize - 1);
        //process the chr read from fin bit by bit for NodeSize-1 cycles
        for(int i = 0; i < NodeSize; i++) {
            if((unsigned char)chr & bit)
                node = tree.tree[node].rchild;
            else
                node = tree.tree[node].lchild;
            //One huffman code found
            if(tree.tree[node].lchild == 0 && tree.tree[node].rchild == 0) {
                buf += (char)node;
                //begin another cycle and set node back to root
                node = tree.size - 1;
                cnt++;
                if(cnt == filesize)
                    break;
            }
            bit = bit >> 1u;
        }
        if(buf.length() > (unsigned int)blocksize) {
            fout << buf;
            buf.clear();
        }
        fin.get(chr);
    }
    //Print remaining to file,
    //just ignore the bits left undecoded, they are dummy bits filled when writing.
    fout << buf;
    fin.close();
    fout.close();
    verboselog("File decompressed.");
}
int main(int argc, char* argv[]){
	parsing_cmdline(argc, argv);
	HuffmanTree tree = HuffmanTree(TreeSize);
	HuffmanCode code = HuffmanCode(CodeSize);


    // Compress file
	if(iscompress) {
	    GetWeight(tree);
        tree.BuildTree();
//	    tree.PrintTree();
	    code.GenerateCode(tree);
//	    code.PrintCode();
        WriteCompressed(tree, code);

	}
    // Extract file
	else {
	    Decompress(tree);
	}
	verboselog("End.");
	return 0;
}
