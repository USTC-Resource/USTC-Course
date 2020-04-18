#include <iostream>
#include <string>
#include <sstream>
#include "poly.hpp"
#include "../Lib/linklist.hpp"
using namespace std;

void test_linklist()
{
	Linklist<int> test;
	test.Append(2);
	test.Append(3);
	test.Append(4);
	test.Append(5);
	test.Append_head(1);
	int p;
	cout << test.GetElem(1, p) << endl;
	cout << p << endl;
	cout << test.GetElem(2, p) << endl;
	cout << p << endl;
	cout << test.GetElem(5, p) << endl;
	cout << p << endl;
	p = 999;
	cout << test.GetElem(6, p) << endl;
	cout << p << endl;
	cout << "----" << endl;
	cout << test.ListInsert(1, -1) << endl;
	cout << test.GetElem(1, p) << endl;
	cout << p << endl;
	cout << "----" << endl;
	Node<int>* q;
	q = test.head;
	while((q = q->next))
		cout << " " << q->data << endl;
	cout << test.ListDelete(1, p) << endl;
	cout << p << endl;
	q = test.head;
	while((q = q->next))
		cout << " " << q->data << endl;
	cout << test.ListDelete(1, p) << endl;
	cout << p << endl;
	Linklist<int> test2 = test;
	q = test2.head;
	while((q = q->next))
		cout << " " << q->data << endl;
	cout << test2.ListDelete(1, p) << endl;
	cout << p << endl;
	q = test2.head;
	while((q = q->next))
		cout << " " << q->data << endl;
}
void test_poly()
{
	Polynomial p;
	Polynomial q;
	Polynomial r;
	Polynomial s;
	Polynomial t;
	cin >> p;
	cin >> q;
	cout << "p: " << p << endl;
	cout << "q: " << q << endl;
	r = p + q;
	cout << "add: " << r << endl;
	r = p - q;
	cout << "subtract: " << r << endl;
	r = (-p);
	cout << "opposite: " << r << endl;
	r = p * q;
	cout << "multiple: " << r << endl;
	cout << "eval p(0) q(2)" << endl;
	cout << p.eval(0) << endl;
	cout << q.eval(2) << endl;
}
int main()
{
	//test_linklist();
	//test_poly();
	Linklist<Polynomial> polys;
	string cmd;
	int idx1;
	int idx2;
	double x;
	Polynomial p1;
	Polynomial p2;
	Polynomial p3;
	cout << "q to quit, new to create new poly, print to print polys stored, delete to delete a poly, add sub mul eval to do operations" << endl;
	while(1){
		try{
			cout << "poly> ";
			getline(cin, cmd);
			if(cmd == "q"){
				break;
			}
			else if(cmd == ""){
				continue;
			}
			else if(cmd == "new" || cmd == "n"){
				cout << "New poly: (enter 1 2 3 0 for +1x^(2)+3x^(0))" << endl;
				cin >> p1;
				cout << "Your poly: " << p1 << endl;
				polys.Append(p1);
			}
			else if(cmd == "print" || cmd == "p"){
				int l = polys.length;
				cout << "Total " << l << " Polys: " << endl;
				for(int i = 1; i <= l; i++){
					polys.GetElem(i, p1);
					cout << "#" << i << ": " << p1 << endl;
				}
			}
			else if(cmd == "delete" || cmd == "d"){
				cout << "Enter a index: ";
				cin >> idx1;
				if(idx1 < 0 && idx1 > polys.length)
					throw "Index out of range";
				polys.ListDelete(idx1, p1);
				cout << "You deleted " << p1 << endl;
			}
			else if(cmd == "add"){
				cout << "Enter two indexes: ";
				cin >> idx1 >> idx2;
				if(idx1 < 0 && idx1 > polys.length && idx2 < 0 && idx2 > polys.length)
					throw "Index out of range";
				polys.GetElem(idx1, p1);
				polys.GetElem(idx2, p2);
				p3 = p1 + p2;
				cout << "Sum is: " << p3 << endl;
				cout << "Result saved" << endl;
				polys.Append(p3);
			}
			else if(cmd == "sub"){
				cout << "Enter two indexes: ";
				cin >> idx1 >> idx2;
				if(idx1 < 0 && idx1 > polys.length && idx2 < 0 && idx2 > polys.length)
					throw "Index out of range";
				polys.GetElem(idx1, p1);
				polys.GetElem(idx2, p2);
				p3 = p1 - p2;
				cout << "Subtraction is: " << p3 << endl;
				cout << "Result saved" << endl;
				polys.Append(p3);
			}
			else if(cmd == "mul"){
				cout << "Enter two indexes: ";
				cin >> idx1 >> idx2;
				if(idx1 < 0 && idx1 > polys.length && idx2 < 0 && idx2 > polys.length)
					throw "Index out of range";
				polys.GetElem(idx1, p1);
				polys.GetElem(idx2, p2);
				p3 = p1 * p2;
				cout << "Multiplication is: " << p3 << endl;
				cout << "Result saved" << endl;
				polys.Append(p3);
			}
			else if(cmd == "eval"){
				cout << "Enter a index: ";
				cin >> idx1;
				if(idx1 < 0 && idx1 > polys.length)
					throw "Index out of range";
				polys.GetElem(idx1, p1);
				cout << "Enter an x value: ";
				cin >> x;
				cout << "The value of poly " << p1 << " when x is " << x << " is: " << p1.eval(x) << endl;
			}
			else{
				throw "No such command";

			}

		}catch(const char *msg){
			cout << "Error: " << msg  << "!" << endl;

		}
	}
	return 0;
}

