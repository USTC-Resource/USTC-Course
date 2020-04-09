#ifndef SIMPLEDRAW_HPP
#define SIMPLEDRAW_HPP
#include <iostream>
#include <sstream>
#include <string>
#include <cstdarg>
#include <cstring>
#include <cstdio>
using namespace std;
const int colmax = 500;
const int rowmax = 500;
const int maxlen = 100;
class SimpleCanvas{
	public:
		SimpleCanvas()
		{
			ClearCanvas();
			rownum = 24;
			colnum = 80;
			color = "No";
		}
		SimpleCanvas(int r, int c)
		{
			ClearCanvas();
			rownum = r;
			colnum = c;
			color = "No";
		}
		~SimpleCanvas()
		{
			cout << "\033[?25h\033[0m";
		}
		void Show(bool isclean)
		{
			string clr = "No";
			if(isclean)
				ClearScreen();
			cout << "\033[?25l\033[1;1H";
			for(int i = 1; i <= rownum; i++){
				for(int j = 1; j <= colnum; j++){
					if(colormap[i][j] != clr){
						clr = colormap[i][j];
						if(clr == "Black"){
							cout << "\033[30m";
						}
						else if(clr == "Red"){
							cout << "\033[31m";
						}
						else if(clr == "Green"){
							cout << "\033[32m";
						}
						else if(clr == "Yellow"){
							cout << "\033[33m";
						}
						else if(clr == "Blue"){
							cout << "\033[34m";
						}
						else if(clr == "Purple"){
							cout << "\033[35m";
						}
						else if(clr == "DarkGreen"){
							cout << "\033[36m";
						}
						else if(clr == "White"){
							cout << "\033[37m";
						}
						else{
							cout << "\033[0m";
						}
					}
					cout << canvas[i][j];
				}
				cout << "\r\n";
			}
			cout << "\033[?25h\033[0m";
		}
		void ClearCanvas()
		{
			for(int i = 1; i <= rowmax; i++)
				for(int j = 1; j <= colmax; j++){
					canvas[i][j] = ' ';
					colormap[i][j] = "No";
				}
		}
		void ClearScreen()
		{
			cout << "\033[?25l\033[1;1H";
			for(int i = 1; i <= rownum; i++){
				for(int j = 1; j <= colnum; j++)
					cout << " ";
				cout << "\r\n";
			}
			cout << "\033[?25h\033[0m";
		}
		//Be able to use c printf style
		void AddString(const char* s, int row, int col, ...)
		{ 
			if(row < 1 || row > rownum || col < 1 || col > colnum)
				return;
			char sfinal[maxlen];
			va_list ap;
			va_start(ap, col);
			vsnprintf(sfinal, maxlen, s, ap);
			int len = strlen(sfinal);
			//Ignore overflow parts
			for(int i = 1; i <= len && i + col <= colnum; i++){
				canvas[row][i + col - 1] = sfinal[i - 1];
				colormap[row][i + col - 1] = color;
			}
		}
		void AddChar(char c, int row, int col)
		{
			if(row < 1 || row > rownum || col < 1 || col > colnum)
				return;
			canvas[row][col] = c;
			colormap[row][col] = color;
		}
		void AddRectangle(int row1, int col1, int row2, int col2, char srow, char scol, char scorner)
		{
			if(row1 < 1 || row1 > rownum || col1 < 1 || col1 > colnum)
				return;
			if(row2 < 1 || row2 > rownum || col2 < 1 || col2 > colnum)
				return;
			if(row1 > row2)
				swap(row1, row2);
			if(col1 > col2)
				swap(col1, col2);
			for(int i = row1; i < row2; i++){
				canvas[i][col1] = srow;
				canvas[i][col2] = srow;
				colormap[i][col1] = color;
				colormap[i][col2] = color;
			}
			for(int i = col1; i < col2; i++){
				canvas[row1][i] = scol;
				canvas[row2][i] = scol;
				colormap[row1][i] = color;
				colormap[row2][i] = color;
			}
			canvas[row1][col1] = scorner;
			canvas[row2][col1] = scorner;
			canvas[row1][col2] = scorner;
			canvas[row2][col2] = scorner;
			colormap[row1][col1] = color;
			colormap[row2][col1] = color;
			colormap[row1][col2] = color;
			colormap[row2][col2] = color;
		}
		void AddColLine(int col, int row1, int row2, char s)
		{
			if(row1 < 1 || row1 > rownum || row2 < 1 || row2 > rownum || col < 1 || col > colnum)
				return;
			if(row1 > row2)
				swap(row1, row2);
			for(int i = row1; i <= row2; i++){
				canvas[i][col] = s;
				canvas[i][col] = s;
				colormap[i][col] = color;
				colormap[i][col] = color;
			}
		}
		void AddRowLine(int row, int col1, int col2, char s)
		{
			if(col1 < 1 || col1 > colnum || col2 < 1 || col2 > colnum || row < 1 || row > rownum)
				return;
			if(col1 > col2)
				swap(col1, col2);
			for(int i = col1; i <= col2; i++){
				canvas[row][i] = s;
				canvas[row][i] = s;
				colormap[row][i] = color;
				colormap[row][i] = color;
			}

		}
		void ChangeColor(string c)
		{
			color = c;
		}
		char canvas[rowmax + 1][colmax + 1];
		string colormap[rowmax + 1][colmax + 1];
		string color;
		int rownum;
		int colnum;
};
#endif
